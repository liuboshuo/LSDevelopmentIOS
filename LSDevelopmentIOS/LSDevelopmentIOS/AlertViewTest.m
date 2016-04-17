

//
//  AlertViewTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "AlertViewTest.h"
#import "LSDevelopmetIOS.h"
@interface AlertViewTest ()<LSAlertViewDelegate>

@property(nonatomic , strong)LSAlertView *alertView;

@end

@implementation AlertViewTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        LSAlertView *alertViewTools = [LSAlertViewTools alertViewWithText:@"世纪东方水库附近呢" title:@"测试" animated:YES imageName:@"111" toView:self.view type:LSShowViewModelOk];
        self.alertView = alertViewTools;
        self.alertView.delegate = self;
    }];
    [self.view addSubview:button];
}

-(void)alertView:(LSAlertView *)alertView didClickWithIndex:(NSUInteger)index type:(LSShowViewModelType)type
{
    NSLog(@"--------%d",index);
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
