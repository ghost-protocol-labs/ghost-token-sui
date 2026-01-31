<p align="center">
  <img src="https://raw.githubusercontent.com/ghost-protocol-labs/ghost-token-sui/refs/heads/main/assets/GHOST.svg" width="100" alt="GHOST Token"/>
</p>

<h1 align="center">Ghost Token Sui SDK</h1>

<p align="center">
  Native token of <strong>Ghost Protocol</strong> — cross-chain DeFi with AI governance
</p>

---

## Table of Contents

* [Tokenomics](#tokenomics)
* [Suiscan Links](#suiscan-links)
* [Installation](#installation)
* [SDK Usage](#sdk-usage)
* [CLI Commands](#cli-commands)
* [Environments](#environments)
* [License](#license)

---

## Tokenomics

| Feature                  | Details                                                             |
| ------------------------ | ------------------------------------------------------------------- |
| Token Name               | GHOST                                                               |
| Symbol                   | GHOST                                                               |
| Total Supply             | 20,000,000,000                                                      |
| Decimals                 | 9                                                                   |
| Transfer Fee             | 2.5% (sender pays)                                                  |
| Fee Split                | 60% burned, 40% treasury                                            |
| Quarterly Burn Threshold | ≥ 3,000,000 GHOST                                                   |
| Admin Functions          | Pause/unpause, withdraw treasury, force burn, manage fee exemptions |

---

## Suiscan Links

| Object         | Link                                                                                                      |
| -------------- | --------------------------------------------------------------------------------------------------------- |
| GHOST Token    | [View](https://suiexplorer.com/object/0x615326bcb0896338ddefe033771f875a4565f649c8d70395da24318c72ac25de) |
| Treasury       | [View](https://suiexplorer.com/object/0x2f78d0479d20590f8e63581feadf4f6a5b97e96340336e7c3e38ff115e117188) |
| DAO            | [View](https://suiexplorer.com/object/0x0897bcfef2ec956c0633ac9050e169976bfcdfb6bf87981acba0cff585ca36d0) |
| Stake          | [View](https://suiexplorer.com/object/0x3ccbdf9ca5a4731b055604297c42b927f1dd28bc85b9fda56b2097c00a7a80a8) |
| Multisig Admin | [View](https://suiexplorer.com/object/0x94a5681ae72bb4df4df9c5e4428dbd7b0157a1dba9206b7861a8912ac8bf68bc) |
| Team           | [View](https://suiexplorer.com/object/0x94a5681ae72bb4df4df9c5e4428dbd7b0157a1dba9206b7861a8912ac8bf68bc) |
| Reserve        | [View](https://suiexplorer.com/object/0xbac7e6ffc1ee5ae648144761d6e601da56e809e8d3da21503209e6adec5e8468) |
| Rewards        | [View](https://suiexplorer.com/object/0xbef832a2894e99414972788250b035a78947787679402a05edc728fab0555193) |
| Network        | [View](https://suiexplorer.com/object/0xc3493233ab753124c7802dc6c7886ecd58c1e1bb2b345798c5eb6579d67f790d) |
| Dev            | [View](https://suiexplorer.com/object/0xe670626f183f24f9fa74725dd1c8670f047786f363e5c5ea8b33310a6b01ff9f) |
| Protocol       | [View](https://suiexplorer.com/object/0xf2607222f566d5120265405c5d292b35de78875dbbb459270029316f7062e003) |

---

## Installation

```bash
npm install ghost-token-sui
```

Set up `.env`:

```env
SUI_NETWORK=devnet
SUI_PRIVATE_KEY=<YOUR_PRIVATE_KEY>
```

Available networks: `devnet`, `testnet`, `mainnet`

---

## SDK Usage

```ts
import { ghost, transfer, treasury, multisig, dao, suiscan } from "ghost-token-sui";

// Mint full supply (deployer only)
await ghost.executeMint();

// Transfer tokens
await transfer.transferTokens("0xRecipientAddress", 1000000000n);

// Burn treasury quarterly
await treasury.quarterlyBurnTreasury();

// Pause transfers (admin)
await multisig.setTransfersPaused(true);

// Add fee-exempt address
await multisig.addExempt("0xExemptAddress");

// DAO propose
await dao.daoPropose(["Proposal description"]);
```

---

## CLI Commands

```bash
# Mint full supply
npm run mint

# Transfer GHOST tokens
npm run transfer -- <recipient> <amount>

# Quarterly burn
npm run quarterly-burn

# Force burn treasury (admin)
npm run force-burn

# Pause or unpause transfers
npm run pause-transfers -- <true|false>

# Add/remove exempt addresses
npm run add-exempt -- <address>
npm run remove-exempt -- <address>

# Multisig actions
npm run multisig-admin -- <action> [params...]

# DAO voting
npm run dao-propose -- <args...>
npm run dao-vote -- <args...>
npm run dao-execute -- <args...>
```

---

## Environments

| Variable          | Description                        |
| ----------------- | ---------------------------------- |
| `SUI_NETWORK`     | devnet/testnet/mainnet             |
| `SUI_PRIVATE_KEY` | Hex-encoded private key for signer |

---

## Official Links

* Website: [https://ghostnetwork.fun](https://ghostnetwork.fun)
* X (Twitter): [https://x.com/ghostnetworkdotfun](https://x.com/ghostnetworkdotfun)
* Telegram: [https://t.me/ghostprotocol_sol](https://t.me/ghostprotocol_sol)

---

## License

MIT License
