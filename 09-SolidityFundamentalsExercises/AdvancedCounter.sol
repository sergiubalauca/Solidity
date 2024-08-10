// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract AdvancedCounter {
    mapping(address => mapping(string => int256)) counters;
    mapping(address => mapping(string => bool)) counterIdExists; // required to keep track of used ids
    mapping(address => uint256) numCountersCreated; // required to keep track of number of counters

    function counterExists(string memory id) internal view returns (bool) {
        return counterIdExists[msg.sender][id];
    }

    function createCounter(string memory id, int256 value) public {
        require(
            numCountersCreated[msg.sender] != 3,
            "Max number of counters already created"
        );
        require(!counterExists(id), "A counter with this ID already exists");

        counters[msg.sender][id] = value;
        numCountersCreated[msg.sender]++;
        counterIdExists[msg.sender][id] = true;
    }

    function deleteCounter(string memory id) public {
        require(counterExists(id), "The counter does not exists");
        delete counters[msg.sender][id];
        numCountersCreated[msg.sender]--;
        counterIdExists[msg.sender][id] = false;
    }

    function incrementCounter(string memory id) public {
        require(counterExists(id), "The counter does not exists");
        counters[msg.sender][id]++;
    }

    function decrementCounter(string memory id) public {
        require(counterExists(id), "The counter does not exists");
        counters[msg.sender][id]--;
    }

    function getCount(string memory id) public view returns (int256) {
        require(counterExists(id), "The counter does not exists");
        return counters[msg.sender][id];
    }
}
