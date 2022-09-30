// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract ItemManager{
    enum SupplyChainState{Created, Paid, Delivered}

    struct S_Item {
        string _identifier;
        uint _itemPrice;
        ItemManager.SupplyChainState _state;
    }

    mapping(uint => S_Item) public items;
    uint itemIndex;

    event SupplyChainStep(uint _itemIndex, uint _step);

function createItem (string memory _identifier, uint _itemPrice) public {
  items[itemIndex]._identifier = _identifier;
  items[itemIndex]._itemPrice = _itemPrice;
  items[itemIndex]._state = SupplyChainState.Created;
  emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state));
  itemIndex++;
}

function triggerPayment(uint _itemIndex) public payable {

    require(items[_itemIndex]._itemPrice == msg.value, "only full payments accepted");
    require(items[_itemIndex]._state == SupplyChainState.Created, "item is further in the chain1");
    items[_itemIndex]._state = SupplyChainState.Paid;

     emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state));
}


function triggerDelivery(uint _itemIndex) public   {
   require(items[_itemIndex]._state == SupplyChainState.Paid, "item is further in the chain2");
    items[_itemIndex]._state = SupplyChainState.Delivered;

     emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state));
}
}