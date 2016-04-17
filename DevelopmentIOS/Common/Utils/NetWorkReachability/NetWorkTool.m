//
//  NetWorkTool.m
//  网络状态监测
//
//  Created by 刘硕 on 15-5-21.
//  Copyright (c) 2015年 刘硕. All rights reserved.
//

#import "NetWorkTool.h"
#import "LSReachability.h"
#import "UIPropertyConstant.h"
@interface NetWorkTool ()

@end

@implementation NetWorkTool

singletonImplementation(NetWorkTool);

-(void)startNotifier
{
    [[self reachability] setNotifyBlock:^(LSReachability * _Nullable reachability) {
        [self checkNetWork];
    }];
}

-(void)checkNetWork
{
    if (![NetWorkTool isConnectNetwork]) {
        //        [MBProgressHUD showHint:@"网络连接不可用"];
        NSLog(@"网络连接不可用");
    }else{
        if ([NetWorkTool isEnableWifi]) {
            //            [MBProgressHUD showHint:@"当前网络是Wifi"];
            NSLog(@"当前网络是Wifi");
        }else if([NetWorkTool isEnable3g]){
            //            [MBProgressHUD showHint:@"当前网络为数据流量"];
            NSLog(@"当前网络为数据流量");
        }
    }
}
//Wifi
+(BOOL)isEnableWifi
{
    return ([LSReachability reachability].status == LSReachabilityStatusWiFi);
}

//3g
+(BOOL)isEnable3g
{
    return ([LSReachability reachability].status == LSReachabilityStatusWWAN);
}

//能连上网络
+(BOOL)isConnectNetwork{
    if([self isEnable3g]||[self isEnableWifi]){
        return YES;
    }else{
        return NO;
    }
}

-(LSReachability *)reachability
{
    if (_reachability == nil) {
        _reachability = [LSReachability reachability];
    }
    return _reachability;
}
@end
