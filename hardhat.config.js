require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {},
    mantle: {
      url: "https://testnet.mantlechain.com",
      accounts: { mnemonic: process.env.MNEMONIC },
      gas: "auto",
      gasPrice: "auto",
    },
  },
};
