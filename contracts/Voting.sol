// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Voting {
    struct Vote {
        uint proposalId;
        uint amount;
        uint time;
    }

    mapping(address => uint) public voteCount;
    mapping(address => mapping(uint => Vote)) public votes;

    uint public totalVotes;
    uint public totalBets;

    dCommerceToken public token;

    constructor(address _token) {
        token = dCommerceToken(_token);
    }

    function vote(uint _proposalId, uint _amount) public {
        require(token.balanceOf(msg.sender) >= _amount, "Insufficient balance");
        require(
            token.allowance(msg.sender, address(this)) >= _amount,
            "Insufficient allowance"
        );
        require(_amount > 0, "Invalid amount");

        token.transferFrom(msg.sender, address(this), _amount);

        Vote memory newVote = Vote(_proposalId, _amount, block.timestamp);
        votes[msg.sender][voteCount[msg.sender]] = newVote;
        voteCount[msg.sender]++;
        totalVotes += _amount;
    }

    function bet(uint _proposalId, uint _amount) public {
        require(voteCount[msg.sender] > 0, "You must vote to place bets");
        require(token.balanceOf(msg.sender) >= _amount, "Insufficient balance");
        require(
            token.allowance(msg.sender, address(this)) >= _amount,
            "Insufficient allowance"
        );
        require(_amount > 0, "Invalid amount");

        token.transferFrom(msg.sender, address(this), _amount);
        totalBets += _amount;
    }

    function getVote(
        address _voter,
        uint _index
    ) public view returns (uint, uint, uint) {
        Vote memory vote = votes[_voter][_index];
        return (vote.proposalId, vote.amount, vote.time);
    }
}