//
//  LSBarButtonItem.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/11.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LSBarButtonItem : UIBarButtonItem

/**
 *  创建BarButtonItem
 *
 *  @param title            标题
 *  @param isBackButtonItem 是否是返回按钮
 *  @param target           <#target description#>
 *  @param action           <#action description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)itemWithTitle:(NSString *)title
             isBackButtonItem:(BOOL)isBackButtonItem
                       target:(id)target
                       action:(SEL)action;

/**
 *  创建BarButtonItem
 *
 *  @param title            标题
 *  @param image            图片
 *  @param isBackButtonItem 是否是返回按钮
 *  @param target           <#target description#>
 *  @param action           <#action description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
             isBackButtonItem:(BOOL)isBackButtonItem
                       target:(id)target
                       action:(SEL)action;

/**
 *  创建BarButtonItem
 *
 *  @param image            t图片
 *  @param isBackButtonItem 是否返回
 *  @param target           <#target description#>
 *  @param action           <#action description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)itemWithImage:(NSString *)image
             isBackButtonItem:(BOOL)isBackButtonItem
                       target:(id)target
                       action:(SEL)action;

/**
 *  创建返回UIBarButtonItem
 *
 *  @param image  图片
 *  @param target <#target description#>
 *  @param action <#action description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)backItemWithImage:(NSString *)image
                           target:(id)target
                           action:(SEL)action;


@end
