export interface RamState {
  percentageAvailable: number;
  percentageUsed: number;
  totalMemory: number;
  availableMemory: number;
  usedMemory: number;
  appUsedMemory?: number;
}

export type GetRamType = number;
