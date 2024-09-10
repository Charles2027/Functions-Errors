// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Volga is ERC20{

    address public owner;

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
    }
     
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // Only the contract owner can mint new tokens
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return 0; // Example: 8 decimals instead of the default 18
    }



    // Any user can burn tokens they own
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
    


  // any user can transfer token if they have enough tokens to transfer
   function customTransferr(address recipient, uint256 amount) public returns (bool) {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(_msgSender()) >= amount, "Insufficient balance");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }


  
}
