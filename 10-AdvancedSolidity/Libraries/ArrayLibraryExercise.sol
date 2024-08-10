// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

library Array {
    function indexOf(int256[] memory numbers, int256 target)
        public
        pure
        returns (int256)
    {
        for (uint256 idx; idx < numbers.length; idx++) {
            if (numbers[idx] == target) {
                return int256(idx);
            }
        }

        return -1;
    }

    function count(int256[] memory numbers, int256 target)
        public
        pure
        returns (uint256)
    {
        uint256 occurence;

        for (uint256 idx; idx < numbers.length; idx++) {
            if (numbers[idx] == target) {
                occurence += 1;
            }
        }

        return occurence;
    }

    function sum(int256[] memory numbers) public pure returns (int256) {
        int256 sumOfNumbers;

        for (uint256 idx; idx < numbers.length; idx++) {
            sumOfNumbers += numbers[idx];
        }

        return sumOfNumbers;
    }
}
