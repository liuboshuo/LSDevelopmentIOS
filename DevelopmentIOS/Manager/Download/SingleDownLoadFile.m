//
//  DownLoad.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "SingleDownLoadFile.h"
#import "UIApplication+Category.h"
#import "CopyFile.h"


@interface SingleDownLoadFile ()<NSURLSessionDelegate>


@property (nonatomic ,strong)NSURLSession *session;

@property (nonatomic , strong)NSURLSessionDownloadTask *downloadTask;

@property (nonatomic ,strong)NSData *data;

@property(nonatomic , assign)long long speed;


@property(nonatomic , assign)NSTimeInterval receiveDataTimeInterval;


@property(nonatomic , assign)int calculate;


@property(nonatomic , assign)long long receiveData;

@end


@implementation SingleDownLoadFile

-(NSURLSession *)session
{
    if (_session == nil) {
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        if (self.end > 0) {
            NSString *value = [NSString stringWithFormat:@"bytes=%lld-%lld", self.begin,self.end];
            NSMutableDictionary *headers = [NSMutableDictionary dictionary];
            headers[@"Range"] = value;
            [cfg setHTTPAdditionalHeaders:headers];
        }
        _session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

-(void)startDownLoad
{
    NSString *fileName = self.downloadUrl;
    
    NSURL *url = [NSURL URLWithString:fileName];
    
    _downloadTask = [self.session downloadTaskWithURL:url];
    
    [_downloadTask resume];
}
-(void)resume
{
    
    _downloadTask = [self.session downloadTaskWithResumeData:self.data];
    
    [_downloadTask resume];
    
    self.data = nil;
    
}

-(void)cancle
{
    __weak typeof(self) vc = self;
    [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        vc.data = resumeData;
        vc.downloadTask = nil;
    }];
    
}
//完成
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    if (self.end <= 0) {
        //进行文件的移动
        NSFileManager *mg = [NSFileManager defaultManager];
        //把文件atPath移到toPath
        [mg moveItemAtPath:location.path toPath:self.destinationPath error:nil];
    }else{
        [self copyFile:location.path];
    }
    
}


-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
}
//收到数据时候才调用
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    _calculate ++;
    _receiveData += bytesWritten;
    if (_calculate >= SingleDownLoadCount) {
        
        NSDate *date = [[NSDate alloc] init];
        _speed = _receiveData / ([date timeIntervalSince1970] - _receiveDataTimeInterval) / SingleDownLoadCount;
        _receiveDataTimeInterval = [date timeIntervalSince1970];
        _receiveData = 0;
        _calculate = 0;
        if ([_delegate respondsToSelector:@selector(downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:speed: isCalculate:)]) {
            [self.delegate downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite speed:_speed isCalculate:YES];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:speed:isCalculate:)]) {
            [self.delegate downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite speed:_speed isCalculate:NO];
        }
        
    }
    //didWriteData收到的数据
    //totalBytesWritten已经
    //totalBytesExpectedToWrite 文件
    
}


-(void)dealloc{
    [self cancle];
    self.downloadTask = nil;
    self.session = nil;
}
- (void)start {
    if (self.downloadTask == nil) {
        NSDate *date = [[NSDate alloc] init];
        _receiveDataTimeInterval = [date timeIntervalSince1970];
        _calculate = 0;
        _receiveData = 0;
        if (self.data == 0) {
            [self startDownLoad];
        }else{
            [self resume];
        }
    }else{
        [self cancle];
    }
}

-(void)stop
{
    [self cancle];
}

-(void)copyFile:(NSString *)absoluteString
{
    
    CopyFile *copyFile = [[CopyFile alloc] init];
    copyFile.desPath = self.destinationPath;
    copyFile.srcPath = absoluteString;
    [copyFile doCopy];
    [[NSFileManager defaultManager] removeItemAtPath:absoluteString error:nil];
    
}

@end
