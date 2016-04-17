
//
//  HUDAndToastTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "HUDAndToastTest.h"
#import "LSDevelopmetIOS.h"
#import "Toast.h"
@interface HUDAndToastTest ()

@end

@implementation HUDAndToastTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"等待" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 100, 60, 50);
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [LSProjectUtils showHudHint:@"请稍后" inView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LSProjectUtils hideHud];
        });
    }];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc] init];
    [button1 setTitle:@"弹出提示" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(100, 100, 60, 50);
    [button1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [LSProjectUtils showHint:@"提示"];
    }];
    [self.view addSubview:button1];
    
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] init];
    [button2 setTitle:@"弹出提示Toast" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.frame = CGRectMake(180, 100, 150, 50);
    [button2 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [Toast showToastWithMessage:@"我是Toast" Length:TOAST_LONG ParentView:self.view];
    }];
    [self.view addSubview:button2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
