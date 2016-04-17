//
//  DownloadMultiThread.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/16.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MultiDownloadFileDelegate <NSObject>


//收到数据时候才调用
-(void)downloadWithTotalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite speed:(long long)speed isCalculate:(BOOL)hasSpeed;


@end
@interface MultiDownloadFile : NSObject


@property(nonatomic , assign)id<MultiDownloadFileDelegate> delegate;


@property(nonatomic , strong)NSString *url;

@property(nonatomic , copy)NSString *destinationPath;

@property(nonatomic , assign)int maxCount;

@property(nonatomic , assign)BOOL isDownloading;

-(void)start;
-(void)stop;

@end
