#!/usr/bin/env ts-node
import 'dotenv/config';
import { transferTokens, printLink } from '../sdk';

async function main() {
  const recipient = process.argv[2];
  const amount = BigInt(process.argv[3]) * 1_000_000_000n;

  if (!recipient || !amount) throw new Error('Usage: npm run transfer -- <recipient> <amount>');

  await transferTokens(recipient, amount);
  console.log(`✅ Transferred ${amount} GHOST to ${recipient}`);
  printLink('GHOST_TOKEN');
}

main();
