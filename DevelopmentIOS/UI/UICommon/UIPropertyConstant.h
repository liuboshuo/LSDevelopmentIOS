//
//  LSLSUIPropertyConstant.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>





#define globalUIColor Color(240, 50.0, 50.0,1.0)


// RGB颜色
#define Color(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// 随机色
#define RandomColor LSColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// ios7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// ios8
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
// ios9
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

// 偏好
#define UserDefaults [NSUserDefaults standardUserDefaults]

// 通知中心
#define NotificationCenter [NSNotificationCenter defaultCenter]

//屏幕宽
#define UIScreenWidth [UIScreen mainScreen].bounds.size.width

// 屏幕高
#define UIScreenHeight [UIScreen mainScreen].bounds.size.height

//应用的当前窗口
#define UICurrentWindow [[[UIApplication sharedApplication] windows] lastObject]





/**
 *  常量的设置和定义的常量
 */
@interface UIPropertyConstant : NSObject



//配置文件
extern NSString *const LSUIPropertyConfigFile;

//全局颜色
extern NSString *const LSUIGloablTheme;

//对应的Tab的key
extern NSString *const LSUITabBarUI;

//每个选项卡对应的类名
extern NSString *const LSUITabBarUITabBarUIController;

//每个选项卡对应的图片和文字
extern NSString *const LSUITabBarUITabBarUIControllerNormalImage;

extern NSString *const LSUITabBarUITabBarUIControllerSelectImage;
//对应需要去显示的标题
extern NSString *const LSUITabBarUITabBarUIControllerShowTitle;










@end
