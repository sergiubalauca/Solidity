// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface Comparable {
    function greaterThan(Comparable other) external view returns (bool);

    function lessThan(Comparable other) external view returns (bool);

    function equalTo(Comparable other) external view returns (bool);

    function getValue() external view returns (int256);
}

contract Vector is Comparable {
    int256 a;
    int256 b;

    constructor(int256 _a, int256 _b) {
        a = _a;
        b = _b;
    }

    function greaterThan(Comparable other)
        external
        view
        override
        returns (bool)
    {
        return getValue() > other.getValue();
    }

    function lessThan(Comparable other) external view override returns (bool) {
        return getValue() < other.getValue();
    }

    function equalTo(Comparable other) external view override returns (bool) {
        return getValue() == other.getValue();
    }

    // we can override external function to public
    function getValue() public view override returns (int256) {
        return a + b;
    }

    // Write your code here
}
