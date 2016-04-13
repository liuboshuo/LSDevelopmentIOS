//
//  UIBezierPath+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/8.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Category)

/**
 *  创建路径
 *
 *  @param text 文字
 *  @param font 字体
 *
 *  @return 路径
 */
+ (nullable UIBezierPath *)bezierPathWithText:(nullable NSString *)text font:(nullable UIFont *)font;

@end
