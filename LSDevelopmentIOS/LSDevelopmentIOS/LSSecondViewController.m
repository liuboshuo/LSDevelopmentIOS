
//
//  LSSecondViewController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSSecondViewController.h"
//#import "LSProjectUtils.h"
@interface LSSecondViewController ()

@property(nonatomic , strong)UIButton *button;


@end
@implementation LSSecondViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [self leftButtonItemWithTitle:@"返回" image:@"nav_back_white" isBackBarButtonItem:YES];
    
    
    [NotificationCenter addObserver:self selector:@selector(refreshCurrentSkin:) name:LSNotificationRefreshAllSkin object:nil];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[LSSkinMananger imageNamed:@"1"]];
    imageView1.frame = CGRectMake(0, 0, 100, 120);
    [self.view addSubview:imageView1];
    
    
    //测试
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 160, 200, 60);
    [button setTitle:@"皮肤" forState:UIControlStateNormal];
    [self.view addSubview:button];
    self.button = button;
    [self refreshCurrentSkin:nil];
    
}
-(void)buttonClick
{
    LSSecondViewController *vc= [[LSSecondViewController alloc] init];
    vc.title = @"二";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshCurrentSkin:(NSNotification*)notification
{
    [_button setBackgroundColor:[LSSkinMananger colorNamed:@"Btn_text_Color"]];
    [_button setTitleColor:[LSSkinMananger colorNamed:@"Btn_bg_Color"] forState:UIControlStateNormal];
    self.view.backgroundColor = [LSSkinMananger colorNamed:@"Page_color"];
    
}
@end
