pragma solidity ^0.4.4;

contract MuitpleSign{
    uint constant public MAX_OWNER_COUNT = 3;
    
    /**
     * event 
     */
    event Log(address addr, string funcName, string info);
     
    modifier checkRequirement(uint ownerCount, uint _required) {
        if (   ownerCount > MAX_OWNER_COUNT
            || _required > ownerCount
            || _required == 0
            || ownerCount == 0)
            throw;
        _;
    }
    
    modifier checkOwnerNotExist(address owner) {
        if (isOwner[owner]) throw;
        _;
    }

    modifier checkOwnerExists(address owner) {
        if (!isOwner[owner]) {
            Log(owner,'checkOwnerExists', '不是决策者');
            throw;
        }
        _;
    }
    
    modifier checkSender() {
        if (!isOwner[msg.sender]) {
            Log(msg.sender,'checkSender', 'msg.sender is not owner');
            throw;
        }
        _;
    }
    
    modifier checkOwnerConfirmed() {
        if (isConfirmed[msg.sender]) {
            Log(msg.sender,'checkOwnerConfirmed', '请不要重复签名确认');
            throw;
        }
        _;
    }
    
    modifier checkOwnerSign(bytes32 _msgHash, uint8 _v, bytes32 _r, bytes32 _s) {
        if (!(msg.sender == ecrecover(_msgHash, _v, _r, _s))) {
            Log(msg.sender,'checkOwnerSign', 'sender和公钥不符');
            Log(ecrecover(_msgHash, _v, _r, _s),'checkOwnerSign', 'sender和公钥不符');
            throw;
        }
        _enable = true;
        _;
    }
    
    modifier checkPermission() {
        if (!(required <= getConfirmationCount())) {
            Log(msg.sender, 'checkPermission', '决策签名不足');
            throw;
        }
        _;
    }
    
    bool private _enable;
    uint public required;
    address[] private owners;
    mapping (address => bool) public isOwner;
    mapping (address => bool) public isConfirmed;
    
    function MuitpleSign(address[] _owners, uint _required) 
        checkRequirement(_owners.length, _required) 
    {
        for (uint i = 0; i < _owners.length; i++) {
            if (isOwner[_owners[i]] || _owners[i] == 0) throw;
            isOwner[_owners[i]] = true;
        }
        owners = _owners;
        required = _required;
    }
    
    function getPubKey(bytes32 msgHash, uint8 v, bytes32 r, bytes32 s) returns (address pub) {
        pub = ecrecover(msgHash, v, r, s);
    }
    
    function getConfirmationCount() constant returns (uint count) {
        for (uint i = 0; i < owners.length; i++) {
            if (isConfirmed[owners[i]]) count += 1;
        }
    }
    
    
    function confirm(bytes32 msgHash, uint8 v, bytes32 r, bytes32 s) 
        checkSender
        checkOwnerConfirmed
        checkOwnerExists(msg.sender)
        checkOwnerSign(msgHash, v, r, s)
    {
        isConfirmed[msg.sender] = true;
        Log(msg.sender,'confirm', '确认成功');
    }
    
    function enable() constant checkPermission returns (bool) {
        return _enable;
    } 
    
}
