//
//  UIAlertView+Block.m
//  AlertViewTest
//
//  Created by 刘硕 on 16/5/3.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>
@implementation UIAlertView (Block)


static const void *completionKey;
-(void)setCompletion:(void (^)(NSInteger, UIAlertView *))completion
{
    objc_setAssociatedObject(self, &completionKey, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void (^)(NSInteger, UIAlertView *))completion
{
    return objc_getAssociatedObject(self, &completionKey);
}

static const void *willDismissKey;

-(void)setWillDismissBlock:(void (^)(NSInteger, UIAlertView *))willDismissBlock
{
    objc_setAssociatedObject(self, &willDismissKey, willDismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(NSInteger, UIAlertView *))willDismissBlock
{
    return objc_getAssociatedObject(self, &willDismissKey);
}

static const void *didPresentKey;
-(void)setDidPresentBlock:(void (^)(UIAlertView *))didPresentBlock
{
    objc_setAssociatedObject(self, &didPresentKey, didPresentBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void (^)(UIAlertView *))didPresentBlock
{
    return objc_getAssociatedObject(self, &didPresentKey);
}

static const void *willPresentKey;
-(void)setWillPresentBlock:(void (^)(UIAlertView *))willPresentBlock
{
    objc_setAssociatedObject(self, &willPresentKey, willPresentBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void (^)(UIAlertView *))willPresentBlock
{
    return objc_getAssociatedObject(self, &willPresentKey);
}
+(UIAlertView *(^)())alertView{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    return ^UIAlertView *(){
        UIAlertView *alertView = [[UIAlertView alloc] init];
        return alertView;
    };
}


static const void *cankey;
-(void)setAlertViewCancleBlock:(void (^)(UIAlertView *))alertViewCancleBlock
{
    objc_setAssociatedObject(self, &cankey, alertViewCancleBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(UIAlertView *))alertViewCancleBlock
{
    return objc_getAssociatedObject(self, &cankey);
}


-(UIAlertView *(^)(NSString *))setMessage
{
    return ^UIAlertView *(NSString *message){
        self.message = message;
        return self;
    };
}

-(UIAlertView *(^)(NSString *))setTitle
{
    return ^UIAlertView *(NSString *message){
        self.title = message;
        return self;
    };
}
-(UIAlertView *(^)(NSArray<NSString *> *))setTitles
{
    return ^UIAlertView *(NSArray<NSString*> *buttons){
        for (int i = 0; i<buttons.count; i++) {
            [self addButtonWithTitle:buttons[i]];
        }
        return self;
    };
}

-(UIAlertView *)addClickedButton:(void (^)(NSInteger, UIAlertView *))didclicked
{
    self.completion = didclicked;
    self.delegate = self;
    return self;
}

-(UIAlertView *(^)(UIAlertViewStyle))setAlertViewStyle
{
    return ^UIAlertView *(UIAlertViewStyle style){
        self.alertViewStyle = style;
        return self;
    };
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completion) {
        self.completion(buttonIndex,alertView);
    }
}
@end
