import { NativeModules, Platform } from 'react-native';
import type { GetRamType, RamState } from './types';

const LINKING_ERROR =
  `The package 'react-native-ram' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const RamModule = NativeModules.RamModule
  ? NativeModules.RamModule
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

const isAndroid = Platform.OS === 'android';

export const getAppRamUsed = async () => {
  if (isAndroid) {
    const perAvailable: GetRamType = await RamModule.getAppRamUsed();
    return perAvailable.toFixed(2);
  }
  return -1;
};

export const getAvailableRam = async () => {
  const ramAvailable: GetRamType = await RamModule.getAvailableRam();
  return ramAvailable.toFixed(2);
};

export const getTotalRam = async () => {
  const ramAvailable: GetRamType = await RamModule.getTotalRam();
  return ramAvailable.toFixed(2);
};

export const getUsedRam = async () => {
  const usedRam: GetRamType = await RamModule.getUsedRam();
  return usedRam.toFixed(2);
};

export const getPercentageUsed = async () => {
  const usedRam: GetRamType = await RamModule.getPercentageUsed();
  return usedRam.toFixed(2);
};

export const getPercentageAvailable = async () => {
  const usedRam: GetRamType = await RamModule.getPercentageAvailable();
  return usedRam.toFixed(2);
};

export const getAllRamInfo = async () => {
  const usedRam: RamState = await RamModule.getAllRamInfo();
  return usedRam;
};

export type { GetRamType, RamState };

export default RamModule;
