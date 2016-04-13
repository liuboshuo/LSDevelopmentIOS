//
//  NSTimer+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Category)

/**
 *  创建NSTimer （把 action-target 改成以Block代码块的方式执行回调内容）
 *
 *  @param seconds 每隔多少秒
 *  @param block   执行的代码块
 *  @param repeats 是否对代码块重复执行
 *
 *  @return 
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;


/**
 *  创建NSTimer （把 action-target 改成以Block代码块的方式执行回调内容）
 *
 *  @param seconds 每隔多少秒
 *  @param block   执行的代码块
 *  @param repeats 是否对代码块重复执行
 *
 *  @return
 */
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;



@end
