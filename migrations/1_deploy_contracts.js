const student = artifacts.require("./Student.sol");

module.exports = function (deployer) {
  deployer.deploy(student);
};
