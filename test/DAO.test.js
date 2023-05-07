const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DAO", function () {
  let DAO,
    dao,
    Proposal,
    proposal,
    Membership,
    membership,
    Voting,
    voting,
    Rewards,
    rewards,
    Token,
    token,
    owner,
    addr1,
    addr2;

  before(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();

    Token = await ethers.getContractFactory("Token");
    token = await Token.deploy(
      "MyToken",
      "MT",
      18,
      ethers.utils.parseEther("1000000")
    );

    Membership = await ethers.getContractFactory("Membership");
    membership = await Membership.deploy();

    Voting = await ethers.getContractFactory("Voting");
    voting = await Voting.deploy();

    Proposal = await ethers.getContractFactory("Proposal");
    proposal = await Proposal.deploy(voting.address, membership.address);

    Rewards = await ethers.getContractFactory("Rewards");
    rewards = await Rewards.deploy(voting.address, membership.address);

    DAO = await ethers.getContractFactory("DAO");
    dao = await DAO.deploy(
      token.address,
      membership.address,
      voting.address,
      proposal.address,
      rewards.address
    );
  });

  describe("Deployment", function () {
    it("Should set the correct token contract address", async function () {
      expect(await dao.tokenContract()).to.equal(token.address);
    });

    it("Should set the correct membership contract address", async function () {
      expect(await dao.membershipContract()).to.equal(membership.address);
    });

    it("Should set the correct voting contract address", async function () {
      expect(await dao.votingContract()).to.equal(voting.address);
    });

    it("Should set the correct proposal contract address", async function () {
      expect(await dao.proposalContract()).to.equal(proposal.address);
    });

    it("Should set the correct rewards contract address", async function () {
      expect(await dao.rewardsContract()).to.equal(rewards.address);
    });
  });

  describe("Functionality", function () {
    it("Should add a member to the DAO", async function () {
      await dao.addMember(addr1.address);
      expect(await membership.members(addr1.address)).to.not.equal(0);
    });

    it("Should create a proposal", async function () {
      await dao.createProposal(
        "Test Proposal",
        "This is a test proposal",
        9999999999
      );
      expect(await proposal.proposalCount()).to.equal(1);
    });

    it("Should vote on a proposal", async function () {
      await dao.vote(0, true);
      expect(await proposal.getVotes(0, owner.address)).to.equal(true);
    });

    it("Should distribute rewards to all members", async function () {
      await dao.distributeRewards(0);
      expect(await rewards.rewards(0, owner.address)).to.not.equal(0);
    });

    it("Should claim rewards by a member", async function () {
      const rewardsBalanceBefore = await token.balanceOf(addr1.address);
      await dao.claimRewards(0, { from: addr1.address });
      const rewardsBalanceAfter = await token.balanceOf(addr1.address);
      expect(rewardsBalanceAfter).to.be.gt(rewardsBalanceBefore);
    });
  });
});
