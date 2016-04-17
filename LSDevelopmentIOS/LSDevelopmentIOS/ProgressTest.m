
//
//  ProgressTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "ProgressTest.h"
#import "LSDevelopmetIOS.h"
@interface ProgressTest ()<SingleDownLoadFileDelegate,MultiDownloadFileDelegate>

@property(nonatomic , strong)SingleDownLoadFile *download;

@property(nonatomic , strong)MultiDownloadFile *downloader;

@property(nonatomic , strong)LSProgressView *progressView;

@property(nonatomic , strong)LSProgressView *progressView0;

@property(nonatomic , weak)UILabel *label;

@property(nonatomic , weak)UILabel *label0;

@end

@implementation ProgressTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _download = [[SingleDownLoadFile alloc] init];
    _download.downloadUrl = @"http://221.228.17.252:8088/vedio/360.mp4";
    _download.destinationPath = [LSProjectUtils getCachesFilePathWithFileName:@"2.mp4"];
    [_download start];
    _download.delegate  = self;
    
    LSProgressView *progress = [[LSProgressView alloc] init];
    progress.frame = CGRectMake(10, 100, 100, 100);
    progress.width = 5;
    progress.color  = [UIColor purpleColor];
    [self.view addSubview:progress];
    _progressView = progress;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(150, 120,160, 20);
    [self.view addSubview:label];
    self.label = label;
    
    
    UIButton *b = [[UIButton alloc] init];
    b.frame = CGRectMake(250, 120, 100, 20);
    [b setTitle:@"暂停" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:b];
    __weak UIButton *weakB = b;
    [b addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        if ([weakB.titleLabel.text isEqualToString:@"继续"]) {
            [_download start];
            [weakB setTitle:@"暂停" forState:UIControlStateNormal];
        }else{
            [_download stop];
            [weakB setTitle:@"继续" forState:UIControlStateNormal];
        }
    }];
    
    
    LSProgressView *progress0 = [[LSProgressView alloc] init];
    progress0.frame = CGRectMake(10, 200, 100, 100);
    progress0.width = 5;
    progress0.color  = [UIColor purpleColor];
    [self.view addSubview:progress0];
    _progressView0 = progress0;
    
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(250, 200, 100, 20);
    [button setTitle:@"暂停" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    __weak UIButton *weakButton = button;
    
    
    UILabel *label0 = [[UILabel alloc] init];
    label0.frame = CGRectMake(150, 200,160, 20);
    [self.view addSubview:label0];
    self.label0 = label0;
    
    
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        if ([weakButton.titleLabel.text isEqualToString:@"继续"]) {
            [weakButton setTitle:@"暂停" forState:UIControlStateNormal];
            [_downloader start];
        }else{
            [weakButton setTitle:@"继续" forState:UIControlStateNormal];
            [_downloader stop];
        }
    }];
    
    
    _downloader = [[MultiDownloadFile alloc] init];
    _downloader.delegate = self;
    _downloader.maxCount = 4;
    _downloader.url = @"http://221.228.17.252:8088/vedio/360.mp4";
    _downloader.destinationPath = [LSProjectUtils getCachesFilePathWithFileName:@"3.mp4"];
    [_downloader start];
    
    
}


-(void)downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite speed:(long long)speed isCalculate:(BOOL)hasSpeed
{
    _progressView.process = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    if (hasSpeed) {
        CGFloat currentSpeed = speed * 1.0 / 1024;
        if (currentSpeed > 1024) {
            self.label.text  = [NSString stringWithFormat:@"%.2lfM",currentSpeed / 1024];
        }else{
            self.label.text = [NSString stringWithFormat:@"%.2fK",currentSpeed];
        }
    }
    
}


-(void)downloadWithTotalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite speed:(long long)speed isCalculate:(BOOL)hasSpeed
{
    _progressView0.process = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    if (hasSpeed) {
        CGFloat currentSpeed = speed * 1.0 / 1024;
        if (currentSpeed > 1024) {
            self.label0.text = [NSString stringWithFormat:@"%.2lfM",currentSpeed / 1024];
        }else{
            self.label0.text = [NSString stringWithFormat:@"%.2fK",currentSpeed];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"---");
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
