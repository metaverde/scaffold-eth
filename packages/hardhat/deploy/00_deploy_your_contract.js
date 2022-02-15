// deploy/00_deploy_your_contract.js

const { ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("Balloons", {
    // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
    from: deployer,
    //args: [ "Hello", ethers.utils.parseEther("1.5") ],
    log: true,
  });

  const balloons = await ethers.getContract("Balloons", deployer);
  

  await deploy("DEX", {
    // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
    from: deployer,
    args: [ balloons.address],
    log: true,
  });

  const dex = await ethers.getContract("DEX", deployer);
  //const result = await balloons.transfer( dex.address, ethers.utils.parseEther("1000") );
  
  
  // paste in your address here to get 10 balloons on deploy:
  await balloons.transfer("0x4A8fA7b9eC7985Fdc7c4846BD264721558D69Ef6",""+(10*10**18));

  // uncomment to init DEX on deploy:
  console.log("Approving DEX ("+dex.address+") to take Balloons from main account...")
  //If you are going to the testnet make sure your deployer account has enough ETH
  await balloons.approve(dex.address,ethers.utils.parseEther('100'));
  console.log("INIT exchange...")
  await dex.init(ethers.utils.parseEther('5'),{value:ethers.utils.parseEther('3'),gasLimit:200000})

};


module.exports.tags = ["YourContract"];
