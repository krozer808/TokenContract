require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const privateKeys = process.env.PRIVATE_KEYS.toString() || "";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
  sepolia: {
    url: `https://sepolia.infura.io/v3/${process.env.INFURA_APIKEY}`,
    accounts: [privateKeys]
  }
},
  hardhat: {}
}