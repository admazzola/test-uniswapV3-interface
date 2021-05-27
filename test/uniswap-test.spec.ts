//https://github.com/Uniswap/uniswap-v3-core/blob/main/test/UniswapV3Factory.spec.ts

import { ethers, waffle } from 'hardhat'
import { expect } from './shared/expect'

 

import {
  abi as FACTORY_ABI,
  bytecode as FACTORY_BYTECODE,
} from '@uniswap/v3-core/artifacts/contracts/UniswapV3Factory.sol/UniswapV3Factory.json'

 

describe("UniswapTesting", async function() {

   

  it("Should deploy Uniswap ", async function() {

    // deploy the uniV3 bytecode
    const factory = await ethers.getContractFactory(FACTORY_ABI, FACTORY_BYTECODE); 

    let deployArgs = {} 

    // If your contract requires constructor args, you can specify them here
    const contract = await factory.deploy(deployArgs);

    console.log('Deployed Uniswap Contract to ',contract.address);

    await expect(contract).to.be.ok 
 
  });

 
 
});
