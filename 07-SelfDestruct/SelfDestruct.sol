// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract SelfDestruct {
    // delete the contract and send the balance of the contract to an address, no matter what
    // it bypasses any receive or fallback function
    // a way to remove the contract from the chain and delete it's state;
    // it can be used in a malicious way - if the contract only relies on the balance, another smart contract which
    // self destructs, can send us funds
    // selfdestruct(address);

    address owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function destroy() external {
        require(owner == msg.sender, "You are not the owner");
        selfdestruct(payable(owner));
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
