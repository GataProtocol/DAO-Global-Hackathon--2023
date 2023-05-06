# DAO-Global-Hackathon--2023DAO Smart Contract:

 This is a smart contract that enables Decentralized Autonomous Organization (DAO). It has several smart contracts that interact with each other to facilitate the operations of the DAO. The smart contracts are as follows:

## DAO:

    This contract contains the main functionality of the DAO. It creates instances of other contracts that facilitate the operations of the DAO. The contracts created include Proposal, Voting, Membership, Rewards and Token contracts. It also has several functions that allow users to interact with the DAO.

### Functions:

a. Constructor - Initializes all the contracts.
b. addMember - This function is used to add a member to the DAO.
c. createProposal - This function is used to create a proposal.
d. vote - This function is used to vote on a proposal.
e. distributeRewards - This function is used to distribute rewards to all members.
f. claimRewards - This function is used by a member to claim rewards.

## Membership:

    This contract manages the membership of the DAO. It stores the details of all members, including their level.

### Functions:

a. addMember - This function is used to add a new member to the DAO.
b. updateMemberLevel - This function is used to update a member's level.
c. getMemberLevel - This function is used to get a member's level.
d. memberExists - This function is used to check if a member exists.
e. getMembersCount - This function is used to get the total number of members.
f. getMemberDetails - This function is used to get a member's details.

## Proposal:

    This contract manages the creation and voting on proposals. It stores the details of the proposal and the vote count.

### Functions:

a. Constructor - Used to get the address of the Voting Contract.
b. createProposal - This function is used to create a new proposal.
c. vote - This function is used to vote on a proposal.
d. hasProposalPassed - This function is used to check if a proposal has passed.

## Voting:

    This contract manages the voting on proposals. It stores the details of the vote.

### Functions:

a. vote - This function is used to vote on a proposal.
b. hasVoted - This function is used to check if a user has voted.
c. setHasVoted - This function is used to set a user's vote status.

## Rewards:
    This contract manages the distribution of rewards to members. It interacts with the Voting, Membership, and Token contracts.

### Functions:
a. Constructor - Used to get the addresses of the Voting, Membership, and Token contracts.
b. distributeRewards - This function is used to distribute rewards to all members.
c. claimRewards - This function is used by a member to claim rewards.

```Note: The contracts are written in Solidity version 0.8.0. The MIT license is used for the contracts.```