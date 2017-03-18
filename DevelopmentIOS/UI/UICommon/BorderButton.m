//
//  MyButton.m
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/22.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import "BorderButton.h"

@implementation BorderButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
}
@end
