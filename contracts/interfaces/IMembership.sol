// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IMembership {
    function addMember(address member, uint256 level) external;

    function members(address member) external returns (bool, uint);

    function membersList() external returns (address[] memory);

    function updateMemberLevel(address member, uint256 level) external;

    function getMemberLevel(address member) external view returns (uint256);

    function memberExists(address member) external view returns (bool);

    function getMembersCount() external view returns (uint256);

    function getMemberDetails(
        address member
    ) external view returns (uint256, bool);
}
