// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface ReturnsValue {
    enum Type {
        One,
        Two
    }

    struct TestStruct {
        string name;
    }

    // interface functions need to be marked as EXTERNAL!!!
    function getValue() external view returns (string memory);
}

contract A is ReturnsValue {
    string str = "Hello World";

    function getValue() external view override returns (string memory) {
        return str;
    }
}

contract B is ReturnsValue {
    string str = "YES";

    function getValue() external view override returns (string memory) {
        return str;
    }
}

// test the fact that we can use getValue() from both A and B
contract Test {
    // I need to add ReturnsValue for the first element since Solidity based on
    // the type of the first element know the type of the array
    ReturnsValue[] values = [ReturnsValue(new A()), new B()];

    function getValues() public view returns (string[] memory) {
        string[] memory strings = new string[](values.length);

        for (uint256 idx; idx < values.length; idx++) {
            strings[idx] = values[idx].getValue();
        }

        return strings;
    }
}
