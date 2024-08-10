// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract FizzBuzz {
    uint256 count = 0;

    event Fizz(address sender, uint256 indexed count);
    event Buzz(address sender, uint256 indexed count);
    event FizzAndBuzz(address sender, uint256 indexed count);

    function increment() public {
        count += 1;

        if (isDivisibleByThree(count) && isDivisibleByFive(count))
            emit FizzAndBuzz(msg.sender, count);
        if (isDivisibleByThree(count)) emit Fizz(msg.sender, count);
        if (isDivisibleByFive(count)) emit Buzz(msg.sender, count);
    }

    function isDivisibleByThree(uint256 _number) public pure returns (bool) {
        return _number % 3 == 0;
    }

    function isDivisibleByFive(uint256 _number) public pure returns (bool) {
        return _number % 5 == 0;
    }
}
