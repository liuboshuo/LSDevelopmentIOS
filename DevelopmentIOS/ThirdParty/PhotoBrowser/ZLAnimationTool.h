//
//  ZLAnimationTool.h
//  多选相册照片
//
//  Created by long on 15/11/26.
//  Copyright © 2015年 long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZLAnimationTool : NSObject

/**
 * @brief viewcontroller之间push和pop的过渡动画
 */
+ (CATransition *)animateWithType:(NSString *)type subType:(NSString *)subType duration:(CFTimeInterval)duration;


+ (CABasicAnimation *)animateWithFromValue:(id)fromValue toValue:(id)toValue duration:(CFTimeInterval)duration keyPath:(NSString *)keyPath;

/**
 * @brief 照片选择状态按钮改变动画
 */
+ (CAKeyframeAnimation *)animateWithBtnStatusChanged;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com