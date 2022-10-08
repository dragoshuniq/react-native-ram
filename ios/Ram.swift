//
//  RamModule.swift
//  ReactNativeRam
//
//  Created by Dragos Todoroșcean  on 08.10.2022.
//


import Foundation

@objc(RamModule)
class RamModule:NSObject{
  override init(){
    super.init()
    totalMemory = getTotalMemory()
    
  }
  var totalMemory:Double = -1;
  final let megabyteRate: Double = 1048576;
  //  @objc
  //  func getTotalRam(
  
  
  func  getUsedMemory()->Double{
    var taskInfo = task_vm_info_data_t()
    var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
    let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
      $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
        task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
      }
    }
    
    var usedMemory: Double = -1
    if result == KERN_SUCCESS {
      usedMemory = Double(taskInfo.phys_footprint) / megabyteRate
    }
    return usedMemory;
    
  }
  
  func getTotalMemory()->Double{
    let totalMemory = Double(ProcessInfo.processInfo.physicalMemory) / megabyteRate
    
    return totalMemory
  }
  
  func getAvailableMemory()->Double{
    let availableMemory = totalMemory - getUsedMemory()
    return availableMemory
  }
  
  func getPercentageAvailableMemory()->Double{
    let percentageAvailable = getAvailableMemory() / totalMemory * 100.0
    return percentageAvailable
  }
  
  func getPercentageUsedMemory()->Double{
    let percentageUsed = getUsedMemory() / totalMemory * 100.0
    return percentageUsed
  }
  
  @objc
  func getAllRamInfo(
    _ resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock
  ) ->Void{

    let usedMemory = getUsedMemory()
    let availableMemory = totalMemory - usedMemory
    let percentageAvailable = availableMemory / totalMemory * 100.0
    let percentageUsed = usedMemory / totalMemory * 100.0
    
    let ramResult: [String: Double] = [
      "usedMemory": usedMemory,
      "totalMemory": totalMemory,
      "availableMemory":availableMemory,
      "percentageAvailable":percentageAvailable,
      "percentageUsed":percentageUsed
      
    ]
    
    resolve (ramResult)
  }
  
  @objc
  func getUsedRam(
    _ resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock)->Void{
      resolve(getUsedMemory())
    }
  
  @objc
  func getTotalRam(
    _ resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock)->Void{
      resolve(getTotalMemory())
    }
  @objc
  func getAvailableRam(
    _ resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock)->Void{
      resolve(getAvailableMemory())
    }
  
  @objc
  func getPercentageAvailable(
    _ resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock)->Void{
      resolve(getPercentageAvailableMemory())
    }
  
  @objc
  func getPercentageUsed(
    _ resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock)->Void{
      resolve(getPercentageUsedMemory())
    }
  
  @objc
  static func requiresMainQueueSetup()->Bool{
    return true;
  }
  
}
