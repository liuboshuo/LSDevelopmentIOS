//
//  Toast.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Toast : UIView

typedef NS_ENUM(NSInteger, TOAST_LENGTH) {
    TOAST_SHORT = 1,
    TOAST_MIDDLE = 2,
    TOAST_LONG = 3
}NS_ENUM_AVAILABLE_IOS(6_0);

+ (void)showToastWithMessage:(NSString*)mesage Length:(TOAST_LENGTH)length ParentView:(UIView*)view;

+ (UIView*)ToastView;

+ (void)TimerOver:(NSTimer*)sender;

@end
