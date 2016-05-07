//
//  LSVideoTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/26.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSVideoTest.h"
#import "LSDevelopmetIOS.h"

@interface LSVideoTest ()

@end
@implementation LSVideoTest
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(10, 100, 50, 20);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
    }];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
}

@end
