const fs = require("fs");
const solc = require('solc')


function deploy(filePath, contractName, web3, cb) {
    let source = fs.readFileSync(filePath, 'utf8');
    let compiledContract = solc.compile(source, 1);
    let abi = compiledContract.contracts[':' + contractName].interface;
    // console.log('--------abi-------- ' + abi);
    let bytecode = '0x' + compiledContract.contracts[':' + contractName].bytecode;
    let gasEstimate = web3.eth.estimateGas({ data: bytecode });
    // console.log('--------gasEstimate--------' + gasEstimate);
    let MyContract = web3.eth.contract(JSON.parse(abi));
    web3.personal.unlockAccount('0xfa3dA03Af4709506B56B26E409D1CDaCf9d16fC5', '123', 36000,
        function (err, result) {
            if (err) {
                return cb(err, null);
            }
            if (result) {
                let myContractReturned = MyContract.new({
                    from: '0xfa3dA03Af4709506B56B26E409D1CDaCf9d16fC5',
                    data: bytecode,
                    gas: gasEstimate
                }, function (err, myContract) {
                    if (!err) {
                        if (!myContract.address) {

                        } else {
                            console.log('--------abi-------- ' + abi);
                            console.log('--------gasEstimate--------' + gasEstimate);
                            console.log('--------myContract.address--------' + myContract.address);
                            return cb(null, { address: myContract.address, abi: abi}); // the contract address
                        }
                    }
                });
            } else {
                return cb('result is false', null);
            }
        });
}

module.exports = deploy;