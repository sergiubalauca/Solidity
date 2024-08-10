// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

error BalanceNotLargeEnough(uint256 balance, uint256 amount); // custom error

contract Banking {
    error BalanceNotLargeEnough2(uint256 balance, uint256 amount); // custom error inside contract

    mapping(address => uint256) balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        uint256 balance = balances[msg.sender];
        // if require fails, any remaining gas part of the transaction will be sent back to the sender
        require(balance >= amount, "Balance is not sufficient");

        if (balance < amount) {
            revert BalanceNotLargeEnough(balance, amount);
        }

        balances[msg.sender] -= amount;
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        // we check for the actual transaction result, so that we don't drain balances of user if transaction failed
        require(sent, "Payment failed");

        // another option is revert for more advanced logical conditions
        if (!sent) {
            revert("Payment failed");
        }
        // assert() should always be true; used to check for invariants and verify contract state
        // require() is something that could fail

        // assert does not refund any gas; it's like a test case, used at the end of a function
        assert(balances[msg.sender] == balance - amount);
    }
}
