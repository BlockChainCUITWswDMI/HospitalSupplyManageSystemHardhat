require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.16",
  networks: {
    // 配置你的自定义网络
    customNetwork: {
      url: 'http://localhost:8545', // 节点 URL
      timeout: 1000, // 设置超时时间为 10 秒
    },
  },
};
