pragma solidity ^0.4.17;

/* A smart contract  available for integration with any database or any transactions performing web application using web3.js lib,
for detection of record tempering and non repudiation */

contract TemperingProof {

    struct DBRecord{
        bytes32 recordHash; //record hash
        address changeBy; 
        uint txid; //transaction id
    }
    
    uint latest_txid;
    address _owner;

    event DBRecordEvent(uint transactionId, uint blocknum, bytes32 indexed recordHash, address indexed from);

    mapping(uint => DBRecord) public txHistory;
    mapping(bytes32 => address) public recordHashMap;
    
    function TemperingProof()
        public{
        _owner = msg.sender; 
    }
    
    function newRecord(bytes32 _recordHash) 
        public
        returns (bool success){
            
        require(recordHashMap[_recordHash] == 0x0);
        ++latest_txid;
            
        txHistory[latest_txid]=DBRecord(_recordHash,msg.sender,latest_txid);
        recordHashMap[_recordHash]=msg.sender;

        DBRecordEvent(latest_txid, block.number, _recordHash, msg.sender);
        return true;
    }

    function recordExists(bytes32 _recordHash) 
        public
        view 
        returns (bool exists){
        if (recordHashMap[_recordHash] != address(0x0)) {
            exists = true;
        }else{
            exists= false;
        }
        return exists;
    }
    
    function getRecordDetails(uint _txid) 
        constant 
        public
        returns (bytes32 _recordHash, address from, uint transactionId){
        
        require(txHistory[_txid].recordHash != bytes32(0x0));
        
        _recordHash = txHistory[_txid].recordHash;
        from = txHistory[_txid].changeBy;
        transactionId = txHistory[_txid].txid;
    }

    function nonRepudationVerify(bytes32 recordHash, address _changeby) 
        constant 
        public
        returns (bool changeOwner){
        
        require(recordHashMap[recordHash] != address(0x0));
        if(recordHashMap[recordHash] == _changeby)
            changeOwner = true;
        else
            changeOwner = false;
        
        return changeOwner;
    }
    
    function getLatestTransactionNum() 
        view 
        public
        returns (uint latest){
        return latest_txid;
    }
    
}