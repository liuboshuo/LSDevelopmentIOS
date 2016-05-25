//
//  LSDownloadManager.h
//  DownManagerDemo
//
//  Created by 刘硕 on 16/5/6.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionModel.h"
@class SessionModel;


/**
 *  
 LSDownloadManager *mgr = [LSDownloadManager shareInstance];
 [mgr download:@"http://221.228.17.252:8088/vedio/360.mp4" progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writenSize, NSString *totalSize) {
 NSLog(@"进度--%f 速度:%@,剩余:%@,下载:%@,下载文件大小:%@",progress,speed,remainingTime,writenSize,totalSize);
 } state:^(DownloadState state) {
 NSLog(@"%d",state);
 }];
 
 
 */

@protocol LSDownloadManagerDelegate <NSObject,NSCopying>

/**
 *  下载的回调
 *
 *  @param session <#session description#>
 */
-(void)downloadResponse:(SessionModel *)session;

@end

#define CachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"download"]
#define DownloadArchiveFile [CachesDirectory stringByAppendingPathComponent:@"downloadDetail.data"]
#define subFileName(url) [[url componentsSeparatedByString:@"/"] lastObject]
#define FileFullPath(url) [CachesDirectory stringByAppendingPathComponent:subFileName(url)]
#define DownloadFileTotalLength(url) [[[NSFileManager defaultManager] attributesOfItemAtPath:FileFullPath(url) error:nil][NSFileSize] integerValue]
@interface LSDownloadManager : NSObject

//所有下载相关信息
@property(nonatomic , strong, readonly)NSMutableDictionary *sessionModels;

@property(nonatomic , assign)id<LSDownloadManagerDelegate> delegate;

/**
 *  单例,下载多个的时候需要
 *
 *  @return <#return value description#>
 */
+(instancetype)shareInstance;

/**
 *  归档
 */
-(void)save:(NSArray *)sessionModels;

/**
 *  读取
 */
-(NSArray *)getSessionModels;


/**
 *  下载
 *
 *  @param url        地址
 *  @param progress   下载进度
 *  @param stateBlock 下载状态
 */
-(void)download:(NSString *)url progress:(DownloadProgressBlock)progress state:(DownloadStateBlock)stateBlock;

/**
 *  下载进度
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)progress:(NSString *)url;

/**
 *  文件的代销
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
-(NSInteger)fileTotalLength:(NSString *)url;

/**
 *  下载是否完成
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)isCompletion:(NSString *)url;


/**
 *  删除文件
 *
 *  @param url <#url description#>
 */
-(void)deleteFile:(NSString *)url;

/**
 *  删除所有文件
 */
-(void)deleteAllFile;

/**
 *  开始
 *
 *  @param url <#url description#>
 */
-(void)start:(NSString *)url;

/**
 *  暂停
 *
 *  @param url <#url description#>
 */
-(void)pause:(NSString *)url;

/**
 *  是否正在下载
 *
 *  @param url      地址
 *  @param progress 下载进度
 *
 *  @return BOOL
 */
-(BOOL)isFileDownloadingForUrl:(NSString *)url withProgress:(DownloadProgressBlock)progress;

/**
 *  获取所欲正在下载的文件
 *
 *  @return <#return value description#>
 */
-(NSArray *)currentDownloads;
@end
