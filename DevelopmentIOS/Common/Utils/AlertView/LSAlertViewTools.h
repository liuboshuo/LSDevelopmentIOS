//
//  AlertViewTools.h
//  CGV电影购票
//
//  Created by 刘硕 on 15/12/14.
//  Copyright (c) 2015年 lck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSAlertView.h"

@protocol LSAlertViewToolsDelegate <NSObject>

-(void)btnClick:(NSInteger)buttonIndex;

@end

/**
 *
 带图片弹出框的使用:
 只支持一张本地图片(后期扩张网络图片和多张图片的使用信息)
 LSAlertView *alertViewTools = [LSAlertViewTools alertViewWithText:@"世纪东方水库附近呢" title:@"测试" animated:YES imageName:@"111" toView:self.view type:LSShowViewModelOk];
 self.alertView = alertViewTools;
 self.alertView.delegate = self;
 */
/**
 *  创建AlertView  文字 图片
 */
@interface LSAlertViewTools : NSObject


/**
 *  创建AlertView
 *
 *  @param text      文字
 *  @param title     标题
 *  @param animated  是否动画
 *  @param imageName 图片名
 *  @param view      添加到那个视图
 *  @param type      类型
 *
 *  @return <#return value description#>
 */
+(LSAlertView *)alertViewWithText:(NSString *)text title:(NSString *)title animated:(BOOL)animated imageName:(NSString *)imageName toView:(UIView *)view type:(LSShowViewModelType)type;


/**
 *  自定义AlertView
 *
 *  @param text      内容
 *  @param title     标题
 *  @param animated  是否加入
 *  @param imageName 图片名称
 *  @param view      添加视图
 *  @param type      type
 */
+(void)alertViewWithContent:(NSString *)text title:(NSString *)title animated:(BOOL)animated imageName:(NSString *)imageName toView:(UIView *)view type:(LSShowViewModelType)type;


/**
 *  回调代理
 */
@property(nonatomic , copy)id<LSAlertViewToolsDelegate> delegate;


@end
