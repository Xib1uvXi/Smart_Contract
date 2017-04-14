module.exports = {
  networks: {
    testrpc: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    geth: {
      host: "localhost",
      port: 8545,
      from: "0xfa3da03af4709506b56b26e409d1cdacf9d16fc5",
      network_id: "82403" // Match any network id
    }
  }
};
