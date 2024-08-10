// SPDX-License-Identifier: MIT
// pragma solidity >=0.4.22 <=0.8.17;
pragma solidity >=0.7.0 <0.9.0;

contract Richest {
    address richestUser = address(0);
    mapping(address => uint256) richestMap;
    uint256 highestBid;

    address richest;
    uint256 mostSent;
    mapping(address => uint256) pendingWithdrawls;

    function becomeRichest() external payable returns (bool) {
        address payable possibleRichestUser = payable(msg.sender);
        uint256 userBid = msg.value;
        if (highestBid < userBid) {
            richestMap[possibleRichestUser] += userBid;
            richestUser = possibleRichestUser;
            highestBid = userBid;
            return true;
        }

        return false;
    }

    function withdraw() external {
        address payable possibleRichestUser = payable(msg.sender);
        uint256 value = richestMap[msg.sender];
        if (possibleRichestUser != richestUser) {
            richestMap[msg.sender] = 0;
            (bool sent, ) = payable(msg.sender).call{value: value}("");
        }
    }

    function becomeRichestOptimal() external payable returns (bool) {
        if (msg.value <= mostSent) {
            return false;
        }

        // this is more optimal because I am LATE assigning pending withdrawls only when a higher bid comes
        // in this way, I don't need to check in withdrawOptimal if the msg.sender is different than the richest
        pendingWithdrawls[richest] += mostSent;
        richest = msg.sender;
        mostSent = msg.value;

        return true;
    }

    function withdrawOptimal() external {
        uint256 amount = pendingWithdrawls[msg.sender];
        pendingWithdrawls[msg.sender] = 0; // important to do this before tranferring the funds
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
    }

    function getRichest() external view returns (address) {
        return richestUser;
    }

    receive() external payable {}

    fallback() external payable {}
}
