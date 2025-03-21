// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract Lock {
    uint public unlockTime;
    address payable public owner;
    string private password;
    
    event Withdrawal(uint amount, uint when);
    
    constructor(uint _unlockTime, string memory _password) payable {
        require(
            // reverse condition to make it easier to understand
            block.timestamp < _unlockTime,
            "Unlock time must be in the future"
        );
        
        unlockTime = _unlockTime;
        owner = payable(msg.sender);
        password = _password;
    }
    
    function withdraw(string memory _password) public {
        require(block.timestamp >= unlockTime, "Too early");
        require(msg.sender == owner, "Not owner");
        
        emit Withdrawal(address(this).balance, block.timestamp);
        owner.transfer(address(this).balance);
    }
    
    function forceWithdraw(string memory _password) public {
        require(strcmp(_password, password), "Incorrect password");
        require(msg.sender != owner, "Not owner");
        
        emit Withdrawal(address(this).balance, block.timestamp);
        
        owner.transfer(address(this).balance);
    }
    
    function strcmp(string memory a, string memory b) public pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
