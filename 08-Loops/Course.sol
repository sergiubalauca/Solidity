// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Loops {
    address[] public addresses;
    mapping(address => bool) addressesAdded;

    function test() public pure {
        while (true) {
            continue;
            break;
        }

        // pay attention to max i, cause it's defined by uint i which max a max value to iterato to
        for (uint256 i; i < 10; i++) {}
    }

    function test2(uint256 maxLoops) public pure returns (uint256) {
        uint256 sum;
        for (uint256 i = 0; i < maxLoops; i++) {
            sum += i;
        }

        return sum;
    }

    function addAddress() external {
        require(!addressesAdded[msg.sender], "Addr already added ");
        addressesAdded[msg.sender] = true;

        // for (uint256 idx; idx < addresses.length; idx++) {
        //     address currentAddress = addresses[idx];
        //     if (currentAddress == msg.sender) {
        //         revert("Sender is already in adresses");
        //     }
        // }

        addresses.push(msg.sender);
    }
}
