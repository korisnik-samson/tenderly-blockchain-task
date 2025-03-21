import hre from "hardhat";

async function main(): Promise<void> {
    await deployLock();
}

async function deployLock(): Promise<void> {
    const currentTimeStampInSeconds = Math.round(Date.now() / 1000);
    const ONE_YEAR_IN_SECONDS = 60 * 60 * 24 * 365;
    const unlockTime = currentTimeStampInSeconds + ONE_YEAR_IN_SECONDS;
    
    const lockedAmount = hre.ethers.parseEther("1");
    
    const Lock = await hre.ethers.getContractFactory("Lock");
    const lock = await Lock.deploy(unlockTime, "CanIHashMoneyPlease", {
        value: lockedAmount,
    });
    
    await lock.waitForDeployment();
    
    console.log(`Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to: ${await lock.getAddress()}`);
}

main().catch((error: any) => {
    console.error(error);
    process.exit(1);
})

function hex2ascii(hex: any): string {
    const hexString = hex.toString();
    const stringBuilder = [];
    
    for (let i = 0; i < hexString.length; i += 2) {
        stringBuilder.push(
            String.fromCharCode(
                parseInt(hexString.substr(i, 2), 16)
            )
        );
    }
    
    return stringBuilder.join("");
}