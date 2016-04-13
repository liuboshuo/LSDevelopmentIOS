
//
//  NSTimer+Category.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "NSTimer+Category.h"

@implementation NSTimer (Category)


+(void)exectionBlock:(NSTimer *)timer
{
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void(^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *))block repeats:(BOOL)repeats
{
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(exectionBlock:) userInfo:[block copy] repeats:repeats];
}

+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *))block repeats:(BOOL)repeats
{
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(exectionBlock:) userInfo:[block copy] repeats:repeats];
}
@end
