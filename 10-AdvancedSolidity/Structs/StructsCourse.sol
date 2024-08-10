// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Structs {
    // mapping(address => Person) people;
    mapping(address => Person) people;

    // struct Person {
    //     uint256 id;
    //     string name;
    //     address addr;
    //     uint256 balance;
    // }

    struct Person {
        uint256 id;
        string name;
        address addr;
        Person[] friends;
    }

    function setAdvancedName(string memory name) public {
        // if (people[msg.sender].addr != address(0)) {
        people[msg.sender].addr = msg.sender;
        people[msg.sender].name = name;
        // }
    }

    function addFriend(address friend) public {
        require(people[friend].addr != address(0), "Friend has not set name");
        people[msg.sender].friends.push(people[friend]);
    }

    function getFriendNames() public view returns (string[] memory) {
        uint256 numNames = people[msg.sender].friends.length;
        string[] memory names = new string[](numNames);

        for (uint256 idx; idx < numNames; idx++) {
            names[idx] = people[msg.sender].friends[idx].name;
        }

        return names;
    }

    // function createPerson(string memory name) public payable {
    //     // 1. Person memory p; // initialisation with default values
    //     // 2. Person memory p = Person(1, name, msg.sender, msg.value);
    //     Person memory p = Person({
    //         id: 1,
    //         name: name,
    //         balance: msg.value,
    //         addr: msg.sender
    //     });

    //     people[msg.sender] = p;
    // }

    // function getName() public view returns (string memory) {
    //     return people[msg.sender].name;
    // }

    // function setName(string memory newName) public {
    //     people[msg.sender].name = newName;
    // }
}
