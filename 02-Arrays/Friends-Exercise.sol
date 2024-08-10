// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Following {
    mapping(address => address[]) following;

    function follow(address toFollow) external {
        require(
            following[msg.sender].length < 3,
            "Already following 3 addresses"
        );
        require(msg.sender != toFollow, "You cannot follow yourself");

        following[msg.sender].push(toFollow);
    }

    function getFollowing(address addr)
        external
        view
        returns (address[] memory)
    {
        return following[addr];
    }

    function clearFollowing() public {
        address sender = msg.sender;
        delete following[sender];
    }
}
