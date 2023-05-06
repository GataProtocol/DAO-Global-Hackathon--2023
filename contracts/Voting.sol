// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting {
    struct Proposal {
        string name;
        uint256 voteCount;
        bool exists;
        mapping(address => uint256) bets;
    }

    address public chairperson;
    mapping(address => bool) public voters;
    mapping(address => uint256) public voteCount;
    mapping(address => mapping(bytes32 => uint256)) public bets;
    mapping(bytes32 => Proposal) public proposals;

    event ProposalRegistered(bytes32 proposalId, string name);
    event Voted(address voter, bytes32 proposalId);
    event Betting(address bettor, bytes32 proposalId, uint256 amount);
    event VotingClosed();

    constructor() {
        chairperson = msg.sender;
    }

    function registerProposal(string memory _name) public {
        require(
            msg.sender == chairperson,
            "Only the chairperson can register proposals."
        );
        bytes32 proposalId = keccak256(abi.encodePacked(_name));
        require(
            !proposals[proposalId].exists,
            "This proposal has already been registered."
        );
        proposals[proposalId].name = _name;
        proposals[proposalId].exists = true;
        emit ProposalRegistered(proposalId, _name);
    }

    function vote(bytes32 proposalId) public {
        require(proposals[proposalId].exists, "This proposal does not exist.");
        require(!voters[msg.sender], "You have already voted.");
        proposals[proposalId].voteCount += 1;
        voters[msg.sender] = true;
        voteCount[msg.sender] += 1;
        emit Voted(msg.sender, proposalId);
    }

    function bet(bytes32 proposalId) public payable {
        require(proposals[proposalId].exists, "This proposal does not exist.");
        require(msg.value > 0, "You must bet at least some ether.");
        proposals[proposalId].bets[msg.sender] += msg.value;
        bets[msg.sender][proposalId] += msg.value;
        emit Betting(msg.sender, proposalId, msg.value);
    }

    function closeVoting() public {
        require(
            msg.sender == chairperson,
            "Only the chairperson can close voting."
        );
        emit VotingClosed();
    }

    function getProposal(
        bytes32 _proposalId
    )
        public
        view
        returns (string memory name, uint256 votesCount, bool exists)
    {
        return (
            proposals[_proposalId].name,
            proposals[_proposalId].voteCount,
            proposals[_proposalId].exists
        );
    }
}
