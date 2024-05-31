// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";

import { IVendingMachine } from "../src/codegen/world/IVendingMachine.sol";
import { RatioConfig } from "../src/codegen/tables/RatioConfig.sol";
import { IWorld } from "../src/codegen/world/IWorld.sol";

contract ExecuteVendingMachine is Script {
  address private cliente;

  constructor() {
    cliente = msg.sender;
  }
  
  function run(address worldAddress) external {
    console.log(cliente);
    console.log("msg sender", msg.sender);
    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");

    uint256 ephemeralPrivateKey = uint256(0x0cc9437d02863de5ff33a0c8ca98f406423fbf83730f96f5002ec4ab9a23e94e);
  
    address ephemeralOwner = address(0x1692715F39E6d406B17AAA2EF6C8e676e1B6aCaA);
    vm.startBroadcast(ephemeralPrivateKey);

    //Read from .env
    uint256 smartStorageUnitId = vm.envUint("SSU_ID");
    uint256 itemIn = vm.envUint("ITEM_IN_ID");

    //The method below will change based on the namespace you have configurd. If the namespace is changed, make sure to update the method name
    IVendingMachine(worldAddress).velorumtest11__executeVendingMachine(smartStorageUnitId, 1, itemIn);

    vm.stopBroadcast();
  }
}
