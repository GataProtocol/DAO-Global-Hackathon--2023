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
        uint256 _proposalDuration,
        uint256 _voteDuration,
        uint256 _quorumPercentage,
        address _tokenAddress
    ) {
        // Initialize token contract
        tokenContract = Token(_tokenAddress);

        // Initialize membership contract
        membershipContract = new Membership();

        // Initialize voting contract
        votingContract = new Voting(
            _voteDuration,
            _quorumPercentage,
            address(membershipContract)
        );

        // Initialize proposal contract
        proposalContract = new Proposal(
            _proposalDuration,
            address(votingContract)
        );

        // Initialize rewards contract
        rewardsContract = new Rewards(
            address(votingContract),
            address(membershipContract),
            address(tokenContract)
        );
    }

    // Function to add a member to the DAO
    function addMember(address _member) external {
        membershipContract.addMember(_member);
    }

    // Function to create a proposal
    function createProposal(
        string memory _title,
        string memory _description,
        uint256 _amount
    ) external {
        proposalContract.createProposal(
            _title,
            _description,
            _amount,
            msg.sender
        );
    }

    // Function to vote on a proposal
    function vote(uint256 _proposalId, bool _vote) external {
        votingContract.vote(_proposalId, _vote, msg.sender);
    }

    // Function to distribute rewards to all members
    function distributeRewards() external {
        rewardsContract.distributeRewards();
    }

    // Function to claim rewards by a member
    function claimRewards() external {
        rewardsContract.claimRewards();
    }
}
