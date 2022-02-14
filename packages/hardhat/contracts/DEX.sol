pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DEX is Ownable {

  using SafeMath for uint256;
  IERC20 token;

  constructor(address token_addr) {
    token = IERC20(token_addr);
  }

}