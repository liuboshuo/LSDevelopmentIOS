//
//  NotificationHub.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/26.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 使用
 
 自定义的消息数字的显示
 
 用法
 NotificationHub *hub = [[NotificationHub alloc] initWithPoint:CGPointMake(10, 100)];
 hub.count = 10;
 
 [self.view addSubview:hub];
 
 - returns: <#return value description#>
 */
@interface NotificationHub : UIView


-(instancetype)initWithPoint:(CGPoint)point;

@property(nonatomic , assign)NSInteger count;

@end
