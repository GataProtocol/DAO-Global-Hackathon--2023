// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Proposal {
    struct Proposed {
        string description;
        uint threshold;
        bool accepted;
        bool active;
        uint level;
    }

    Proposed[] public proposals;

    uint public proposalLevels;
    uint public proposalCount;

    dCommerceToken public token;

    constructor(address _token, uint _proposalLevels) {
        token = dCommerceToken(_token);
        proposalLevels = _proposalLevels;
    }

    function addProposal(string memory _description, uint _threshold) public {
        require(
            token.balanceOf(msg.sender) >= _threshold,
            "Insufficient balance"
        );
        require(_threshold > 0, "Invalid threshold");

        Proposed memory newProposal = Proposed(
            _description,
            _threshold,
            false,
            true,
            1
        );
        proposals.push(newProposal);
        proposalCount++;
    }

    function approveProposal(uint _proposalId) public {
        require(
            proposals[_proposalId].active == true,
            "Proposal is not active"
        );

        proposals[_proposalId].level++;
        if (proposals[_proposalId].level == proposalLevels) {
            proposals[_proposalId].accepted = true;
        }
    }

    function disableProposal(uint _proposalId) public {
        proposals[_proposalId].active = false;
    }
}
