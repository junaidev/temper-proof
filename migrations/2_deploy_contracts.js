var TemperingProof = artifacts.require("./TemperingProof.sol");

module.exports = function(deployer) {
  deployer.deploy(TemperingProof);//, {gas: 4612388});

};
