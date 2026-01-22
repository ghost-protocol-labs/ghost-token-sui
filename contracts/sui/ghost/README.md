# Sui Contracts — Ghost Network

This directory contains **all Sui Move smart contracts** for the Ghost Network ecosystem.

It defines:
- ✅ **Canonical GHOST token on Sui (mainnet)**
- 🗳️ DAO governance & TreasuryCap custody
- 🌉 Bridge vault logic (Sui ↔ Solana)
- 🧪 **GHST test token** (devnet / testnet only)

> **Important:**  
> **GHOST** is the production token.  
> **GHST** is strictly for testing and has no economic or governance relationship to GHOST.

---

## 📦 Directory Structure

```

contracts/sui/
├── ghost/                    # ✅ MAINNET — Canonical GHOST
│   ├── Move.toml
│   └── sources/
│       ├── ghost_token.move  # Immutable GHOST coin
│       ├── dao.move          # DAO governance
│       ├── treasury.move     # TreasuryCap custody
│       ├── bridge_vault.move # Lock / unlock vault
│       ├── bridge_events.move# Bridge event schema
│       ├── pause.move        # Emergency pause
│       └── errors.move       # Shared error codes
│
├── ghst-test/                # ⚠️ DEVNET / TESTNET ONLY
│   ├── Move.toml
│   └── sources/
│       └── ghst_token.move   # Test token (GHST)
│
└── deploy/
├── publish_mainnet.sh
├── publish_testnet.sh
├── verify_supply.sh
└── lock_treasurycap.sh

````

---

## 🪙 Canonical Token — GHOST (Mainnet)

**Package:** `contracts/sui/ghost`

### Token Parameters
- **Name:** Ghost Network Token
- **Symbol:** GHOST
- **Decimals:** 9
- **Total Supply:** **20,000,000,000 GHOST (fixed)**
- **Standard:** Sui `coin` framework
- **Mint Authority:** DAO-controlled `TreasuryCap`

### Supply Guarantees
- Entire supply is minted according to protocol rules
- No inflation beyond 20B
- No hidden mint paths
- TreasuryCap is never publicly accessible

---

## 🔒 Immutability & Upgrades

### Immutable
- `ghost_token.move`  
  → **Never upgraded after v1.0.0**

This guarantees:
- Fixed supply
- Stable coin type
- Exchange & indexer safety

### Upgradeable (DAO-Controlled)
- `dao.move`
- `treasury.move`
- `bridge_*`
- `pause.move`

**Upgrade conditions**
- DAO multisig approval
- ≥ 2/3 quorum
- Optional timelock (24–72h recommended)

Public statement:
> “The GHOST token contract is immutable. Governance and bridge modules may be upgraded via on-chain DAO governance.”

---

## 🧪 Test Token — GHST (Devnet / Testnet)

**Package:** `contracts/sui/ghst-test`

### Purpose
- Wallet integration testing
- Frontend development
- Bridge simulations

### Hard Rules
- ❌ Never deployed to mainnet
- ❌ Never bridged
- ❌ Never listed
- ❌ Never shares state with GHOST

This strict isolation is intentional and audit-enforced.

---

## 🗳️ DAO & Treasury

**Core responsibilities**
- Custody of TreasuryCap
- Controlled minting (if enabled)
- Bridge configuration
- Emergency pause / resume
- Metadata version upgrades (if enabled)

**Security model**
- Multisig DAO
- Explicit access checks
- No single-key mint authority

---

## 🌉 Bridge (Sui Side)

**Modules**
- `bridge_vault.move`
- `bridge_events.move`

### Flow (Sui → Solana)
1. User locks GHOST into Sui vault
2. Event emitted with amount + nonce
3. Relayer verifies event
4. Wrapped GHOST minted on Solana

### Reverse Flow
- Burn wrapped GHOST on Solana
- Proof submitted
- GHOST unlocked on Sui

### Protections
- Replay protection (nonce)
- Rate limits
- DAO-controlled relayer set
- Emergency pause

---

## 🧾 Metadata & Versioning

- On-chain metadata is frozen at creation
- Off-chain metadata follows **versioned JSON**
- DAO may approve metadata version upgrades
- No metadata change can affect supply or ownership

---

## 🚀 Build & Deployment

### Build
```bash
cd contracts/sui/ghost
sui move build
````

### Publish (Mainnet)

```bash
./deploy/publish_mainnet.sh
```

### Verify Supply

```bash
./deploy/verify_supply.sh
```

---

## 🔍 Audit & Listing Notes

* Canonical supply fixed at 20B
* Clear separation: GHOST (prod) vs GHST (test)
* Bridge minting strictly proof-based
* Architecture compatible with:

  * CoinMarketCap
  * CoinGecko
  * Major exchanges

---

## 📜 License

See root `LICENSE` file.

---

## 👻 Ghost Network

* Website: [https://ghostnetwork.fun](https://ghostnetwork.fun)
* GitHub: [https://github.com/ghost-protocol-labs](https://github.com/ghost-protocol-labs)
