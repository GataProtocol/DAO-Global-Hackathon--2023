// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IVoting {
    function vote(uint _proposalId, uint _amount) external;

    function bet(uint _proposalId, uint _amount) external;

    function getVoteCount(address _voter) external view returns (uint);

    function getBetCount(address _voter) external view returns (uint);

    function Token() external view returns (IERC20);

    function votes(
        uint
    )
        external
        view
        returns (uint amount, uint time, uint totalVotes, uint totalBets);

    function voteCount(address) external view returns (uint);

    function betCount(address) external view returns (uint);
}
