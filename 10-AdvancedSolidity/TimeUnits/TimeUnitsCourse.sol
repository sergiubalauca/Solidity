// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TimeUnits {
    uint256 timebomb;
    uint256 count;
    uint256 count2;
    uint256 public lastTime;

    constructor() {
        timebomb = block.timestamp + 1 minutes;
        lastTime = block.timestamp;
    }

    function getTime() public view returns (uint256) {
        // when the block was mined, nonce found, etc
        // Jan 1, 1970 - seconds passed since this date - this is the EPOCH
        return block.timestamp - 2 days;
    }

    function addOne() public {
        require(block.timestamp < timebomb, "Contract done");
        count++;
    }

    function increment() public {
        count2++;
        lastTime = block.timestamp;
    }

    function getMinutesSinceLastCall() public view returns (uint256) {
        return (block.timestamp - lastTime) / 1 minutes;
    }
}
