// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract HelloWorld {
    uint256 number; // this takes up 256 bits which is 32 bytes
    uint8 number2; // this can stores numbers from 0 -> 2^8, but not including last value!!! so 0 -> (2^8 - 1) so 0 - 255
    // by default uint defaults to uint256
    int8 number3 = 6; // this needs a bit to store the sign so it will be (-2^(8-1) -> (2^(8-1) - 1)

    address _addr = address(0); // will use 20 bytes, 160 bits
    // 0 is represented as address(0) or  0x0000000000000000000000000000000000000000
    bool b = true;

    function store(uint256 num) public {
        number = num;
    }

    function setAddress(address addr) public {
        _addr = addr;
    }

    function get() public view returns (uint256) {
        return number;
    }

    function getAddress() public view returns (address) {
        return _addr;
    }

    function getBool() public view returns (bool) {
        return b;
    }

    int256 y = 9;
    uint256 x = 10;

    function op() public {
        number3 = number3 / 5; // the implicit type of 5 will be automatically done to int8, type of number3
        // the result of the operation is always going to be the type of the operator used in the operation -> 1
        x = x + uint256(y);
        // cannot convert x to int(x) because I cannot store unit to int, but the other way around - because of the operation result type
        // I would want usually to go with the larger type, int
    }

    uint256 a = 10000;
    uint8 c = 9;

    function getC() public view returns (uint8) {
        // c = uint8(a) + c; if I do this, conversion uint8(a) will actually not throw any error, but the result will be unexpected
        return c;
    }
}
