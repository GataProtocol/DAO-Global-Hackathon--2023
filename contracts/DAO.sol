// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Proposal.sol";
import "./Voting.sol";
import "./Membership.sol";
import "./Rewards.sol";
import "./Token.sol";

contract DAO {
    Proposal public proposalContract;
    Voting public votingContract;
    Membership public membershipContract;
    Rewards public rewardsContract;
    Token public tokenContract;

    // add Constructor that is used to initialize all the contracts
    constructor(
        // uint256 _proposalDuration,
        // uint256 _voteDuration,
        // uint256 _quorumPercentage,
        address _tokenAddress
    ) {
        // Initialize token contract
        tokenContract = Token(_tokenAddress);

        // Initialize membership contract
        membershipContract = new Membership();

        // Initialize voting contract
        votingContract = new Voting();

        // Initialize proposal contract
        proposalContract = new Proposal(
            address(votingContract),
            address(membershipContract)
        );

        // Initialize rewards contract
        rewardsContract = new Rewards(
            address(votingContract),
            address(membershipContract)
        );
    }

    // Function to add a member to the DAO
    function addMember(address _member) external {
        membershipContract.addMember(_member, 0);
    }

    // Function to create a proposal
    function createProposal(
        string memory _title,
        string memory _description,
        uint256 _endTime
    ) external {
        proposalContract.createProposal(_title, _description, _endTime);
    }

    // Function to vote on a proposal
    function vote(uint256 _proposalId, bool _vote) external {
        proposalContract.vote(_proposalId, _vote);
    }

    // Function to distribute rewards to all members
    function distributeRewards(uint256 _proposalId) external {
        rewardsContract.distributeRewards(_proposalId);
    }

    // Function to claim rewards by a member
    function claimRewards(uint256 _proposalId) external {
        rewardsContract.claimRewards(_proposalId);
    }
}
