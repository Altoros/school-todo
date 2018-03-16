pragma solidity 0.4.19;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/ToDo.sol";

contract TestToDo {

  function testCreatingUser() public {
    ToDo todo = ToDo(DeployedAddresses.ToDo());
    todo.create("item");

    bytes32 item = todo.get(0);

    Assert.equal(item, "item", "Item should be the same as created");
  }

}
