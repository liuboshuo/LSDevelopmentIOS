//
//  TabBarItem.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/6/1.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSTabBarItem.h"

@implementation LSTabBarItem
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.65;
    return CGRectMake(0, 5, imageW, imageH)
    ;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * 0.65;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}
@end
