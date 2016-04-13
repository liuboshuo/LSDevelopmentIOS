//
//  UIView+Extension.m
//
//  Created by 刘硕 on 15-6-22.
//  Copyright (c) 2015年 刘硕. All rights reserved.
//

#import "UIView+Extension.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIView (Extension)

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGSize)size{
    
    
    return self.frame.size;
}

-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
-(CGPoint)origin{
    
    
    return self.frame.origin;
}

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(CGFloat)x{
    
    
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}
-(CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}
-(CGFloat)centerY
{
    return self.center.y;
}
-(CGFloat)bottomY
{
    return self.frame.origin.y + self.frame.size.height;
}
-(CGFloat)rightX{
    return self.frame.origin.x + self.frame.size.width;
}
-(void)setRightX:(CGFloat)rightX
{
    CGRect frame = self.frame;
    frame.origin.x = rightX - frame.size.width;
    self.frame = frame;
}
-(void)setBottomY:(CGFloat)bottomY
{
    CGRect frame = self.frame;
    frame.origin.y = bottomY - frame.size.height;
    self.frame = frame;
}

-(UIImage *)snapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

-(UIViewController *)viewController
{
    for (UIView *v = self; v; v = v.superview) {
        UIResponder *nextResponder = [v nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(NSData *)snapshotPDF
{
    CGRect bounds = self.bounds;
    NSMutableData *mutabledata = [NSMutableData data];
    CGDataConsumerRef consum = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)mutabledata);
    CGContextRef context = CGPDFContextCreate(consum, &bounds, NULL);
    CGDataConsumerRelease(consum);
    if (!context) {
        return nil;
    }
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return mutabledata;
}


-(void)setLayerShow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
-(void)removeAllSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}

-(CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view
{
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        }else{
            return [self convertPoint:point toView:nil];
        }
    }
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to) ) {
        return [self convertPoint:point toView:view];
    }
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}
-(CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view
{
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        }else{
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) {
        return [self convertPoint:point fromView:view];
    }
    
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

-(CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view
{
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        }else{
            return [self convertRect:rect toView:nil];
        }
    }
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}
-(CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view
{
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        }else{
            [self convertRect:rect fromView:nil];
        }
    }
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

@end
