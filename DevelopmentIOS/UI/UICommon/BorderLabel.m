//
//  MyLabel.m
//  WQWorkOrderIOS
//
//  Created by 刘硕 on 16/5/10.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "BorderLabel.h"

@implementation BorderLabel
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
