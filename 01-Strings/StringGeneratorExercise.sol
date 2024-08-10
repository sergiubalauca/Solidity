// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract StringGenerator {
    string generated;
    mapping(address => bool) userGenerated;

    function addCharacter(string memory character) public {
        require(!userGenerated[msg.sender], "Already submitted a character");
        require(bytes(character).length == 1, "A single char is accepted only");
        require(
            bytes(generated).length < 5,
            "Reached max allowed chars for the string"
        );

        userGenerated[msg.sender] = true;
        string memory newStr = string.concat(generated, character);
        generated = newStr;
    }

    function getString() public view returns (string memory) {
        return generated;
    }
}
