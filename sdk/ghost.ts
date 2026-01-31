import { ghostAddresses } from './config';
import { SuiClient, TransactionBlock } from '@mysten/sui';

const client = new SuiClient({ url: process.env.SUI_RPC });

export async function mintTokens(amount: bigint) {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_TOKEN}::ghost_token::mint`,
    arguments: [tx.pure(amount), tx.object(ghostAddresses.GHOST_TEAM)]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}
