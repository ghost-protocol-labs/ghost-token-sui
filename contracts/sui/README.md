<p align="center">
  <img src="https://raw.githubusercontent.com/ghost-protocol-labs/ghost-token-sui/refs/heads/main/assets/GHOST.svg" width="120" alt="GHOST Token"/>
</p>

<h2 align="center">GHOST Token Contract</h2>

<p align="center">
  Native token of <strong>Ghost Protocol</strong> — cross-chain DeFi with AI governance
</p>

---

## Tokenomics

| Feature                 | Details |
|-------------------------|---------|
| Token Name              | GHOST |
| Symbol                  | GHOST |
| Total Supply            | 20,000,000,000 |
| Decimals                | 9 |
| Transfer Fee            | 2.5% (sender pays) |
| Fee Split               | 60% burned, 40% treasury |
| Quarterly Burn Threshold| ≥ 3,000,000 GHOST |
| Admin Functions         | Pause/unpause, withdraw treasury, force burn, manage fee exemptions |

---

## Key Objects (Suiscan)

| Object         | Address | Link |
|----------------|---------|------|
| GHOST Token    | 0x6153…25de | [View](https://suiexplorer.com/object/0x615326bcb0896338ddefe033771f875a4565f649c8d70395da24318c72ac25de) |
| Treasury       | 0x2f78…7188 | [View](https://suiexplorer.com/object/0x2f78d0479d20590f8e63581feadf4f6a5b97e96340336e7c3e38ff115e117188) |
| DAO            | 0x0897…36d0 | [View](https://suiexplorer.com/object/0x0897bcfef2ec956c0633ac9050e169976bfcdfb6bf87981acba0cff585ca36d0) |
| Stake          | 0x3ccb…80a8 | [View](https://suiexplorer.com/object/0x3ccbdf9ca5a4731b055604297c42b927f1dd28bc85b9fda56b2097c00a7a80a8) |
| Multisig Admin | 0x94a5…68bc | [View](https://suiexplorer.com/object/0x94a5681ae72bb4df4df9c5e4428dbd7b0157a1dba9206b7861a8912ac8bf68bc) |

---

## Contract Highlights

- **Module:** `ghost::ghost_token`  
- **Main Functions:**
  - `init()` → deploy & mint full supply
  - `transfer()` → fee-enabled transfers
  - `quarterly_burn()` → burns treasury ≥ 3M GHOST, rewards caller
  - Admin:
    - `set_paused()`
    - `withdraw_treasury()`
    - `admin_force_burn()`
    - `add_exempt() / remove_exempt()`

---

## Development & Testing

```bash
# Build Move package
sui move build

# Run Move tests
sui move test
````

---

## Resources

* GHOST Token SVG: [assets/GHOST.svg](https://raw.githubusercontent.com/ghost-protocol-labs/ghost-token-sui/refs/heads/main/assets/GHOST.svg)
* Documentation: [Root README](../README.md)

---

## License

MIT