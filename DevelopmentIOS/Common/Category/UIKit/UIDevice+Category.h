//
//  UIDevice+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/8.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Category)

/**
 *  系统版本
 *
 *  @return <#return value description#>
 */
+ (double)systemVersion;

/**
 *  判断设备是不是pad
 */
@property (nonatomic, readonly) BOOL isPad;
/**
 *  是否是模拟器
 */
@property (nonatomic, readonly) BOOL isSimulator;

/**
 *  打电话
 */
@property (nonatomic, readonly) BOOL canMakePhoneCalls;

/**
 *  返回
 *  iphone6.1
 */
@property (nonatomic, readonly, nullable) NSString *machineModel;

/**
 *  iphone6 iphone6s
 */
@property (nonatomic, readonly , nullable) NSString *machineModelName;

/**
 *  系统激活时间
 */
@property (nonatomic, readonly, nullable) NSDate *systemUptime;



@property (nullable, nonatomic, readonly) NSString *ipAddressWIFI;

@property (nullable, nonatomic, readonly) NSString *ipAddressCell;
/**
 *  物理存储
 */
@property (nonatomic, readonly) int64_t diskSpace;
/**
 *  可用的物理存储
 */
@property (nonatomic, readonly) int64_t diskSpaceFree;

/**
 *  已用的物理存储
 */
@property (nonatomic, readonly) int64_t diskSpaceUsed;

/**
 *  总内存的空间
 */
@property (nonatomic, readonly) int64_t memoryTotal;
/**
 *  已用的内存空间
 */
@property (nonatomic, readonly) int64_t memoryUsed;
/**
 *  可用的内存
 */
@property (nonatomic, readonly) int64_t memoryFree;
@property (nonatomic, readonly) int64_t memoryActive;
@property (nonatomic, readonly) int64_t memoryInactive;
@property (nonatomic, readonly) int64_t memoryWired;
@property (nonatomic, readonly) int64_t memoryPurgable;
@end
