//
//  LSLSUIPropertyConstant.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "UIPropertyConstant.h"

@implementation UIPropertyConstant

/**
 *  配置文件
 */
NSString *const LSUIPropertyConfigFile = @"UIPropertyConfig.plist";

//全局主题
NSString *const LSUIGloablTheme = @"GlobalUITheme";

//全局框架
NSString *const LSUITabBarUI = @"TabBarUi";

//每个选项卡对应的类名
NSString *const LSUITabBarUITabBarUIController = @"controller";

//每个选项卡对应的图片和文字
NSString *const LSUITabBarUITabBarUIControllerNormalImage = @"normalImage";

//选中图片的值
NSString *const LSUITabBarUITabBarUIControllerSelectImage = @"selectImage";
//对应需要去显示的标题
NSString *const LSUITabBarUITabBarUIControllerShowTitle = @"title";



@end
