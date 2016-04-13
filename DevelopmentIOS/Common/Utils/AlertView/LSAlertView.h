//
//  LSAlertView.h
//  CGV电影购票
//
//  Created by 刘硕 on 15/12/11.
//  Copyright (c) 2015年 lck. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    LSShowViewModelCancle,
    
    LSShowViewModelOk,
    
    LSShowViewModelBoth
    
} LSShowViewModelType;

@class LSAlertView;


@protocol LSAlertViewDelegate<NSObject>

-(void)alertView:(LSAlertView *)alertView didClickWithIndex:(NSUInteger)index type:(LSShowViewModelType)type;


@end

typedef void(^alertButtonClick)(LSAlertView *alertView,NSUInteger index, LSShowViewModelType type);

@interface LSAlertView : UIView

@property(nonatomic , assign)CGFloat maxHeight;
/**
 *  标题
 */
@property(nonatomic , copy)NSString *alertViewTitle;

/**
 *  弹出框的图片地址
 */
@property(nonatomic , copy)NSString *imageURL;
/**
 *  弹出框的正文
 */
@property(nonatomic , copy)NSString *alertViewText;
@property(nonatomic , assign)id<LSAlertViewDelegate> delegate;
@property(nonatomic , copy)alertButtonClick block;
-(instancetype)initWithType:(LSShowViewModelType)type;
-(void)show;
-(void)hide;
@end
