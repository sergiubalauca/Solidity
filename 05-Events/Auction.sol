// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Auction {
    address owner;

    uint256 highestBid;
    address highestBidder;
    mapping(address => uint256) oldBids;

    // indexed allows to search though the Bid event, using bidder address
    event Bid(address indexed bidder, uint256 value);
    // event data is stored in transaction logs
    // I can mark max 3 indexed props in event
    // indexed keywords are referred to as topics and are the fields you can use to search for events.
    event StopAuction(address indexed highestBidder, uint256 highestBid);

    constructor() {
        owner = msg.sender;
    }

    function bid() external payable {
        require(msg.value > highestBid, " Bid too low");
        require(msg.sender != owner, "Owner cannot bid");

        // update also the previous addresses in the mapping, so that the old bidders can withdraw eth
        oldBids[highestBidder] = highestBid;
        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
    }

    function withdraw() external {
        require(msg.sender != owner, "Owner cannot withdraw");

        uint256 value = oldBids[msg.sender];

        oldBids[msg.sender] = 0;

        (bool sent, ) = payable(msg.sender).call{value: value}("");

        require(sent, "Payment failed");
    }

    function stopAuction() external payable {
        require(msg.sender == owner);
        emit StopAuction(highestBidder, highestBid);
        selfdestruct(payable(owner));
    }
}
