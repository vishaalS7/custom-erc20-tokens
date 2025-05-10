// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {VantageToken} from "src/VantageToken.sol";
import {Test} from "forge-std/Test.sol";
// import {DeployVantageToken} from "script/DeployVantageTk.s.sol";

contract VantageTokenTest is Test {
    VantageToken public token;
    address alice = address(1);
    address bob = address(2);

    function setUp() public {
        token = new VantageToken();
        token.mint(alice, 50 ether);
        token.mint(bob, 20 ether);
    }

    function testNameAndSymbol() public view {
        assertEq(token.name(), "Vantage Token");
        assertEq(token.symbol(), "VTG");
    }

    function testInitialBalances() public view {
        assertEq(token.balanceOf(alice), 50 ether);
        assertEq(token.balanceOf(bob), 20 ether);
    }

    function testTransferTokens() public {
        vm.prank(alice);
        token.transfer(bob, 10 ether);

        assertEq(token.balanceOf(alice), 40 ether);
        assertEq(token.balanceOf(bob), 30 ether);
    }

    function testRevertWhen_TransferMoreThanBalance() public {
        // Bob tries to send more tokens than he has — should revert
        vm.prank(bob);
        vm.expectRevert();
        token.transfer(alice, 100 ether);
    }
}
