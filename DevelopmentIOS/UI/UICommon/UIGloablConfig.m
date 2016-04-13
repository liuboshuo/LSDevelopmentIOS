//
//  LSUIGloablConfig.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "UIGloablConfig.h"
#import "LSDevelopmetIOS.h"
@implementation UIGloablConfig


+(NSDictionary *)getConfigs
{
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:LSUIPropertyConfigFile ofType:nil]];
}

+(UIColor *)getColorWithKey:(NSString *)key
{
    NSDictionary *propertyConfigDictionary = [self getConfigs];
    
    NSString *colorS = propertyConfigDictionary[LSUIGloablTheme];
    if (colorS) {
        NSArray *colors = [colorS componentsSeparatedByString:@","];
        if (colors.count >= 4) {
            UIColor *globalColor = Color([colors[0] floatValue], [colors[1] floatValue], [colors[2] floatValue], [colors[3] floatValue]);
            return globalColor;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
    
    //判断是否为空，若有空设置主体颜色，不为空不设置主体颜色
    
    return nil;
}
/**
 *  用来配置主体颜色
 *
 *  @return <#return value description#>
 */
+(UIColor *)configGlobalColor
{
    //获取配置文件的主题颜色
    
    UIColor *globalColor = [self getColorWithKey:LSUIGloablTheme];
    //判断是否为空，若有空设置主体颜色，不为空不设置主体颜色
    if (globalColor) {
        
        [self configGlobalColorWithColor:globalColor];
        
        //返回颜色
        return globalColor;
    }
    return nil;
}

+(UIColor *)configGlobalColorWithColor:(UIColor *)color
{
    if (color == nil) {
        return nil;
    }
    
    [self configNavigationBarWithColor:color];
    
    [self configTabBarWithColor:color];
    
    [self configTableViewWithColor:color];
    
    [self configSearchBarWithColor:color];
    
    return color;
}
+(UIColor *)configNavigationBar
{
    //获取配置文件的主题颜色
    
    UIColor *globalColor = [self getColorWithKey:LSUIGloablTheme];
    //判断是否为空，若有空设置主体颜色，不为空不设置主体颜色
    if (globalColor) {
        
        //返回颜色
        return [self configNavigationBarWithColor:globalColor];
    }
    return nil;
}
+(UIColor *)configNavigationBarWithColor:(UIColor *)color
{
    if (color == nil) {
        return nil;
    }
    [[UINavigationBar appearance] setBarTintColor:color];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [UINavigationBar appearance].translucent = NO;
        [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].shadowImage = [[UIImage alloc] init];
    return color;
}

+(UIColor *)configTabBar
{
    //获取配置文件的主题颜色
    UIColor *globalColor = [self getColorWithKey:LSUIGloablTheme];
    //判断是否为空，若有空设置主体颜色，不为空不设置主体颜色
    if (globalColor) {
        //返回颜色
        return [self configTabBarWithColor:globalColor];
    }
    return nil;
}
+(UIColor *)configTabBarWithColor:(UIColor *)color
{
    if (color) {
        [UITabBar appearance].tintColor = color;
    }
    return color;
}

+(UIColor *)configTableView
{
    //获取配置文件的主题颜色
    UIColor *globalColor = [self getColorWithKey:LSUIGloablTheme];
    //判断是否为空，若有空设置主体颜色，不为空不设置主体颜色
    if (globalColor) {
        //返回颜色
        return [self configTableViewWithColor:globalColor];
    }
    return nil;
}
+(UIColor *)configTableViewWithColor:(UIColor *)color
{
    if (color == nil) {
        return nil;
    }
    [UITableView appearance].tintColor = color;
    return color;
}
+(UIColor *)configSearchBar
{
    //获取配置文件的主题颜色
    UIColor *globalColor = [self getColorWithKey:LSUIGloablTheme];
    //判断是否为空，若有空设置主体颜色，不为空不设置主体颜色
    if (globalColor) {
        //返回颜色
        return [self configSearchBarWithColor:globalColor];
    }
    return nil;
}

+(UIColor *)configSearchBarWithColor:(UIColor *)color
{
    if (color == nil) {
        return nil;
    }
    [UISearchBar appearance].tintColor = color;
    return color;
}
@end
