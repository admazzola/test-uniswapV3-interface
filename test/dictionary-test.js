const { expect } = require("chai");

/*
describe("Greeter", function() {
  it("Should return the new greeting once it's changed", async function() {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    
    await greeter.deployed();
    expect(await greeter.greet()).to.equal("Hello, world!");

    await greeter.setGreeting("Hola, mundo!");
    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});

*/

var dictionaryContract;
var signerAccount;

describe("TellerNFTDictionary", async function() {

  

  it("Should deploy the dictionary", async function() {
    const Dictionary = await ethers.getContractFactory("TellerNFTDictionary");

    signerAccount = Dictionary.signer; 
    //const accounts = await ethers.getSigners();

    dictionaryContract = await Dictionary.deploy(  );
    
    await dictionaryContract.deployed();  



    let mintersArray = [ signerAccount.address ] 

    //await dictionaryContract.initialize(mintersArray, {from:signerAccount.address }) ;  


   // expect(await dictionaryContract.contractURI()).to.equal("QmWAfQFFwptzRUCdF2cBFJhcB2gfHJMd7TQt64dZUysk3R");
  });


  it("Should add tier data", async function() {

    /*Tier 0 
 
    */

    let Tier0 = {
      baseLoanSize: '2500',
      hashes: ['QmeL8KzMzHXgMUXWNEjTk5aWbWvHWqjmbpE8AjE47p366e',
      'QmZcwPGf3GfLUBZpy722kgT6yLLUde6fytDRDq3r7FfZtW',
      'QmZQT2o2pTVU5s8Q9iJU5dNi3o18Xm8Xy2FGBAbj3T9f3o',
      'QmTheQh5CcJrZVT9diSaBcJSQBENe9sk2rucNPnxNPkzm8',
      'QmPWWrGZaKVTxUF7pGE25xbiwVZefD4kbi52jaKnuQ4nzp',
      'QmaBGT6RMnuHj81CRMEhLv1WRffzQje1MD8jG6KAGdxdbH',
      'QmNixErgSC6Xu1Pu2KH4m7PBvXMMdqVMH6fEDdLXWnJn7G',
      'QmXB1oArPyHsxePno6AXUMqbEDJTWCBUSmodjJmEYp4YRb',
      'QmUiBrZQ9nEwX7JswPudR2rYzrHLpoGqTfdRGd3S9gDmBr',
      'QmNsXvprKiq3Yd5dYf5JaCCUJ7kveCx8sJukS94ZZkqVro',
      'QmWF3z1wK72XAAwdH7XD2pceDfgkUTbefokDtTPmJveZmR',
      'QmUPaWYc92fjyRTZrAH2pWG6FibWLTS9x4ZiZHvttQoMmQ',
      'QmXsPyFPa8cUbW7puziizkizoo3vCeYLG6MoWFb8xzuNxX',
      'QmVMA8JytaJkNni7TdgXNaJi6k8tbDW1Pbt3SfmPSLTJnN',
      'QmdcrimdE1q3HEU57u1GEwm4cxH2SNnrqcJK4z2a2bB14Y',
      'QmeSPtb6Qu9m9piX38igLWGKuNJKXgd1pvCxZH9A2gGeR2',
      'QmUNQ7pSJjwzdzFyr9RuH1dZoj7kKmRJGUC6ti1Que8FDg',
      'QmU4MGXdfVdohsE7TL8XBTBdfuhtrPUM9B2A9U4N7AKWAp',
      'QmVR7jJrKzDAeSejU8baDZScgJ6pFc4KGqreeqkytkyzTY',
      'QmVraE3NYsTv2mENa7Wv5ZNJRgD9X5fuDU9wfnxDVmVRrm',
      'QmXfBXftm7HaDr6YUEruL2ivfpRyMW6UndRuhQ1TgcjbYX',
      'QmQHSFeexH3AmUcviCNkyHD1eqHFBVRdHCAeyBAfDaaVgQ',
      'QmUT59247c7BmheSanY7C78CSvjyrC6PDL2sMJJE2zaRy3',
      'QmdANMtQmBhj8aVoLUkohgwWLpdVvSn4xF1Ht9Q5YzXnS3',
      'QmZABrffv7PJu9XhT5J5FVS7xq4xeE7exSDDa9u5KmWrq2',
      'QmUgRy8xGsg4tXbeZFsKHesbRh3ijEqiZv5MkRFEBD4Q9V',
      'QmVb7YNZ3bCXgvZbuZvXfTTn9DWHywFqtA3tigrh9SkNMh',
      'QmWJZL44Tds1fXMH6M7UERU4gyaeuiMSJGjqvuumzK83RQ',
      'QmRfxX27ifBjmNpkUbnYVuawBgPWgkuQKfGocc9gqB7heT',
      'QmSuFXx7Tkwf9wkW6omZymJgX7BkdVVmMubQQ96iRw6XsG',
      'QmXq4wRV5hzK63PJ98yiyPb4RzhE4Z1CbScFYF2eaA6wLm',
      'QmWduUWv4eqJvL5xK6uwdurbGafXzYEQp7X881YjoPS8ae',
      'QmaL8xB6s1DSvVrcbtcvAdhdpwXjrgBfAi9og2rwofThKD',
      'QmNWizjUQQ8bqUALB3d716eTXFyzd6qTvwTRwUrZPd5HE7'],
      contributionAsset: '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE', 
      contributionSize: '1000000000000000000', 
      contributionMultiplier:  '150'
    }

    
    await dictionaryContract.addTier(Tier0, {from:signerAccount.address }) ;  

    let readTier =  await dictionaryContract.getTier('0')

    console.log('read tier', readTier )

    let baseLoanSize = await dictionaryContract.tokenBaseLoanSize('0')
   
    expect(baseLoanSize).to.equal("2500");
   
    
  });
});
