// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Membership {
    struct Member {
        uint256 tokenBalance;
        bool isMember;
    }

    mapping(address => Member) public members;
    mapping(uint256 => address) public nftToMember;
    uint256 public totalMembers = 0;

    function addMember(
        address _member,
        uint256 _nftId,
        uint256 _tokenBalance
    ) public {
        require(!members[_member].isMember, "Already a member");
        members[_member] = Member(_tokenBalance, true);
        nftToMember[_nftId] = _member;
        totalMembers++;
    }
}
