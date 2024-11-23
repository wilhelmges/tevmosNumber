// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GuessTheNumber {
    uint256 private randomNumber;
    address public owner;

    event NumberGenerated(uint256 randomNumber);
    event UserGuessed(address user, uint256 guessedNumber, bool success);

    constructor() {
        owner = msg.sender;
        generateRandomNumber();
    }

    // Функція для генерації випадкового числа (0-99)
    function generateRandomNumber() public onlyOwner {
        randomNumber = uint256(
            keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))
        ) % 100; // Задає діапазон від 0 до 99
        emit NumberGenerated(randomNumber);
    }

    // Функція для перевірки числа користувача
    function guessNumber(uint256 guessedNumber) public returns (bool) {
        require(guessedNumber < 100, "Number must be between 0 and 99");

        bool isCorrect = (guessedNumber == randomNumber);
        emit UserGuessed(msg.sender, guessedNumber, isCorrect);

        return isCorrect;
    }

    // Модифікатор доступу лише для власника
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}


