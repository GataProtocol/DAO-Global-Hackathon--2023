// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Reputation {
    mapping(address => uint256) public reputationPoints;

    function addReputation(
        address member,
        uint256 points
    ) external onlyProposalContract {
        reputationPoints[member] += points;
    }

    modifier onlyProposalContract() {
        require(
            msg.sender == proposalContract,
            "Only the Proposal Contract can call this function."
        );
        _;
    }
}