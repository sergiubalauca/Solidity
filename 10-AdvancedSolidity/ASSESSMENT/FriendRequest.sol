// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Friends {
    struct Friend {
        address[] pendingFriendRequests;
        string[] friends;
    }

    function getFriendRequests() public view returns (address[] memory) {}
}
