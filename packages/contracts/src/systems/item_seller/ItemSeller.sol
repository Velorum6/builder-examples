// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { console } from "forge-std/console.sol";
import { ResourceId } from "@latticexyz/world/src/WorldResourceId.sol";
import { ResourceIds } from "@latticexyz/store/src/codegen/tables/ResourceIds.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";

import { IERC20 } from "@latticexyz/world-modules/src/modules/erc20-puppet/IERC20.sol";
import { IERC721 } from "@eveworld/world/src/modules/eve-erc721-puppet/IERC721.sol";

import { DeployableTokenTable } from "@eveworld/world/src/codegen/tables/DeployableTokenTable.sol";
import { InventoryLib } from "@eveworld/world/src/modules/inventory/InventoryLib.sol";
import { InventoryItem } from "@eveworld/world/src/modules/inventory/types.sol";
import { IInventoryErrors } from "@eveworld/world/src/modules/inventory/IInventoryErrors.sol";
import { InventoryItemTable } from "@eveworld/world/src/codegen/tables/InventoryItemTable.sol";
import { EphemeralInvTable } from "@eveworld/world/src/codegen/tables/EphemeralInvTable.sol";
import { EntityRecordTable, EntityRecordTableData } from "@eveworld/world/src/codegen/tables/EntityRecordTable.sol";
import { Utils as EntityRecordUtils } from "@eveworld/world/src/modules/entity-record/Utils.sol";
import { Utils as SmartDeployableUtils } from "@eveworld/world/src/modules/smart-deployable/Utils.sol";
import { FRONTIER_WORLD_DEPLOYMENT_NAMESPACE as DEPLOYMENT_NAMESPACE } from "@eveworld/common-constants/src/constants.sol";

import { ItemSellerERC20, ItemSellerERC20Data } from "../../codegen/tables/ItemSellerERC20.sol";
import { ItemPrice, ItemPriceData } from "../../codegen/tables/ItemPrice.sol";
import { Utils as ItemSellerUtils } from "./Utils.sol";
import { Utils as InventoryUtils } from "@eveworld/world/src/modules/inventory/Utils.sol";

import { IWorld } from "../../codegen/world/IWorld.sol" ;
/**
 * @dev This contract is an example for extending Inventory functionality from game.
 * This contract implements an ItemSeller that swaps ERC-20 tokens for Inventory items
 */
