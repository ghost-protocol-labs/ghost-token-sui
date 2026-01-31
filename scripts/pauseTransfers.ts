#!/usr/bin/env ts-node
import { setPaused } from '../sdk';

const pausedArg = process.argv[2];
if (pausedArg !== 'true' && pausedArg !== 'false') throw new Error('Usage: npm run pause-transfers -- <true|false>');

async function main() {
  const paused = pausedArg === 'true';
  await setPaused(paused);
  console.log(`⏸ Transfers paused=${paused}`);
}

main();
