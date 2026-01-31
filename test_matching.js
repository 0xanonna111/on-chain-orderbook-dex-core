const { expect } = require("chai");
const hre = require("hardhat");

async function main() {
  const [trader1, trader2] = await hre.ethers.getSigners();
  const OrderBook = await hre.ethers.getContractFactory("OrderBook");
  const dex = await OrderBook.deploy();

  await dex.waitForDeployment();
  console.log(`DEX Core deployed to: ${await dex.getAddress()}`);

  // Simulate placing a buy order
  await dex.connect(trader1).placeLimitOrder(0, 2000, 10); // Buy 10 units at 2000
  console.log("Limit Buy Order placed by Trader 1");
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
