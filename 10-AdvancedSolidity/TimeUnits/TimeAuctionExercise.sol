// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TimedAuction {
    address highestBidder;
    uint256 highestBid;

    mapping(address => uint256) oldBids;
    uint256 totalWithdrableBids;

    address owner;
    uint256 startTime;

    event Bid(address indexed sender, uint256 amount, uint256 timestamp);

    constructor() {
        startTime = block.timestamp;
        owner = msg.sender;
    }

    function bid() external payable {
        require(
            block.timestamp - startTime < 5 minutes,
            "Auction is past 5 min"
        );

        require(msg.value > highestBid, "Tour bid is too low");

        oldBids[highestBidder] += highestBid;
        totalWithdrableBids += highestBid;

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value, block.timestamp);
    }

    function withdraw() public {
        uint256 amount = oldBids[msg.sender];
        oldBids[msg.sender] = 0;
        totalWithdrableBids -= amount;

        (bool sent, ) = payable(msg.sender).call{value: amount}("");

        require(sent, "Payment failed");
    }

    function claim() public {
        require(msg.sender == owner);
        require(
            block.timestamp - startTime >= 5 minutes,
            "Auction still going"
        );

        require(
            totalWithdrableBids == 0,
            "Not all user have claimed their bids yet"
        );
        selfdestruct(payable(owner));
    }

    function getHighestBidder() public view returns (address) {
        return highestBidder;
    }
}
