//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicVotingSystem {
    // Struct to represent each option
    struct Option {
        string name;
        uint256 voteCount;
    }

    // Array of options
    Option[] public options;

    // Mapping to keep track of whether an address has voted
    mapping(address => bool) public hasVoted;

    // Function to add an option
    function addOption(string memory _name) public {
        options.push(Option(_name, 0));
    }

    // Function to vote for an option
    function vote(uint256 _optionIndex) public {
        require(_optionIndex < options.length, "Invalid option index");
        require(!hasVoted[msg.sender], "You have already voted");

        options[_optionIndex].voteCount++;
        hasVoted[msg.sender] = true;
    }

    // Function to get the total number of options
    function getOptionsCount() public view returns (uint256) {
        return options.length;
    }

    // Function to get the name and vote count of an option
    function getOption(uint256 _index) public view returns (string memory, uint256) {
        require(_index < options.length, "Invalid option index");

        return (options[_index].name, options[_index].voteCount);
    }

    // Function to determine the winner
    function getWinner() public view returns (string memory) {
        uint256 maxVotes = 0;
        uint256 winningOptionIndex = 0;

        for (uint256 i = 0; i < options.length; i++) {
            if (options[i].voteCount > maxVotes) {
                maxVotes = options[i].voteCount;
                winningOptionIndex = i;
            }
        }

        return options[winningOptionIndex].name;
    }
}
