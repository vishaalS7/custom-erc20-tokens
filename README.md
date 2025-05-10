
# ⚡ ERC20 Token Portfolio - Vantage & Zephyra

This repository showcases two ERC20 token implementations for demonstration and portfolio purposes:

1. **VantageToken** — A manually coded ERC20 token implementation (no external libraries).
2. **ZephyraToken** — A standard ERC20 token using OpenZeppelin, with deployment and testing automation.

---

## 🛠️ Setup Instructions

### 1. Install Foundry
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### 2. Clone This Repository
```bash
git clone https://github.com/vishaalS7/custom-erc20-tokens.git
cd custom-erc20-tokens
forge install
```

---

## 📁 Project Structure

```
erc20-portfolio/
├── src/
│   ├── VantageToken.sol         # Manual ERC20 implementation
│   └── ZephyraToken.sol         # OpenZeppelin-based ERC20 token
│
├── test/
│   ├── VantageTokenTest.t.sol   # Tests for VantageToken
│   └── ZephyraTokenTest.t.sol   # Tests for ZephyraToken
│
├── script/
│   └── DeployZephyra.s.sol      # Deployment script for ZephyraToken
│
├── foundry.toml
└── README.md
```

---

## 💡 Manual ERC20 - VantageToken

### Features
- Pure Solidity implementation.
- Functions: `name`, `symbol`, `decimals`, `totalSupply`, `balanceOf`, `transfer`.
- `mint` included for testing/demo only.

### 🔬 Run Tests
```bash
forge test --match-path test/VantageTokenTest.t.sol
```

---

## ⚙️ OpenZeppelin ERC20 - ZephyraToken

### Features
- Inherits from OpenZeppelin’s ERC20 standard.
- Safe and production-ready.
- Supports script-based deployment and tests.

### 🧪 Run Tests
```bash
forge test --match-path test/ZephyraTokenTest.t.sol
```

### 🚀 Deploy Script (Foundry)
File: `script/DeployZephyra.s.sol`
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {ZephyraToken} from "../src/ZephyraToken.sol";

contract DeployZephyra is Script {
    function run() external returns (ZephyraToken) {
        vm.startBroadcast();
        ZephyraToken token = new ZephyraToken();
        vm.stopBroadcast();
        return token;
    }
}
```

### 📤 Deploy Locally or on Testnet
```bash
forge script script/DeployZephyra.s.sol --broadcast --rpc-url <your_rpc_url> --private-key <your_private_key>
```

---

## 🧪 Sample Test: VantageTokenTest

File: `test/VantageTokenTest.t.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/VantageToken.sol";

contract VantageTokenTest is Test {
    VantageToken public token;
    address alice = address(1);
    address bob = address(2);

    function setUp() public {
        token = new VantageToken();
        token.mint(alice, 50 ether);
        token.mint(bob, 20 ether);
    }

    function testNameSymbol() public {
        assertEq(token.name(), "Vantage Token");
        assertEq(token.symbol(), "VTG");
    }

    function testTransfer() public {
        vm.prank(alice);
        token.transfer(bob, 10 ether);

        assertEq(token.balanceOf(alice), 40 ether);
        assertEq(token.balanceOf(bob), 30 ether);
    }

    function test_RevertWhen_TransferMoreThanBalance() public {
        vm.prank(bob);
        vm.expectRevert();
        token.transfer(alice, 100 ether);
    }
}
```

---

## 📄 License

MIT © 2025 [@0xVishh](https://github.com/0xVishh)

---

## 🙌 Acknowledgements

- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Foundry Toolkit](https://book.getfoundry.sh/)
- [Chainlink Smart Contract Kit](https://docs.chain.link/smart-contracts)
