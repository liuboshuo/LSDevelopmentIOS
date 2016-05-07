//
//  UIAlertView+Block.h
//  AlertViewTest
//
//  Created by 刘硕 on 16/5/3.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Block)<UIAlertViewDelegate>

@property(nonatomic , copy)void (^completion)(NSInteger index,UIAlertView *alertView);
@property(nonatomic , copy)void (^willDismissBlock)(NSInteger buttonIndex,UIAlertView *alertView);
@property(nonatomic ,copy)void (^didPresentBlock)(UIAlertView *alertView);

@property(nonatomic , copy)void (^willPresentBlock)(UIAlertView *alertView);
@property(nonatomic , copy)void (^alertViewCancleBlock)(UIAlertView *alertView);


+(UIAlertView *(^)())alertView;
-(UIAlertView *(^)(NSString *))setMessage;
-(UIAlertView *(^)(NSString *))setTitle;
-(UIAlertView *(^)(NSArray <NSString*> *))setTitles;

-(UIAlertView *(^)(UIAlertViewStyle alertViewStyle))setAlertViewStyle;

-(UIAlertView *)addClickedButton:(void (^)(NSInteger index,UIAlertView *alertView))didclicked;
@end
