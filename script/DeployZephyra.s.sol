// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ZephyraToken} from "src/ ZephyraToken.sol";
import {Script} from "forge-std/Script.sol";

contract DeployZephyra is Script {
    uint256 public constant INITIAL_SUPPLY = 100 ether; // 100 tokens with 18 decimal places

    function run() external {
        vm.startBroadcast();
        // Deploy the ZephyraToken contract
        new ZephyraToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
    }
}
