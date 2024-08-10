// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

error NumberNotInRange(uint256 number);

contract Voting {
    mapping(uint8 => uint256) private votes;
    mapping(address => bool) private voted;
    uint256 private currentWinner;
    uint256 mostVotes;

    function vote(uint8 number) external {
        require(!voted[msg.sender], "You already voted");

        if (1 >= number || number >= 5) {
            revert NumberNotInRange(number);
        }

        voted[msg.sender] = true;
        votes[number]++;

        // checking if votes[number] >= to mostVotes, in order to
        // assign the most recent voting winner
        if (votes[number] >= mostVotes) {
            currentWinner = number;
            mostVotes = votes[number];
        }
    }

    function getVotes(uint8 number) public view returns (uint256) {
        if (1 >= number || number >= 5) {
            revert NumberNotInRange(number);
        }
        return votes[number];
    }

    function getCurrentWinner() public view returns (uint256) {
        if (currentWinner == 0) {
            return 1;
        }
        return currentWinner;
    }

    receive() external payable {}

    fallback() external payable {}
}
