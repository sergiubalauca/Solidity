// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract SendReceive {
    // here I want to send balance of smart contract to the whoever called the function
    function withdraw1() public {
        address payable user = payable(msg.sender);
        bool sent = user.send(address(this).balance); // send() returns a bool
    }

    // send and transfer functions only forward 2300 gas to whatever functions is receiving this eth.
    // considering another smart contract could be calling the withdraw, in the end eth getting to them
    // will be handle in their own receive functions which may not be able to process based on 2300 gas,
    // especially if in the receive function we do some extra logic and operations
    // Solidity does this to avoid re-entrance attack
    function withdraw2() public {
        address payable user = payable(msg.sender);
        user.transfer(address(this).balance); // transfer does not return anything
    }

    // preffered way to transfer
    function withdraw3() public {
        address payable user = payable(msg.sender);
        user.call{value: address(this).balance}(""); // does a low level call with more flexibility
        // this also passed the necessary gas along
    }

    // receive and fallback don't necessarily need to handle msg.value, they are still going to
    // be handled by the contract
    receive() external payable {}

    fallback() external payable {}
}

// Re entrance attack
contract Thief {
    SendReceive ctr = new SendReceive();

    function callWithdraw() public {
        ctr.withdraw1();
    }

    receive() external payable {
        // when ctr is transfering eth, here when I receive it I can call it again!!!
    }

    fallback() external payable {}
}
