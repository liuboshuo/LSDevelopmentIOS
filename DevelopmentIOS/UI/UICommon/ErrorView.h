//
//  ErrorView.h
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/16.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^errorViewTap)();

@protocol ErrorViewDelegate <NSObject>

@optional
-(void)errorViewTouch;

@end
/**
 *  发送网络请求出错,和没有记录的时候等等
 */
@interface ErrorView : UIView

/**
 *  出错提示的文字
 */
@property(nonatomic,copy)NSString *errorText;
/**
 *  出错提示的图片名称
 */
@property(nonatomic,copy)NSString *errorImageName;


/**
 *  错误用户点击屏幕
 */
@property(nonatomic , copy)errorViewTap tap;

@property(nonatomic , assign)id<ErrorViewDelegate> delegate;

@end
