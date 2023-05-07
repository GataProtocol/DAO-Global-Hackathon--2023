// deploy.js
const { ethers, upgrades } = require("hardhat");

async function main() {
  const Token = await ethers.getContractFactory("Token");
  const Membership = await ethers.getContractFactory("Membership");
  const Voting = await ethers.getContractFactory("Voting");
  const Proposal = await ethers.getContractFactory("Proposal");
  const Rewards = await ethers.getContractFactory("Rewards");
  const DAO = await ethers.getContractFactory("DAO");

  // Deploy Token contract
  const token = await Token.deploy(
    "MyToken",
    "MT",
    18,
    ethers.utils.parseEther("1000000")
  );
  await token.deployed();

  console.log("Token deployed to:", token.address);

  // Deploy Membership contract
  const membership = await Membership.deploy();
  await membership.deployed();

  console.log("Membership deployed to:", membership.address);

  // Deploy Voting contract
  const voting = await Voting.deploy();
  await voting.deployed();

  console.log("Voting deployed to:", voting.address);
  const proposal = await Proposal.deploy(voting.address, membership.address);
  await proposal.deployed();
  console.log("proposal deployed to:", proposal.address);
  const rewards = await Rewards.deploy(voting.address, membership.address);
  await rewards.deployed();
  console.log("rewards deployed to:", rewards.address);
  const dao = await DAO.deploy(
    token.address,
    membership.address,
    voting.address,
    proposal.address,
    rewards.address
  );
  await dao.deployed();
  console.log("DAO deployed to:", dao.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
