import { ghostAddresses } from './config';
import { SuiClient, TransactionBlock } from '@mysten/sui';

const client = new SuiClient({ url: process.env.SUI_RPC });

export async function transferTokens(recipient: string, amount: bigint) {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_TOKEN}::ghost_token::transfer`,
    arguments: [
      tx.object(ghostAddresses.GHOST_TOKEN),
      tx.pure(recipient),
      tx.object(ghostAddresses.GHOST_TREASURY),
      tx.object(ghostAddresses.GHOST_TEAM)
    ]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}
