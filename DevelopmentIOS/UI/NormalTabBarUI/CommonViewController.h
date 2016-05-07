//
//  CommonViewController.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/6.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonViewController : UIViewController

/**
 *  导航左上角的按钮
 */
@property(nullable , nonatomic , strong)UIBarButtonItem *leftButtonItem;

/**
 *  导航右上角的按钮
 */
@property(nullable , nonatomic , strong)UIBarButtonItem *rightButtonItem;

/**
 *  自定义返回
 */
@property(nonatomic,assign)BOOL customBackItem;

/**
 *  设置系统返回按钮
 *
 *  @param text <#text description#>
 */
- (void)setBackBarButtonItemWithTitle:(nullable NSString *)text;

/**
 *  创建导航左上角的按钮
 *
 *  @param text                文字内容
 *  @param isBackBarButtonItem 是否是返回按钮
 *
 *  @return <#return value description#>
 */
- (nullable UIBarButtonItem *)leftButtonItemWithTitle:(nullable NSString *)text isBackBarButtonItem:(BOOL)isBackBarButtonItem;

/**
 *  创建导航左上角的按钮
 *
 *  @param imageName           图片
 *  @param isBackBarButtonItem 是否是范湖按钮
 *
 *  @return <#return value description#>
 */
- (nullable UIBarButtonItem *)leftButtonItemWithImage:(nullable NSString *)imageName isBackBarButtonItem:(BOOL)isBackBarButtonItem;

/**
 *  创建导航左上角的按钮
 *
 *  @param text                文字
 *  @param imageName           图片
 *  @param isBackBarButtonItem 是否是返回按钮
 *
 *  @return <#return value description#>
 */
- (nullable UIBarButtonItem *)leftButtonItemWithTitle:(nullable NSString *)text image:(nullable NSString *)imageName isBackBarButtonItem:(BOOL)isBackBarButtonItem;

/**
 *  创建导航右上角按钮
 *
 *  @param text 按钮的文字
 *
 *  @return <#return value description#>
 */
- (nullable UIBarButtonItem *)rightButtonItemWithTitle:(nullable NSString *)text;

/**
 *  创建导航右上角按钮
 *
 *  @param imageName 按钮的图片
 *
 *  @return <#return value description#>
 */
- (nullable UIBarButtonItem *)rightButtonItemWithImage:(nullable NSString *)imageName;

- (void)leftBtnClick:(nullable UIBarButtonItem *)leftButtonItem;//左边按钮点击事件
- (void)righBtnClick:(nullable UIBarButtonItem *)rightButtonItem;//右边按钮点击事件

// 默认返回为YES,表示支持右滑返回
- (BOOL)gestureRecognizerShouldBegin;

/**
 *  设置标题的颜色
 *
 *  @param color <#color description#>
 */
-(void)setTitleColor:(nullable UIColor *)color;





@end
