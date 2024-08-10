// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract GasCostCourse {
    uint256 public sum;
    uint256 constant sumTo = 1000;
    uint256 start = 0;
    uint256 end = 100;
    uint256 public gasLeft;

    function addIntegers() public {
        require(end <= sumTo);

        uint256 startGas = gasleft();
        uint256 increment = 100;
        // for (uint256 i = 1; i <= sumTo; i++) {
        //     sum += i;
        // }

        for (uint256 i = start; i <= end; i++) {
            sum += i;
        }

        start = end + 1;
        end = end + increment;

        gasLeft = startGas - gasleft();
    }
}
