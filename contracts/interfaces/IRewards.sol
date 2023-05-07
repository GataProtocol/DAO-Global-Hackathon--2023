// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IRewards {
    function rewards(address) external view returns (uint256);

    function badges(address) external view returns (uint256);

    function participationMultiplier(uint256) external view returns (uint256);

    function VotingContract() external view returns (address);

    function MembershipContract() external view returns (address);

    function calculateRewards(address, uint256) external view returns (uint256);

    function distributeRewards(uint256) external;

    function claimRewards(uint256) external;

    function getRewardsBalance(address) external view returns (uint256);

    function getBadge(address) external view returns (uint256);
}
