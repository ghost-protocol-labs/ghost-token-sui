import { ghostAddresses } from './config';
import { SuiClient, TransactionBlock } from '@mysten/sui';

const client = new SuiClient({ url: process.env.SUI_RPC });

export async function quarterlyBurn() {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_TOKEN}::ghost_token::quarterly_burn`,
    arguments: [tx.object(ghostAddresses.GHOST_TREASURY), tx.object(ghostAddresses.GHOST_TEAM)]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}

export async function forceBurn() {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_TOKEN}::ghost_token::admin_force_burn`,
    arguments: [tx.object(ghostAddresses.GHOST_TREASURY), tx.object(ghostAddresses.GHOST_TEAM)]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}
