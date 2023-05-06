// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IMembership.sol";
import "./interfaces/IVoting.sol";

contract Rewards {
    IVoting public VotingContract;
    IMembership public MembershipContract;

    // add Constructor that is used to get address of Membership and Voting Contract
    constructor(
        address _votingContractAddress,
        address _membershipContractAddress
    ) {
        VotingContract = IVoting(_votingContractAddress);
        MembershipContract = IMembership(_membershipContractAddress);
    }

    // Rewards and badges earned by each member
    mapping(address => uint256) public rewards;
    mapping(address => uint256) public badges;

    // Rewards multiplier based on level of participation
    uint256[] public participationMultiplier = [0, 1, 2, 4, 8];

    // Event to track rewards earned by a member
    event RewardsEarned(address member, uint256 amount);

    // Event to track changes in the leaderboard
    event LeaderboardChanged(address[] members);

    // Function to calculate rewards earned by a member for participating in governance
    function calculateRewards(address member) internal view returns (uint256) {
        // Get the level of participation
        (, uint256 level) = MembershipContract.members(member);

        // Get the number of votes and bets placed by the member
        uint256 votesPlaced = VotingContract.voteCount(member);
        uint256 betsPlaced = VotingContract.bets[member];

        // Calculate the rewards earned by the member
        uint256 rewardsEarned = (votesPlaced + betsPlaced) *
            participationMultiplier[level];

        return rewardsEarned;
    }

    // Function to distribute rewards to all members and update the leaderboard
    function distributeRewards() external {
        address[] memory leaderboard = new address[](
            MembershipContract.membersCount
        );
        uint256[] memory leaderboardScores = new uint256[](
            MembershipContract.membersCount
        );

        // Iterate through all members
        for (uint256 i = 0; i < MembershipContract.membersCount; i++) {
            address member = MembershipContract.membersList[i];

            // Calculate rewards earned by the member
            uint256 rewardsEarned = calculateRewards(member);

            // Add rewards to the member's balance
            rewards[member] += rewardsEarned;

            // Add the member's score to the leaderboard
            leaderboard[i] = member;
            leaderboardScores[i] = rewards[member];

            // Emit an event to track rewards earned by the member
            emit RewardsEarned(member, rewardsEarned);
        }

        // Sort the leaderboard by score in descending order
        for (uint256 i = 0; i < leaderboardScores.length - 1; i++) {
            for (uint256 j = i + 1; j < leaderboardScores.length; j++) {
                if (leaderboardScores[j] > leaderboardScores[i]) {
                    // Swap the scores and corresponding addresses
                    uint256 tempScore = leaderboardScores[i];
                    leaderboardScores[i] = leaderboardScores[j];
                    leaderboardScores[j] = tempScore;

                    address tempMember = leaderboard[i];
                    leaderboard[i] = leaderboard[j];
                    leaderboard[j] = tempMember;
                }
            }
        }

        // Emit an event to notify of the new leaderboard
        emit LeaderboardChanged(leaderboard);
    }

    // Function to claim rewards by a member
    function claimRewards() external {
        address member = msg.sender;
        uint256 rewardsEarned = calculateRewards(member);
        rewards[member] += rewardsEarned;
        emit RewardsEarned(member, rewardsEarned);
    }

    function getRewardsBalance(address member) external view returns (uint256) {
        return rewards[member];
    }

    function getBadge(address member) external view returns (uint256) {
        return badges[member];
    }
}
