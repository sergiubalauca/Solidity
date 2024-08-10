// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Mappings {
    mapping(address => mapping(address => uint256)) private allowance;
    mapping(uint256 => bool) map;
    mapping(uint256 => mapping(uint256 => int256)) map2;
    mapping(uint256 => int256) baseMap;

    function addItem(uint256 key, bool value) public {
        map[key] = value;
    }

    function getItem(uint256 key) public view returns (bool) {
        // if there is not vaue for a key, it's going to return the default value for the type of the value,
        // which in this case is false for bool
        return map[key];
    }

    function addItem2(
        uint256 key1,
        uint256 key2,
        int256 value
    ) public {
        map2[key1][key2] = value;
    }

    function getItem2(uint256 key1, uint256 key2) public view returns (int256) {
        return map2[key1][key2];
    }

    function copyMapAndModify() public {
        // this does not actually copy my mapping, but it creates an alias to reference the same baseMap!!!
        // mappings can only be used on storage level
        // mappings are pretty weird and limited. They don't have any .keys(), .values() methods
        // we can't know which keys hold values. For that we need arrays to store separately such info.....
        mapping(uint256 => int256) storage duplicateMapping = baseMap;
        duplicateMapping[1] = 2;
        duplicateMapping[2] = 3;
    }

    function getDuplicateMapping(uint256 key) public view returns (int256) {
        return baseMap[key];
    }

    function fn(mapping(uint256 => int256) storage mp) internal returns (bool) {
        // this is the only way we can use a mapping as parameter - storage memory and for
        // the function to use internal - basically it's only used in the internal context of
        // the contract, can't do any transaction with it
    }

    mapping(uint256 => int256) quantities;

    function addQty(uint256 itemId, uint256 quantity) public {
        if (entryExistsInMap(itemId) == 1) {
            quantities[itemId] += int256(quantity);
            return;
        } else {
            quantities[itemId] = int256(quantity);
        }

        // OR Simplified version
        // quantities[itemId] += int256(quantity); // because if 0, means it does not exist
    }

    function getQuantity(uint256 itemId) public view returns (int256) {
        if (entryExistsInMap(itemId) == 1) {
            return quantities[itemId];
        }
        return -1;

        // OR Simplified version
        // return quantities[itemId] != 0 ? int256(quantities[itemId]) : -1
    }

    function entryExistsInMap(uint256 key) internal view returns (int256) {
        return quantities[key] != 0 ? int256(1) : int256(-1);
    }
}

contract DebtTracking {
    // Write your code here
    mapping(address => mapping(address => uint256)) owing;

    function addDebt(
        address toBePaidAddress,
        address payingAddress,
        uint256 amount
    ) public {
        owing[toBePaidAddress][payingAddress] += amount;
    }

    function payDebt(
        address toBePaidAddress,
        address payingAddress,
        uint256 amount
    ) public {
        if (owing[toBePaidAddress][payingAddress] >= amount) {
            owing[toBePaidAddress][payingAddress] -= amount;
        } else {
            owing[payingAddress][toBePaidAddress] =
                amount -
                owing[toBePaidAddress][payingAddress];
            owing[toBePaidAddress][payingAddress] = 0;
        }
    }

    function getDebt(address toBePaidAddress, address payingAddress)
        public
        view
        returns (uint256)
    {
        return owing[toBePaidAddress][payingAddress];
    }
}
