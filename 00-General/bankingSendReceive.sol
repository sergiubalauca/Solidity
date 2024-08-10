// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract SendReceive {
    mapping(address => uint256) received;

    // send what money the user sent to us back to him
    function withdraw() external {
        uint256 value = received[msg.sender];
        received[msg.sender] = 0; // we need to set this before sending eth to them, to avoid exploting attack
        payable(msg.sender).call{value: value}(""); // in the end we give control to them
        // received[msg.sender] = 0;

        // payable(msg.sender).call{value: 1 ether}(""); --- if we try to send more than the balance,
        // we will not get any exception. The return value will just be false
    }

    receive() external payable {
        received[msg.sender] += msg.value;
    }

    fallback() external payable {
        received[msg.sender] += msg.value;
    }
}
