//
//  UIColor+Category.h
//  LSTestCategory
//
//  Created by 刘硕 on 15/12/16.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 2



@interface UIColor (Category)

/**
 *  创建一个color
 *
 *  @param color color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  使用二进制颜色值
 *
 *  @param hex   颜色的二进制值
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha;


@end
