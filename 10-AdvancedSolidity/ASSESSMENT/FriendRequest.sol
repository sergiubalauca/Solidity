// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Friends {
    mapping(address => Friend) people;

    struct Friend {
        address[] requestsSent;
        address[] requestsReceived;
        address[] friends;
    }

    function deleteFromArray(address[] storage array, address target) internal {
        uint256 targetIdx;

        for (uint256 idx; idx < array.length; idx++) {
            if (array[idx] == target) {
                targetIdx = idx;
                break;
            }
        }

        uint256 lastIdx = array.length - 1;
        address lastValue = array[lastIdx];
        array[lastIdx] = target;
        array[targetIdx] = lastValue;
        array.pop();
    }

    function arrayContains(
        address[] memory array,
        address target
    ) internal pure returns (bool) {
        for (uint256 idx; idx < array.length; idx++) {
            if (array[idx] == target) {
                return true;
            }
        }

        return false;
    }

    function getFriendRequests() public view returns (address[] memory) {
        return people[msg.sender].requestsReceived;
    }

    function getNumberOfFriends() public view returns (uint256) {
        return people[msg.sender].friends.length;
    }

    function getFriends() public view returns (address[] memory) {
        return people[msg.sender].friends;
    }

    modifier notSelf(address friend) {
        require(
            msg.sender != friend,
            "You cannot send a friend request to yourself"
        );
        _;
    }

    modifier requestNotSent(address friend) {
        address[] memory receivedRequests = people[msg.sender].requestsSent;
        require(!arrayContains(receivedRequests, friend));
        _;
    }
    modifier requestNotReceived(address friend) {
        address[] memory sentRequests = people[msg.sender].requestsReceived;
        require(!arrayContains(sentRequests, friend));
        _;
    }
    modifier requestExists(address friend) {
        address[] memory receivedRequests = people[msg.sender].requestsReceived;
        require(arrayContains(receivedRequests, friend));
        _;
    }
    modifier notAlreadyFriends(address friend) {
        address[] memory receivedRequests = people[msg.sender].friends;
        require(!arrayContains(receivedRequests, friend));
        _;
    }

    function sendFriendRequest(
        address friend
    )
        public
        notSelf(friend)
        requestNotReceived(friend)
        requestNotSent(friend)
        notAlreadyFriends(friend)
    {
        people[friend].requestsReceived.push(msg.sender);
        people[msg.sender].requestsSent.push(friend);
    }

    function acceptFriendRequest(address friend) public requestExists(friend) {
        deleteFromArray(people[msg.sender].requestsReceived, friend);
        deleteFromArray(people[friend].requestsSent, msg.sender);
        people[msg.sender].friends.push(friend);
        people[friend].friends.push(msg.sender);
    }
}
