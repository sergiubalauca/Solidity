// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract MathUtils {
    function floor(int256 value) public pure returns (int256) {
        return value -= value % 10;
    }

    function ceil(int256 value) public pure returns (int256) {
        int256 rest = value % 10;

        if (rest != 0) {
            return value > 0 ? (value + (10 - rest)) : (value - (rest + 10));
        }

        return value;
    }

    function average(int256[] memory values, bool down)
        public
        pure
        returns (int256)
    {
        int256 sum;

        if (values.length == 0) return 0;

        for (uint256 idx = 0; idx < values.length; idx++) {
            sum += values[idx];
        }

        int256 avg = sum / int256(values.length);

        return down ? floor(avg) : ceil(avg);
    }
}
