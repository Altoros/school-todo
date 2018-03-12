pragma solidity ^0.4.15;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/Users.sol";

contract TestUsers {
  uint public initialBalance = 1 ether;
  event Test2(address addr);

  function testCreatingUser() {
    Users users = Users(DeployedAddresses.Users());
    users.create("login");

    bytes32 username = users.get(this);

    Assert.equal(username, "login", "Username should be the same as registered");
  }

}
