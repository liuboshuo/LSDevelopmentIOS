//
//  NetWorkTool.h
//  网络状态监测
//
//  Created by 刘硕 on 15-5-21.
//  Copyright (c) 2015年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"
#import "LSReachability.h"
@interface NetWorkTool : NSObject



singletonInterface(NetWorkTool);


@property(nonatomic , strong)LSReachability *reachability;


/**
 *  检测网络的当前状态
 */
-(void)checkNetWork;

/**
 *  开始坚挺状态的变化
 */
-(void)startNotifier;

//是否能连上网络
+(BOOL)isConnectNetwork;

//是否WIFI
+(BOOL)isEnableWifi;

//是否手机网络
+(BOOL)isEnable3g;
@end
