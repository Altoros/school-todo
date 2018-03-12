var Users = artifacts.require("./Users.sol");
var Web3 = require('web3');

var web3 = new Web3();

contract('User', function (accounts) {
  it("should create user", async function () {
    var instance = await Users.deployed();

    instance.create('login').then(function () {
      return instance.get.call(accounts[0]);
    }).then(function (result) {
      var login = web3.toAscii(result.replace(/0+$/, ''));
      assert.equal(login, 'login', "Username wasn't correct");
    });
  });
});
