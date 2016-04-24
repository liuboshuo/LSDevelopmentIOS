//
//  ProgressView.m
//  LSZhiHuNews
//
//  Created by 刘硕 on 15/12/20.
//  Copyright © 2015年 刘硕. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView{
    CAShapeLayer *circleLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        circleLayer = [[CAShapeLayer alloc] init];
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeColor = [UIColor grayColor].CGColor;
        circleLayer.lineWidth = 10.0f;
        circleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width / 2, frame.size.height / 2) radius:frame.size.width / 2 -self.width startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
        circleLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:circleLayer];
    }
    return self;
}

-(void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    circleLayer.strokeColor = strokeColor.CGColor;
}

-(void)setWidth:(CGFloat)width
{
    _width = width;
    circleLayer.lineWidth = _width;
    circleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.frame.size.width / 2 - self.width startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
}
-(void)loadingAnimation
{
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    
    group.animations = @[strokeStartAnimation,strokeEndAnimation];
    group.repeatCount = MAXFLOAT;
    group.duration = 2.4;
    [circleLayer addAnimation:group forKey:nil];
}

-(void)stop
{
    
    [circleLayer removeAllAnimations];
    
    [self removeFromSuperview];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
