var MyTest = artifacts.require("./Itest.sol");

module.exports = function (deployer) {
    deployer.deploy(MyTest);
};
