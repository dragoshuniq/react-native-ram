# react-native-ram

A react-native module to get device RAM

## Installation

#### Using npm:

```sh
npm install react-native-ram
```

#### or using yarn:

```sh
yarn add react-native-ram
```

## Usage

```js
import { getAllRamInfo } from "react-native-ram";

React.useEffect(()=>{
   getAllRamInfo().then(( ramInfo )=> console.log(ramInfo))
},[])


#### OR use async/await

const getRam=async()=>{
 const ramInfo = await getAllRamInfo();
 console.log(ramInfo)
}

// ...result example in MB and %

{
  "appUsedMemory": 12.637718200683594,
  "percentageUsed": 48.736824388734746,
  "usedMemory": 2726.0390625,
  "availableMemory": 2867.34765625,
  "totalMemory": 5593.38671875,
  "percentageAvailable": 51.263175611265254
}

```

## API

| Method                                              | Return Type         | iOS | Android |
| --------------------------------------------------- | ------------------- | :-: | :-----: |
| [getAllRamInfo()](#getallraminfo)                   | `Promise<RamState>` | ✅  |   ✅    |
| [getTotalRam()](#gettotalram)                       | `Promise<number>`   | ✅  |   ✅    |
| [getUsedRam()](#getusedram)                         | `Promise<number>`   | ✅  |   ✅    |
| [getAvailableRam()](#getavailableram)               | `Promise<number>`   | ✅  |   ✅    |
| [getPercentageUsed()](#getpercentageused)           | `Promise<number>`   | ✅  |   ✅    |
| [getPercentageAvailable()](#getpercentageavailable) | `Promise<number>`   | ✅  |   ✅    |
| [getAppRamUsed()](#getappramused)                   | `Promise<number>`   | ❌  |   ✅    |

## Type

```js
interface RamState {
  percentageAvailable: number;
  percentageUsed: number;
  totalMemory: number;
  availableMemory: number;
  usedMemory: number;
  appUsedMemory?: number;
}
```

## License

MIT

---
