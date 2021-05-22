/* eslint-disable prefer-const */
/* global artifacts */

const NFTDictionary = artifacts.require('TellerNFTDictionary')
 
 

module.exports = function (deployer, network, accounts) {
  
    return deployer.deploy(NFTDictionary)

}
