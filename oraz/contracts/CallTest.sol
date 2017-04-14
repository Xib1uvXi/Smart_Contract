pragma solidity ^0.4.4;
contract CallTest{
    function callByFun(address addr, uint age)returns (bool){
        bytes4 methodId = bytes4(keccak256("increaseAge(uint256)"));
        return addr.call(methodId, age);
    }
}