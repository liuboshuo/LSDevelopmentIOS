
//
//  LSTestFirstViewController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSFirstViewController.h"
#import "LSSecondViewController.h"
#import "LSDevelopmetIOS.h"

@interface LSFirstViewController ()

@property(nonatomic , weak)UIButton *button;

@property(nonatomic , weak)UIImageView *imageView;

@property(nonatomic , weak)UIButton *button0;

@end

@implementation LSFirstViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self add];
    [NotificationCenter addObserver:self selector:@selector(refreshCurrentSkin:) name:LSNotificationRefreshAllSkin object:nil];
    self.navigationItem.leftBarButtonItem = [self leftButtonItemWithTitle:@"返回" isBackBarButtonItem:NO];
    self.navigationItem.rightBarButtonItem = [self rightButtonItemWithTitle:@"侧滑"];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.sideMenuViewController.backgroundImage = [UIImage imageWithColor:[UIColor redColor]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.sideMenuViewController.backgroundImage = [UIImage imageWithColor:[UIColor clearColor]];
}
-(void)add
{
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(20, 100, 200, 60);
    [button setTitle:@"点击进入第二个页面" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.button = button;
    
    
    UIButton *button2 = [[UIButton alloc] init];
    button2.frame = CGRectMake(20, 200, 200, 60);
    [button2 setTitle:@"换皮肤" forState:UIControlStateNormal];
    
    [button2 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        if ([LSSkinMananger sharedLSSkinMananger].currentSkinType == LSSkinManangerDefalut) {
            [[LSSkinMananger sharedLSSkinMananger] setCurrentSkinType:LSSkinManangerNight];
        }else{
            [[LSSkinMananger sharedLSSkinMananger] setCurrentSkinType:LSSkinManangerDefalut];
        }
        [NotificationCenter postNotificationName:LSNotificationRefreshAllSkin object:nil];
    }];
    [self.view addSubview:button2];
    self.button0 = button2;
    
    
    [self refreshCurrentSkin:nil];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[LSSkinMananger imageNamed:@"0"]];
    imageView1.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:imageView1];
    self.imageView = imageView1;
    
}

-(void)refreshCurrentSkin:(NSNotification *)notification
{
    self.imageView.image = [LSSkinMananger imageNamed:@"0"];
    
    [self.button setTitleColor:[LSSkinMananger colorNamed:@"Btn_bg_Color"] forState:UIControlStateNormal];
    [self.button setBackgroundColor:[LSSkinMananger colorNamed:@"Btn_text_Color"]];
    
    [self.button0 setTitleColor:[LSSkinMananger colorNamed:@"Btn_bg_Color"] forState:UIControlStateNormal];
    [self.button0 setBackgroundColor:[LSSkinMananger colorNamed:@"Btn_text_Color"]];
    self.view.backgroundColor = [LSSkinMananger colorNamed:@"Page_color"];
    
    if (notification) {
        self.sideMenuViewController.backgroundImage = [UIImage imageWithColor:[UIColor purpleColor]];
    }
}
-(void)buttonClick
{
    LSSecondViewController *vc= [[LSSecondViewController alloc] init];
    vc.title = @"二";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)leftBtnClick:(UIBarButtonItem *)leftButtonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)righBtnClick:(UIBarButtonItem *)rightButtonItem
{
    if ([self.sideMenuViewController respondsToSelector:@selector(presentLeftMenuViewController)]) {
        [self presentLeftMenuViewController:nil];
    }
}
@end
