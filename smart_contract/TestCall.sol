pragma solidity ^0.4.0;

contract TestCall {
    function test() {
        address saddr = 0x784E69471120d19bf4Eb0C4d682cC0d154266040;
        if (!saddr.call("set","Test")) {
            throw;
        }
    }
}


// contract TestShow {
//     string name;
//     function set(string x) {
//         name = x;
//     }
//     function get() constant returns (string retVal) {
//         return name;
//     }
// }