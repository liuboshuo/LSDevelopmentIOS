//
//  QRCodeView.m
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/4/6.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import "QRCodeView.h"
#import "UIView+Extension.h"
static const  CGFloat  kBorderWidth = 100;
static const CGFloat kMargin = 30;

@interface QRCodeView ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic , weak)UIView *maskView;
@property(nonatomic , strong)UIView *scanWindow;
@property(nonatomic , strong)UIImageView *scanNetImageView;
@property(nonatomic , weak)UIView *waitView;
@property(nonatomic , weak)UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic , weak)UILabel *titleLabel;
@end

@implementation QRCodeView

-(instancetype)initWithFrame:(CGRect)frame
{
    frame = [UIScreen mainScreen].bounds;
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        [self setupMaskView];
        [self setupTipTitleView];
        [self setupScanWindow];
        [self initActivityIndicatorView];
    }
    return self;
}

-(void)initActivityIndicatorView
{
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    view.center = self.scanWindow.center;
    view.width = 30;
    view.width = 30;
    [view startAnimating];
    [self addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"准备中...";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.width = self.width;
    titleLabel.height = 30;
    titleLabel.y = view.bottomY + 10;
    titleLabel.centerX = self.centerX;
    [self addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    
    self.activityIndicatorView = view;
    self.scanWindow.hidden = YES;
    self.scanNetImageView.hidden = YES;
}
-(void)removeActivityIndicatorView
{
    [self.activityIndicatorView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    [self.activityIndicatorView stopAnimating];
    
    self.scanWindow.hidden = NO;
    self.scanNetImageView.hidden = NO;
}
/**
 *  初始化遮盖视图
 */
-(void)setupMaskView
{
    UIView *mask = [[UIView alloc] init];
    mask.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    mask.layer.borderWidth = kBorderWidth;
    mask.width = self.width + kBorderWidth + kMargin;
    mask.height = self.width + kBorderWidth + kMargin;
    mask.centerX = self.width * 0.5;
    mask.y = 0;
    [self addSubview:mask];
    _maskView = mask;
}
/**
 *  初始化提示标题
 */
-(void)setupTipTitleView
{
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, _maskView.y + _maskView.height, self.width, kBorderWidth)];
    mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self addSubview:mask];
    //2.操作提示
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height*0.9-kBorderWidth*2, self.bounds.size.width, kBorderWidth)];
    tipLabel.text = @"将取景框对准二维码，即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipLabel.numberOfLines = 2;
    tipLabel.font=[UIFont systemFontOfSize:12];
    tipLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:tipLabel];
}
/**
 *  初始化扫描窗口的周围边界视图
 */
-(void)setupScanWindow
{
    CGFloat scanWindowHeight = self.width - kMargin * 2;
    CGFloat scanWindowWidth = self.width - kMargin * 2;
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kMargin, kBorderWidth - 4, scanWindowWidth, scanWindowHeight)];
    _scanWindow.clipsToBounds = YES;
    [self addSubview:_scanWindow];
    _scanWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    CGFloat buttonWH = 18;
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowWidth - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowHeight - buttonWH, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(topRight.x, bottomLeft.y, buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomRight];
}
/**
 *  开始
 */
-(void)beginScanning
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        if (!input) {
            /**
             *  处理错误
             */
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        CGRect scanCrop = [self getScanCrop:_scanWindow.bounds readerViewBounds:self.frame];
        
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        self.session = session;
        
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
        output.rectOfInterest = scanCrop;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self removeActivityIndicatorView];
            
            AVCaptureVideoPreviewLayer*preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
            preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            preview.frame = self.layer.bounds;
            [self.layer insertSublayer:preview atIndex:0];
            [_session startRunning];
            
            [UIView animateWithDuration:1 animations:^{
                
            }];
        });
    });
    
}

/**
 *  开始动画
 */
-(void)resumeAnimation
{
    CAAnimation *anim = [_scanNetImageView.layer animationForKey:@"translationAnimation"];
    if (anim) {
        //将动画的时间偏移量座位暂停时间
        CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
        
        //根据媒体时间计算出准确的启动动画时间,对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        
        //需把偏移时间清除
        [_scanNetImageView.layer setTimeOffset:0];
        //设置图层的开始
        [_scanNetImageView.layer setBeginTime:beginTime];
        [_scanNetImageView.layer setSpeed:1.0];
    }else{
        CGFloat scanNetImageViewH = 241;
        CGFloat scanWindowH = self.width - kMargin * 2;
        CGFloat scanNetImageViewW = _scanWindow.width;
        
        _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanBaseAnimation = [CABasicAnimation animation];
        scanBaseAnimation.keyPath = @"transform.translation.y";
        scanBaseAnimation.byValue = @(scanWindowH);
        scanBaseAnimation.duration  =1.0;
        scanBaseAnimation.repeatCount = MAXFLOAT;
        [_scanNetImageView.layer addAnimation:scanBaseAnimation forKey:@"translationAnimation"];
        [_scanWindow addSubview:_scanNetImageView];
        
    }
}
#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}

/**
 *  扫描结束
 *
 *  @param captureOutput   <#captureOutput description#>
 *  @param metadataObjects <#metadataObjects description#>
 *  @param connection      <#connection description#>
 */
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] > 0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metadata = [metadataObjects firstObject];
        stringValue = metadata.stringValue;
        if ([self.delegate respondsToSelector:@selector(qrCodeView:value:)]) {
            [_delegate qrCodeView:self value:stringValue];
        }
    }
}


@end