contract ItemSeller is System {
  using InventoryLib for InventoryLib.World;
  using EntityRecordUtils for bytes14;
  using InventoryUtils for bytes14;
  using ItemSellerUtils for bytes14;
  using SmartDeployableUtils for bytes14;

  struct Item {
    uint256 itemId; // id of item
    uint256 price; // price of item (wei)
    uint256 targetQuantity; // quantity where the price would be the lowest
  }

  Item[] public Items;

  /**
   * @dev Only owner modifer
   */
  modifier onlyOwner(uint256 smartObjectId) {
    address ssuOwner = IERC721(DeployableTokenTable.getErc721Address(_namespace().deployableTokenTableId())).ownerOf(
      smartObjectId
    );
    require(tx.origin== ssuOwner, "Only owner can call this function");
    _;
  }

  function world() internal view returns (IWorld){
    return IWorld(_world());
  }

  function _initialMsgSender() internal view returns (address) {
    return world().initialMsgSender();
  }
  /**
   * @dev Register an ERC-20 token to be used for swapping with Inventory items
   * @param smartObjectId The smart object id of the SSU
   * @param tokenAddress The address of the ERC-20 token
   * @param receiver The address of the receiver of the token
   */
  function registerERC20Token(
    uint256 smartObjectId,
    address tokenAddress,
    address receiver
  ) public onlyOwner(smartObjectId) {
    require(tokenAddress != address(0) && receiver != address(0), "Invalid address");

    uint256 tokenDecimals = IERC20(tokenAddress).decimals();

    ItemSellerERC20.set(smartObjectId, tokenAddress, tokenDecimals, receiver);
  }

  /**
   * @dev Update the receiver address for the ERC-20 token
   * @param smartObjectId The smart object id of the SSU
   * @param receiver The address of the receiver of the token
   */
  function updateERC20Receiver(uint256 smartObjectId, address receiver) public onlyOwner(smartObjectId) {
    require(receiver != address(0), "Invalid address");

    ItemSellerERC20Data memory ssuData = ItemSellerERC20.get(smartObjectId);
    require(ssuData.tokenAddress != address(0), "Invalid SSU ID");

    ItemSellerERC20.setReceiver(smartObjectId, receiver);
  }

  /**
   * @dev Set the price of an item in ERC-20 tokens
   * @param smartObjectId The smart object id of the SSU
   * @param inventoryItemId The item id of the item
   * @param price The price of the item in ERC-20 tokens
   */
  function setItemPrice(uint256 smartObjectId, uint256 inventoryItemId, uint256 price, uint256 targetQuantity) public onlyOwner(smartObjectId) {
    require(price > 0, "Price cannot be 0");

    Items.push(Item(inventoryItemId, price, targetQuantity));

    // ItemSellerERC20Data memory ssuData = ItemSellerERC20.get(smartObjectId);
    // require(ssuData.tokenAddress != address(0), "Invalid Smart Object ID");

    // ItemPrice.set(smartObjectId, inventoryItemId, true, price);


  }

  /**
   * @dev Unset the price of an item in ERC-20 tokens
   * @param smartObjectId The smart object id of the SSU
   * @param inventoryItemId The item id of the item
   */
  function unsetItemPrice(uint256 smartObjectId, uint256 inventoryItemId) public onlyOwner(smartObjectId) {
    ItemPrice.set(smartObjectId, inventoryItemId, false, 0);
  }

  /**
   * @dev Purchase an item with ERC-20 tokens
   * @param smartObjectId The smart object id of the SSU
   * @param inventoryItemId The item id of the item
   * @param quantity The quantity of the item to purchase
   */

function purchaseItem(uint256 smartObjectId, uint256 inventoryItemId, uint256 quantity) public {
    ItemSellerERC20Data memory ssuData = ItemSellerERC20.get(smartObjectId);
    require(ssuData.tokenAddress != address(0), "Invalid ERC20 Data");

    uint256 totalAmount = Items[inventoryItemId].price * quantity;

    // @ invQuantityAtTheMoment Quantity inside the SSU of said Item when executing this function (HOW DO I GET THIS?) DONE
    // @ targetQuantity Max quantity set by the owner for said Item (HOW DO I SET & GET THIS?)
    // @ spreadPercentage Percentage of how full is the inventory for said item
    // @ spreadPrice Price set by the owner, intended to be the finalPrice when spreadPercentage is at 50%
    // @ finalPrice Final price of the item!
    //
    // spreadPercentage = invQuantityAtTheMoment / targetQuantity 
    // finalPrice = (spreadPrice * 2) * (1 - spreadPercentage) 

    // 0.9 = 900 / 1000
    // 20 = (100 * 2) * (1 - 0.9)

    // User pays/receives 20 EVE for the item

    console.logAddress(address(this));
    // Transfer tokens from user to this contract
    IERC20(ssuData.tokenAddress).transferFrom(_initialMsgSender(), address(this), totalAmount);

    EntityRecordTableData memory itemOutEntity = EntityRecordTable.get(
        _namespace().entityRecordTableId(),
        inventoryItemId
    );

    if (!itemOutEntity.recordExists) {
        revert IInventoryErrors.Inventory_InvalidItem("ItemSeller: item is not created on-chain", itemOutEntity.itemId);
    }

    InventoryItem[] memory outItems = new InventoryItem[](1);
    outItems[0] = InventoryItem(
        inventoryItemId,
        _initialMsgSender(),
        itemOutEntity.itemId,
        itemOutEntity.typeId,
        itemOutEntity.volume,
        quantity
    );

  /*
    struct InventoryItem {
      uint256 inventoryItemId;
      address owner;
      uint256 itemId;
      uint256 typeId;
      uint256 volume;
      uint256 quantity;
    }
  */


    _inventoryLib().inventoryToEphemeralTransfer(smartObjectId, outItems);
}


  /**
   * @dev sell an item for ERC-20 tokens
   * @param smartObjectId The smart object id of the SSU
   * @param inventoryItemId The item id of the item
   * @param quantity The quantity of the item to sell
   */

  function sellItem(uint256 smartObjectId, uint256 inventoryItemId, uint256 quantity) public {

    ItemSellerERC20Data memory ssuData = ItemSellerERC20.get(smartObjectId);
    require(ssuData.tokenAddress != address(0), "Invalid ERC20 Data");


    uint256 totalAmount = Items[inventoryItemId].price * quantity;


    IERC20(ssuData.tokenAddress).transfer(_initialMsgSender(), totalAmount);
        
        EntityRecordTableData memory itemInEntity = EntityRecordTable.get(
        _namespace().entityRecordTableId(),
        inventoryItemId
    );

    if (!itemInEntity.recordExists) {
        revert IInventoryErrors.Inventory_InvalidItem("ItemSeller: item is not created on-chain", itemInEntity.itemId);
    }

    InventoryItem[] memory inItems = new InventoryItem[](1);
    inItems[0] = InventoryItem(
        inventoryItemId,
        tx.origin,
        itemInEntity.itemId,
        itemInEntity.typeId,
        itemInEntity.volume,
        quantity
    );

    _inventoryLib().ephemeralToInventoryTransfer(smartObjectId, inItems);
  }
  /**
   * @dev Collect the ERC-20 tokens from the contract
   * @param smartObjectId The smart object id of the SSU
   */
  function collectTokens(uint256 smartObjectId) public onlyOwner(smartObjectId) {
    ItemSellerERC20Data memory ssuData = ItemSellerERC20.get(smartObjectId);
    address tokenAddress = ssuData.tokenAddress;

    IERC20(tokenAddress).transfer(ssuData.receiver, IERC20(tokenAddress).balanceOf(address(this)));
  }

  /**
   * @dev Get the price of an item in ERC-20 tokens
   * @param smartObjectId The smart object id of the SSU
   * @param inventoryItemId The item id of the item
   */
  function getItemPriceData(uint256 smartObjectId, uint256 inventoryItemId) public returns (ItemPriceData memory) {
    return ItemPrice.get(smartObjectId, inventoryItemId);
  }

  /**
   * @dev Get the ERC-20 token data
   * @param smartObjectId The smart object id SSU
   */
  function getERC20Data(uint256 smartObjectId) public returns (ItemSellerERC20Data memory) {
    return ItemSellerERC20.get(smartObjectId);
  }

  function getContractAddress() public returns (address) {
    return address(this);
  }

  function getQuantity(uint256 smartObjectId, uint256 inventoryItemId) public returns (uint) {
    return InventoryItemTable.getQuantity(
      _namespace().inventoryItemTableId(),
       smartObjectId,
       inventoryItemId);
  }

  function _inventoryLib() internal view returns (InventoryLib.World memory) {
    if (!ResourceIds.getExists(WorldResourceIdLib.encodeNamespace(DEPLOYMENT_NAMESPACE))) {
      return InventoryLib.World({ iface: IBaseWorld(_world()), namespace: DEPLOYMENT_NAMESPACE });
    } else return InventoryLib.World({ iface: IBaseWorld(_world()), namespace: DEPLOYMENT_NAMESPACE });
  }

  function _namespace() internal pure returns (bytes14 namespace) {
    return DEPLOYMENT_NAMESPACE;
  }
}
