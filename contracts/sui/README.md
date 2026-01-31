# **GHOST Token (Sui Move)**

## **1️. Overview**

**GHOST Token** is the native token of **Ghost Protocol**, a cross-chain DeFi platform with AI governance.

**Key Highlights:**

* **Fixed Supply:** 20,000,000,000 GHOST
* **Decimals:** 9
* **Transfer Fee:** 2.5% (sender pays)

  * **60% burned immediately**
  * **40% goes to the treasury**
* **Quarterly Burn:** Treasury can be burned permissionlessly if ≥ 3,000,000 GHOST, caller rewarded ~1%
* **Admin Controls:** Pause/unpause transfers, withdraw treasury, force burn, manage fee exemptions
* **Multi-network ready:** Devnet, Testnet, Mainnet

---

## **2️. Token Mechanics**

### **Transfer Fee Logic**

1. Every transfer charges **2.5%** by default.
2. **60% of the fee** is burned (reduces total supply).
3. **40% of the fee** goes to the **treasury balance**.
4. **Exempt addresses** can skip the fee entirely.

**Example:**

* Transfer 1,000 GHOST → Fee 25 GHOST

  * Burn: 15 GHOST
  * Treasury: 10 GHOST
  * Recipient receives: 975 GHOST

---

### **Quarterly Burn**

* Any user or admin can trigger **`quarterly_burn`**.
* Treasury balance must be ≥ **3,000,000 GHOST**.
* Burns **entire treasury balance**.
* Caller receives **~1% reward** from treasury.
* Timestamp updated to track last burn.

---

### **Admin Functions**

| Function            | Purpose                               |
| ------------------- | ------------------------------------- |
| `admin_force_burn`  | Force burn entire treasury anytime    |
| `withdraw_treasury` | Withdraw specific GHOST from treasury |
| `set_paused`        | Pause or unpause transfers            |
| `add_exempt`        | Add address to fee-exempt list        |
| `remove_exempt`     | Remove address from fee-exempt list   |

---

## **3️. Contract Structure**

**Move module:** `ghost::ghost_token`

**Key Structs:**

* `GHOST` → Token type
* `Treasury` → Holds treasury balance, paused state, last burn timestamp
* `FeeConfig` → Holds transfer fee & burn split
* `ExemptList` → Bag mapping addresses exempt from fees
* `AdminCap` → Authority for admin functions

**Key Entry Functions:**

* `init` → Initializes contract, mints **20B GHOST** to deployer, sets up treasury and admin caps
* `transfer` → Handles transfers with fees and optional burn/treasury split
* `transfer_no_fee` → Free transfer for special cases
* `quarterly_burn` → Burns treasury if ≥ 3M GHOST, rewards caller
* Admin functions → Force burn, withdraw treasury, pause transfers, manage exemptions

---

## **4️. How it Works Step by Step**

1. **Deployment:**

   * Deployer calls `init` → receives full supply of **20B GHOST**
   * Treasury and admin caps are created
   * FeeConfig & ExemptList initialized

2. **User Transfers:**

   * Calls `transfer`
   * Fee calculated → Burn portion destroyed, Treasury portion added
   * Exempt addresses bypass fees

3. **Quarterly Burn:**

   * Anyone can call `quarterly_burn`
   * Treasury balance checked (≥ 3M GHOST)
   * Treasury is burned, caller rewarded

4. **Admin Operations:**

   * Admin can withdraw from treasury, pause transfers, or force burn

---

## **5️. Example CLI Usage (TypeScript)**

```bash
# Transfer tokens
npm run transfer -- devnet <coin_id> <recipient>

# Trigger quarterly burn
npm run quarterly-burn -- devnet

# Force burn treasury (admin)
npm run force-burn -- devnet

# Pause transfers
npm run pause-transfers -- devnet true

# Add exempt address
npm run add-exempt -- devnet 0x1234
```

---

## **6️. Security Notes**

* Use **multisig** for `AdminCap` in production
* Protect treasury minimums to ensure quarterly burn can function
* Avoid sending treasury funds to untrusted addresses

---

## Ghost Network

* Website: [https://ghostnetwork.fun](https://ghostnetwork.fun)
* GitHub: [https://github.com/ghost-protocol-labs](https://github.com/ghost-protocol-labs)

---

## **7️. License**

MIT License – see LICENSE

Built on **Sui Move**.

---
