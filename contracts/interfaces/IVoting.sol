// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IVoting {
    struct Proposal {
        string name;
        uint256 voteCount;
        bool exists;
        mapping(address => uint256) bets;
    }

    event ProposalRegistered(bytes32 proposalId, string name);
    event Voted(address voter, bytes32 proposalId);
    event Betting(address bettor, bytes32 proposalId, uint256 amount);
    event VotingClosed();

    function registerProposal(string memory _name) external;

    function vote(bytes32 proposalId) external;

    function bet(bytes32 proposalId) external payable;

    function closeVoting() external;

    function voteCount(address member) external returns (uint);

    function getProposal(
        bytes32 _proposalId
    )
        external
        view
        returns (string memory name, uint256 votesCount, bool exists);
}
