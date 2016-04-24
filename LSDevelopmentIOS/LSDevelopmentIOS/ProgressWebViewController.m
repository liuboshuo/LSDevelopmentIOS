//
//  ProgressWebViewController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/22.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "ProgressWebViewController.h"
#import "LSDevelopmetIOS.h"
@implementation ProgressWebViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(10, 100, 50, 20);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        CustomWebViewController *web = [[CustomWebViewController alloc] initProgressWebViewWithURLStr:@"http://www.baidu.com" withTitle:@"百度"];
        web.navigatemColor = [UIColor orangeColor];
        web.progressColor = [UIColor orangeColor];
        [self.navigationController pushViewController:web animated:YES];
    }];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
}

@end
