const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
const Person = require('./oraz/build/contracts/OzServer.json');

// let abi = [{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"getBalance","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"}]
// var MyContract = web3.eth.contract(abi);
// var myContractInstance = MyContract.at('0xfe4dcbe850945fd5ddf5f31fd44fa2b96e926c77');
// let result = myContractInstance.getBalance('0xfa3dA03Af4709506B56B26E409D1CDaCf9d16fC5');
// console.log(result);


let abi = Person.abi;
var MyContract = web3.eth.contract(abi);
var myContractInstance = MyContract.at('0x6c7c3a7c95142d2f7fce0d3bcfa0b658b97b59fb');
var event = myContractInstance.Deposit(function(error, result){
    if (!error) {
      db(result);
    }
        
});


function db(result) {
  
  console.log(result.args)
}