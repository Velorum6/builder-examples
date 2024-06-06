// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout, FieldLayoutLib } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

// Hex below is the result of `WorldResourceIdLib.encode({ namespace: "velorumtest25", name: "ItemSellerERC20", typeId: RESOURCE_TABLE });`
ResourceId constant _tableId = ResourceId.wrap(0x746276656c6f72756d746573743235004974656d53656c6c6572455243323000);
ResourceId constant ItemSellerERC20TableId = _tableId;

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x0048030014201400000000000000000000000000000000000000000000000000
);

struct ItemSellerERC20Data {
  address tokenAddress;
  uint256 tokenDecimals;
  address receiver;
}

library ItemSellerERC20 {
  /**
   * @notice Get the table values' field layout.
   * @return _fieldLayout The field layout for the table.
   */
  function getFieldLayout() internal pure returns (FieldLayout) {
    return _fieldLayout;
  }

  /**
   * @notice Get the table's key schema.
   * @return _keySchema The key schema for the table.
   */
  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _keySchema = new SchemaType[](1);
    _keySchema[0] = SchemaType.UINT256;

    return SchemaLib.encode(_keySchema);
  }

  /**
   * @notice Get the table's value schema.
   * @return _valueSchema The value schema for the table.
   */
  function getValueSchema() internal pure returns (Schema) {
    SchemaType[] memory _valueSchema = new SchemaType[](3);
    _valueSchema[0] = SchemaType.ADDRESS;
    _valueSchema[1] = SchemaType.UINT256;
    _valueSchema[2] = SchemaType.ADDRESS;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "smartObjectId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](3);
    fieldNames[0] = "tokenAddress";
    fieldNames[1] = "tokenDecimals";
    fieldNames[2] = "receiver";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get tokenAddress.
   */
  function getTokenAddress(uint256 smartObjectId) internal view returns (address tokenAddress) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get tokenAddress.
   */
  function _getTokenAddress(uint256 smartObjectId) internal view returns (address tokenAddress) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set tokenAddress.
   */
  function setTokenAddress(uint256 smartObjectId, address tokenAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((tokenAddress)), _fieldLayout);
  }

  /**
   * @notice Set tokenAddress.
   */
  function _setTokenAddress(uint256 smartObjectId, address tokenAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((tokenAddress)), _fieldLayout);
  }

  /**
   * @notice Get tokenDecimals.
   */
  function getTokenDecimals(uint256 smartObjectId) internal view returns (uint256 tokenDecimals) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get tokenDecimals.
   */
  function _getTokenDecimals(uint256 smartObjectId) internal view returns (uint256 tokenDecimals) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set tokenDecimals.
   */
  function setTokenDecimals(uint256 smartObjectId, uint256 tokenDecimals) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((tokenDecimals)), _fieldLayout);
  }

  /**
   * @notice Set tokenDecimals.
   */
  function _setTokenDecimals(uint256 smartObjectId, uint256 tokenDecimals) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((tokenDecimals)), _fieldLayout);
  }

  /**
   * @notice Get receiver.
   */
  function getReceiver(uint256 smartObjectId) internal view returns (address receiver) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get receiver.
   */
  function _getReceiver(uint256 smartObjectId) internal view returns (address receiver) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set receiver.
   */
  function setReceiver(uint256 smartObjectId, address receiver) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((receiver)), _fieldLayout);
  }

  /**
   * @notice Set receiver.
   */
  function _setReceiver(uint256 smartObjectId, address receiver) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((receiver)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get(uint256 smartObjectId) internal view returns (ItemSellerERC20Data memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(uint256 smartObjectId) internal view returns (ItemSellerERC20Data memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(uint256 smartObjectId, address tokenAddress, uint256 tokenDecimals, address receiver) internal {
    bytes memory _staticData = encodeStatic(tokenAddress, tokenDecimals, receiver);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(uint256 smartObjectId, address tokenAddress, uint256 tokenDecimals, address receiver) internal {
    bytes memory _staticData = encodeStatic(tokenAddress, tokenDecimals, receiver);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(uint256 smartObjectId, ItemSellerERC20Data memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.tokenAddress, _table.tokenDecimals, _table.receiver);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(uint256 smartObjectId, ItemSellerERC20Data memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.tokenAddress, _table.tokenDecimals, _table.receiver);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  ) internal pure returns (address tokenAddress, uint256 tokenDecimals, address receiver) {
    tokenAddress = (address(Bytes.slice20(_blob, 0)));

    tokenDecimals = (uint256(Bytes.slice32(_blob, 20)));

    receiver = (address(Bytes.slice20(_blob, 52)));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   *
   *
   */
  function decode(
    bytes memory _staticData,
    PackedCounter,
    bytes memory
  ) internal pure returns (ItemSellerERC20Data memory _table) {
    (_table.tokenAddress, _table.tokenDecimals, _table.receiver) = decodeStatic(_staticData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(uint256 smartObjectId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(uint256 smartObjectId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    address tokenAddress,
    uint256 tokenDecimals,
    address receiver
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(tokenAddress, tokenDecimals, receiver);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    address tokenAddress,
    uint256 tokenDecimals,
    address receiver
  ) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData = encodeStatic(tokenAddress, tokenDecimals, receiver);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(uint256 smartObjectId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = bytes32(uint256(smartObjectId));

    return _keyTuple;
  }
}
