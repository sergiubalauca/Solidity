// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

abstract contract SignUpBonus {
    mapping(address => bool) usersFirstDeposit;
    mapping(address => uint256) userDeposits;

    function getBonusAmount() public virtual returns (uint256);

    function getBonusRequirements() public virtual returns (uint256);

    function deposit() public payable {
        // require(msg.value > 0, "Deposit amount must be greater than 0");
        if (!usersFirstDeposit[msg.sender]) {
            uint256 bonusRequirement = getBonusRequirements();

            if (msg.value > bonusRequirement) {
                uint256 signupBonus = getBonusAmount();

                userDeposits[msg.sender] += signupBonus;
            }
        }
        usersFirstDeposit[msg.sender] = true;
        userDeposits[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(userDeposits[msg.sender] >= amount, "Insufficient balance");

        userDeposits[msg.sender] -= amount;

        (bool sent, ) = payable(msg.sender).call{value: amount}("");

        require(sent, "Failed to send");
    }

    function getBalance() public view returns (uint256) {
        return userDeposits[msg.sender];
    }
}

contract Bank is SignUpBonus {
    function getBonusAmount() public pure override returns (uint256) {
        // return usersFirstDeposit[msg.sender] ? 150 wei : 0;
        return 150 wei;
    }

    function getBonusRequirements() public pure override returns (uint256) {
        return 1000 wei;
    }
}
