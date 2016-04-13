//
//  LSUIGloablConfig.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPropertyConstant.h"
/**
 *  配置UI的全局
 */
@interface UIGloablConfig : NSObject

/**
 *  配置全局主题颜色
 */
+(UIColor*)configGlobalColor;
+(UIColor*)configGlobalColorWithColor:(UIColor *)color;


/**
 *  配置导航
 *
 *  @return <#return value description#>
 */
+(UIColor *)configNavigationBar;
+(UIColor *)configNavigationBarWithColor:(UIColor *)color;

/**
 *  配置tableView
 *
 *  @return <#return value description#>
 */
+(UIColor *)configTableView;
+(UIColor *)configTableViewWithColor:(UIColor *)color;

/**
 *  配置searchBar
 *
 *  @return <#return value description#>
 */
+(UIColor *)configSearchBar;
+(UIColor *)configSearchBarWithColor:(UIColor *)color;

/**
 *  配置选项卡
 *
 *  @return <#return value description#>
 */
+(UIColor *)configTabBar;
+(UIColor *)configTabBarWithColor:(UIColor *)color;

@end
