//
//  SizeTool.m
//  besttoneMobile
//
//  Created by 刘硕 on 15/9/10.
//  Copyright (c) 2015年 Besttone. All rights reserved.
//

#import "SizeTool.h"

@implementation SizeTool


+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font w:(CGFloat)w
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(w, MAXFLOAT);
    
    return [text boundingRectWithSize:maxSize options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil].size;
}


+(CGSize )sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font w:MAXFLOAT];
}


@end
