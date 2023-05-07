// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IVoting {
    struct Proposal {
        uint256 voteCount;
        bool exists;
        uint256 betCount;
    }

    function chairperson() external view returns (address);

    function voters(address) external view returns (bool);

    function voteCount(address) external view returns (uint256);

    function bets(address, uint256) external view returns (uint256, bool);

    function proposals(uint256) external view returns (Proposal memory);

    event ProposalRegistered(uint256 proposalId);
    event Voted(address voter, uint256 proposalId);
    event Betting(address bettor, uint256 proposalId, uint256 amount);
    event VotingClosed();

    function vote(uint256 _proposalId, address _voter) external;

    function bet(uint256 _proposalId) external payable;

    function closeVoting() external;

    function getProposal(
        uint256 _proposalId
    ) external view returns (uint256 votesCount, bool exists, uint256 betCount);
}
