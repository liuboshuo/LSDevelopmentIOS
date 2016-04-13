//
//  SizeTool.h
//  besttoneMobile
//
//  Created by 刘硕 on 15/9/10.
//  Copyright (c) 2015年 Besttone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SizeTool : NSObject

/**
 *  计算文字的尺寸
 *
 *  @param text 文字
 *  @param font 字体
 *  @param w    宽度
 *
 *  @return 文字的大小
 */
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font w:(CGFloat)w;


/**
 *  计算文字的大小
 *
 *  @param text 文字
 *  @param font 字体
 *
 */
+(CGSize )sizeWithText:(NSString *)text font:(UIFont *)font;

@end
