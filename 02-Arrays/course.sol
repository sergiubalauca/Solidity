// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Arrays {
    // fixed sized array (STORAGE) with initialisation. The rest of the 3 slots are the default value for uint256, meaning 0;
    uint256[5] public numbers = [1, 2];
    // dynamic sized array
    uint256[] public numbers2 = [1, 2];
    uint256 constant arrayLength = 1;

    function add(uint256 value) public {
        numbers2.push(value);
    }

    function pop() public {
        numbers2.pop();
    }

    function length() public view returns (uint256) {
        return numbers2.length;
    }

    function remove(uint256 idx) public {
        // reset the default value at index ids from the array
        delete numbers2[idx];
    }

    // in MEMORY arrays now - they can only be fixed size because I don't have access to functions like push
    function test() public pure returns (uint256) {
        // cannot create dynamic arrays like this
        uint256[] memory numbers3;
        // uint256[] memory numbers4 = [1, 2, 3]; --- error: value 1 dictates what type the array is (uint8 in this case)
        // confusing because uint256 x = 2 works. but for arrays not..... SOLIDITY...
        // this works - I need to parse the first number and allocated fixed size of 3 to the array
        uint256[3] memory numbers4 = [uint256(1), 2, 3];
        // numbers3.push(1); --- error

        return numbers4.length;
    }

    function test2(uint256 size) public pure returns (uint256[] memory) {
        // uint256[size] memory number; -- error, size can change, I need a constant;
        uint256[arrayLength] memory numbers;

        uint256[] memory numbers2 = new uint256[](size); // this works as dynamic array creation
        uint256[] memory numbers3 = numbers2; // if I reference a storage array to assign it like this,
        // solidity will automatically create a separate copy, meaning if I change the value of numbers2,
        // it will not be reflected in numbers3;

        // from memory to memory, it will just create an alis, not a copy, meaning chaning a value in one array
        // it will change it in the other

        return numbers2;
    }

    // MULTI DIMENSIONAL Arrays
    function test3() public pure returns (uint256[][3] memory) {
        uint256[][3] memory x = [
            new uint256[](2),
            new uint256[](1),
            new uint256[](3)
        ];

        return x;
    }
}
