// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Strings {
    // strings are ONLY useful for storing the character set UTF-8
    string public x = "Hello World!";

    // on the other hand, bytes type is the prefered way for storing chars as raw data
    // Must be store in memory, calldata or storage
    bytes public y = "Hello world!";

    function testString() public {
        y[0] = "F";
        y.length;
        y.push("!");
        y.pop();
        delete y[0];
    }

    function getBytesAsString() public view returns (string memory) {
        return string(y);
    }

    function addCharToString(string memory str)
        public
        pure
        returns (string memory)
    {
        bytes memory convertedStr1 = bytes(str);
        // convertedStr.push("1"); // -- this does not work -- "push" is not available in bytes memory outside of storage
        // it's dynamic, so I need to create a fixed size bytes with at least one slot extra
        bytes memory convertedStr2 = new bytes(bytes(str).length + 1);
        // then I will need to push all chars into the new array, but we need FOR LOOPS - there is an easier way

        string memory newStr = string.concat(str, "s"); // low level, it converts to bytes arrays and does it efficiently

        return newStr;
    }
}
