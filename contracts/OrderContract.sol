// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.16;

contract OrderContract {
    // 定义订单结构体
    struct Order {
        bytes contractId;
        bytes whitelistId;
        bytes supplierId;
        bytes hospitalId;
        uint256 deposit;
        uint256 dedit;
        uint256 blockTime;
        bytes udi;
        uint amount;
        bytes hospitalSignature;
        bytes supplierSignature;
    }

    // 订单列表
    mapping(uint => Order) public orders;
    uint public nextOrderId = 1;
    
    // 定义事件：订单创建
    event OrderCreated(
        uint indexed orderId,
        bytes contractId,
        bytes whitelistId,
        bytes supplierId,
        bytes hospitalId,
        uint256 deposit,
        uint256 dedit,
        uint256 blockTime,
        bytes udi,
        uint256 amount,
        bytes hospitalSignature
    );

    // 定义事件：供应商签名存储
    event SupplierSignatureStored(
        uint indexed orderId,
        bytes supplierSignature
    );
    
    constructor() {}

    // 创建订单函数
    function createOrderContract(
        bytes memory _contractId, bytes memory _whitelistId,
        bytes memory _supplierId, bytes memory _hospitalId,
        uint256 _deposit, uint256 _dedit, bytes memory _hospitalSignature,
        bytes memory _udi, uint _amount
    ) public returns (uint) {
        // 创建一个新的订单实例并初始化其字段，同时初始化签名为空字节
        Order memory newOrder = Order({
            contractId: _contractId,
            whitelistId: _whitelistId,
            supplierId: _supplierId,
            hospitalId: _hospitalId,
            deposit: _deposit,
            dedit: _dedit,
            blockTime: block.timestamp,
            udi: _udi,
            amount: _amount,
            hospitalSignature: _hospitalSignature,
            supplierSignature: new bytes(0)
        });

        // 将新订单存储到映射中
        orders[nextOrderId] = newOrder;

        // 更新下一个订单ID
        nextOrderId++;
        emit OrderCreated(nextOrderId-1, _contractId,_whitelistId,_supplierId, _hospitalId,_deposit,_dedit,block.timestamp,_udi,_amount,_hospitalSignature);
        // 返回创建的订单ID
        return nextOrderId - 1;
    }

    // 存储供应商签名到指定订单
    function storeSupplierSignature(uint orderId, bytes memory _signature) public {
        require(orders[orderId].supplierSignature.length == 0, "Order already has a supplier signature");
        orders[orderId].supplierSignature = _signature;
        emit SupplierSignatureStored(orderId, _signature);
    }

    // 查看订单属性的视图方法
    function getOrderDetails(uint orderId) public view returns (
        bytes memory contractId,
        bytes memory whitelistId,
        bytes memory supplierId,
        bytes memory hospitalId,
        uint256 deposit,
        uint256 dedit,
        uint256 blockTime,
        bytes memory udi,
        uint amount,
        bytes memory hospitalSignature,
        bytes memory supplierSignature
    ) {
        // 获取指定订单的属性值
        Order storage order = orders[orderId];
        return (
            order.contractId,
            order.whitelistId,
            order.supplierId,
            order.hospitalId,
            order.deposit,
            order.dedit,
            order.blockTime,
            order.udi,
            order.amount,
            order.hospitalSignature,
            order.supplierSignature
        );
    }
}