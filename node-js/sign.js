const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

const account1 = '0xfa3da03af4709506b56b26e409d1cdacf9d16fc5';
const account2 = '0x8d0cf83e79593D3D3153EBEAcB001D6397A91Aca';

const message = 'abc';


function messageHash(msg) {
    return web3.sha3('\x19Ethereum Signed Message:\n' + msg.length + msg);
}

function signHandler(err, signature) {
    if (!err) {       
        console.log('Signature:', signature);
        signature = signature.substr(2);
        r = '0x' + signature.substr(0, 64);
        s = '0x' + signature.substr(64, 64);
        v = '0x' + signature.substr(128, 2)
        v = web3.toDecimal(v);
        // if (v != 27 && v != 28) v += 27;
        
        console.log('        r:', r)
        console.log('        s:', s)
        console.log('        v:', v)
        console.log();
        console.log('        messageHash:',messageHash(message));
        // process.exit();

    } else {
        console.error('Coult not sign message:', err);
    }
}


let messageHex = '0x' + Buffer.from(message).toString('hex');

web3.eth.sign(account1, messageHex, signHandler);
web3.eth.sign(account2, messageHex, signHandler);


//["0xfa3dA03Af4709506B56B26E409D1CDaCf9d16fC5","0x8d0cf83e79593D3D3153EBEAcB001D6397A91Aca"]