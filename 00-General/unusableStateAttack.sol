// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// contract which sends change back to someone if they send us to much ETH
contract SendReceive {
    mapping(address => uint256) changeOwed;

    function pay() external payable {
        uint256 value = msg.value;
        if (value > 1000) {
            changeOwed[msg.sender] = value - 1000;
            // payable(msg.sender).transfer(value - 1000); // we don't want to send it inside here, but
            // do the transfer in a separate function.
        }
    }

    // we do the transfer in a separate function because the other contract receiving the change, can
    // set out contract in an unusable state by making the transaction FAIL!!!. We can't try to pay them
    // and if that fails, other parts of the contract can fail. They are writing a smart contract with a
    // fallback that might fail for instance.
    function withdraw() public {
        uint256 value = changeOwed[msg.sender];
        changeOwed[msg.sender] = 0;
        payable(msg.sender).transfer(value);
    }
}
