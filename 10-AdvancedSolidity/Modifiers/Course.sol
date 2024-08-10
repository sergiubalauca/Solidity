// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Modifiers {
    address owner;
    uint256 public modifierCount;
    uint256 public x;
    uint256 public y;
    uint256 public z;

    uint256 public count;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        modifierCount++;
        _; // execute the function that is being modified, represents the function body
    }

    modifier costs(uint256 value) {
        require(msg.value >= value);
        _;
    }

    modifier greaterThan(uint256 value, uint256 min) {
        require(value > min);
        if (true) {
            _;
        }
        setX(5);
        _;
        _; // depending on how many underscores I place, this is how many time the next function/handler will be called
    }

    function setX(uint256 num)
        public
        payable
        costs(1 ether) // the order that we dfine here represents the order the modifiers will be called
        greaterThan(num, 10) // we can send the param directly to the modifier for checking
    {
        x = num;
        count++;
    }

    function setY(uint256 num)
        public
        payable
        costs(2 ether)
        greaterThan(num, 10)
    {
        y = num;
    }

    function setZ(uint256 num)
        public
        payable
        costs(3 ether)
        greaterThan(num, 10)
    {
        z = num;
    }

    function test1() public onlyOwner returns (uint256) {
        return 1;
    }

    function test2() public onlyOwner returns (uint256) {
        return 1;
    }
}
