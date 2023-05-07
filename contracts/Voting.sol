// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting {
    struct Proposal {
        uint256 voteCount;
        bool exists;
        uint256 betCount;
    }

    struct BetType {
        uint256 betAmount;
        bool betType;
    }

    address public chairperson;
    mapping(address => bool) public voters;
    mapping(address => uint256) public voteCount;
    mapping(address => mapping(uint256 => BetType)) public bets;
    mapping(uint => Proposal) public proposals;

    event ProposalRegistered(uint256 proposalId);
    event Voted(address voter, uint256 proposalId);
    event Betting(address bettor, uint256 proposalId, uint256 amount);
    event VotingClosed();

    constructor() {
        chairperson = msg.sender;
    }

    // function registerProposal(string memory _name) public {
    //     require(
    //         msg.sender == chairperson,
    //         "Only the chairperson can register proposals."
    //     );
    //     bytes32 proposalId = keccak256(abi.encodePacked(_name));
    //     require(
    //         !proposals[proposalId].exists,
    //         "This proposal has already been registered."
    //     );
    //     proposals[proposalId].name = _name;
    //     proposals[proposalId].exists = true;
    //     emit ProposalRegistered(proposalId, _name);
    // }

    function vote(uint256 _proposalId, address _voter) public {
        require(
            proposals[_proposalId].exists,
            " This proposal does not exist."
        );
        require(!voters[_voter], "You have already voted.");
        proposals[_proposalId].voteCount += 1;
        voters[_voter] = true;
        voteCount[_voter] += 1;
        emit Voted(_voter, _proposalId);
    }

    function bet(uint256 _proposalId, bool _bet) public payable {
        require(proposals[_proposalId].exists, "This proposal does not exist.");
        require(msg.value > 0, "You must bet at least some ether.");
        proposals[_proposalId].betCount += 1;
        bets[msg.sender][_proposalId].betAmount = msg.value;
        bets[msg.sender][_proposalId].betType = _bet;
        emit Betting(msg.sender, _proposalId, msg.value);
    }

    function closeVoting() public {
        require(
            msg.sender == chairperson,
            "Only the chairperson can close voting."
        );
        emit VotingClosed();
    }

    function getProposal(
        uint256 _proposalId
    ) public view returns (uint256 votesCount, bool exists, uint256 betCount) {
        return (
            proposals[_proposalId].voteCount,
            proposals[_proposalId].exists,
            proposals[_proposalId].betCount
        );
    }
}
