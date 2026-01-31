import { ghostAddresses } from './config';

const base = 'https://suiscan.xyz/object/';

export const SuiscanLinks = {
  GHOST_TOKEN: `${base}${ghostAddresses.GHOST_TOKEN}`,
  GHOST_TREASURY: `${base}${ghostAddresses.GHOST_TREASURY}`,
  GHOST_GOV: `${base}${ghostAddresses.GHOST_GOV}`,
  GHOST_STAKE: `${base}${ghostAddresses.GHOST_STAKE}`,
  GHOST_TEAM: `${base}${ghostAddresses.GHOST_TEAM}`,
  GHOST_RESERVE: `${base}${ghostAddresses.GHOST_RESERVE}`,
  GHOST_REWARDS: `${base}${ghostAddresses.GHOST_REWARDS}`,
  GHOST_NETWORK: `${base}${ghostAddresses.GHOST_NETWORK}`,
  GHOST_DEV: `${base}${ghostAddresses.GHOST_DEV}`,
  GHOST_PROTOCOL: `${base}${ghostAddresses.GHOST_PROTOCOL}`
};

export function openInBrowser(alias: keyof typeof SuiscanLinks) {
  const url = SuiscanLinks[alias];
  console.log(`Open in browser: ${url}`);
  const start = process.platform === 'darwin' ? 'open' :
                process.platform === 'win32' ? 'start' : 'xdg-open';
  require('child_process').exec(`${start} ${url}`);
}

export function printLink(alias: keyof typeof SuiscanLinks) {
  console.log(`${alias} Suiscan URL: ${SuiscanLinks[alias]}`);
}
