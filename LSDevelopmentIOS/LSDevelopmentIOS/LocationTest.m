//
//  LocationTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LocationTest.h"
#import "LSDevelopmetIOS.h"
@interface LocationTest ()

@end

@implementation LocationTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 64, 260, 500);
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    [[ReverseGeocodeLocation sharedReverseGeocodeLocation] getLocation:^(NSDictionary *adress, NSString *cityName, CLLocation *location) {
        NSString *text = [NSString stringWithFormat:@"城市名:%@\n地址:%@\n坐标:%@",cityName,adress,location];
        label.text = text;
    }];
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
