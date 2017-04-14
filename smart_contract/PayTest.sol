pragma solidity ^0.4.0;
contract PayTest {
    function getBalance() constant returns (uint) {
        return this.balance;//0
    }  
    function deposit() payable returns(address addr, uint amount, bool success){
        return (msg.sender, msg.value, this.send(msg.value));
    }
}