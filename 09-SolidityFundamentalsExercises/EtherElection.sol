// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract EtherElection {
    mapping(address => bool) voted;
    mapping(address => int256) votes;

    address[] candidates;

    int256 constant EnrollmentFee = 1 ether;
    int256 constant VoteFee = 10000 wei;

    address owner;
    address winner;

    bool winnerWithdrew;

    constructor() {
        owner = msg.sender;
    }

    function isCandidateInCandidates(address candidate)
        internal
        view
        returns (bool)
    {
        for (uint256 idx; idx < candidates.length; idx++) {
            address currentCandidate = candidates[idx];

            if (currentCandidate == candidate) {
                return true;
            }
        }

        return false;
    }

    function enroll() public payable {
        require(candidates.length != 3, "Candidates list is full");
        require(
            int256(msg.value) == 1 ether,
            "Incorrect enrollment Ether amount"
        );
        require(
            !isCandidateInCandidates(msg.sender),
            "Candidate already registered"
        );

        candidates.push(msg.sender);
    }

    function vote(address candidate) public payable {
        require(candidates.length == 3, "List of candidates still in progress");
        require(
            isCandidateInCandidates(candidate),
            "This is not a valid candidate"
        );
        require(winner == address(0), "Voting phase is done");
        require(!voted[msg.sender], "You already voted");
        require(int256(msg.value) == 10000, "Incorrect voting wei amount");

        voted[msg.sender] = true;

        votes[candidate]++;

        if (votes[candidate] == 5) {
            winner = candidate;
        }
    }

    function getWinner() public view returns (address) {
        require(winner != address(0), "Voting still in progress");

        return winner;
    }

    function claimReward() public {
        require(winner != address(0), "Voting still in progress");
        require(msg.sender == winner, "Only the winner can claim the reward");
        require(!winnerWithdrew, "You already claimed the reward");

        winnerWithdrew = true;
        (bool sent, ) = payable(winner).call{value: 3 ether}("");

        require(sent, "Payment failed");
    }

    function collectFees() public {
        require(winnerWithdrew, "Winnder has not yet claimed their reward");
        require(msg.sender == owner, "You are not the owner");

        selfdestruct(payable(owner));
    }
}
