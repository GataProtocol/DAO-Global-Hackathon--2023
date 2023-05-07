// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IProposal {
    struct AProposal {
        string proposalTitle;
        string proposalDescription;
        uint256 proposalEndTime;
        uint256 yesVotes;
        uint256 noVotes;
        bool proposalPassed;
        address proposer;
        uint256 yesBets;
        uint256 noBets;
    }

    function createProposal(
        string calldata _title,
        string calldata _description,
        uint256 _endTime
    ) external;

    function vote(uint _proposalId, bool _support) external;

    function hasProposalPassed(uint _proposalId) external returns (bool);

    function proposalsCount() external view returns (uint);

    function proposals(
        uint _proposalId
    ) external view returns (AProposal memory);

    function VotingContract() external view returns (address);

    function MembershipContract() external view returns (address);
}
