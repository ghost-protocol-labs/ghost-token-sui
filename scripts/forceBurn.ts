#!/usr/bin/env ts-node
import { forceBurn } from '../sdk/treasury';
import { printLink } from '../sdk/suiscan';

async function main() {
  await forceBurn();
  console.log('💥 Force burn executed.');
  printLink('GHOST_TREASURY');
}

main();
