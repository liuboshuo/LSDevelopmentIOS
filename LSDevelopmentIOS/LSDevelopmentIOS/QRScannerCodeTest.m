
//
//  QRCodeController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "QRScannerCodeTest.h"

@interface QRScannerCodeTest ()<QRCodeViewAction>

@property(nonatomic , strong)QRCodeView *qrCodeView;

@end

@implementation QRScannerCodeTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.qrCodeView = [[QRCodeView alloc] init];
    [self.view addSubview:_qrCodeView];
    _qrCodeView.delegate = self;
    [_qrCodeView beginScanning];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
}

-(void)qrCodeView:(QRCodeView *)QRcodeView value:(NSString *)stringValue
{
    NSLog(@"扫描结果%@",stringValue);
    
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
