// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IProposal.sol";
import "./interfaces/IVoting.sol";
import "./interfaces/IMembership.sol";
import "./interfaces/IRewards.sol";
import "./interfaces/IToken.sol";

contract DAO {
    IProposal public proposalContract;
    IVoting public votingContract;
    IMembership public membershipContract;
    IRewards public rewardsContract;
    IToken public tokenContract;

    // add Constructor that is used to initialize all the contracts
    constructor(
        // uint256 _proposalDuration,
        // uint256 _voteDuration,
        // uint256 _quorumPercentage,
        address _tokenAddress,
        address _membershipAddress,
        address _votingAddress,
        address _proposalAddress,
        address _rewardsAddress
    ) {
        // Initialize token contract
        tokenContract = IToken(_tokenAddress);

        // Initialize membership contract
        membershipContract = IMembership(_membershipAddress);

        // Initialize voting contract
        votingContract = IVoting(_votingAddress);

        // Initialize proposal contract
        proposalContract = IProposal(_proposalAddress);

        // Initialize rewards contract
        rewardsContract = IRewards(_rewardsAddress);
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
