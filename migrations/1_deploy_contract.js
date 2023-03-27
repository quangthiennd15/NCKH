const manage = artifacts.require("ManageMedicalRecords");

module.exports = function (deployer) {
  deployer.deploy(manage);
};
