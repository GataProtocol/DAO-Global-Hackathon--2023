// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Reputation {
    //add constructor to collect address of proposal contract when deploying
    address immutable ProposalContractAddress;

    constructor(address _proposalContractAddress) {
        ProposalContractAddress = _proposalContractAddress;
    }

    mapping(address => uint256) public reputationPoints;

    function addReputation(
        address member,
        uint256 points
    ) external onlyProposalContract {
        reputationPoints[member] += points;
    }

    modifier onlyProposalContract() {
        require(
            msg.sender == ProposalContractAddress,
            "Only the Proposal Contract can call this function."
        );
        _;
    }
}
