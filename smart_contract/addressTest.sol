pragma solidity ^0.4.0;
contract addressTest{
    function getBalance(address addr) constant returns (uint){
        return addr.balance;
    }
}