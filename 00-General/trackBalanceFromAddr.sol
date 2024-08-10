// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Balances {
    // Write your code here
    mapping(address => uint256) received;

    function getAmountSent(address addr) public view returns (uint256) {
        return received[addr];
    }

    receive() external payable {
        received[msg.sender] += msg.value;
    }

    fallback() external payable {
        received[msg.sender] += msg.value;
    }
}
