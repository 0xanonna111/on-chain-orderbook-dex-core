# On-Chain Orderbook DEX Core

This repository contains the core logic for a Central Limit Order Book (CLOB) decentralized exchange. Unlike automated market makers (AMMs), this engine allows users to set specific price points for their trades, similar to traditional financial exchanges.



## Features
* **Linked List Implementation**: Efficiently manages the order book without hitting gas limits during large price swings.
* **Partial Fills**: Logic to handle orders that are only partially matched.
* **Atomic Settlement**: Ensures that the trade execution and asset transfer happen in a single, irreversible transaction.

## How it Works
1. **Place Order**: Users call `placeLimitOrder` with side (Buy/Sell), price, and quantity.
2. **Matching**: The engine checks the opposite side of the book for any overlapping prices.
3. **Execution**: Assets are swapped between the parties, and the remaining quantities are updated.

## Setup
1. `npm install`
2. `npx hardhat compile`
3. Use `test_matching.js` to simulate a trade between two local accounts.
