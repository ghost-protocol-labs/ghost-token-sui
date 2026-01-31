# Ghost Token Contract Documentation

This folder contains the **Sui Move contracts** for the GHOST Token and its DAO governance.

---

## Hero Section / Tokenomics

### GHOST Token – Hero Summary

* **Symbol:** GHOST
* **Decimals:** 9
* **Total Supply:** 20,000,000,000 GHOST (fixed)
* **Transfer Fee:** 2.5% per transaction

  * **60% burned immediately**
  * **40% sent to treasury**
* **Quarterly Burn:** Treasury can be burned if ≥ 3,000,000 GHOST, caller receives ~1%
* **Admin Controls:** Pause transfers, withdraw treasury, manage fee exemptions
* **Multi-network Ready:** Devnet, Testnet, Mainnet

---

## Key Objects on Suiscan


| Alias | Address | Suiscan Link |
|------------------|--------------------------------------------------------------------|------------------------------------------------------------------------------|
| GHOST_TOKEN | 0x615326bcb0896338ddefe033771f875a4565f649c8d70395da24318c72ac25de | [View on Suiscan](https://suiscan.xyz/object/0x615326bcb0896338ddefe033771f875a4565f649c8d70395da24318c72ac25de) |
| GHOST_TREASURY | 0x2f78d0479d20590f8e63581feadf4f6a5b97e96340336e7c3e38ff115e117188 | [View on Suiscan](https://suiscan.xyz/object/0x2f78d0479d20590f8e63581feadf4f6a5b97e96340336e7c3e38ff115e117188) |
| GHOST_GOV | 0x0897bcfef2ec956c0633ac9050e169976bfcdfb6bf87981acba0cff585ca36d0 | [View on Suiscan](https://suiscan.xyz/object/0x0897bcfef2ec956c0633ac9050e169976bfcdfb6bf87981acba0cff585ca36d0) |
| GHOST_STAKE | 0x3ccbdf9ca5a4731b055604297c42b927f1dd28bc85b9fda56b2097c00a7a80a8 | [View on Suiscan](https://suiscan.xyz/object/0x3ccbdf9ca5a4731b055604297c42b927f1dd28bc85b9fda56b2097c00a7a80a8) |
| GHOST_TEAM | 0x94a5681ae72bb4df4df9c5e4428dbd7b0157a1dba9206b7861a8912ac8bf68bc | [View on Suiscan](https://suiscan.xyz/object/0x94a5681ae72bb4df4df9c5e4428dbd7b0157a1dba9206b7861a8912ac8bf68bc) |
| GHOST_RESERVE | 0xbac7e6ffc1ee5ae648144761d6e601da56e809e8d3da21503209e6adec5e8468 | [View on Suiscan](https://suiscan.xyz/object/0xbac7e6ffc1ee5ae648144761d6e601da56e809e8d3da21503209e6adec5e8468) |
| GHOST_REWARDS | 0xbef832a2894e99414972788250b035a78947787679402a05edc728fab0555193 | [View on Suiscan](https://suiscan.xyz/object/0xbef832a2894e99414972788250b035a78947787679402a05edc728fab0555193) |
| GHOST_NETWORK | 0xc3493233ab753124c7802dc6c7886ecd58c1e1bb2b345798c5eb6579d67f790d | [View on Suiscan](https://suiscan.xyz/object/0xc3493233ab753124c7802dc6c7886ecd58c1e1bb2b345798c5eb6579d67f790d) |
| GHOST_DEV | 0xe670626f183f24f9fa74725dd1c8670f047786f363e5c5ea8b33310a6b01fff | [View on Suiscan](https://suiscan.xyz/object/0xe670626f183f24f9fa74725dd1c8670f047786f363e5c5ea8b33310a6b01fff) |
| GHOST_PROTOCOL | 0xf2607222f566d5120265405c5d292b35de78875dbbb459270029316f7062e003 | [View on Suiscan](https://suiscan.xyz/object/0xf2607222f566d5120265405c5d292b35de78875dbbb459270029316f7062e003) |


---

## Contract Modules

### 1. ghost_token.move

* Implements the **GHOST token**.
* Handles **minting, transfers, fees, treasury, and quarterly burn**.
* Admin functions for **pausing transfers, forcing burns, managing fee-exempt addresses**.

### 2. ghost_dao.move

* Implements **DAO governance**.
* Basic structure for **proposals, voting, and execution hooks**.
* Can be extended to **token-weighted voting, quorum enforcement, and proposal lifecycle**.

---

## Key Structs

| Struct       | Purpose                                                   |
| ------------ | --------------------------------------------------------- |
| `GHOST`      | Token type                                                |
| `Treasury`   | Holds treasury balance, paused state, last burn timestamp |
| `ExemptList` | Mapping of addresses exempt from fees                     |
| `AdminCap`   | Authority for admin functions                             |
| `Proposal`   | DAO proposals                                             |
| `Dao`        | Holds vector of proposals                                 |

---

## Tokenomics Overview

### Transfers

* 2.5% fee on all transfers (unless sender is exempt)

  * 60% burned, reducing supply
  * 40% added to treasury
* Example: Transfer 1,000 GHOST → 25 GHOST fee

  * Burn: 15 GHOST
  * Treasury: 10 GHOST
  * Recipient receives: 975 GHOST

### Quarterly Burn

* Treasury balance must be ≥ 3,000,000 GHOST
* Burns the **entire treasury balance**
* Caller receives ~1% of the treasury

### Admin Controls

* Pause or unpause transfers
* Withdraw treasury
* Force burn treasury
* Add/remove fee-exempt addresses

---

## Deployment Steps

1. **Init Contract:** Deploy `ghost_token.move` and call `init`
2. **Mint Supply:** Full supply sent to deployer/admin
3. **Treasury & Admin Setup:** AdminCap and TreasuryCap created
4. **DAO Deployment:** Deploy `ghost_dao.move` for proposal management
5. **Wallet Integration:** Connect to scripts / SDK for CLI interactions

---

## Hero Graphic / Tokenomics (ASCII Concept)

```
      ________GHOST TOKEN HERO________
     /                                  \
    |  Total Supply: 20B GHOST           |
    |  Transfer Fee: 2.5%                |
    |    -> 60% Burned                   |
    |    -> 40% Treasury                 |
    |  Quarterly Burn: Treasury ≥ 3M     |
    |    -> Caller Reward: 1%            |
    |  Admin: Pause, Withdraw, Force Burn|
     \__________________________________/
```
