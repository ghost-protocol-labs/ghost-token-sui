#!/usr/bin/env ts-node
import 'dotenv/config';
import { mintTokens, printLink } from '../sdk';

async function main() {
  const totalSupply = 20_000_000_000n * 1_000_000_000n;
  await mintTokens(totalSupply);
  console.log('✅ Full supply minted.');
  printLink('GHOST_TOKEN');
}

main();
