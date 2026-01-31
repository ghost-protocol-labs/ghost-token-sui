# GHOST Token (Sui Move)

**Ghost Protocol** native token – cross-chain DeFi with AI governance.

This repository contains the full **production-ready package** for the GHOST Token on Sui, including:

- Move contract  
- Resources and metadata  
- CLI scripts for devnet/testnet/mainnet  
- Deployment and admin tooling  
- Dashboard and Telegram integration placeholders  

---

## **Token Details**

- **Symbol:** GHOST  
- **Decimals:** 9  
- **Total Supply:** 20,000,000,000 (fixed)  
- **Transfer Fee:** 2.5%  
  - 60% burned immediately (1.5% of transfer)  
  - 40% sent to treasury (1.0% of transfer)  
- **Exemptions:** Whitelisted addresses pay 0% fee  
- **Quarterly Burn:** Treasury burn ≥3,000,000 GHOST  
  - Caller reward: ~1% of burned amount  
  - Occurs roughly every 90 days  

---

## **Tokenomics at a Glance**

| Action               | Rate          | Outcome                     |
|----------------------|---------------|-----------------------------|
| Transfer fee         | 2.5%          | —                           |
| Immediate burn       | 60% of fee    | Supply ↓                    |
| Treasury accrual     | 40% of fee    | Treasury balance ↑          |
| Quarterly burn       | All treasury  | Supply ↓ (if ≥3M)           |
| Caller reward        | ~1% of burn   | Paid to transaction caller  |

---

## **Folder Structure**

```

ghost-token-sui/
├── contracts/
│   ├── ghost_token.move
│   ├── Move.toml
│   └── resources/
│       ├── ghost-logo-1000x1000.png
│       └── metadata.json
├── scripts/
│   ├── transfer.ts
│   ├── transfer_no_fee.ts
│   ├── quarterly_burn.ts
│   ├── admin_force_burn.ts
│   ├── withdraw_treasury.ts
│   ├── pause_transfers.ts
│   ├── add_exempt.ts
│   ├── remove_exempt.ts
│   ├── deploy.ts
│   └── README.md
├── scripts/config/
│   ├── devnet.js
│   ├── testnet.js
│   ├── mainnet.js
│   └── README.md
├── metadata.json
├── README.md   <- This file
├── package.json
└── tsconfig.json

````

---

## **CLI Scripts Overview**

| Script | Description |
|--------|-------------|
| `transfer.ts` | Transfer GHOST with fee |
| `transfer_no_fee.ts` | Transfer without fee |
| `quarterly_burn.ts` | Permissionless quarterly burn (≥3M GHOST) |
| `admin_force_burn.ts` | Admin force burn treasury |
| `withdraw_treasury.ts` | Admin withdrawal |
| `pause_transfers.ts` | Pause/unpause transfers |
| `add_exempt.ts` / `remove_exempt.ts` | Manage fee exemptions |
| `deploy.ts` | Deploy Move contract |
| `scripts/README.md` | Detailed usage instructions |

---

## **Network Configs**

- Devnet, Testnet, Mainnet configs in `scripts/config/`  
- Update `<PACKAGE_ID>`, `<TREASURY_OBJ_ID>`, `<ADMIN_CAP_OBJ_ID>` per network  
- Supports multi-network deployment  

---

## **Quick CLI Commands**

```bash
# Deploy contract
npm run deploy:devnet
npm run deploy:testnet
npm run deploy:mainnet

# Transfer tokens
npm run transfer -- devnet <coin_id> <recipient>
npm run transfer:no-fee -- devnet <coin_id> <recipient>

# Treasury burns
npm run quarterly-burn -- devnet
npm run force-burn -- devnet

# Admin actions
npm run withdraw-treasury -- devnet <amount> <recipient>
npm run pause-transfers -- devnet true
npm run add-exempt -- devnet 0x1234
npm run remove-exempt -- devnet 0x1234
````

---

## **Metadata & Resources**

* Token icon: `ipfs://Qm.../ghost-logo-1000x1000.png`
* Metadata file: `metadata.json`
* Dashboard: `[Your dashboard URL here]`
* Telegram: `[Your Telegram link here]`

---

## **Sui CLI Setup**

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# Install Node.js 25+
node -v
npm -v

# Install Sui CLI
git clone https://github.com/MystenLabs/sui.git
cd sui
git checkout main
cargo install --path crates/sui
sui --version

# Generate wallet and set network
sui keytool generate
export SUI_RPC_URL=https://fullnode.devnet.sui.io:443
sui client active-address
```

* Switch `SUI_RPC_URL` for **testnet** or **mainnet**

---

## **Security Notes**

* Protect `TreasuryCap` and `AdminCap` objects
* Use multisig for admin keys in production
* Only treasury/admin functions can mint, withdraw, or burn beyond fees

---

## **License**

MIT License

Copyright (c) 2026 Ghost Protocol Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
