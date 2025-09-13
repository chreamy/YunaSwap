// This script can be used to deploy the "Storage" contract using ethers.js library.
// Please make sure to compile "./contracts/1_Storage.sol" file before running this script.
// And use Right click -> "Run" from context menu of the file to run the script. Shortcut: Ctrl+Shift+S
import { ethers } from 'hardhat';

async function main() {
  const factoryAddress = '0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f'; // Uniswap V2 factory address
  const WETHAddress = '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2'; // WETH address
  
  const UniswapV2Router02 = await ethers.getContractFactory('UniswapV2Router02');
  const router = await UniswapV2Router02.deploy(factoryAddress, WETHAddress);
  
  await router.deployed();
  
  console.log(`Router deployed at ${router.address}`);
}
import { deploy } from './ethers-lib'

(async () => {
  try {
    const result = await deploy('Storage', [])
    console.log(`address: ${result.address}`)
  } catch (e) {
    console.log(e.message)
  }
})()main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
