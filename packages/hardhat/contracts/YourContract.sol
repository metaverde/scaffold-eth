pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract FatAssPonies is Ownable {
    
    struct Pony {
        string name;
        string breed;
        uint height;
        uint weight;
        string color;
        bool truePony;
        address stall;
        
    }
    
    event ponyCreated(string name, string breed, string color, bool truePony);
    
    
    Pony [] public deets;
    address [] public byAddy;
    mapping (address => Pony) public ponies;
    //Need to push the address to an array separate from the mapping...
    
    uint public balance;
    
   
    modifier costs(uint cost) {
        require(msg.value >= cost);
        _;
        
    }
    
    function createPony(string memory name, string memory breed, uint height, uint weight, string memory color) public payable costs(1 ether){
        address pony = msg.sender;
        balance += msg.value;
        Pony memory newPony;
        newPony.name = name;
        newPony.breed = breed;
        newPony.height = height;
        newPony.weight = weight;
        newPony.color = color;
        if(height<=56){
            newPony.truePony = true;
        }
        else {
            newPony.truePony = false;
        }
        newPony.stall = msg.sender;
        deets.push(newPony);
        byAddy.push(pony);
        ponies[pony]= newPony;
        
    
    
    
    assert(
            keccak256(
                abi.encodePacked(
                    ponies[msg.sender].name,
                    ponies[msg.sender].breed,
                    ponies[msg.sender].height
                )
            )
            ==
            keccak256(
                abi.encodePacked(
                    newPony.name,
                    newPony.breed,
                    newPony.height
                    
                )
            )
        );
       
        
        
    emit ponyCreated(newPony.name, newPony.breed, newPony.color, newPony.truePony ); 
    /*Needs to match event in arguments*/

    }
    
    function withdrawAll() public payable onlyOwner returns(uint) {
       uint toTransfer = balance;
       balance = 0;
       payable(msg.sender).transfer(toTransfer);
       return toTransfer;
    }

    
}