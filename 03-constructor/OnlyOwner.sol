// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract OnlyOwner {
    address owner;
    uint8 interactions;

    constructor() {
        owner = msg.sender;
    }

    function add(uint8 number) public {
        require(msg.sender == owner, 'You are not the owner');
        interactions += number;
    }

    function subtract(uint8 number) public {
        require(msg.sender == owner, 'You are not the owner');
        interactions -= number;
    }

    function get() public view returns (uint8){
        require(msg.sender == owner, 'You are not the owner');
        return interactions;
    }
}