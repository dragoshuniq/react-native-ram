//
//  RamModule.m
//  ReactNativeRam
//
//  Created by Dragos Todoroșcean  on 08.10.2022.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RamModule,NSObject)

RCT_EXTERN_METHOD(getAllRamInfo: (RCTPromiseResolveBlock) resolve rejecter: (RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(getUsedRam: (RCTPromiseResolveBlock) resolve rejecter: (RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(getTotalRam: (RCTPromiseResolveBlock) resolve rejecter: (RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(getAvailableRam: (RCTPromiseResolveBlock) resolve rejecter: (RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(getPercentageUsed: (RCTPromiseResolveBlock) resolve rejecter: (RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(getPercentageAvailable: (RCTPromiseResolveBlock) resolve rejecter: (RCTPromiseRejectBlock) reject)

@end
