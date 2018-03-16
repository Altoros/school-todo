pragma solidity 0.4.19;


contract ToDo {

  mapping(address => bytes32[]) public items;

  event ItemCreated(address indexed _address, bytes32 _item);
  event ItemUpdated(address indexed _address, uint _id);
  event ItemDestroyed(address indexed _address, uint _id);

  function create(bytes32 item) public {
    items[msg.sender].push(item);
    ItemCreated(msg.sender, item);
  }

  function read() public constant returns (bytes32[] _items) {
    return items[msg.sender];
  }

  function get(uint id) public constant returns (bytes32 _item) {
    return items[msg.sender][id];
  }

  function destroy(uint id) public {
    require(items[msg.sender].length > id);
    items[msg.sender][id] = items[msg.sender][items[msg.sender].length - 1];
    items[msg.sender].length--;
    ItemDestroyed(msg.sender, id);
  }

}
