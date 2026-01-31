#!/usr/bin/env ts-node
import { quarterlyBurn, printLink } from '../sdk';

async function main() {
  await quarterlyBurn();
  console.log('🔥 Quarterly burn executed.');
  printLink('GHOST_TREASURY');
}

main();
