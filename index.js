const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

const deploy = require('./lib/contract.js');


// let filePath = './smart_contract/SimpleStorage.sol';
// let contractName = 'SimpleStorage';

// let filePath = './smart_contract/PayTest.sol';
// let contractName = 'PayTest';


let filePath = './smart_contract/addressTest.sol';
let contractName = 'addressTest';







deploy(filePath, contractName, web3, function(err, result){
    if (err) {
        console.log(err);
    }
    return console.log('发布成功');
});



