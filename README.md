# Solidity Contract: Liquidity Pool with Custom Token

## Overview

The `SimpleLiquidityPool` contract allows users to add and withdraw liquidity using a custom ERC20 token. The contract includes built-in safety checks using `require`, `revert`, and `assert` for secure transactions.

---

## Key Elements: `require`, `revert`, and `assert`

### `require`

Used to validate inputs and conditions. If the condition fails, the transaction is reverted, and the provided error message is returned.

**Example:**

```solidity
require(_amount > 0, "Liquidity must be greater than 0");
require(token.transferFrom(msg.sender, address(this), _amount), "Token transfer failed");
```
### `revert`
Reverts the transaction and provides an error message when a condition is violated manually.

**Example:**
```solidity
if(_amount > totalLiquidity) {
    revert("Not enough liquidity in the pool");
}
```

### `assert`
Used for internal checks where a condition must always be true. It helps identify bugs. If the condition fails, it indicates a critical issue in the contract.

**Example**
```solidity
assert(totalLiquidity >= 0);
```


## Getting Started
- Prerequisites
- To deploy and interact with the contract, you’ll need the following:
  1.Solidity compiler: Version 0.8.0 or later.
  2.Remix Ide

## Installation
- Clone or download this repository.
- paste contracts in remix ide
- compile & deploy the code and test the code.

## Usage
- This contract implements a basic liquidity pool, allowing users to add liquidity using a custom ERC20 token and withdraw it later. The contract owner can perform emergency withdrawals.

1. Add Liquidity:

  Users call the addLiquidity function, passing the amount of tokens to be added.
  The contract validates the amount using the require() statement and transfers tokens to the contract.
  
2. Withdraw Liquidity:

  Users call the withdrawLiquidity function with the amount they wish to withdraw.
  The contract checks if the user has sufficient liquidity and transfers tokens back using require().
  
3. Emergency Withdraw (Owner Only):

  The owner can use the emergencyWithdraw function, which checks if there’s enough liquidity in the pool.
  If not, it reverts the transaction using revert().
  The function also ensures the pool’s total liquidity does not go below zero using assert().

