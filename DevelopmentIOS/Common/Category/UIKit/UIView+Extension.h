//
//  UIView+Extension.h
//
//  Created by 刘硕 on 15-6-22.
//  Copyright (c) 2015年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)


@property(nonatomic , assign , readwrite)CGSize size;

@property(nonatomic , assign , readwrite)CGPoint origin;

@property(nonatomic , assign , readwrite)CGFloat x;
@property(nonatomic , assign , readwrite)CGFloat y;
@property(nonatomic , assign , readwrite)CGFloat width;
@property(nonatomic , assign , readwrite)CGFloat height;
@property(nonatomic , assign , readwrite)CGFloat centerX;
@property(nonatomic , assign , readwrite)CGFloat centerY;

/**
 *  下边的Y
 */
@property(nonatomic , assign,readwrite)CGFloat bottomY;
/**
 *  最大X
 */
@property(nonatomic , assign,readwrite)CGFloat rightX;

@property(nonatomic , strong,nullable)UIViewController *viewController;


/**
 *  这个视图图片
 *
 *  @return <#return value description#>
 */
-(nullable UIImage *)snapshotImage;


/**
 *
 *
 *  @return <#return value description#>
 */
-(nullable NSData *)snapshotPDF;

/**
 *  设置边界阴影
 *
 *  @param color  颜色
 *  @param offset 偏移量
 *  @param radius
 */
-(void)setLayerShow:(nullable UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 *  移除子视图
 */
-(void)removeAllSubviews;
/**
 *  转换在自己坐标系统的位置到view的坐标系统的位置
 *
 *  @param point point
 *  @param view  目标视图
 *
 *  @return 目标位置
 */
-(CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 *  从view转换point到self的位置
 *
 *  @param point point
 *  @param view  目标视图
 *
 *  @return <#return value description#>
 */
-(CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;
/**
 *  转换在self坐标系统的位置到view的坐标系统的位置
 *
 *  @param rect rect
 *  @param view 目标视图
 *
 *  @return
 */
-(CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;
/**
 *  从view转换位置到self的位置
 *
 *  @param rect rect
 *  @param view 目标视图
 *
 *  @return <#return value description#>
 */
-(CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;
@end
