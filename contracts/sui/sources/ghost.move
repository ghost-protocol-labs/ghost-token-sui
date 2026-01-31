module ghost::ghost_token {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, UID};
    use sui::balance::{Self, Balance};
    use sui::event;
    use sui::url;
    use sui::bag::{Self, Bag};
    use sui::clock::{Self, Clock};

    // ──────────────────────────────
    // Token struct
    // ──────────────────────────────
    public struct GHOST has drop {}

    // ──────────────────────────────
    // Constants
    // ──────────────────────────────
    const DECIMALS: u8 = 9;
    const TOTAL_SUPPLY: u64 = 20_000_000_000_000_000_000; // 20B * 10^9
    const TOTAL_FEE_BP: u64 = 250;    // 2.5%
    const BURN_SHARE_BP: u64 = 6000;  // 60% of fee burned
    const BURN_REWARD_BP: u64 = 100;  // 1% reward on quarterly burn
    const MIN_BURN: u64 = 3_000_000_000_000; // 3M GHOST minimum
    const QUARTER_MS: u64 = 90 * 24 * 60 * 60 * 1000;

    // ──────────────────────────────
    // Shared objects
    // ──────────────────────────────
    public struct Treasury has key {
        id: UID,
        balance: Balance<GHOST>,
        paused: bool,
        last_burn_ms: u64,
    }

    public struct FeeConfig has key {
        id: UID,
        total_bp: u64,
        burn_share_bp: u64,
    }

    public struct ExemptList has key {
        id: UID,
        exempt: Bag, // address → true = fee exempt
    }

    public struct AdminCap has key, store { id: UID }

    // ──────────────────────────────
    // Events
    // ──────────────────────────────
    public struct TransferWithFee has copy, drop {
        from: address,
        to: address,
        gross_amount: u64,
        fee_burned: u64,
        fee_to_treasury: u64,
        net_amount: u64,
    }

    public struct QuarterlyBurnExecuted has copy, drop {
        burned_amount: u64,
        reward_amount: u64,
        caller: address,
        timestamp_ms: u64,
    }

    public struct BurnSkipped has copy, drop {
        reason: vector<u8>, // "threshold"
        treasury_balance: u64,
        timestamp_ms: u64,
        caller: address,
    }

    public struct TreasuryWithdrawal has copy, drop {
        to: address,
        amount: u64,
    }

    public struct ExemptUpdated has copy, drop {
        addr: address,
        is_exempt: bool,
    }

    public struct FeeConfigUpdated has copy, drop {
        total_bp: u64,
        burn_share_bp: u64,
    }

    // ──────────────────────────────
    // Initialization
    // ──────────────────────────────
    fun init(witness: GHOST, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency(
            witness,
            DECIMALS,
            b"GHOST",
            b"Ghost Protocol Token",
            b"Native token of Ghost Protocol – Cross-chain DeFi with AI governance",
            option::some(url::new_unsafe_from_bytes(
                b"ipfs://QmYourHashHere/ghost.png"
            )),
            ctx
        );

        transfer::public_freeze_object(metadata);

        let clock = clock::clock();
        let now = clock::timestamp_ms(&clock);

        let treasury = Treasury {
            id: object::new(ctx),
            balance: balance::zero(),
            paused: false,
            last_burn_ms: now,
        };

        let fee_config = FeeConfig {
            id: object::new(ctx),
            total_bp: TOTAL_FEE_BP,
            burn_share_bp: BURN_SHARE_BP,
        };

        let exempt_list = ExemptList {
            id: object::new(ctx),
            exempt: bag::new(ctx),
        };

        let admin_cap = AdminCap { id: object::new(ctx) };

        // Mint full supply to deployer
        let full_supply = coin::mint(&treasury_cap, TOTAL_SUPPLY, ctx);
        transfer::public_transfer(full_supply, tx_context::sender(ctx));

        transfer::share_object(treasury);
        transfer::share_object(fee_config);
        transfer::share_object(exempt_list);
        transfer::transfer(admin_cap, tx_context::sender(ctx));
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }

    // ──────────────────────────────
    // Transfer
    // ──────────────────────────────
    public entry fun transfer(
        coin: Coin<GHOST>,
        treasury: &mut Treasury,
        fee_config: &FeeConfig,
        exempt_list: &ExemptList,
        recipient: address,
        ctx: &mut TxContext
    ) {
        assert!(!treasury.paused, 0x1);
        let sender = tx_context::sender(ctx);
        let gross = coin::value(&coin);
        if (gross == 0) { transfer::public_transfer(coin, recipient); return; }

        let is_exempt = bag::contains(&exempt_list.exempt, sender);
        let fee_burned: u64 = 0;
        let fee_treasury: u64 = 0;
        let mut remaining = coin;

        if (!is_exempt && fee_config.total_bp > 0) {
            let total_fee_u128 = (gross as u128) * (fee_config.total_bp as u128) / 10000u128;
            let total_fee = total_fee_u128 as u64;
            if (total_fee > 0 && total_fee <= gross) {
                let fee_coin = coin::split(&mut remaining, total_fee, ctx);
                let burn_amount_u128 = total_fee_u128 * (fee_config.burn_share_bp as u128) / 10000u128;
                let burn_amount = burn_amount_u128 as u64;
                if (burn_amount > 0) { let burn_coin = coin::split(&mut fee_coin, burn_amount, ctx); coin::burn(burn_coin); fee_burned = burn_amount; }
                let treasury_amount = coin::value(&fee_coin);
                if (treasury_amount > 0) { balance::join(&mut treasury.balance, coin::into_balance(fee_coin)); fee_treasury = treasury_amount; } else { coin::destroy_zero(fee_coin); }
            }
        }

        transfer::public_transfer(remaining, recipient);
        event::emit(TransferWithFee { from: sender, to: recipient, gross_amount: gross, fee_burned, fee_to_treasury: fee_treasury, net_amount: gross - (fee_burned + fee_treasury) });
    }

    // ──────────────────────────────
    // Quarterly Burn
    // ──────────────────────────────
    public entry fun quarterly_burn(
        treasury: &mut Treasury,
        treasury_cap: &mut TreasuryCap<GHOST>,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        let now = clock::timestamp_ms(clock);
        let current = balance::value(&treasury.balance);
        if (current < MIN_BURN) {
            event::emit(BurnSkipped { reason: b"threshold", treasury_balance: current, timestamp_ms: now, caller: tx_context::sender(ctx) });
            return;
        }

        let burn_balance = balance::split(&mut treasury.balance, current);
        let burn_coin = coin::from_balance(burn_balance, ctx);
        coin::burn(treasury_cap, burn_coin);

        let reward_u128 = (current as u128) * (BURN_REWARD_BP as u128) / 10000u128;
        let reward = reward_u128 as u64;
        if (reward > 0 && balance::value(&treasury.balance) >= reward) {
            let reward_balance = balance::split(&mut treasury.balance, reward);
            let reward_coin = coin::from_balance(reward_balance, ctx);
            transfer::public_transfer(reward_coin, tx_context::sender(ctx));
        }

        treasury.last_burn_ms = now;
        event::emit(QuarterlyBurnExecuted { burned_amount: current, reward_amount: reward, caller: tx_context::sender(ctx), timestamp_ms: now });
    }

    // ──────────────────────────────
    // Admin functions
    // ──────────────────────────────
    public entry fun admin_force_burn(
        _: &AdminCap,
        treasury: &mut Treasury,
        treasury_cap: &mut TreasuryCap<GHOST>,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        let amount = balance::value(&treasury.balance);
        if (amount == 0) { return; }
        let burn_balance = balance::split(&mut treasury.balance, amount);
        let burn_coin = coin::from_balance(burn_balance, ctx);
        coin::burn(treasury_cap, burn_coin);
        treasury.last_burn_ms = clock::timestamp_ms(clock);
        event::emit(QuarterlyBurnExecuted { burned_amount: amount, reward_amount: 0, caller: tx_context::sender(ctx), timestamp_ms: treasury.last_burn_ms });
    }

    public entry fun withdraw_treasury(
        _: &AdminCap,
        treasury: &mut Treasury,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        let withdrawn = balance::split(&mut treasury.balance, amount);
        let coin = coin::from_balance(withdrawn, ctx);
        transfer::public_transfer(coin, recipient);
        event::emit(TreasuryWithdrawal { to: recipient, amount });
    }

    public entry fun set_paused(_: &AdminCap, treasury: &mut Treasury, paused: bool) { treasury.paused = paused; }

    public entry fun add_exempt(_: &AdminCap, exempt_list: &mut ExemptList, addr: address) {
        if (!bag::contains(&exempt_list.exempt, addr)) {
            bag::add(&mut exempt_list.exempt, addr, true);
            event::emit(ExemptUpdated { addr, is_exempt: true });
        }
    }

    public entry fun remove_exempt(_: &AdminCap, exempt_list: &mut ExemptList, addr: address) {
        if (bag::contains(&exempt_list.exempt, addr)) {
            let (_): (address, bool) = bag::remove(&mut exempt_list.exempt, addr);
            event::emit(ExemptUpdated { addr, is_exempt: false });
        }
    }
}
