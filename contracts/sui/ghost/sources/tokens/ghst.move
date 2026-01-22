module ghst::ghst {
    use sui::coin::{Self, TreasuryCap};
    use sui::tx_context::{TxContext, sender};
    use sui::transfer;
    use std::option;

    /// GHST must NEVER be published at a mainnet address.
    const E_MAINNET_PUBLISH_FORBIDDEN: u64 = 0;

    /// Replace with your known testnet/devnet publisher address
    const ALLOWED_PUBLISHER: address = @0xA;

    struct GHST has drop {}

    fun init(otw: GHST, ctx: &mut TxContext) {
        // 🔐 Compile-time + publish-time safety
        assert!(sender(ctx) == ALLOWED_PUBLISHER, E_MAINNET_PUBLISH_FORBIDDEN);

        let treasury_cap = create_currency(otw, ctx);
        transfer::public_transfer(treasury_cap, sender(ctx));
    }

    fun create_currency<T: drop>(
        otw: T,
        ctx: &mut TxContext
    ): TreasuryCap<T> {
        let (treasury_cap, metadata) = coin::create_currency(
            otw,
            9,
            b"GHST",
            b"Ghost Test Token",
            b"DEVNET / TESTNET ONLY — NEVER MAINNET",
            option::none(),
            ctx
        );

        transfer::public_freeze_object(metadata);
        treasury_cap
    }

    public entry fun mint(
        cap: &mut TreasuryCap<GHST>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(cap, amount, recipient, ctx);
    }

    public entry fun burn(
        cap: &mut TreasuryCap<GHST>,
        coin: coin::Coin<GHST>
    ) {
        coin::burn(cap, coin);
    }

    #[test_only]
    public fun init_for_test(ctx: &mut TxContext) {
        init(GHST {}, ctx);
    }
}
