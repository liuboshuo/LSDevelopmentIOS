//
//  UIApplication+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/8.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Category)

/**
 *  沙盒documents文件的URL
 */
@property (nullable, nonatomic, readonly) NSURL *documentsURL;

/**
 *  沙盒documents文件的path
 */
@property (nullable, nonatomic, readonly) NSString *documentsPath;
/**
 *  沙盒caches文件的URL
 */
@property (nullable, nonatomic, readonly) NSURL *cachesURL;
/**
 *  沙盒caches文件的path
 */
@property (nullable, nonatomic, readonly) NSString *cachesPath;

/**
 *  获取library文件的URL
 */
@property (nullable, nonatomic, readonly) NSURL *libraryURL;
/**
 *  获取library文件的Path
 */
@property (nullable, nonatomic, readonly) NSString *libraryPath;

/**
 *  获取应用名称
 */
@property (nullable, nonatomic, readonly) NSString *appBundleName;

/**
 *  获取应用id
 */
@property (nullable, nonatomic, readonly) NSString *appBundleID;
/**
 *  获取应用的版本
 */
@property (nullable, nonatomic, readonly) NSString *appVersion;

/**
 *  获取应用构建build的版本
 */
@property (nullable, nonatomic, readonly) NSString *appBuildVersion;

/**
 *  判断应用是不是盗版 即 是不是来源从商店下载的应用
 */
@property (nonatomic, readonly) BOOL isPirated;


@property (nonatomic, readonly) BOOL isBeingDebugged;


+ (BOOL)isAppExtension;

+ (nullable UIApplication *)sharedExtensionApplication;
@end
