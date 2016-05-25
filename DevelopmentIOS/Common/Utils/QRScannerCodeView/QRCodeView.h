//
//  QRCodeView.h
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/4/6.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


/**
 
 二维码扫描的使用
 self.qrCodeView = [[QRCodeView alloc] init];
 [self.view addSubview:_qrCodeView];
 _qrCodeView.delegate = self;
 [_qrCodeView beginScanning];
 self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
 */

@class QRCodeView;

@protocol QRCodeViewAction <NSObject>


-(void)qrCodeView:(QRCodeView *)QRcodeView value:(NSString *)stringValue;

@end
@interface QRCodeView : UIView

@property (strong,nonatomic)AVCaptureSession * session;

@property(nonatomic , assign)id<QRCodeViewAction> delegate;


/**
 *  回复动画
 */
-(void)resumeAnimation;

/**
 *  开始扫描
 */
-(void)beginScanning;

@end
