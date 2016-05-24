//
//  SessionModel.h
//  DownManagerDemo
//
//  Created by 刘硕 on 16/5/6.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , DownloadState){
    //开始
    DownloadStateStart = 0,
    //暂停
    DownloadStateSuspended,
    //完成
    DownloadStateCompleted,
    //失败
    DownloadStateFailed
    
};

//下载进度回调
typedef void(^DownloadProgressBlock)(CGFloat progress , NSString *speed , NSString *remainingTime , NSString *writenSize , NSString *totalSize);

//下载状态的回调
typedef void(^DownloadStateBlock)(DownloadState state);

@interface SessionModel : NSObject<NSCoding>

/**
 *  下载
 */
@property(nonatomic , strong) NSOutputStream *stream;

/**
 *  url
 */
@property(nonatomic , copy)NSString *url;

/**
 *  下载开始时间
 */
@property(nonatomic , strong)NSDate *startTime;
/**
 *  文件名称
 */
@property(nonatomic , copy)NSString *filename;

/**
 *  文件大小
 */
@property(nonatomic , copy)NSString *totalSize;
/**
 *  文件大小单位字节
 */
@property(nonatomic , assign)NSInteger totalLength;


/**
 *  下载进度
 */
@property(nonatomic , copy) DownloadProgressBlock progress;

/**
 *  下载状态
 */
@property(nonatomic , copy) DownloadStateBlock stateBlcok;


/**
 *  计算大小GB,KB,保留2位小数
 *
 *  @param contentLength <#contentLength description#>
 *
 *  @return <#return value description#>
 */
-(float)calculateFileSizeInUnit:(unsigned long long)contentLength;

/**
 *  计算文件的大小单位
 *
 *  @param contentLength <#contentLength description#>
 *
 *  @return <#return value description#>
 */
-(NSString *)calculateUint:(unsigned long long)contentLength;


@end
