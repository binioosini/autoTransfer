// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenTransferContract {
    address public owner;
    address public tokenAddress;
    bool public approved;
    uint256 public transferAmount;


    constructor(address _tokenAddress) {
        owner = msg.sender;
        tokenAddress = _tokenAddress;
        approved = false;
    }

    function getERC20Balance() external view returns (uint256) {
        return IERC20(tokenAddress).balanceOf(address(this));
    }

    function getBNBBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function approveTokenTransfer() external {
        uint256 fullAmount = IERC20(tokenAddress).balanceOf(address(this));
        IERC20(tokenAddress).approve(owner, fullAmount);
        approved = true;
    }

    function transferTokens() external payable {
        require(approved, "Token not approved yet");
        require(msg.value >= transferAmount, "Insufficient BNB balance");

        IERC20(tokenAddress).transfer(owner, transferAmount);
        payable(owner).transfer(msg.value);
    }

    function setTransferAmount(uint256 _amount) external {
        transferAmount = _amount;
    }
}

//contract : 0xbeD055AB65364C04a810Af5c03c0cF34E5E09805
