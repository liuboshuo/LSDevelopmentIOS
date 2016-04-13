//
//  UIGestureRecognizer+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (Category)

/**
 *  创建手势
 *
 *  @param block 手势回调Block代码块
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithActionBlock:(void (^)(id sender))block;


/**
 *  添加回调Block代码块
 *
 *  @param block <#block description#>
 */
- (void)addActionBlock:(void (^)(id sender))block;
/**
 *  删除手势的回调Block代码块
 */
- (void)removeAllActionBlocks;
@end
