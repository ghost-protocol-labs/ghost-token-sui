# Ghost Token SDK — Sui Move

**Ghost Protocol** native token SDK, modular TypeScript + CLI for Devnet/Testnet/Mainnet.

---

## 🌟 Hero Tokenomics

- **Token Name:** GHOST  
- **Alias:** GHOST_TOKEN  
- **Total Supply:** 20,000,000,000 GHOST  
- **Decimals:** 9  
- **Transfer Fee:** 2.5%  
  - 60% burned immediately  
  - 40% goes to treasury  
- **Quarterly Burn:** Treasury burned permissionlessly if ≥ 3,000,000 GHOST, caller rewarded ~1%  
- **Admin Controls:** Pause/unpause transfers, force burn, manage fee exemptions  
- **Cross-chain Ready:** Devnet / Testnet / Mainnet

---

## 📦 SDK Structure

```

sdk/
├── config.ts       # Ghost addresses & typed loader
├── ghost.ts        # Token interactions (mint)
├── transfer.ts     # Transfers
├── treasury.ts     # Quarterly burn / force burn
├── multisig.ts     # Admin actions
├── dao.ts          # DAO governance
├── suiscan.ts      # Explorer links & utilities
├── index.ts        # Re-export all modules

scripts/
├── mint.ts
├── transfer.ts
├── quarterlyBurn.ts
├── forceBurn.ts
├── pauseTransfers.ts
├── manageExempt.ts
├── multisigAdmin.ts
├── daoVote.ts

````

---

## 🚀 CLI Usage

All scripts are run via **npm run <command>**:

| Command | Description |
|---------|-------------|
| `npm run mint` | Mint full supply to deployer |
| `npm run transfer -- <recipient> <amount>` | Transfer GHOST tokens |
| `npm run quarterly-burn` | Execute treasury quarterly burn |
| `npm run force-burn` | Force burn treasury (admin) |
| `npm run pause-transfers -- <true|false>` | Pause/unpause transfers |
| `npm run add-exempt -- <address>` | Add address to fee exemption |
| `npm run remove-exempt -- <address>` | Remove address from fee exemption |
| `npm run multisig-admin -- <pause|unpause|force-burn|add-exempt|remove-exempt> [address]` | Multisig admin operations |
| `npm run dao-propose -- "<description>"` | Propose DAO vote |
| `npm run dao-vote -- <proposalId> <true|false>` | Vote on DAO proposal |
| `npm run dao-execute -- <proposalId>` | Execute DAO proposal |

---

## 🔗 Suiscan Links

- **GHOST_TOKEN:** [Suiscan](https://suiscan.xyz/object/0x615326bcb0896338ddefe033771f875a4565f649c8d70395da24318c72ac25de)  
- **GHOST_TREASURY:** [Suiscan](https://suiscan.xyz/object/0x2f78d0479d20590f8e63581feadf4f6a5b97e96340336e7c3e38ff115e117188)  
- **GHOST_GOV:** [Suiscan](https://suiscan.xyz/object/0x0897bcfef2ec956c0633ac9050e169976bfcdfb6bf87981acba0cff585ca36d0)  
- **GHOST_STAKE:** [Suiscan](https://suiscan.xyz/object/0x3ccbdf9ca5a4731b055604297c42b927f1dd28bc85b9fda56b2097c00a7a80a8)  
- **GHOST_TEAM:** [Suiscan](https://suiscan.xyz/object/0x94a5681ae72bb4df4df9c5e4428dbd7b0157a1dba9206b7861a8912ac8bf68bc)  
- **GHOST_RESERVE:** [Suiscan](https://suiscan.xyz/object/0xbac7e6ffc1ee5ae648144761d6e601da56e809e8d3da21503209e6adec5e8468)  
- **GHOST_REWARDS:** [Suiscan](https://suiscan.xyz/object/0xbef832a2894e99414972788250b035a78947787679402a05edc728fab0555193)  
- **GHOST_NETWORK:** [Suiscan](https://suiscan.xyz/object/0xc3493233ab753124c7802dc6c7886ecd58c1e1bb2b345798c5eb6579d67f790d)  
- **GHOST_DEV:** [Suiscan](https://suiscan.xyz/object/0xe670626f183f24f9fa74725dd1c8670f047786f363e5c5ea8b33310a6b01fff)  
- **GHOST_PROTOCOL:** [Suiscan](https://suiscan.xyz/object/0xf2607222f566d5120265405c5d292b35de78875dbbb459270029316f7062e003)

---

## 🌐 Official Links

- Website: [https://ghostnetwork.fun](https://ghostnetwork.fun)  
- X (Twitter): [https://x.com/ghostnetworkdotfun](https://x.com/ghostnetworkdotfun)  
- Telegram: [https://t.me/ghostprotocol_sol](https://t.me/ghostprotocol_sol)

---

## 🛠 Environment

- Set RPC endpoint in `.env`:

```bash
SUI_RPC=https://fullnode.devnet.sui.io:443
````

* Install dependencies:

```bash
pnpm install
```

* Build SDK:

```bash
pnpm run build
```

* Run CLI scripts:

```bash
pnpm run <command>
```

---

## ✅ Notes

* Ensure multisig/admin addresses are secured for production.
* Treasury burns and fee exemptions can be monitored via Suiscan.
* Use Devnet/Testnet before deploying on Mainnet.

``