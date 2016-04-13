//
//  UIScrollView+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Category)


/**
 *  滑到头部
 */
- (void)scrollToTop;
/**
 *  滑到头部
 *
 *  @param animated 是否动画
 */
- (void)scrollToTopAnimated:(BOOL)animated;
/**
 *  滑到底部
 */
- (void)scrollToBottom;
/**
 *  滑到底部
 *
 *  @param animated 是否动画
 */
- (void)scrollToBottomAnimated:(BOOL)animated;
/**
 *  滑到最左边
 */
- (void)scrollToLeft;
/**
 *  滑到左边
 *
 *  @param animated 是否进行动画
 */
- (void)scrollToLeftAnimated:(BOOL)animated;
/**
 *  滑到右侧
 */
- (void)scrollToRight;
/**
 *  滑到右侧
 *
 *  @param animated 是否动画
 */
- (void)scrollToRightAnimated:(BOOL)animated;


@end
