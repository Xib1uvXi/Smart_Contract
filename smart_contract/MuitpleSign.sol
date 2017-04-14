pragma solidity ^0.4.4;

contract MuitpleSign{
    uint constant public MAX_OWNER_COUNT = 3;
    
    /**
     * event 
     */
     
    modifier validRequirement(uint ownerCount, uint _required) {
        if (   ownerCount > MAX_OWNER_COUNT
            || _required > ownerCount
            || _required == 0
            || ownerCount == 0)
            throw;
        _;
    }  
    
    uint public required;
    address[] public owers;
    mapping (address => bool) public isOwner;
    mapping (address => bool) public isConfirmed;
    
    function MuitpleSign(address[] _owners, uint _required) 
        validRequirement(_owners.length, _required) 
    {
        for (uint i = 0; i < _owners.length; i++) {
            if (isOwner[_owners[i]] || _owners[i] == 0) throw;
            isOwner[_owners[i]] = true;
        }        
    }
    
    
}