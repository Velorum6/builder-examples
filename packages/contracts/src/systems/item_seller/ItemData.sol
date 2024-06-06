// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;
  
  struct ItemData {
    uint256 id;
    uint256 inventoryItemId; // id of item
    uint256 price; // price of item (wei)
    uint256 targetQuantity; // quantity where the price would be the lowest
  }