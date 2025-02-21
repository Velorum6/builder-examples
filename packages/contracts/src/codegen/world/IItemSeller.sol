// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { ItemData } from "./../../systems/item_seller/ItemData.sol";
import { Liquidity } from "./../../systems/item_seller/Liquidity.sol";
import { ItemSellerERC20Data } from "./../tables/ItemSellerERC20.sol";

/**
 * @title IItemSeller
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IItemSeller {
  function velorumtest42__getAllItems() external view returns (ItemData[] memory);

  function velorumtest42__invest(uint256 smartObjectId, uint256 amount) external;

  function velorumtest42__giveBackInvestment(uint256 smartObjectId) external;

  function velorumtest42__collectRewards(uint256 smartObjectId) external;

  function velorumtest42__getAllInvestments() external view returns (Liquidity[] memory);

  function velorumtest42__getItemPriceData(
    uint256 smartObjectId,
    uint256 inventoryItemId
  ) external view returns (uint256, uint256, uint256);

  function velorumtest42__registerERC20Token(uint256 smartObjectId, address tokenAddress, address receiver) external;

  function velorumtest42__updateERC20Receiver(uint256 smartObjectId, address receiver) external;

  function velorumtest42__setItemPrice(
    uint256 smartObjectId,
    uint256 inventoryItemId,
    uint256 price,
    uint256 targetQuantity
  ) external;

  function velorumtest42__unsetItemPrice(uint256 smartObjectId, uint256 inventoryItemId) external;

  function velorumtest42__purchaseItem(uint256 smartObjectId, uint256 inventoryItemId, uint256 quantity) external;

  function velorumtest42__sellItem(uint256 smartObjectId, uint256 inventoryItemId, uint256 quantity) external;

  function velorumtest42__collectTokens(uint256 smartObjectId) external;

  function velorumtest42__getERC20Data(uint256 smartObjectId) external returns (ItemSellerERC20Data memory);

  function velorumtest42__getContractAddress() external returns (address);

  function velorumtest42__getQuantity(uint256 smartObjectId, uint256 inventoryItemId) external returns (uint);
}
