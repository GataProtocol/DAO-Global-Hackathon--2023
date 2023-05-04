// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IVoting {
    struct Vote {
        uint proposalId;
        uint amount;
        uint time;
    }

    function vote(uint _proposalId, uint _amount) external;

    function bet(uint _proposalId, uint _amount) external;

    function getVote(
        address _voter,
        uint _index
    ) external view returns (uint, uint, uint);

    function voteCount(address _voter) external view returns (uint);

    function totalVotes() external view returns (uint);

    function totalBets() external view returns (uint);

    function Token() external view returns (address);
}
