//
//  UIControl+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Category)

/**
 *  删除事件
 */
- (void)removeAllTargets;

/**
 *  设置target-action时间
 *
 *  @param target        <#target description#>
 *  @param action        <#action description#>
 *  @param controlEvents <#controlEvents description#>
 */
-(void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  添加事件
 *
 *  @param controlEvents 动作
 *  @param block         回调代码块
 */
-(void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void(^)(id sender))block;

/**
 *  添加事件
 *
 *  @param controlEvents 动作
 *  @param block         回调代码块
 */
-(void)setBlockForControlEvents:(UIControlEvents)controlEvents block:(void(^)(id sender))block;
/**
 *  删除所有controlEvents的target-action事件
 *
 *  @param controlEvents <#controlEvents description#>
 */
- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;
@end
