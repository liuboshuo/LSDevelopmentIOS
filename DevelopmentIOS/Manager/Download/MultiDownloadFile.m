//
//  DownloadMultiThread.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/16.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "MultiDownloadFile.h"
#import "SingleDownLoadFile.h"


@interface MultiDownloadFile ()<SingleDownLoadFileDelegate>

@property(nonatomic , strong)NSMutableArray *singleDownloaders;

@property(nonatomic , assign)long long totalLength;


@property(nonatomic , assign)long long currentDownload;

@property(nonatomic , assign)long long speed;

@property(nonatomic , assign)int count;

@property(nonatomic , assign)NSTimeInterval receiveDataTime;

@property(nonatomic , assign)long long reeciveData;



@end

@implementation MultiDownloadFile


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.currentDownload = 0;
    }
    return self;
}
-(void)getFileSize
{
    NSMutableURLRequest *re = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    re.HTTPMethod = @"HEAD";
    
    [NSURLConnection sendAsynchronousRequest:re queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        self.totalLength = response.expectedContentLength;
        
        [self.singleDownloaders makeObjectsPerformSelector:@selector(start)];
        _isDownloading  = YES;
    }];
}


-(NSMutableArray *)singleDownloaders
{
    if ( _singleDownloaders == nil) {
        _singleDownloaders = [NSMutableArray array];
        
        long long size = 0;
        if (self.totalLength % self.maxCount == 0 ) {
            size = self.totalLength / self.maxCount;
        }else{
            size = self.totalLength / self.maxCount + 1;
        }
        
        for (int i = 0; i<self.maxCount; i++) {
            SingleDownLoadFile *singleDownload = [[SingleDownLoadFile alloc] init];
            singleDownload.downloadUrl = self.url;
            singleDownload.destinationPath = self.destinationPath;
            singleDownload.begin = i * size;
            singleDownload.end = singleDownload.begin + size - 1;
            singleDownload.delegate = self;
            [_singleDownloaders addObject:singleDownload];
        }
        
        // 创建一个跟服务器文件等大小的临时文件
        [[NSFileManager defaultManager] createFileAtPath:self.destinationPath contents:nil attributes:nil];
        
        // 让self.destPath文件的长度是self.totalLengt
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:self.destinationPath];
        [handle truncateFileAtOffset:self.totalLength];
    }
    return _singleDownloaders;
}
-(void)downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite speed:(long long)speed isCalculate:(BOOL)hasSpeed
{
    _count++;
    _reeciveData+=bytesWritten;
    
    self.currentDownload += bytesWritten;
    if (_count >= self.maxCount * SingleDownLoadCount) {
        NSDate *date = [NSDate date];
        NSTimeInterval times = [date timeIntervalSince1970] - _receiveDataTime;
        _speed = _reeciveData / times / SingleDownLoadCount;
        _count = 0;
        _reeciveData = 0;
        _receiveDataTime = [date timeIntervalSince1970];
        if ([self.delegate respondsToSelector:@selector(downloadWithTotalBytesWritten:totalBytesExpectedToWrite:speed:isCalculate:)]) {
            [self.delegate downloadWithTotalBytesWritten:self.currentDownload totalBytesExpectedToWrite:self.totalLength speed:_speed isCalculate:YES ];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(downloadWithTotalBytesWritten:totalBytesExpectedToWrite:speed:isCalculate:)]) {
            [self.delegate downloadWithTotalBytesWritten:self.currentDownload totalBytesExpectedToWrite:self.totalLength speed:0 isCalculate:NO];
        }
    }
    
    
    
    
    
    //    NSLog(@"%lld---%lld",self.currentDownload,self.totalLength);
    //    NSLog(@"%lld",self.currentDownload);
    
    
    
}
-(void)start
{
    
    NSDate *date = [NSDate date];
    _receiveDataTime = [date timeIntervalSince1970];
    _count = 0;
    _reeciveData = 0;
    
    if (self.totalLength <= 0) {
        [self getFileSize];
    }else{
        [self.singleDownloaders makeObjectsPerformSelector:@selector(start)];
        _isDownloading  = YES;
    }
}

-(void)stop
{
    [self.singleDownloaders makeObjectsPerformSelector:@selector(stop)];
    _isDownloading  = NO;
}

@end
