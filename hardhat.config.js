require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  // networks: {
  //   hardhat: {},
  //   mantle: {
  //     url: "https://testnet.mantlechain.com",
  //     accounts: { mnemonic: process.env.MNEMONIC },
  //     gas: "auto",
  //     gasPrice: "auto",
  //   },
  // },
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
      blockConfirmations: 1,
    },
    mantle: {
      url: "https://rpc.testnet.mantle.xyz/",
      accounts: [`0x${process.env.PRIVATE_KEY}`],
      saveDeployments: true,
      chainId: 5001,
      gas: "auto",
      gasPrice: "auto",
    },
  },
};
