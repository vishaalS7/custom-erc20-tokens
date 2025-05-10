// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

/// @title Vantage Token - A manually implemented ERC20 Token
/// @author @0xVishh
/// @notice This contract implements the ERC20 token standard manually for portfolio demonstration.
/// @dev Compliant with EIP-20 standard, implemented without using OpenZeppelin.

contract VantageToken {
    mapping(address => uint256) private s_balances;

    function name() public pure returns (string memory) {
        return "Vantage Token";
    }

    function symbol() public pure returns (string memory) {
        return "VTG";
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether; // 100 tokens 100 * 10^18
    }

    function decimals() public pure returns (uint8) {
        return 18; // 18 decimal places
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _value) public {
        uint256 previousBalance = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _value;
        s_balances[_to] += _value;
        require(balanceOf(msg.sender) + balanceOf(_to) == previousBalance, "Transfer failed");
    }

    /// @notice Mints `_amount` tokens to `_to` (only for testing/demo)
    function mint(address _to, uint256 _amount) public {
        s_balances[_to] += _amount;
    }
}
