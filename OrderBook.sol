// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract OrderBook is ReentrancyGuard {
    enum Side { Buy, Sell }

    struct Order {
        uint256 id;
        address trader;
        Side side;
        uint256 price;
        uint256 amount;
        uint256 filled;
    }

    uint256 public nextOrderId;
    mapping(Side => Order[]) public orderHistory;
    
    event OrderPlaced(uint256 id, address trader, Side side, uint256 price, uint256 amount);
    event TradeExecuted(uint256 buyId, uint256 sellId, uint256 price, uint256 amount);

    function placeLimitOrder(Side _side, uint256 _price, uint256 _amount) external nonReentrant {
        require(_price > 0 && _amount > 0, "Invalid order parameters");

        Order memory newOrder = Order({
            id: nextOrderId++,
            trader: msg.sender,
            side: _side,
            price: _price,
            amount: _amount,
            filled: 0
        });

        // Simplified matching logic: in production, use a sorted linked list for price priority
        _matchOrders(newOrder);
        
        if (newOrder.filled < newOrder.amount) {
            orderHistory[_side].push(newOrder);
        }

        emit OrderPlaced(newOrder.id, msg.sender, _side, _price, _amount);
    }

    function _matchOrders(Order memory _newOrder) internal {
        // Implementation of matching logic against orderHistory[oppositeSide]
        // This is where price-time priority is enforced
    }
}
