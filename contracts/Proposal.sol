// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IVoting.sol";
import "./interfaces/IMembership.sol";

contract Proposal {
    IVoting public VotingContract;
    IMembership public MembershipContract;

    // add Constructor that is used to get address of Voting Contract
    constructor(
        address _votingContractAddress,
        address _membershipContractAddress
    ) {
        VotingContract = IVoting(_votingContractAddress);
        MembershipContract = IMembership(_membershipContractAddress);
    }

    struct AProposal {
        string proposalTitle;
        string proposalDescription;
        uint256 proposalEndTime;
        uint256 yesVotes;
        uint256 noVotes;
        bool proposalPassed;
        address proposer;
        uint256 yesBets;
        uint256 noBets;
    }

    mapping(uint => AProposal) proposals;
    uint proposalsCount;

    // Event to track proposal creation
    event ProposalCreated(address proposer, string title, uint _proposalId);

    // Event to track proposal votes
    event ProposalVoted(uint _proposalId, address voter, bool support);

    // Modifier to check if proposal has ended
    modifier proposalHasEnded(uint _proposalId) {
        require(
            block.timestamp > proposals[_proposalId].proposalEndTime,
            "Proposal has ended "
        );
        _;
    }

    // Function to create a new proposal
    function createProposal(
        string memory _title,
        string memory _description,
        uint256 _endTime
    ) external {
        require(_endTime > block.timestamp, "Proposal cant end before date");
        require(
            MembershipContract.memberExists(msg.sender),
            "Only members can create proposals"
        );
        proposalsCount++;
        // Set the proposal details
        proposals[proposalsCount].proposalTitle = _title;
        proposals[proposalsCount].proposalDescription = _description;
        proposals[proposalsCount].proposalEndTime = _endTime;
        proposals[proposalsCount].proposer = msg.sender;

        // Emit an event to track proposal creation
        emit ProposalCreated(msg.sender, _title, proposalsCount);
    }

    // Function to vote on a proposal
    function vote(uint _proposalId, bool _support) external {
        // Get the current voter's address
        address voter = msg.sender;

        require(
            MembershipContract.memberExists(msg.sender),
            "Only members can vote on proposals"
        );
        // Check if voter has already voted
        require(!VotingContract.voters(voter), "Voter has already voted");
        VotingContract.vote(_proposalId, msg.sender);
        // Update vote count based on vote type
        if (_support) {
            proposals[_proposalId].yesVotes++;
        } else {
            proposals[_proposalId].noVotes++;
        }

        // // Update voter's vote status
        // VotingContract.setHasVoted(voter, true);
        MembershipContract.updateMemberLevel(msg.sender, 1);
        // Emit an event to track proposal votes
        emit ProposalVoted(_proposalId, voter, _support);
    }

    // Function to check if proposal has passed
    function hasProposalPassed(
        uint _proposalId
    ) external proposalHasEnded(_proposalId) returns (bool) {
        // Check if yes votes are more than no votes
        if (proposals[_proposalId].yesVotes > proposals[_proposalId].noVotes) {
            proposals[_proposalId].proposalPassed = true;
        }

        return proposals[_proposalId].proposalPassed;
    }
}
