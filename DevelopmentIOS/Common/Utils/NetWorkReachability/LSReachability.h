//
//  LSReachability.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/8.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <netinet6/in6.h>


typedef NS_ENUM(NSUInteger , LSReachabilityStatus){
    LSReachabilityStatusNone = 0,
    LSReachabilityStatusWWAN = 1,
    LSReachabilityStatusWiFi
    
};

typedef NS_ENUM(NSUInteger , LSReachabilityWWANStatus) {
    LSReachabilityWWANStatusNone = 0,
    LSReachabilityWWANStatus2G = 1,
    LSReachabilityWWANStatus3G = 2,
    LSReachabilityWWANStatus4G
};

@interface LSReachability : NSObject

@property(nonatomic , readonly)SCNetworkReachabilityFlags flags;

@property(nonatomic , readonly)LSReachabilityStatus status;
@property(nonatomic , readonly)LSReachabilityWWANStatus wwanStatus;

@property(nonatomic , readonly , getter=isReachable)BOOL reachable;



/**
 *  网络变化
 */
@property(nullable, nonatomic , copy) void(^notifyBlock)( LSReachability * _Nullable  reachability);

/**
 *  创建
 *
 *  @return <#return value description#>
 */
+(nullable instancetype)reachability;
/**
 *  判断wifi连接成功
 *
 *  @return <#return value description#>
 */
+(nullable instancetype)reachabilityForLocalWifi;
+(nullable instancetype)reachabilityWithHostname:(NSString *)hostname;


@end
