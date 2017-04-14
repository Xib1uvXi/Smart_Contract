pragma solidity ^0.4.4;

contract testI{
    function getA() returns(string){}
}

contract MyTest {
    address addr = 0x8d82e934aa1400f0bb09d8ece0d6be4e1441afb9
    testI i = testI(addr);
    function test() returns (string){
       string a = i.getA();
       return a;
    }
}