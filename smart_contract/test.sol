pragma solidity ^0.4.4;

contract MuitpleSign{
    uint constant public MAX_OWNER_COUNT = 3;
    
    /**
     * event 
     */
    event Log(address addr, string funcName, uint info);
     
    
    
    
    address[] private owners;
    
    function MuitpleSign() {
        
    }
    
    function setOwners(address[] _owners){
        Log(msg.sender, "1", _owners.length);
        for(var i = 0; i < _owners.length; i++){
            Log(_owners[i], "1", 0);
            owners.push(_owners[i]);
        }
    }

    function get1() constant returns(address) {
        return owners[0];
    }

    function get2() constant returns(address) {
        return owners[1];
    }
    
}