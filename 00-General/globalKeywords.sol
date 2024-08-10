// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract GlobalKeywords {
    // this
    // msg
    // block
    // tx

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function viewMsg() public view returns (address) {
        // msg.data - complete call data which is a not modifiable not persistent array
        // msg.sig - first 4 bytes of the call data, function to be called
        // msg.value - references how much eth was sent
        return msg.sender; // give whatever called the contract, not any address
    }

    // block.number
    // block.chainid
    // block.gaslimit
    // block.difficulty
    // block.timestamp
    // block.coinbase - address of the miner who mined the block

    function viewBlockNumber() public view returns (uint256) {
        return block.number;
    }

    function getTxOrigin() public view returns (address) {
        return tx.origin;
    }

    function viewGas() public view returns (uint256) {
        return gasleft();
    }
}
