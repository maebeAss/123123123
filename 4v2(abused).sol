// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Character {
    string username;
    address owner;
    uint health;
    constructor(string memory nameIn) payable {
        owner = payable(msg.sender);
        username = nameIn;
        characterData.username = nameIn;
        characterData.health = 10;
        // lastPaymentDate = block.timestamp;
        // lastPaymentAmount = (msg.value);
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    struct CharacterData {
        uint balance;
        uint health;
        string username;
        uint lastPaymentAmount;
        uint lastPaymentDate;
    }

    CharacterData public characterData;

    function deposit() public payable onlyOwner returns (uint256) {
        require(msg.value >= 0.01 ether, "Minimum payment required is 0.01 ETH");
        characterData.balance += msg.value;
        characterData.lastPaymentAmount = msg.value;
        characterData.lastPaymentDate = block.timestamp;
        return msg.value;
    }

    function increaseHealth() public payable onlyOwner returns (uint256) {
        require(characterData.balance >= 0.001 ether, "Insufficient balance for health increase");
        characterData.balance -= 0.001 ether;
        characterData.health++;
        return characterData.health;
    }
}

// contract CharacterManger {
//     mapping(string => address) public characters;

//     function createCharacter (string memory name) public returns (address) {
//         address newCharacter = address(new Character(name));
//         characters[name] = newCharacter;
//         return newCharacter;
// }
//     function getCharacterData(string memory name) public view returns (uint256, uint256, uint256, uint256) {
//         address characterAddress = characters[name];
//         require(characterAddress != address(0), "Character not found");
//         Character character = Character(characterAddress);
//         return (
//            character.getBalance(),
//            character.getLastPaymentDate(),
//            character.getLastPaymentAmount(),
//            character.getHealth()
//         );
//     }
// }
