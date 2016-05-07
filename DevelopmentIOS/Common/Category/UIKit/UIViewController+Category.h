//
//  UIViewController+Category.h
//  LSTestCategory
//
//  Created by 刘硕 on 15/12/16.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Category)

typedef NS_ENUM(NSUInteger , HiddenControlOption){
    HiddenControlOptionLeft = 0x01,
    HiddenControlOptionTitle = 0x01 << 1,
    HiddenControlOptionRight = 0x01 << 2
};

/**
 *  视图控制器隐藏键盘
 */
-(void)setupForDismissKeyboard;

/**
 *  导航
 *
 *  @param nullable  <#nullable description#>
 *  @param nonatomic <#nonatomic description#>
 *  @param strong    <#strong description#>
 *
 *  @return <#return value description#>
 */
/**
 *  导航左上角的按钮
 */
@property(nullable , nonatomic , strong)UIBarButtonItem *leftButtonItem;

/**
 *  导航右上角的按钮
 */
@property(nullable , nonatomic , strong)UIBarButtonItem *rightButtonItem;


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

/**
 *  配合ScrollView使用
 */
- (void)setScrollVew:(UIScrollView *)scrollView scrollOffsetY:(CGFloat)scrollOffsetY options:(HiddenControlOption)options;

- (void)setInViewWillAppear;
- (void)setInViewWillDisappear;

@end
