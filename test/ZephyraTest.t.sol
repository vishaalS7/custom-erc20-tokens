// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ZephyraToken} from "src/ ZephyraToken.sol";
import {Test} from "forge-std/Test.sol";
import {DeployZephyra} from "script/DeployZephyra.s.sol";

contract ZephyraTest is Test {
    ZephyraToken public zephyraToken;
    DeployZephyra public deployer;

    address bob = makeAddr("bob");
    address stark = makeAddr("stark");
    address steve = makeAddr("steve");

    uint256 public constant STARTING_BALANCE = 100 ether; // 100 tokens with 18 decimal places

    function setUp() public {
        deployer = new DeployZephyra();
        zephyraToken = deployer.run();

        vm.prank(msg.sender);
        zephyraToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(zephyraToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testTotalSupplyUnchanged() public view {
        uint256 totalSupply = zephyraToken.totalSupply();
        assertEq(totalSupply, zephyraToken.balanceOf(address(this)) + STARTING_BALANCE);
    }

    function testTransferWorks() public {
        vm.prank(bob);
        zephyraToken.transfer(stark, 10 ether);

        assertEq(zephyraToken.balanceOf(stark), 10 ether);
        assertEq(zephyraToken.balanceOf(bob), 90 ether);
    }

    function testTransferInsufficientBalanceReverts() public {
        vm.expectRevert();
        vm.prank(stark); // stark has 0 tokens
        zephyraToken.transfer(steve, 1 ether);
    }

    function testApproveAndAllowance() public {
        vm.prank(bob);
        zephyraToken.approve(steve, 50 ether);

        uint256 allowance = zephyraToken.allowance(bob, steve);
        assertEq(allowance, 50 ether);
    }

    function testTransferFromWorks() public {
        // Bob approves steve to spend 30 tokens
        vm.prank(bob);
        zephyraToken.approve(steve, 30 ether);

        // steve transfers on behalf of Bob
        vm.prank(steve);
        zephyraToken.transferFrom(bob, stark, 30 ether);

        assertEq(zephyraToken.balanceOf(stark), 30 ether);
        assertEq(zephyraToken.balanceOf(bob), 70 ether);
        assertEq(zephyraToken.allowance(bob, steve), 0);
    }

     function testTransferFromMoreThanAllowanceReverts() public {
        vm.prank(bob);
        zephyraToken.approve(steve, 10 ether);
        // steve tries to transfer 20 tokens on behalf of Bob
        // This should revert because Bob only approved 10 tokens
        // and steve is trying to transfer 20 tokens
        // This is a revert test
        vm.expectRevert();
        vm.prank(steve);
        zephyraToken.transferFrom(bob, stark, 20 ether);
    }

    function testIncreaseAndDecreaseAllowance() public {
        // Optional if using OZ's extensions for allowance
        vm.prank(bob);
        zephyraToken.approve(steve, 10 ether);

        vm.prank(bob);
        zephyraToken.approve(steve, 20 ether); // override

        assertEq(zephyraToken.allowance(bob, steve), 20 ether);
    }

}
