// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Competitors {
    address owner;
    address public winner;
    address firstSender;
    address secondSender;
    mapping(address => bool) competitors;
    mapping(address => int8) competitorDeposit;
    uint8 countCompetitors;
    int8 walletSum;
    int8 max;
    bool public widtdrawn;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value == 1 ether, "Value should be 1 Ether");
        require(countCompetitors <= 1, "You arrived too late to the race");
        require(walletSum < 3, "Cannot reposit more ");

        competitors[msg.sender] = true;
        // require(competitors[msg.sender], "You are not one of the valid competitors");

        if (!competitors[msg.sender]) {
            countCompetitors++;
        }
        competitorDeposit[msg.sender] += 1;

        if (competitorDeposit[msg.sender] >= max) {
            max = competitorDeposit[msg.sender];
            winner = msg.sender;
        }
        walletSum++;
    }

    function withdraw() external {
        require(walletSum == 3, "Cannot withdraw yet");
        require(!widtdrawn, "Already withdrew");

        address payable competitor = payable(msg.sender);
        require(competitor == winner, "You are not the winner");

        (bool sent, ) = competitor.call{value: 3 ether}("");
        require(sent, "Failed to send");

        widtdrawn = true;
    }

    function destroy() external {
        require(widtdrawn);
        require(
            msg.sender == owner,
            "You are not the owner and cannot destroy this"
        );
        selfdestruct(payable(owner));
    }
}
