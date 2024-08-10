// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Test {
    // =============== 1. CALL DATA =============== //
    // when using memory numbers, we get infinite gas estimation
    // that is because numbers array can be infinite length
    function func1(uint256[] memory numbers) external pure returns (uint256) {
        // numbers[0] = 1; this can be performed here
        return numbers[0];
    }

    // when using calldata, we get an actual fixed estimate for gas
    // that is because we are just reading whatever the call data was passed ar argument
    // so it is basically data resulted by a transaction
    function func2(uint256[] calldata numbers) external pure returns (uint256) {
        // numbers[0] = 1; this can NOT be performed here
        return numbers[0];
    }

    // =============== 2. PACK VARIABLES =============== //
    // it's important to be aware of the order in which variables are defined,
    // since the compiler decides memory locations based on that, the structure of storage
    uint8 x = 2;
    uint8 y = 17;
    uint256 z = 20;
    uint128 w = 30;

    // SLOT 1 (32 bytes = 256 bits)
    // x = 2 (8 bits)
    // y = 17

    // SLOT 2
    // z = 20

    // SLOT 3
    // w = 30

    // Based on this, we can optimize out costs, by reordering a bit the variables
    // SLOT 1
    // uint8 x = 2;
    // uint8 y = 17;
    // uint128 w = 30;

    // SLOT2
    // uint256 z = 20;

    // =============== 3. DELETE UNUSED VARIABLES =============== //
    uint256 a = 10;

    function delA() public {
        delete a; // this only resets the value to 0 - this actually does a gas refund!!!
        x = 0; // this is different than deleting the value, it costs more gas!!!
    }

    // =============== 4. DON'T SHRINK VARIABLES =============== //
    // uint as default
    // int as default
    uint8 b = 10; // it's actually more effective to use the uint default type. The conversion to int costs gas.

    // ONLY SHRINK is you pack the variables together!!!

    // =============== 5. USE EVENTS rather that storing data on chain =============== //
    // =============== 6. USE LIBRARIES for code reusing =============== //
    // =============== 7. USE CALLDATA instead of MEMORY =============== //
    // =============== 8. USE SHORT CIRCUITING RULES =============== //
    function check1() internal pure returns (bool) {
        // returns true very ofter
        return true;
    }

    function check2() internal pure returns (bool) {
        // harly returns true
        return true;
    }

    function test() public pure {
        require(check2() && check1()); // this would be an optimized way, considering the occurence of true/false
        // however, if check2() would require a lot of gas for computation, I should reconsider the order => check1 && check2
    }

    // =============== 9. AVOID ASSIGNMENTS (especially to storage) =============== //
    // uint p = 0; this takes up more gas than leaving p blank
    uint256 p;

    // =============== 10. AVOID DOING OPERATIONS ON STORAGE =============== //
    uint256 count;

    function countUp(uint256 count2) external {
        uint256 _count;
        for (uint256 idx; idx < count2; idx++) {
            // count += idx; // the issue here is that we are repeatedly doing an operation on a storage variable
            _count += idx; // we should locally cache the result and only in the end assign the var to the storage one
        }

        count = _count;
    }

    // =============== 11. USE FIXED SIZE ARRAYS =============== //
    // =============== 12. USE MAPPINGS instead of ARRAYS =============== //
    // =============== 13. USE BYTES instead of STRING =============== //
    // =============== 14. USE EXTERNAL instead of PUBLIC modifier =============== //
}
