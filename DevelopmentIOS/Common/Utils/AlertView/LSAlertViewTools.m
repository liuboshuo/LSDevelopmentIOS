//
//  AlertViewTools.m
//  CGV电影购票
//
//  Created by 刘硕 on 15/12/14.
//  Copyright (c) 2015年 lck. All rights reserved.
//

#import "LSAlertViewTools.h"
#import "LSAlertView.h"
#import "UIPropertyConstant.h"

@interface LSAlertViewTools ()<LSAlertViewDelegate>

@end
@implementation LSAlertViewTools

+(LSAlertView *)alertViewWithText:(NSString *)text title:(NSString *)title animated:(BOOL)animated imageName:(NSString *)imageName toView:(UIView *)view type:(LSShowViewModelType)type
{
    LSAlertView *alertView = [[LSAlertView alloc] initWithType:type];
    alertView.alertViewText = text;
    alertView.alertViewTitle = title;
    alertView.frame = UICurrentWindow.bounds;
    alertView.delegate = self;
    alertView.imageURL = imageName;
    [alertView show];
    [UICurrentWindow addSubview:alertView];
    
    return alertView;
    
}
+(void)alertViewWithContent:(NSString *)text title:(NSString *)title animated:(BOOL)animated imageName:(NSString *)imageName toView:(UIView *)view type:(LSShowViewModelType)type
{
    [self alertViewWithText:text title:title animated:animated imageName:imageName toView:view type:type];
}

-(void)alertView:(LSAlertView *)alertView didClickWithIndex:(NSUInteger)index type:(LSShowViewModelType)type
{
    if ([self.delegate respondsToSelector:@selector(btnClick:)]) {
        [self.delegate btnClick:index];
    }
}
@end
