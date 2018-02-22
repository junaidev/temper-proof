#Tampering Proof Helper

A smart contract readily available for integration with any database MySQL, SQL Server..etc for records tempering detection and non-repudiation. 

#How To Use

For any DML call newRecord(bytes32 _recordHash) function with hash of that data + time stamp, this function will be called with some account id hence smart contract records transaction with hash and sender address. This smart contract can easily be intergatable with any web application forms which are used for performing database transactions ( DML ) using web3.js pointing to any Ethereum NW where this smart contract is deployed.

#How to Verify

Use nonRepudationVerify(bytes32 recordHash, address _changeby) function in contract vis web3.js for verification of change owner in database tables.

There are various function in contract for use.
