var OzServer = artifacts.require("./OzServer.sol");
// var CallTest = artifacts.require("./CallTest.sol");

module.exports = function(deployer) {
  deployer.deploy(OzServer);
  // deployer.deploy(CallTest);
};
