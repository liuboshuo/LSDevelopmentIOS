//
//  CommonViewController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/6.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "CommonViewController.h"
#import "LSBarButtonItem.h"
#import "LSSkinMananger.h"
@implementation CommonViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        /**
         *  默认是系统
         *  设置系统的返回按钮
         */
        self.customBackItem = NO;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}
-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    if ([LSSkinMananger isUseSKin]) {
        [self setTitleColor:[LSSkinMananger colorNamed:@"Nav_title_Color"]];
    }
}

-(void)setBackBarButtonItemWithTitle:(NSString *)text
{
    self.customBackItem = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(UIBarButtonItem *)leftButtonItemWithTitle:(NSString *)text isBackBarButtonItem:(BOOL)isBackBarButtonItem
{
    return [self leftButtonItemWithTitle:text image:nil isBackBarButtonItem:isBackBarButtonItem];
}
-(UIBarButtonItem *)leftButtonItemWithImage:(NSString *)imageName isBackBarButtonItem:(BOOL)isBackBarButtonItem
{
    return [self leftButtonItemWithTitle:nil image:imageName isBackBarButtonItem:isBackBarButtonItem];
}

-(UIBarButtonItem *)leftButtonItemWithTitle:(NSString *)text image:(NSString *)imageName isBackBarButtonItem:(BOOL)isBackBarButtonItem
{
    self.customBackItem = YES;
    if (!_leftButtonItem) {
        _leftButtonItem = [LSBarButtonItem itemWithTitle:text image:imageName isBackButtonItem:isBackBarButtonItem target:self action:@selector(leftBtnClick:)];
    }
    return _leftButtonItem;
}


-(UIBarButtonItem *)rightButtonItemWithTitle:(NSString *)text
{
    if (!_rightButtonItem)
    {
        _rightButtonItem = [LSBarButtonItem itemWithTitle:text isBackButtonItem:NO target:self action:@selector(righBtnClick:)];
    }
    return _rightButtonItem;
}

-(UIBarButtonItem *)rightButtonItemWithImage:(NSString *)imageName
{
    if (!_rightButtonItem) {
        _rightButtonItem = [LSBarButtonItem itemWithImage:imageName isBackButtonItem:NO target:self action:@selector(righBtnClick:)];
    }
    return _rightButtonItem;
}


- (void)leftBtnClick:(UIBarButtonItem *)leftButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)righBtnClick:(UIBarButtonItem *)rightButtonItem
{
    //防止编译器提示，只需在子类重写就OK
}

- (BOOL)gestureRecognizerShouldBegin {
    return YES;
}

-(void)setTitleColor:(UIColor *)color
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,nil]];
}

@end
