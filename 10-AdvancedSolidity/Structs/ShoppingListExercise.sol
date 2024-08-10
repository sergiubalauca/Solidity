// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract ShoppingList {
    mapping(address => User) users;

    struct User {
        mapping(string => List) lists;
        string[] listName;
    }

    struct List {
        string name;
        Item[] items;
    }

    struct Item {
        string name;
        uint256 quantity;
    }

    function listNameExists(string memory listName)
        internal
        view
        returns (bool)
    {
        return bytes(users[msg.sender].lists[listName].name).length != 0;
    }

    function createList(string memory name) public {
        require(!listNameExists(name), "List already created with this name");
        require(bytes(name).length > 0, "Name for list cannot be empty");
        users[msg.sender].listName.push(name);
        users[msg.sender].lists[name].name = name;
    }

    function getListNames() public view returns (string[] memory) {
        return users[msg.sender].listName;
    }

    function getItemNames(string memory listName)
        public
        view
        returns (string[] memory)
    {
        require(listNameExists(listName), "List does not exists");

        uint256 listItemNamesLength = users[msg.sender]
            .lists[listName]
            .items
            .length;
        string[] memory itemNames = new string[](listItemNamesLength);

        for (uint256 idx; idx < listItemNamesLength; idx++) {
            itemNames[idx] = users[msg.sender].lists[listName].items[idx].name;
        }

        return itemNames;
    }

    function addItem(
        string memory listName,
        string memory itemName,
        uint256 quantity
    ) public {
        require(listNameExists(listName), "List does not exists");

        Item memory item = Item({name: itemName, quantity: quantity});

        users[msg.sender].lists[listName].items.push(item);
    }
}
