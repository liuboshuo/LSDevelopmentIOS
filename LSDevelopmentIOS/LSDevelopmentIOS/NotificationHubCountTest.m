//
//  NotificationHubCountTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/26.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "NotificationHubCountTest.h"
#import "LSDevelopmetIOS.h"
@implementation NotificationHubCountTest
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NotificationHub *hub = [[NotificationHub alloc] initWithPoint:CGPointMake(10, 100)];
    hub.count = 10;
    
    [self.view addSubview:hub];
    
    NotificationHub *hub1 = [[NotificationHub alloc] initWithPoint:CGPointMake(50, 100)];
    hub1.count = 66;
    
    [self.view addSubview:hub1];
    
    NotificationHub *hub2 = [[NotificationHub alloc] initWithPoint:CGPointMake(100, 100)];
    hub2.count = 100;
    
    [self.view addSubview:hub2];
}
@end
