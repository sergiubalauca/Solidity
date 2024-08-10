// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract RestrictedCount {
    address owner;
    int256 count;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier addCheck(int256 value) {
        require(count + value <= 100);
        require(count + value >= -100);
        _;
    }

    modifier subtractCheck(int256 value) {
        require(count - value <= 100);
        require(count - value >= -100);
        _;
    }

    function getCount() public view returns (int256) {
        return count;
    }

    function add(int256 value) public onlyOwner addCheck(value) {
        count += value;
    }

    function subtract(int256 value) public onlyOwner subtractCheck(value) {
        count -= value;
    }
}
