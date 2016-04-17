//
//  LSView.m
//  02-下载进度
//
//  Created by 刘硕 on 15-5-6.
//  Copyright (c) 2015年 刘硕. All rights reserved.
//

#import "LSProgressView.h"

@interface LSProgressView  ()

@property(nonatomic , weak) UILabel *lab;

@end

@implementation LSProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(UILabel *)lab
{
    if (_lab == nil) {
        UILabel *la = [[UILabel alloc] init];
        CGFloat x = self.frame.size.width * 0.5;
        CGFloat y = self.frame.size.height * 0.5;
        la.center = CGPointMake(x,y);
        
        la.bounds = CGRectMake(0, 0, self.bounds.size.width - self.width , self.bounds.size.height - self.width);
        la.textAlignment = NSTextAlignmentCenter;
        [self addSubview:la];
        _lab = la;
    }
    return  _lab;
}
-(void)setProcess:(CGFloat )process
{
    _process = process;
    
    self.lab.text = [NSString stringWithFormat:@"%0.2f%%",_process*100];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ct = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGFloat r = (self.bounds.size.width - self.width) / 2;
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = startAngle + _process * M_PI * 2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
    CGContextAddPath(ct, path.CGPath);
    if (self.color) {
        CGContextSetStrokeColorWithColor(ct, self.color.CGColor);
    }
    if (_width > 0) {
        CGContextSetLineWidth(ct, self.width);
    }
    
    CGContextStrokePath(ct);
}


@end
