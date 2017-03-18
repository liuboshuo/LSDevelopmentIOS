//
//  BorderView.m
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/20.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import "BorderView.h"

@implementation BorderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerRadius];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setcornerRadius];
}

/**
 *  设置圆角属性等
 */
-(void)setcornerRadius
{
    if(self.height > 10){
        self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.layer.borderWidth = 1.5;
    }
    self.layer.cornerRadius = 10;
}

@end
