// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IVoting.sol";

contract Proposal {
    IVoting public VotingContract;

    // add Constructor that is used to get address of Voting Contract
    constructor(address _votingContractAddress) {
        VotingContract = IVoting(_votingContractAddress);
    }

    // Proposal details
    string public proposalTitle;
    string public proposalDescription;
    uint256 public proposalEndTime;

    // Vote count and state
    uint256 public yesVotes;
    uint256 public noVotes;
    bool public proposalPassed;

    // Event to track proposal creation
    event ProposalCreated(address proposer, string title);

    // Event to track proposal votes
    event ProposalVoted(address voter, bool support);

    // Modifier to check if proposal has ended
    modifier proposalHasEnded() {
        require(
            block.timestamp > proposalEndTime,
            "Proposal has not ended yet"
        );
        _;
    }

    // Function to create a new proposal
    function createProposal(
        string memory _title,
        string memory _description,
        uint256 _endTime
    ) external {
        // Set the proposal details
        proposalTitle = _title;
        proposalDescription = _description;
        proposalEndTime = _endTime;

        // Emit an event to track proposal creation
        emit ProposalCreated(msg.sender, _title);
    }

    // Function to vote on a proposal
    function vote(bool _support) external {
        // Get the current voter's address
        address voter = msg.sender;

        // Check if voter has already voted
        require(!VotingContract.hasVoted(voter), "Voter has already voted");

        // Update vote count based on vote type
        if (_support) {
            yesVotes++;
        } else {
            noVotes++;
        }

        // Update voter's vote status
        VotingContract.setHasVoted(voter, true);

        // Emit an event to track proposal votes
        emit ProposalVoted(voter, _support);
    }

    // Function to check if proposal has passed
    function hasProposalPassed() external proposalHasEnded returns (bool) {
        // Check if yes votes are more than no votes
        if (yesVotes > noVotes) {
            proposalPassed = true;
        } else {
            proposalPassed = false;
        }

        return proposalPassed;
    }
}
