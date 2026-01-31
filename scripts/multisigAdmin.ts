#!/usr/bin/env ts-node
import 'dotenv/config';
import {
  setPaused,
  addExempt,
  removeExempt,
  forceBurn,
  printLink
} from '../sdk';

const action = process.argv[2]; // 'pause', 'unpause', 'force-burn', 'add-exempt', 'remove-exempt'
const target = process.argv[3]; // For exempt address

if (!action) throw new Error(`Usage: npm run multisig-admin -- <pause|unpause|force-burn|add-exempt|remove-exempt> [address]`);

async function main() {
  switch (action) {
    case 'pause':
      await setPaused(true);
      console.log('⏸ Transfers paused.');
      break;

    case 'unpause':
      await setPaused(false);
      console.log('▶️ Transfers unpaused.');
      break;

    case 'force-burn':
      await forceBurn();
      console.log('💥 Treasury force-burn executed.');
      printLink('GHOST_TREASURY');
      break;

    case 'add-exempt':
      if (!target) throw new Error('Address required for add-exempt.');
      await addExempt(target);
      console.log(`✅ Address added to fee exemption: ${target}`);
      break;

    case 'remove-exempt':
      if (!target) throw new Error('Address required for remove-exempt.');
      await removeExempt(target);
      console.log(`✅ Address removed from fee exemption: ${target}`);
      break;

    default:
      throw new Error('Invalid action. Use pause, unpause, force-burn, add-exempt, remove-exempt.');
  }
}

main();
