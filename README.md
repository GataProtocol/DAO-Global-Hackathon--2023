
# DAO-Global-Hackathon--2023 DAO Smart Contract:

 This is a smart contract that enables Decentralized Autonomous Organization (DAO). It has several smart contracts that interact with each other to facilitate the operations of the DAO. The smart contracts are as follows:

## 🔩 Project Structure

- [Working Frontend](https://governance-dao.vercel.app)
- [Contracts](./)
- [FrontendCode](https://github.com/incoknito/GovernanceDAO)

# CHECK OUT THE CONTRACTS WHICH ARE ALREADY DEPLOYED ON THE MANTLE TESTNET AT:

- [Token Contract](https://explorer.testnet.mantle.xyz/address/0xD518510C440214DfcE445155D058F2e14F760961)

- [Membership Contract](https://explorer.testnet.mantle.xyz/address/0x12B1118267385177520426cA8539b5c80a7eDFbf)

- [Voting Contract](https://explorer.testnet.mantle.xyz/address/0xc4Dc827f7c8c5ac854d42592Ea6c92DBBc957F81)

- [Proposal Contract](https://explorer.testnet.mantle.xyz/address/0xA62760BEa985246eF020C8e34f47f5F3A469C943)

- [Rewards Contract](https://explorer.testnet.mantle.xyz/address/0xBDdE80BE987712e0fA3284004EA82CcDA8c58147)

- [Token Contract](https://explorer.testnet.mantle.xyz/address/0xe57A480Edd93381cAAb28249b6966F6E520EA577)
  

## DAO:

This contract contains the main functionality of the DAO. It creates instances of other contracts that facilitate the operations of the DAO. The contracts created include Proposal, Voting, Membership, Rewards and Token contracts. It also has several functions that allow users to interact with the DAO.

### Functions:

- Constructor - Initializes all the contracts.
- addMember - This function is used to add a member to the DAO.
- createProposal - This function is used to create a proposal.
- vote - This function is used to vote on a proposal.
- distributeRewards - This function is used to distribute rewards to all members.
- claimRewards - This function is used by a member to claim rewards.

## Membership:

This contract manages the membership of the DAO. It stores the details of all members, including their level.

### Functions:

- addMember - This function is used to add a new member to the DAO.
- updateMemberLevel - This function is used to update a member's level.
- getMemberLevel - This function is used to get a member's level.
- memberExists - This function is used to check if a member exists.
- getMembersCount - This function is used to get the total number of members.
- getMemberDetails - This function is used to get a member's details.

## Proposal:

This contract manages the creation and voting on proposals. It stores the details of the proposal and the vote count.

### Functions:

- Constructor - Used to get the address of the Voting Contract.
- createProposal - This function is used to create a new proposal.
- vote - This function is used to vote on a proposal.
- hasProposalPassed - This function is used to check if a proposal has passed.

## Voting:

This contract manages the voting on proposals. It stores the details of the vote.

### Functions:

- vote - This function is used to vote on a proposal.
- hasVoted - This function is used to check if a user has voted.
- setHasVoted - This function is used to set a user's vote status.

## Rewards:

This contract manages the distribution of rewards to members. It interacts with the Voting, Membership, and Token contracts.

### Functions:

- Constructor - Used to get the addresses of the Voting, Membership, and Token contracts.
- distributeRewards - This function is used to distribute rewards to all members.
- claimRewards - This function is used by a member to claim rewards.

```Note: The contracts are written in Solidity version 0.8.0. The MIT license is used for the contracts.```

