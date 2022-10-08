package com.reactnativeram;

import androidx.annotation.NonNull;

import android.app.ActivityManager;
import android.app.ActivityManager.MemoryInfo;
import android.content.Context;
import android.os.Build;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableNativeMap;

import java.util.HashMap;

@ReactModule(name = RamModule.NAME)
public class RamModule extends ReactContextBaseJavaModule {
  public static final String NAME = "RamModule";
  private MemoryInfo memoryInfo = new MemoryInfo();
  private static ReactApplicationContext reactContext;
  private ActivityManager activityManager;
  private final double mebiByte = 0x100000L; //value to convert bytes to mebibytes = 1024x1024


  RamModule(ReactApplicationContext reactContext) {
    super(reactContext);
    reactContext = reactContext;
    activityManager = ((ActivityManager) reactContext.getSystemService(Context.ACTIVITY_SERVICE));
    activityManager.getMemoryInfo(memoryInfo);

  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }

  public double getAvailableRamSync() {
    try {
      double availableMemory = memoryInfo.availMem / mebiByte;
      return availableMemory;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return -1;
  }


  public double getUsedRamSync() {
    try {
      double usedMemory = getTotalRamSync() - getAvailableRamSync();

      return usedMemory;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return -1;
  }


  public double getTotalRamSync() {
    try {
      double totalMemory = memoryInfo.totalMem / mebiByte;
      return totalMemory;

    } catch (Exception e) {
      e.printStackTrace();
    }
    return -1;
  }

  public double getPercentageAvailableSync() {
    try {
      double percentageAvailable = getAvailableRamSync() / getTotalRamSync() * 100.0;
      return percentageAvailable;

    } catch (Exception e) {
      e.printStackTrace();
    }
    return -1;
  }

  public double getPercentageUsedSync() {
    try {
      double percentageUsed = 100 - (getAvailableRamSync() / getTotalRamSync() * 100.0);
      return percentageUsed;

    } catch (Exception e) {
      e.printStackTrace();
    }
    return -1;
  }

  public WritableNativeMap getAllRamInfoSync() {
    WritableNativeMap wResult = new WritableNativeMap();
    try {
      activityManager.getMemoryInfo(memoryInfo);
      double totalMemory = getTotalRamSync();
      double availableMemory = getAvailableRamSync();
      double usedMemory = getUsedRamSync();
      double percentageAvailable = getPercentageAvailableSync();
      double percentageUsed = getPercentageUsedSync();
      double appUsedMemory = getAppRamUsedSync();

      wResult.putDouble("percentageAvailable", percentageAvailable);
      wResult.putDouble("totalMemory", totalMemory);
      wResult.putDouble("availableMemory", availableMemory);
      wResult.putDouble("usedMemory", usedMemory);
      wResult.putDouble("percentageUsed", percentageUsed);
      wResult.putDouble("appUsedMemory", appUsedMemory);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return wResult;
  }

  public double getAppRamUsedSync() {
    try {
      Runtime info = Runtime.getRuntime();
      double freeMemory = info.freeMemory();
      double totalMemory = info.totalMemory();
      double usedMemory = (totalMemory - freeMemory) / mebiByte;
      return usedMemory;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return -1;
  }

  @ReactMethod
  public void getAppRamUsed(Promise promise) {
    promise.resolve(getAppRamUsedSync());
  }

  @ReactMethod
  public void getAvailableRam(Promise promise) {
    promise.resolve(getAvailableRamSync());
  }

  @ReactMethod
  public void getUsedRam(Promise promise) {
    promise.resolve(getUsedRamSync());
  }

  @ReactMethod
  public void getPercentageUsed(Promise promise) {
    promise.resolve(getPercentageUsedSync());
  }

  @ReactMethod
  public void getPercentageAvailable(Promise promise) {
    promise.resolve(getPercentageAvailableSync());
  }

  @ReactMethod
  public void getTotalRam(Promise promise) {
    promise.resolve(getTotalRamSync());
  }

  @ReactMethod
  public void getAllRamInfo(Promise promise) {
    promise.resolve(getAllRamInfoSync());
  }
}
