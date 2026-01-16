# 👻 GHOST Token

**Version:** v1.0.0-alpha
**Status:** Authoritative Specification

GHOST is a **cross-chain token** available on **Solana** and **Sui**, designed for long-term ecosystem growth with clear separation between **devnet testing** and **mainnet production**.

---

## 🌐 What “Cross-Chain” Means

* ✅ Same token **identity and brand** across chains
* ❌ Not a single global supply (unless a future bridge enforces it)

GHOST exists **natively** on multiple blockchains with:

* the same symbol (`GHOST`)
* the same purpose
* **chain-specific parameters** (decimals, max supply)

This model is used by established tokens such as **USDC**, **USDT**, and **WETH**.

---

## 🧪 Devnet vs Mainnet

### Devnet (Testing Only)

| Chain         | Token    | Purpose           |
| ------------- | -------- | ----------------- |
| Solana Devnet | **GHST** | Faucet test token |
| Sui Devnet    | **GHST** | Faucet test token |

> **GHST is devnet-only**
>
> * Never bridged
> * Never deployed to mainnet
> * Has no monetary or market value

### Mainnet (Production)

| Chain          | Token     | Symbol |
| -------------- | --------- | ------ |
| Solana Mainnet | **GHOST** | GHOST  |
| Sui Mainnet    | **GHOST** | GHOST  |

---

## 🪙 Token Parameters

### GHOST — Solana Mainnet

| Field      | Value          |
| ---------- | -------------- |
| Symbol     | GHOST          |
| Decimals   | 9              |
| Max Supply | 18,446,000,000 |
| Faucet     | ❌ Disabled     |
| Standard   | SPL Token-2022 |

---

### GHOST — Sui Mainnet

| Field      | Value          |
| ---------- | -------------- |
| Symbol     | GHOST          |
| Decimals   | 18             |
| Max Supply | 20,000,000,000 |
| Faucet     | ❌ Disabled     |

> ⚠️ Same symbol ≠ same decimals
> ⚠️ Same symbol ≠ shared ledger

---

## 🚰 Faucets (Devnet Only)

### GHST Faucet Rules

| Chain         | Claim Amount | Decimals | Availability |
| ------------- | ------------ | -------- | ------------ |
| Solana Devnet | 5,000 GHST   | 9        | ✅            |
| Sui Devnet    | 5,000 GHST   | 18       | ✅            |

* Open to **developers, users, and testers**
* Cooldowns and rate limits apply
* **No faucet exists on mainnet**

---

## 🔒 Supply Model

### Current Model (v1.x)

* Independent max supply per chain
* No automatic mint/burn parity
* No bridge required

This approach is:

* Safe
* Auditable
* Exchange-friendly

### Future Model (v2+, Optional)

A future hard-parity bridge would require:

* Canonical mint chain
* Lock/burn on source
* Mint on destination
* Strict supply accounting
* Third-party audits

> 🚫 Not part of v1.0.0-alpha

---

## ⚠️ Devnet Disclaimer (Mandatory)

> **GHST is a devnet-only test token.**
> It has **no monetary value**, **no market value**, and **no guarantee of conversion** to mainnet GHOST.
>
> GHST is provided strictly for development, testing, and demonstration purposes.

---

## 📊 Final Token Matrix

| Token | Chain  | Network | Decimals | Max Supply |
| ----- | ------ | ------- | -------- | ---------- |
| GHST  | Solana | Devnet  | 9        | Test only  |
| GHST  | Sui    | Devnet  | 18       | Test only  |
| GHOST | Solana | Mainnet | 9        | 18.446B    |
| GHOST | Sui    | Mainnet | 18       | 20.0B      |

---

## ✅ Status

* GHOST is **cross-chain**
* GHST is **devnet-only**
* No naming conflicts
* No supply ambiguity
* Safe for Alpha
* Ready for developers, users, and exchanges

---

## 📎 Links

* Solana Program: *GhostFaucet (Devnet)*
* Sui Module: *GhostFaucet (Devnet)*
* Documentation: *Coming soon*

---

© 2026 Ghost Protocol
