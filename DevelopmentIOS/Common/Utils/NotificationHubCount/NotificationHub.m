
//
//  NotificationHub.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/26.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "NotificationHub.h"
#import "LSDevelopmetIOS.h"

@interface NotificationHub ()

@property(nonatomic , weak)UILabel *label;
@property(nonatomic , copy)NSString *countString;

@end
@implementation NotificationHub

-(instancetype)initWithPoint:(CGPoint)point
{
    if (self = [super init]) {
        self.origin = point;
        [self initView];
    }
    return self;
}

-(void)setCount:(NSInteger)count
{
    _count = count;
    if (count <= 0) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
        if (count >= 100) {
            self.countString = @"99+";
        }else{
            self.countString = [NSString  stringWithFormat:@"%ld", count];
        }
    }
}
-(void)setCountString:(NSString *)countString
{
    _countString = countString;
    CGSize size = [SizeTool sizeWithText:_countString font:self.label.font];
    
    if (size.width > size.height) {
        
        if (_count >= 100) {
            CGFloat padding = 1;
            _label.width = size.width + 2 * padding;
            _label.height = size.height + 2 * padding;
            _label.x = 0;
            _label.y = 0;
            self.layer.cornerRadius = 10;
            self.frame = CGRectMake(self.x, self.y,_label.width, _label.height);
        }else{
            
            CGFloat padding = 3;
            _label.width = size.width + padding;
            _label.height = size.width + padding;
            _label.x = 0;
            _label.y = 0;
            
            self.frame = CGRectMake(self.x, self.y,_label.width, _label.height);
            self.layer.cornerRadius = self.width / 2;
        }
        
        
    }else{
        CGFloat padding = 3;
        _label.width = size.height + padding;
        _label.height = size.height + padding;
        _label.x = 0;
        _label.y = 0;
        
        self.frame = CGRectMake(self.x, self.y, _label.width, _label.height);
        self.layer.cornerRadius = self.width / 2;
    }
    
    self.label.text = countString;
}
-(void)awakeFromNib
{
    [self initView];
}

-(void)initView
{
    
    self.backgroundColor = [UIColor redColor];
    self.clipsToBounds = YES;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _label = label;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
