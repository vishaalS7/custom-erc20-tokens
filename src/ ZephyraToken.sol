// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

/// @title Zephyra Token - ERC20 Token based on OpenZeppelin implementation
/// @author @0xVishh
/// @notice A standard ERC20 token fully inherited from OpenZeppelin’s secure implementation
/// @dev Inherits OpenZeppelin's ERC20, ensuring audited functionality and best practices

import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ZephyraToken is ERC20 {
    constructor(uint256 _initialSupply) ERC20("Zephyra Token", "ZPH") {
        _mint(msg.sender, _initialSupply);
    }
}
