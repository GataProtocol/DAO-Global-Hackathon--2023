// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Membership {
    // Struct to represent a member
    struct Member {
        bool exists;
        uint256 level;
    }

    // Mapping to store all members
    mapping(address => Member) public members;

    // List of all members
    address[] public membersList;

    // Event to track new members added
    event NewMember(address member);

    // Function to add a new member
    function addMember(address member, uint256 level) external {
        require(!members[member].exists, "Member already exists");
        members[member] = Member(true, level);
        membersList.push(member);
        emit NewMember(member);
    }

    // Function to update a member's level
    function updateMemberLevel(address member, uint256 level) external {
        require(members[member].exists, "Member does not exist");
        members[member].level = level;
    }

    // Function to get a member's level
    function getMemberLevel(address member) external view returns (uint256) {
        require(members[member].exists, "Member does not exist");
        return members[member].level;
    }

    // Function to check if a member exists
    function memberExists(address member) external view returns (bool) {
        return members[member].exists;
    }

    // Function to get the total number of members
    function getMembersCount() external view returns (uint256) {
        return membersList.length;
    }

    // Function to get a member's details
    function getMemberDetails(
        address member
    ) external view returns (uint256, bool) {
        return (members[member].level, members[member].exists);
    }
}
