// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Dice {
    mapping (address => uint) betBalance;

    function fundPlayer() public {
        require(betBalance[msg.sender] < 1);
        betBalance[msg.sender] = 10; 
    }

    function playerBalance() public view returns (uint) {
        return betBalance[msg.sender];
    }

    function rollDice() private view returns (uint) {
        //generates random numbers range 1 to 6.
        return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % 7;
    }

    function play(uint amount) public {
        require(betBalance[msg.sender] >= amount);
        uint a = rollDice();
        uint b = rollDice();
        uint rolled = a + b;
        if(rolled >= 10 && rolled <= 12) {
            betBalance[msg.sender] += 10;
        } else {
            betBalance[msg.sender] -= amount;
        }
    }

}