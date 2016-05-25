//
//  DownLoad.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SingleDownLoadCount 3


/**
 *  _download = [[SingleDownLoadFile alloc] init];
 _download.downloadUrl = @"http://221.228.17.252:8088/vedio/360.mp4";
 _download.destinationPath = [LSProjectUtils getCachesFilePathWithFileName:@"2.mp4"];
 [_download start];
 */
@protocol SingleDownLoadFileDelegate <NSObject>

//收到数据时候才调用
-(void)downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite speed:(long long)speed isCalculate:(BOOL)hasSpeed;

@end



@interface SingleDownLoadFile : NSObject

@property(nonatomic , copy)NSString *downloadUrl;

@property(nonatomic , copy)NSString *destinationPath;


@property(nonatomic  ,assign)long long begin;

@property(nonatomic  ,assign)long long end;

@property(nonatomic , assign)id<SingleDownLoadFileDelegate> delegate;

/**
 *  开始下载
 */
-(void)start;
/**
 *  停止下载 继续
 */
-(void)stop;

@end
