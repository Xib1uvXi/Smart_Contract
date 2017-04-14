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
    
    modifier checkOwnerNotExist() {
        if (isOwner[msg.sender]) throw;
        _;
    }

    modifier checkOwnerExists() {
        if (!isOwner[msg.sender]) {
            // Log(msg.sender,'checkOwnerExists', '不是决策者');
            throw;
        }
        _;
    }
    
    modifier checkSender() {
        if (!isOwner[msg.sender]) {
            // Log(msg.sender,'checkSender', 'msg.sender is not owner');
            throw;
        }
        _;
    }
    
    modifier checkOwnerConfirmed() {
        if (isConfirmed[msg.sender]) {
            // Log(msg.sender,'checkOwnerConfirmed', '请不要重复签名确认');
            throw;
        }
        _;
    }
    
    
    // uint public required;
    address[2] private owners;
    mapping (address => bool) private isOwner;
    mapping (address => bool) private isConfirmed;
    
    function MuitpleSign() {
        // if (   _owners.length > MAX_OWNER_COUNT
        //     || _required > _owners.length
        //     || _required == 0
        //     || _owners.length == 0) throw;

        // for (uint i = 0; i < _owners.length; i++) {
        //     // if (isOwner[_owners[i]] || _owners[i] == 0) throw;
        //     isOwner[_owners[i]] = true;
        // }
        // owners = _owners;

        owners[0] = 0xfa3dA03Af4709506B56B26E409D1CDaCf9d16fC5
        owners[1] = 0x8d0cf83e79593D3D3153EBEAcB001D6397A91Aca

        for (uint i = 0; i < owners.length; i++) {
            // if (isOwner[_owners[i]] || _owners[i] == 0) throw;
            isOwner[owners[i]] = true;
        }

        // required = _required;
    }
    
    function getPubKey(bytes32 msgHash, uint8 v, bytes32 r, bytes32 s) returns (address pub) {
        pub = ecrecover(msgHash, v, r, s);
    }
    
    function getConfirmationCount() constant returns (uint count) {
        for (uint i = 0; i < owners.length; i++) {
            if (isConfirmed[owners[i]]) count += 1;
        }
    }
    
    
    function confirm(bytes32 msgHash, uint8 v, bytes32 r, bytes32 s) {
        Log(msg.sender,'confirm', 'log--go--there');
        address addr = ecrecover(msgHash, v, r, s);
        if (!(msg.sender == addr)) {
            Log(msg.sender,'checkOwnerSign', 'sender和公钥不符');
            Log(addr,'checkOwnerSign', 'sender和公钥不符');
        }else {
            isConfirmed[msg.sender] = true;
            Log(msg.sender,'confirm', '确认成功');
        }
    }
    
}


//0xfa3dA03Af4709506B56B26E409D1CDaCf9d16fC5
//0x8d0cf83e79593D3D3153EBEAcB001D6397A91Aca
// ['0xfa3dA03Af4709506B56B26E409D1CDaCf9d16fC5','0x8d0cf83e79593D3D3153EBEAcB001D6397A91Aca']