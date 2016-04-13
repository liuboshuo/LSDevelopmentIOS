//
//  LSReachability.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/8.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSReachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <objc/message.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

static LSReachabilityStatus LSReachabilityStatusFromFlags(SCNetworkReachabilityFlags flags , BOOL allowWWAN){
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
        return LSReachabilityStatusNone;
    }
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) && (flags & kSCNetworkReachabilityFlagsTransientConnection)) {
        return LSReachabilityStatusNone;
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) && allowWWAN) {
        return LSReachabilityStatusWWAN;
    }
    return LSReachabilityStatusWiFi;
}

static void LSReachabilityCallback(SCNetworkReachabilityRef target,SCNetworkReachabilityFlags flags,void *info){
    LSReachability *self = ((__bridge LSReachability*)info);
    if (self.notifyBlock) {
        self.notifyBlock(self);
    }
}

@interface LSReachability ()
@property(nonatomic , assign) SCNetworkReachabilityRef ref;
@property(nonatomic , assign) BOOL scheduled;
@property(nonatomic , assign) BOOL allowWWAN;
@property(nonatomic , strong) CTTelephonyNetworkInfo *networkInfo;


@end
@implementation LSReachability

+(dispatch_queue_t)shareQueue
{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("LSReachability", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

-(instancetype)init
{
    
    struct sockaddr_in zero_address;
    bzero(&zero_address, sizeof(zero_address));
    zero_address.sin_len = sizeof(zero_address);
    zero_address.sin_family = AF_INET;
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zero_address);
    return [self initWithRef:ref];
}

-(instancetype)initWithRef:(SCNetworkReachabilityRef)ref
{
    if (!ref) {
        return nil;
    }
    self = super.init;
    if (!self) {
        return nil;
    }
    _ref = ref;
    _allowWWAN = YES;
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        _networkInfo = [CTTelephonyNetworkInfo new];
    }
    return self;
}

-(void)dealloc
{
    self.notifyBlock = nil;
    self.scheduled = NO;
    CFRelease(self.ref);
}
-(void)setScheduled:(BOOL)scheduled
{
    if (_scheduled == scheduled) {
        return;
    }
    _scheduled = scheduled;
    
    if (scheduled) {
        SCNetworkReachabilityContext con = {0,(__bridge void *)self,NULL,NULL,NULL
        };
        SCNetworkReachabilitySetCallback(self.ref, LSReachabilityCallback, &con);
        SCNetworkReachabilitySetDispatchQueue(self.ref, [self.class shareQueue]);
        
    }else{
        SCNetworkReachabilitySetDispatchQueue(self.ref, NULL);
    }
}

-(SCNetworkReachabilityFlags)flags
{
    SCNetworkReachabilityFlags flags = 0;
    SCNetworkReachabilityGetFlags(self.ref, &flags);
    return flags;
}

-(LSReachabilityStatus)status
{
    return LSReachabilityStatusFromFlags(self.flags, self.allowWWAN);
}
-(LSReachabilityWWANStatus)wwanStatus
{
    if (!self.networkInfo) {
        return LSReachabilityWWANStatusNone;
    }
    NSString *status = self.networkInfo.currentRadioAccessTechnology;
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{CTRadioAccessTechnologyGPRS : @(LSReachabilityWWANStatus2G),  // 2.5G   171Kbps
                CTRadioAccessTechnologyEdge : @(LSReachabilityWWANStatus2G),  // 2.75G  384Kbps
                CTRadioAccessTechnologyWCDMA : @(LSReachabilityWWANStatus3G), // 3G     3.6Mbps/384Kbps
                CTRadioAccessTechnologyHSDPA : @(LSReachabilityWWANStatus3G), // 3.5G   14.4Mbps/384Kbps
                CTRadioAccessTechnologyHSUPA : @(LSReachabilityWWANStatus3G), // 3.75G  14.4Mbps/5.76Mbps
                CTRadioAccessTechnologyCDMA1x : @(LSReachabilityWWANStatus3G), // 2.5G
                CTRadioAccessTechnologyCDMAEVDORev0 : @(LSReachabilityWWANStatus3G),
                CTRadioAccessTechnologyCDMAEVDORevA : @(LSReachabilityWWANStatus3G),
                CTRadioAccessTechnologyCDMAEVDORevB : @(LSReachabilityWWANStatus3G),
                CTRadioAccessTechnologyeHRPD : @(LSReachabilityWWANStatus3G),
                CTRadioAccessTechnologyLTE : @(LSReachabilityWWANStatus4G)};
    });
    NSNumber *num = dic[status];
    if (num) {
        return num.unsignedIntegerValue;
    }else{
        return LSReachabilityWWANStatusNone;
    }
    
}
-(BOOL)isReachable
{
    return self.status != LSReachabilityStatusNone;
}
+(instancetype)reachability
{
    return [[self alloc] init];
}
+(instancetype)reachabilityForLocalWifi
{
    struct sockaddr_in localWifiAddress;
    bzero(&localWifiAddress, sizeof(localWifiAddress));
    localWifiAddress.sin_len = sizeof(localWifiAddress);
    localWifiAddress.sin_family = AF_INET;
    localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
    LSReachability *one = [self reachabilityWithAdress:&localWifiAddress];
    one.allowWWAN = NO;
    return one;
}

+ (instancetype)reachabilityWithHostname:(NSString *)hostname {
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [hostname UTF8String]);
    return [[self alloc] initWithRef:ref];
}

+(instancetype)reachabilityWithAdress:(const struct sockaddr_in *)hostadress
{
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)hostadress);
    return [[self alloc] initWithRef:ref];
}


-(void)setNotifyBlock:(void (^)(LSReachability * _Nullable))notifyBlock
{
    _notifyBlock = [notifyBlock copy];
    self.scheduled = (self.notifyBlock != nil);
}
@end
