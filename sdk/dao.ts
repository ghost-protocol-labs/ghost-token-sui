import { ghostAddresses } from './config';
import { SuiClient, TransactionBlock } from '@mysten/sui';

const client = new SuiClient({ url: process.env.SUI_RPC });

export async function proposeVote(description: string) {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_GOV}::ghost_dao::propose_vote`,
    arguments: [tx.pure(description), tx.object(ghostAddresses.GHOST_TEAM)]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}

export async function vote(proposalId: bigint, support: boolean) {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_GOV}::ghost_dao::vote`,
    arguments: [tx.pure(proposalId), tx.pure(support), tx.object(ghostAddresses.GHOST_TEAM)]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}

export async function executeVote(proposalId: bigint) {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: `${ghostAddresses.GHOST_GOV}::ghost_dao::execute_vote`,
    arguments: [tx.pure(proposalId), tx.object(ghostAddresses.GHOST_TEAM)]
  });
  return client.signAndExecuteTransactionBlock({ transactionBlock: tx });
}
