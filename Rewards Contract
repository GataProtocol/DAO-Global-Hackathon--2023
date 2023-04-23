// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Membership.sol";

contract Rewards {
    // Rewards and badges earned by each member
    mapping(address => uint256) public rewards;
    mapping(address => uint256) public badges;

    // Rewards multiplier based on level of participation
    uint256[] public participationMultiplier = [0, 1, 2, 4, 8];

    // Event to track rewards earned by a member
    event RewardsEarned(address member, uint256 amount);

    // Function to calculate rewards earned by a member for participating in governance
    function calculateRewards(address member) internal view returns (uint256) {
        // Get the level of participation
        uint256 level = Membership.members[member].level;
        
        // Get the number of votes and bets placed by the member
        uint256 votesPlaced = Voting.votes[member];
        uint256 betsPlaced = Voting.bets[member];
        
        // Calculate the rewards earned by the member
        uint256 rewardsEarned = (votesPlaced + betsPlaced) * participationMultiplier[level];
        
        return rewardsEarned;
    }

    // Function to distribute rewards to all members
    function distributeRewards() external {
        // Iterate through all members
        for (uint256 i = 0; i < Membership.membersCount; i++) {
            address member = Membership.membersList[i];
            
            // Calculate rewards earned by the member
            uint256 rewardsEarned = calculateRewards(member);
            
            // Add rewards to the member's balance
            rewards[member] += rewardsEarned;
            
            // Emit an event to track rewards earned by the member
            emit RewardsEarned(member, rewardsEarned);
        }
    }

    // Function to claim rewards by a member
    function claimRewards() external {
        address member = msg.sender;
        
        // Calculate rewards earned by the member
        uint256 rewardsEarned = calculateRewards(member);
        
        // Add rewards to the member's balance
        rewards[member] += rewardsEarned;
        
        // Emit an event to track rewards earned by the member
        emit RewardsEarned(member, rewardsEarned);
    }
}
