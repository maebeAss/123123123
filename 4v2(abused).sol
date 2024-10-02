// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Character {
    string username;
    address owner;
    uint health;
    constructor(string memory nameIn, address _owner) payable {
        owner = payable (_owner);
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

    CharacterData characterData;

    function deposit() public payable onlyOwner returns (uint256) {
        require(msg.value >= 0.01 ether, "error deposit");
        characterData.balance += msg.value;
        characterData.lastPaymentAmount = msg.value;
        characterData.lastPaymentDate = block.timestamp;
        return msg.value;
    }

    address to = 0x0000000000000000000000000000000000000000;

    function increaseHealth() public payable onlyOwner returns (uint256) {
        require(characterData.balance >= 0.001 ether, "error health");
        characterData.balance -= 0.001 ether;
        (bool sent, ) = to.call{value: 0.001 ether}("");
        require(sent, "ETH burn failed");
        characterData.health++;
        return characterData.health;
    }

    function getData() public view returns(uint, uint, string memory, uint, uint) {
        return (characterData.balance, characterData.health, characterData.username, characterData.lastPaymentAmount, characterData.lastPaymentDate);
    }

}

contract CharacterManager {
    mapping(string => address) public characters;

    function createCharacter (string memory name) public returns (address) {
        address newCharacter = address(new Character(name, msg.sender));
        characters[name] = newCharacter;
        return newCharacter;
}
    function getCharacterData(string memory name) public view returns (uint, uint, string memory, uint, uint) {
        address characterAddress = characters[name];
        require(characterAddress != address(0));
        Character character = Character(characterAddress);
        (uint balance, uint health, string memory username, uint lastPaymentAmount, uint lastPaymentDate) = character.getData();
        return (
            balance,
            health,
            username,
            lastPaymentAmount,
            lastPaymentDate
        );
    }
}