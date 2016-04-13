//
//  CALayer+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/8.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CALayer (Category)

/**
 *  Layer截图
 *
 *  @return <#return value description#>
 */
- (UIImage *)snapshotImage;

/**
 *  Layer添加一个阴影效果
 *
 *  @param color  阴影的色值
 *  @param offset 偏移
 *  @param radius 半径
 */
- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

- (void)removeAllSublayers;

/**
 *  layer的大小
 */
@property(nonatomic , assign , readwrite)CGSize size;

/**
 *  layer的位置
 */
@property(nonatomic , assign , readwrite)CGPoint origin;

/**
 *  x
 */
@property(nonatomic , assign , readwrite)CGFloat x;

/**
 *  y
 */
@property(nonatomic , assign , readwrite)CGFloat y;
/**
 *  宽
 */
@property(nonatomic , assign , readwrite)CGFloat width;
/**
 * 高
 */
@property(nonatomic , assign , readwrite)CGFloat height;
/**
 *  中点
 */
@property (nonatomic) CGPoint center;
/**
 *  中点X
 */
@property(nonatomic , assign , readwrite)CGFloat centerX;
/**
 *  中点Y
 */
@property(nonatomic , assign , readwrite)CGFloat centerY;

/**
 *  下边的Y
 */
@property(nonatomic , assign,readwrite)CGFloat bottomY;
/**
 *  最大X
 */
@property(nonatomic , assign,readwrite)CGFloat rightX;
/**
 * 旋转动画 tranform.rotation
 */
@property (nonatomic) CGFloat transformRotation;


/**
 * 旋转动画 tranform.rotation.x
 */
@property (nonatomic) CGFloat transformRotationX;

/**
 * 旋转动画 tranform.rotation.y
 */
@property (nonatomic) CGFloat transformRotationY;

/**
 * 旋转动画 tranform.rotation.z
 */
@property (nonatomic) CGFloat transformRotationZ;

/**
 *  缩放动画 tranform.scale
 */
@property (nonatomic) CGFloat transformScale;

/**
 *  缩放动画 tranform.scale.x
 */
@property (nonatomic) CGFloat transformScaleX;

/**
 *  缩放动画 tranform.scale.y
 */
@property (nonatomic) CGFloat transformScaleY;

/**
 *  位移动画 tranform.scale.z
 */
@property (nonatomic) CGFloat transformScaleZ;

/**
 *  位移动画 tranform.translation.x
 */
@property (nonatomic) CGFloat transformTranslationX;

/**
 *  位移动画 tranform.translation.y
 */
@property (nonatomic) CGFloat transformTranslationY;

/**
 *  位移动画 tranform.translation.z
 */
@property (nonatomic) CGFloat transformTranslationZ;

/**
 *  添加淡入淡出动画
 *
 *  @param duration <#duration description#>
 *  @param curve    <#curve description#>
 */
- (void)addFadeAnimationWithDuration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve;

/**
 *  移除淡入淡出动画
 */
- (void)removePreviousFadeAnimation;


@end
