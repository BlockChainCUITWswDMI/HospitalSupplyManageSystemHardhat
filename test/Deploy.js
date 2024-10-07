const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("OrderContract", function () {
  let contract;

  // "before each" 钩子：在每个测试案例执行前创建一个新的合约实例
  beforeEach(async function () {
    // 部署合约
    const OrderContract = await ethers.getContractFactory("OrderContract");
    contract = await OrderContract.deploy();

    // 确保 contract.deployTransaction 不是 undefined
    if (contract.deployTransaction) {
      await contract.deployTransaction.wait(); // 等待合约部署完成
    }
  });

  it("Should create an order and emit OrderCreated event with orderId", async function () {
    // 准备创建订单所需的参数
    const hashedContractId = "0xd9145CCE52D386f254917e481eB44e9943F39139";
    const hashedWhitelistId = "0xd9145CCE52D386f254917e481eB44e9943F39139";
    const hashedSupplierId = "0xd9145CCE52D386f254917e481eB44e9943F39139";
    const hashedHospitalId = "0xd9145CCE52D386f254917e481eB44e9943F39139";
    const deposit = 12345;
    const dedit = 12345;
    const udi = "0xd9145CCE52D386f254917e481eB44e9943F39139";
    const amount = 12345;
    const hospitalSignature = "0x957a9ced54d7af0d11992772d6d73a6298894658dae80bf2610419c97408c6f5732ff3ebfdba620c932d82fc462dc76fad237d8a8366d81ae3cfa1766e15781a1c";
    
    // 执行创建订单的交易，并捕获订单创建事件
    const tx = await contract.createOrderContract(
      hashedContractId, hashedWhitelistId, 
      hashedSupplierId, hashedHospitalId, 
      deposit, dedit, hospitalSignature,
      udi, amount
    );

  
    // 等待交易被挖掘和确认
    const receipt = await tx.wait();

    console.log(receipt, "receipt");

    // 获取订单创建事件
    const events = await contract.queryFilter("OrderCreated", tx.blockNumber);

    // 断言 OrderCreated 事件被触发，并且包含 orderId
    expect(events.length).to.equal(1);
    const orderId = events[0].args.orderId;
    expect(orderId).to.exist;

    console.log("Order ID:", orderId.toString());
  });
});  