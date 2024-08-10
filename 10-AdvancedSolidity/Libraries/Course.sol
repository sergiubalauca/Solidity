// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

library Math {
    // can't have state
    // can't selfdestruct
    // cannot inherit from anything
    // cannot be inheritted from
    // calling Lib methods is free, they don't cost anything, they don't modify any state
    // can't mark functions as payable
    // we can define structs and enums

    function max(int256[] memory numbers, int256 test)
        public
        pure
        returns (int256)
    {
        if (numbers.length == 0) {
            return 0;
        }
        int256 currentMax = numbers[0];

        for (uint256 idx; idx < numbers.length; idx++) {
            if (numbers[idx] > currentMax) {
                currentMax = numbers[idx];
            }
        }

        return currentMax;
    }

    function max(uint256[] memory numbers) public pure returns (uint256) {
        if (numbers.length == 0) {
            return 0;
        }
        uint256 currentMax = numbers[0];

        for (uint256 idx; idx < numbers.length; idx++) {
            if (numbers[idx] > currentMax) {
                currentMax = numbers[idx];
            }
        }

        return currentMax;
    }
}

contract Test {
    int256[] numbers;
    uint256[] uNumbers;
    uint256 constant MY_CONSTANT = 42;

    function addNumber(int256 number) public {
        numbers.push(number);
    }

    function addUNumber(uint256 number) public {
        uNumbers.push(number);
    }

    using Math for int256[];

    // what this means is I am going to be able to call any function who's
    // first param is the int type directly on that type
    function getMax() public view returns (int256) {
        // return Math.max(numbers);
        return numbers.max(2); // when using Math for ...
    }

    using Math for uint256[];

    function getUMax() public view returns (uint256) {
        return uNumbers.max();
    }

    function getCombinedMax() public view returns (int256, uint256) {
        return (numbers.max(3), uNumbers.max());
    }
}
