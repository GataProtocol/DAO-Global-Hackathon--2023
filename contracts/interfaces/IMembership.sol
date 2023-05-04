// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IMembership {
    struct Member {
        uint256 tokenBalance;
        bool isMember;
    }

    function addMember(
        address _member,
        uint256 _nftId,
        uint256 _tokenBalance
    ) external;

    function members(address _member) external view returns (uint256, bool);

    function nftToMember(uint256 _nftId) external view returns (address);

    function totalMembers() external view returns (uint256);
}
