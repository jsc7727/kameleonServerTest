import {
  recordBulkPoolLiquidity_service,
  recordPoolLiquidity_service,
} from "../service/contract.service";
import { IPoolLiquidity } from "../types/utilities/interfaceInterestCalculator";
import { getPoolLiquidity } from "./interestCalculator";
const checkPoolLiquidity = async () => {
  const { success, data } = await getPoolLiquidity();
  if (success && data !== null) {
    console.log(data);
    data.map(
      ({
        exchangeAddress: address,
        poolLiquidity: poolSize,
      }: IPoolLiquidity) => {
        recordPoolLiquidity_service({
          address,
          poolSize,
        });
      }
    );
  }
};
// bulk형
const checkBulkPoolLiquidity = async () => {
  const { success, data } = await getPoolLiquidity();
  if (success && data !== null) {
    const newData = data.map(
      ({
        exchangeAddress: address,
        poolLiquidity: poolSize,
      }: IPoolLiquidity) => ({
        address,
        poolSize,
      })
    );
    recordBulkPoolLiquidity_service(newData);
  }
};

const calcPoolRoi = ({ first, last }) => {
  const result = [];
  for (let i = 0; i < first.length; i++) {
    const firstPoolData = first[i];
    const lastPoolData = last[i];
    const firstDate = new Date(firstPoolData.createdAt).getDate;
    const lastDate = new Date(lastPoolData.createdAt).getDate;
    const ROI =
      (lastPoolData.poolSize / firstPoolData.poolSize) ^
      ((365 / (+lastDate - +firstDate) - 1) * 100);
    result.push({ address: firstPoolData.address, roi: ROI });
  }
  console.log(result);
  return result;
};
export { checkPoolLiquidity, checkBulkPoolLiquidity, calcPoolRoi };
