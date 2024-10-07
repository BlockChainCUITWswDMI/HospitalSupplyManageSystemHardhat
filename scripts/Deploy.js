const { ethers } = require("hardhat");

async function main() {
    try { 
      // 获取智能合约工厂
      const OrderContract = await ethers.getContractFactory("OrderContract");
      // 部署合约到测试链
      console.log("开始部署合约到测试链...");
      const orderContract = await OrderContract.deploy({ gasLimit: 3000000 });
      await orderContract.waitForDeployment();
  
      console.log("合约地址:", orderContract.target);
    } catch (error) {
      console.error("部署过程中发生错误:", error);
      process.exit(1);
    }
  }
  
  // 执行部署函数  remixd -s  ./  --remix-ide https://remix.ethereum.org/
main();