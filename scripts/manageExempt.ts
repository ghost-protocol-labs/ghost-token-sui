#!/usr/bin/env ts-node
import { addExempt, removeExempt } from '../sdk';

const action = process.argv[2]; // 'add' or 'remove'
const address = process.argv[3];

if (!action || !address) throw new Error('Usage: npm run add-exempt/remove-exempt -- <add|remove> <address>');

async function main() {
  if (action === 'add') await addExempt(address);
  else if (action === 'remove') await removeExempt(address);
  else throw new Error('Invalid action. Use add or remove.');

  console.log(`✅ ${action === 'add' ? 'Added' : 'Removed'} fee exempt: ${address}`);
}

main();
