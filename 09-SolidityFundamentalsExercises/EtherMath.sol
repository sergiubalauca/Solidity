// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

error NumberNotInChallenge(int256 number);

contract EtherMath {
    address onwer;
    int256 sum;
    uint256 reward;

    int256[] public challengeArray;
    int256 public challengeTargetSum;

    mapping(address => uint256) unclaimedRewards;
    address[] submittedSolution;

    constructor() {
        onwer = msg.sender;
    }

    function submitChallenge(int256[] memory array, int256 targetSum)
        public
        payable
    {
        require(reward == 0, "Challenge not yet set or resolved");
        require(onwer == msg.sender, "You are not the owner");
        require(msg.value > 0, "You must provide a reward");
        challengeArray = array;
        challengeTargetSum = targetSum;
        reward = msg.value;
    }

    function submitSolution(int256[] memory solution) public {
        require(reward != 0, "No challenge yet set");
        require(
            !userSubmittedSolution(msg.sender),
            "You already submitted a solution"
        );

        if (checkSolution(solution)) {
            unclaimedRewards[msg.sender] += reward;

            reward = 0;
            challengeTargetSum = 0;

            delete challengeArray;
            delete submittedSolution;
        }
    }

    function userSubmittedSolution(address user) internal view returns (bool) {
        for (uint256 idx; idx < submittedSolution.length; idx++) {
            address currentUser = submittedSolution[idx];
            if (currentUser == user) {
                return true;
            }

            return false;
        }
    }

    function checkSolution(int256[] memory array) internal view returns (bool) {
        int256 possibleSolution;

        for (uint256 i = 0; i < array.length; i++) {
            bool numberExists;
            for (uint256 j = 0; j < challengeArray.length; j++) {
                if (array[i] == challengeArray[j]) {
                    numberExists = true;
                }
            }

            if (!numberExists) {
                return false;
            }
            possibleSolution += array[i];
        }

        return possibleSolution == challengeTargetSum;
    }

    function claimRewards() public {
        uint256 userReward = unclaimedRewards[msg.sender];
        unclaimedRewards[msg.sender] = 0;

        (bool sent, ) = payable(msg.sender).call{value: userReward}("");
        require(sent, "Transfer failed");
    }
}
