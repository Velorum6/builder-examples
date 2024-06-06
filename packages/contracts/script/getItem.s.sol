// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { IItemSeller } from "../src/codegen/world/IItemSeller.sol";
import { IWorld } from "../src/codegen/world/IWorld.sol";
import { RatioConfig } from "../src/codegen/tables/RatioConfig.sol";

import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";
import { PuppetModule } from "@latticexyz/world-modules/src/modules/puppet/PuppetModule.sol";
import { IERC20Mintable } from "@latticexyz/world-modules/src/modules/erc20-puppet/IERC20Mintable.sol";
import { ERC20Module } from "@latticexyz/world-modules/src/modules/erc20-puppet/ERC20Module.sol";

import { ItemData } from "../src/systems/item_seller/ItemData.sol";
contract getItem is Script {
  function run(address worldAddress) external {
    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 playerPrivateKey = vm.envUint("PLAYER_PRIVATE_KEY");
    vm.startBroadcast(playerPrivateKey);

    address owner = vm.addr(playerPrivateKey);

    console.log(owner);

    //Read from .env
    uint256 smartStorageUnitId = vm.envUint("SSU_ID");
    uint256 inventoryItemId = vm.envUint("INVENTORY_ITEM_ID");
    vm.stopBroadcast();
  }

  function itemSellerSystemId() internal pure returns (uint256) {
    return 0;
  }
}
