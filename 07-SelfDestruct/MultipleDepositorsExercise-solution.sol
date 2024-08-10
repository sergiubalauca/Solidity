// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Competitors {
    address owner;
    address depositor1;
    address depositor2;
    address maxDepositor;

    uint256 depositor1Deposited;
    uint256 depositor2Deposited;

    bool withdrew;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value == 1 ether, "Value should be 1 Ether");
        require(
            depositor1Deposited + depositor2Deposited < 3 ether,
            "3 ETH have been received, no more deposits accepted"
        );

        if (depositor1 == address(0)) {
            depositor1 = msg.sender;
        } else if (depositor2 == address(0)) {
            depositor2 = msg.sender;
        }

        if (msg.sender == depositor1) {
            depositor1Deposited += msg.value;
        } else if (msg.sender == depositor2) {
            depositor2Deposited += msg.value;
        } else {
            revert("You are not a valid depositor");
        }

        if (depositor1Deposited + depositor2Deposited >= 3 ether) {
            if (depositor1Deposited > depositor2Deposited) {
                maxDepositor = depositor1;
            } else {
                maxDepositor = depositor2;
            }
        }
    }

    function withdraw() external {
        require(
            depositor1Deposited + depositor2Deposited >= 3 ether,
            "3 ether have not yet been received"
        );
        require(msg.sender == maxDepositor, "You did not deposit the most ");

        (bool sent, ) = payable(maxDepositor).call{value: 3 ether}("");
        require(sent);
        withdrew = true;
    }

    function destroy() external {
        require(withdrew);
        require(
            msg.sender == owner,
            "You are not the owner and cannot destroy this"
        );
        selfdestruct(payable(owner));
    }
}
