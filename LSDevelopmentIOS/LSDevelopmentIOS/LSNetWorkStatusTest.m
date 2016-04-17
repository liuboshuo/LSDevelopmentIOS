
//
//  LSNetWorkTatusTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSNetWorkStatusTest.h"
#import "LSDevelopmetIOS.h"
@interface LSNetWorkStatusTest ()

@property(nonatomic , weak)UILabel *label;
@end

@implementation LSNetWorkStatusTest

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 64, 100, 20);
    [self.view addSubview:label];
    self.label = label;
    
    [self showNetWorkStatus:[NetWorkTool sharedNetWorkTool].reachability.status];
    //    [[NetWorkTool sharedNetWorkTool] startNotifier];
    
    [[NetWorkTool sharedNetWorkTool].reachability setNotifyBlock:^(LSReachability * _Nullable reachability) {
        [self showNetWorkStatus:reachability.status];
    }];
}

-(void)showNetWorkStatus:(LSReachabilityStatus)status
{
    switch (status) {
        case LSReachabilityStatusNone:
            self.label.text = @"没网";
            break;
        case LSReachabilityStatusWiFi:
            self.label.text = @"wifi";
            break;
        case LSReachabilityStatusWWAN:
            self.label.text = @"流量";
            break;
        default:
            break;
    }
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
