pragma solidity ^0.4.0;
contract TestWallet {
    uint public account;
    function chongzhi() payable {
        account += msg.value;
    }
    function zhuanzhang(address a, uint v) {
        if (account < v) {
            throw;
        }
        if (!a.send(v)) {
            throw;
        }
    }
}