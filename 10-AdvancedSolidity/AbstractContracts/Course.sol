// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

abstract contract AbstractMath {
    function return1() public pure returns (uint256) {
        return 1;
    }

    function getValue() public view virtual returns (uint256);

    function add5() public view returns (uint256) {
        return getValue() + 5; // this is valid, even though we don't know the implementation for getValue()
        // this is because this class cannot be instantiated, and classes that inherits it will have to implement
        // getValue() method for sure
    }
}

contract Math is AbstractMath {
    uint256 x;

    function setX(uint256 newX) public {
        x = newX;
    }

    function getValue() public view override returns (uint256) {
        return x;
    }
}

abstract contract Test {
    uint256 x;

    constructor(uint256 _x) internal {
        // abstract contract constructor is internal by default
        // for non abstract ones, internal is not possible
        x = _x;
    }
}

contract A is Test(2) {

}