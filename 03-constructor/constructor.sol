// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract ConstructorTest {
    address public owner;

    // runs one time when the contract is deployed
    constructor() {
        owner = msg.sender;
    }

    receive() external payable {

    }

    // eg. track that only the onwer of the contract can withdraw money
    function withdraw(uint amount) public {
        require(msg.sender == owner, 'You are not the owner');
        require(address(this).balance >= amount, 'Not enough balance');

        (bool sent, ) = payable (owner).call{value: amount}('');
        require(sent, 'Failed to send');
    }
}