const ToDo = artifacts.require("./ToDo.sol");
const Web3 = require('web3');

const web3 = new Web3();

contract('ToDo', function (accounts) {
  it("should create item", async () => {
    const instance = await ToDo.deployed();
    return instance.create('item').then(function () {
      return instance.get.call(0);
    }).then(function (result) {
      const item = web3.utils.hexToUtf8(result);
      return assert.equal(item, 'item', "Item wasn't correct");
    });
  })
});
