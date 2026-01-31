import { ghostAddresses } from './config';
import { SuiClient, TransactionBlock } from '@mysten/sui';

const client = new SuiClient({ url: process.env.SUI_RPC });

export async function setPaused(paused: boolean) {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_TOKEN}::ghost_token::set_paused`,
    arguments: [tx.pure(paused), tx.object(ghostAddresses.GHOST_TEAM)]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}

export async function addExempt(address: string) {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_TOKEN}::ghost_token::add_exempt`,
    arguments: [tx.pure(address), tx.object(ghostAddresses.GHOST_TEAM)]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}

export async function removeExempt(address: string) {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_TOKEN}::ghost_token::remove_exempt`,
    arguments: [tx.pure(address), tx.object(ghostAddresses.GHOST_TEAM)]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}
