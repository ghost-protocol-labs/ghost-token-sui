#!/usr/bin/env ts-node
import { proposeVote, vote, executeVote, printLink } from '../sdk';

const action = process.argv[2]; // 'propose' | 'vote' | 'execute'
const arg1 = process.argv[3];
const arg2 = process.argv[4]; // For vote: true/false

async function main() {
  if (action === 'propose') {
    await proposeVote(arg1);
    console.log('📊 DAO vote proposed');
    printLink('GHOST_GOV');
  } else if (action === 'vote') {
    if (arg2 !== 'true' && arg2 !== 'false') throw new Error('Vote must be true or false');
    await vote(BigInt(arg1), arg2 === 'true');
    console.log(`✅ Voted ${arg2} on proposal ${arg1}`);
  } else if (action === 'execute') {
    await executeVote(BigInt(arg1));
    console.log(`🚀 Executed DAO proposal ${arg1}`);
    printLink('GHOST_GOV');
  } else {
    throw new Error('Invalid action. Use propose, vote, or execute.');
  }
}

main();
