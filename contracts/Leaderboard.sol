// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Leaderboard {
    struct LeaderboardMember {
        uint256 points;
        address member;
    }

    LeaderboardMember[5] public topMembers;

    function updateTopMembers(
        address member,
        uint256 points
    ) external onlyRewardContract {
        if (points <= topMembers[4].points) {
            return;
        }

        uint256 index = 4;
        while (index > 0 && topMembers[index - 1].points < points) {
            topMembers[index] = topMembers[index - 1];
            index--;
        }

        topMembers[index] = LeaderboardMember(points, member);
    }

    modifier onlyRewardContract() {
        require(
            msg.sender == rewardContract,
            "Only the Reward Contract can call this function."
        );
        _;
    }
}
