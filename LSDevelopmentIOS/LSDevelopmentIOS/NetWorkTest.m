//
//  NetWorkTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "NetWorkTest.h"

#import "LSDevelopmetIOS.h"
@interface NetWorkTest ()

@end

@implementation NetWorkTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     *  GET
     */
    //    [NetWorkManager updateBaseURL:@"http://apis.baidu.com"];
    //    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //    dictionary[@"area"] = @"北京";
    //    [NetWorkManager configCommonHttpHeaders:@{@"apikey":@"ecc213f67a1616fbca00358b9b9d3480"}];
    //    [NetWorkManager postWithUrl:@"/showapi_open_bus/weather_showapi/areaid" params:dictionary success:^(id response) {
    //        NSLog(@"%@",response);
    //    } fail:^(NSError *error) {
    //        NSLog(@"%@",error);
    //    }];
    
    
    /**
     *  POST
     */
    [NetWorkManager updateBaseURL:@"http://121.196.228.152:8080"];
    [NetWorkManager postWithUrl:@"/SCFinance/mobile/product/findFinanceProductList" params:@{@"city":@""} success:^(id response) {
        NSLog(@"%@",response);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
