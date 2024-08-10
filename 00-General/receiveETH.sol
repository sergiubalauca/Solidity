// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract SendReceive {
    // wei - smallest possible amount of eth = 1
    // gwei = 1e9 wei
    // ether = 1e18 wei
    uint256 public received;
    uint256 public fallbackReceived;
    uint256 public payReceived;

    // special function used to receive eth - we don't any way to call this function
    // in the deployed contract, but when msg.data is blank, but if send eth to this smart contract
    // it's called automatically
    receive() external payable {
        received += msg.value; // amount of eth sent with the transaction
    }

    // called in case the smart contract can't handle what was sent to it
    // for instance when msg.data is not empty - the last resort
    // another case is when we try to call a function on the contract that does not exists
    fallback() external payable {
        fallbackReceived += msg.value;
    }

    // marking a function as payable, allows for receiving eth and in this specific case, we can
    // send eth to a function. It's available to interact with.
    function pay() external payable {
        payReceived += msg.value;
    }
}
