// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract GreedyBanker {
    mapping(address => bool) usedFreeUserDeposits;
    mapping(address => uint256) userDeposits;

    uint256 ownerDepositPool;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        uint256 depositFee = 1000 wei;
        if (!usedFreeUserDeposits[msg.sender]) {
            userDeposits[msg.sender] += msg.value;
            usedFreeUserDeposits[msg.sender] = true;
        } else {
            require(msg.value >= depositFee, "At least 1000 wei are required");

            userDeposits[msg.sender] += msg.value - depositFee;
            ownerDepositPool += depositFee;
        }
    }

    fallback() external payable {
        ownerDepositPool += msg.value;
    }

    function withdraw(uint256 amount) external {
        address payable userToPay = payable(msg.sender);
        uint256 withdrawal = userDeposits[msg.sender];
        require(withdrawal >= amount, "You want to withdraw too much");

        userDeposits[msg.sender] -= amount;

        (bool sent, ) = userToPay.call{value: amount}("");
        require(sent, "Failed to sent transaction");
    }

    function collectFees() external {
        require(msg.sender == owner, "Only the onwer can withdraw fees");

        uint256 balanceToWithdraw = ownerDepositPool;
        ownerDepositPool = 0;
        (bool sent, ) = payable(msg.sender).call{value: balanceToWithdraw}("");
        require(sent, "Failed to sent transaction");
    }

    function getBalance() public view returns (uint256) {
        uint256 amount = userDeposits[msg.sender];
        return amount;
    }
}
