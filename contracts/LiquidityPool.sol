// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleLiquidityPool {
    address public owner;
    uint256 public totalLiquidity;
    IERC20 public token; 

    mapping(address => uint256) public liquidityProviders;

    constructor(address _tokenAddress) {
        owner = msg.sender;
        token = IERC20(_tokenAddress);
    }

    function addLiquidity(uint256 _amount) external {
    
        require(_amount > 0, "Liquidity must be greater than 0"); 
        require(token.transferFrom(msg.sender, address(this), _amount), "Token transfer failed");

        liquidityProviders[msg.sender] += _amount;
        totalLiquidity += _amount;
    }


    function withdrawLiquidity(uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        require(_amount <= liquidityProviders[msg.sender], "Insufficient liquidity");

        liquidityProviders[msg.sender] -= _amount;
        totalLiquidity -= _amount;
        assert(totalLiquidity >= 0); 

        require(token.transfer(msg.sender, _amount), "Token transfer failed");
    }

    function emergencyWithdraw() external {   
        if (msg.sender != owner) {
            revert("Only the owner can call this function"); 
        }  

        uint256 amount = token.balanceOf(address(this));
        totalLiquidity = 0;

        require(token.transfer(owner, amount), "Token transfer failed");
    }
}
