pragma solidity ^0.4.4;

contract OzServer{
    uint age;
    bytes32 id = 0x0000000000000000000000000000000000000000000000000000000000000001;
    event Deposit(
        bytes32 _myid,
        address indexed _from,
        uint indexed _value
    );
    function setT(uint num) returns (uint){
        age = num;
        Deposit(getMyId(),msg.sender,num);
        return age;
    }

    function getT() returns (uint){
        return age;
    }

    function getMyId() returns (bytes32) {
        uint256 tmp = uint256(id);
        tmp++;
        id = bytes32(tmp);
        return id;
    }
}
