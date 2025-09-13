// This script can be used to deploy the "Storage" contract using Web3 library.
// Please make sure to compile "./contracts/1_Storage.sol" file before running this script.
// And use Right click -> "Run" from context menu of the file to run the script. Shortcut: Ctrl+Shift+S
import Web3 from 'web3';
import { AbiItem } from 'web3-utils';
import * as UniswapV2Router02 from '../artifacts/contracts/UniswapV2Router02.sol/UniswapV2Router02.json';

async function main() {
  const web3 = new Web3('http://localhost:8545');
  const accounts = await web3.eth.getAccounts();
  
  const factoryAddress = '0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f'; // Uniswap V2 factory address
  const WETHAddress = '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2'; // WETH address
  
  const router = new web3.eth.Contract(UniswapV2Router02.abi as AbiItem[]);
  
  const deploy = router.deploy({
    data: UniswapV2Router02.bytecode,
    arguments: [factoryAddress, WETHAddress]
  });
  
  const gas = await deploy.estimateGas();
  
  const deployedRouter = await deploy.send({
    from: accounts[0],
    gas
  });
  
  console.log(`Router deployed at ${deployedRouter.options.address}`);
}
import { deploy } from './web3-lib'

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
