
require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  networks: {
    hardhat: {},
    // rinkeby: {
    //   url: `https://rinkeby.infura.io/v3/0b293a89346f49939d411e2a44f94c65`,
    //   accounts: {mnemonic: mnemonic}
    // },
    // mainnet: {
    //   url: `https://mainnet.infura.io/v3/${infuraProjectId}`,
    //   accounts: {mnemonic: mnemonic}
    // }
  },

  // etherscan: {
  //   // Your API key for Etherscan
  //   // Obtain one at https://etherscan.io/
  //   apiKey: etherscanApiKey
  // },
  solidity: "0.8.16",

  settings: {
      //   optimizer: {
      //    enabled: true,
      //    runs: 200
      //  },
      //  evmVersion: "petersburg"
      // evmVersion: "byzantium"
      }
};
