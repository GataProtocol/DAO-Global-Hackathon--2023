// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Voting {
    struct Vote {
        uint amount;
        uint time;
        uint totalVotes;
        uint totalBets;
    }

    mapping(address => uint) public voteCount;
    mapping(address => uint) public betCount;

    mapping(uint => Vote) public votes;

    IERC20 public Token;

    constructor(address _token) {
        Token = IERC20(_token);
    }

    function vote(uint _proposalId, uint _amount) public {
        require(Token.balanceOf(msg.sender) >= _amount, "Insufficient balance");
        require(
            Token.allowance(msg.sender, address(this)) >= _amount,
            "Insufficient allowance"
        );
        require(_amount > votes[_proposalId].amount, "Invalid amount");

        Token.transferFrom(msg.sender, address(this), _amount);

        // Vote memory newVote = Vote(_proposalId, _amount, block.timestamp);
        // votes[msg.sender][voteCount[msg.sender]] = newVote;
        voteCount[msg.sender] += _amount;
        votes[_proposalId].totalVotes += _amount;
    }

    function bet(uint _proposalId, uint _amount) public {
        require(voteCount[msg.sender] > 0, "You must vote to place bets");
        require(Token.balanceOf(msg.sender) >= _amount, "Insufficient balance");
        require(
            Token.allowance(msg.sender, address(this)) >= _amount,
            "Insufficient allowance"
        );
        require(_amount > 0, "Invalid amount");

        Token.transferFrom(msg.sender, address(this), _amount);
        votes[_proposalId].totalBets += _amount;
    }

    function getVoteCount(address _voter) public view returns (uint) {
        return voteCount[_voter];
    }

    function getBetCount(address _voter) public view returns (uint) {
        return betCount[_voter];
    }
}
