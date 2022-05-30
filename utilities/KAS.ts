import Caver from "caver-js";
require("dotenv").config();
export const caver = new Caver(process.env.BAOBAB_NETWORK);

import { abiList, byteCodeList } from "./contractData";

const deployerKeyring = caver.wallet.keyring.create(
  process.env.FEEADDRESS,
  process.env.FEEPRIVATEKEY
);
caver.wallet.add(deployerKeyring);

const deployContract = async ({
  contractName,
  parameters = [],
}: {
  contractName: string;
  parameters?: Array<string>;
}) => {
  try {
    if (contractName === undefined) throw "Not enough arguments";
    const contract = caver.contract.create(abiList[contractName]);
    const delployedContract = await contract.deploy(
      {
        from: deployerKeyring.address,
        gas: 5000000,
      },
      byteCodeList[contractName],
      ...parameters
    );
    console.log(
      `The address of deployed smart contract: ${delployedContract.options.address}`
    );
    return delployedContract.options.address;
  } catch (error) {
    console.log(error);
    return error;
  }
};

const callContract = async ({
  contractName,
  contractAddress,
  methodName,
  parameters = [],
}: {
  contractName: string;
  contractAddress: string;
  methodName: string;
  parameters?: Array<string>;
}) => {
  try {
    if (
      contractName === undefined ||
      contractAddress === undefined ||
      methodName === undefined
    )
      throw "Not enough arguments";
    const contract = caver.contract.create(
      abiList[contractName],
      contractAddress
    );
    const callResult = await contract.call(methodName, ...parameters);
    console.log(`Result of calling ${methodName} with key: ${callResult}`);
    return callResult;
  } catch (error) {
    console.log(error);
    return error;
  }
};

const sendContract = async ({
  contractName,
  contractAddress,
  methodName,
  parameters = [],
  value = undefined,
}: {
  contractName: string;
  contractAddress: string;
  methodName: string;
  parameters?: Array<string | number>;
  value?: String | undefined;
}) => {
  try {
    if (
      contractName === undefined ||
      contractAddress === undefined ||
      methodName === undefined
    )
      throw "Not enough arguments";
    const contract = caver.contract.create(
      abiList[contractName],
      contractAddress
    );
    const receipt = await contract.send(
      {
        from: deployerKeyring.address,
        gas: 3000000,
        // value,
      },
      methodName,
      ...parameters
    );
    console.log(receipt?.blockHash);
    return receipt;
  } catch (error) {
    console.log(error);
    return error;
  }
};

// const multiMint = () => {
//   const CronJob = require("cron").CronJob;
//   const job = new CronJob("0 0 */1 * * *", function () {
//     sendContract({
//       contractName: "MyKIP7",
//       contractAddress: "",
//       methodName: "multiMint",
//     });
//   });
//   job.start();
// };

const getBalance = async ({ address }: { address: string }) => {
  try {
    const balance = await caver.klay.getBalance(address);
    return balance;
  } catch (error) {
    console.log(error);
    return "";
  }
};

// how to use

// deployContract({ contractName: "MyKIP7" });

// const contractAddress = "0x9ae71CA5Babd51D1Cdda1785091Dab28866C54C9";
// callContract({
//   contractName: "MyKIP7",
//   contractAddress,
//   methodName: "totalSupply",
// });

// const contractAddress = "0x9ae71CA5Babd51D1Cdda1785091Dab28866C54C9";
// sendContract({
//   contractName: "MyKIP7",
//   contractAddress,
//   methodName: "approve",
//   parameters: [process.env.FEEADDRESS, "1000000"],
// });

// multiMint();

export { deployContract, callContract, sendContract, getBalance };
