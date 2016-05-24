
//
//  LSDownloadManager.m
//  DownManagerDemo
//
//  Created by 刘硕 on 16/5/6.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "LSDownloadManager.h"

@interface LSDownloadManager ()<NSURLSessionDataDelegate>

/**
 *  任务 已下载文件名作为键值对
 */
@property(nonatomic , strong)NSMutableDictionary *tasks;
/**
 *  下载模型 已下载任务的唯一标示作为键值对
 */
@property(nonatomic , strong)NSMutableDictionary *sessionModels;
/**
 *  存储下载模型
 */
@property(nonatomic , strong)NSMutableArray *sessionModelsArray;

@end

@implementation LSDownloadManager

-(NSMutableDictionary *)tasks
{
    if (!_tasks) {
        _tasks = [NSMutableDictionary dictionary];
    }
    return _tasks;
}
-(NSMutableDictionary *)sessionModels
{
    if (!_sessionModels) {
        _sessionModels = [NSMutableDictionary dictionary];
    }
    return _sessionModels;
}
-(NSMutableArray *)sessionModelsArray
{
    if (!_sessionModelsArray) {
        _sessionModelsArray = [NSMutableArray arrayWithArray:[self getSessionModels]];
    }
    return _sessionModelsArray;
}
static LSDownloadManager *_downloadManager;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downloadManager = [super allocWithZone:zone];
    });
    return _downloadManager;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return _downloadManager;
}
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downloadManager = [[self alloc] init];
    });
    return _downloadManager;
}




-(void)save:(NSArray *)sessionModels
{
    [NSKeyedArchiver archiveRootObject:sessionModels toFile:DownloadArchiveFile];
}
-(NSArray *)getSessionModels
{
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:DownloadArchiveFile];
    return array;
}
-(void)createDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:CachesDirectory]) {
        [fileManager createDirectoryAtPath:CachesDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
}

-(void)download:(NSString *)url progress:(DownloadProgressBlock)progress state:(DownloadStateBlock)stateBlock
{
    
    if (!url) {
        return;
    }
    if ([self isCompletion:url]) {
        stateBlock(DownloadStateCompleted);
        return;
    }
    //查看内存中是否存在 任务，有的话不去创建，没有则去创建任务下载
    if ([self.tasks valueForKey:subFileName(url)]) {
        [self handle:url];
        return;
    }
    
    [self createDirectory];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:FileFullPath(url) append:YES];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-",DownloadFileTotalLength(url)];
    [req setValue:range forHTTPHeaderField:@"Range"];
    NSURLSessionDataTask *t = [session dataTaskWithRequest:req];
    NSUInteger taskId = arc4random() % ((arc4random() % 10000 + arc4random() % 10000));
    [t setValue:@(taskId) forKeyPath:@"taskIdentifier"];
    [self.tasks setValue:t forKey:subFileName(url)];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:subFileName(url)]) {
        SessionModel *sessionModel = [[SessionModel alloc] init];
        sessionModel.url = url;
        sessionModel.progress = progress;
        sessionModel.stateBlcok = stateBlock;
        sessionModel.stream = stream;
        sessionModel.startTime = [[NSDate alloc] init];
        sessionModel.filename = subFileName(url);
        [self.sessionModels setValue:sessionModel forKey:@(t.taskIdentifier).stringValue];
        [self.sessionModelsArray addObject:sessionModel];
        [self save:self.sessionModelsArray];
    }else{
        for (SessionModel *sessionModel in self.sessionModelsArray) {
            if ([sessionModel.url isEqualToString:url]) {
                sessionModel.url = url;
                sessionModel.progress = progress;
                sessionModel.stateBlcok = stateBlock;
                sessionModel.stream = stream;
                sessionModel.startTime = [[NSDate alloc] init];
                sessionModel.filename = subFileName(url);
                [self.sessionModels setValue:sessionModel forKey:@(t.taskIdentifier).stringValue];
            }
        }
    }
    [self start:url];
}
-(void)handle:(NSString *)url
{
    NSURLSessionDataTask *t = [self getTask:url];
    if (t.state == NSURLSessionTaskStateRunning) {
        [self pause:url];
    }else{
        [self start:url];
    }
}
-(void)start:(NSString *)url
{
    NSURLSessionDataTask *t = [self getTask:url];
    [t resume];
    [self getSessionModel:t.taskIdentifier].stateBlcok(DownloadStateStart);
}
-(void)pause:(NSString *)url
{
    NSURLSessionDataTask *t = [self getTask:url];
    [t suspend];
    [self getSessionModel:t.taskIdentifier].stateBlcok(DownloadStateSuspended);
}
-(NSURLSessionDataTask *)getTask:(NSString *)url
{
    return [self.tasks valueForKey:subFileName(url)];
}
-(SessionModel *)getSessionModel:(NSUInteger)taskIden
{
    return [self.sessionModels valueForKey:@(taskIden).stringValue];
}
-(BOOL)isCompletion:(NSString *)url
{
    if ([self fileTotalLength:url] && DownloadFileTotalLength(url) == [self fileTotalLength:url]) {
        return YES;
    }
    return NO;
}
-(CGFloat)progress:(NSString *)url
{
    return [self fileTotalLength:url] == 0 ? 0.0 : 1.0 * DownloadFileTotalLength(url) / [self fileTotalLength:url];
}
-(NSInteger)fileTotalLength:(NSString *)url
{
    for (SessionModel *sessionModel in self.sessionModelsArray) {
        if ([sessionModel.url isEqualToString:url]) {
            return sessionModel.totalLength;
        }
    }
    return 0;
}
-(void)deleteFile:(NSString *)url
{
    NSURLSessionTask *t = [self getTask:url];
    if (t) {
        [t cancel];
    }
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath:subFileName(url)]) {
        [mgr removeItemAtPath:subFileName(url) error:nil];
        if ([mgr fileExistsAtPath:DownloadArchiveFile]) {
            for (SessionModel *model in self.sessionModelsArray.mutableCopy) {
                if ([model.url isEqualToString:url]) {
                    [model.stream close];
                    [self.sessionModelsArray removeObject:model];
                }
            }
        }
        [self.tasks removeObjectForKey:subFileName(url)];
        [self.sessionModels removeObjectForKey:@([self getTask:url].taskIdentifier).stringValue];
        [self save:self.sessionModelsArray];
    }
}
-(void)deleteAllFile
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath:CachesDirectory]) {
        [mgr removeItemAtPath:CachesDirectory error:nil];
        [[self.tasks allValues] makeObjectsPerformSelector:@selector(cancel)];
        [self.tasks removeAllObjects];
        for (SessionModel *model in self.sessionModelsArray) {
            [model.stream close];
        }
        [self.sessionModels removeAllObjects];
        if ([mgr fileExistsAtPath:DownloadArchiveFile]) {
            [mgr removeItemAtPath:DownloadArchiveFile error:nil];
            [self.sessionModelsArray removeAllObjects];
            self.sessionModelsArray = nil;
        }
    }
}
-(BOOL)isFileDownloadingForUrl:(NSString *)url withProgress:(DownloadProgressBlock)progress
{
    BOOL retValue = NO;
    NSURLSessionTask *session = [self getTask:url];
    SessionModel *model = [self getSessionModel:session.taskIdentifier];
    if (session) {
        if (progress) {
            model.progress = progress;
        }
        retValue = YES;
    }
    return retValue;
}
-(NSArray *)currentDownloads
{
    NSMutableArray *array = [NSMutableArray array];
    [self.sessionModels enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, SessionModel *model, BOOL * _Nonnull stop) {
        [array addObject:model.url];
    }];
    return array;
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    SessionModel *sessionModel = [self getSessionModel:dataTask.taskIdentifier];
    [sessionModel.stream open];
    
    NSInteger totalLength = [response.allHeaderFields[@"Content-Length"] integerValue] + DownloadFileTotalLength(sessionModel.url);
    sessionModel.totalLength = totalLength;
    NSString *fileSizeInUint = [NSString stringWithFormat:@"%.2f %@",[sessionModel calculateFileSizeInUnit:(unsigned long long)totalLength],[sessionModel calculateUint:(unsigned long long)totalLength]];
    sessionModel.totalSize = fileSizeInUint;
    [self save:self.sessionModelsArray];
    completionHandler(NSURLSessionResponseAllow);
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    SessionModel *sessionModel = [self getSessionModel:dataTask.taskIdentifier];
    [sessionModel.stream write:data.bytes maxLength:data.length];
    NSUInteger receiveLength = DownloadFileTotalLength(sessionModel.url);
    NSUInteger expectedSize = sessionModel.totalLength;
    CGFloat progress = 1.0 * receiveLength / expectedSize;
    NSTimeInterval downloadTime = -1 * [sessionModel.startTime timeIntervalSinceNow];
    NSUInteger speed = receiveLength / downloadTime;
    if (speed == 0) {
        return;
    }
    float speedSec = [sessionModel calculateFileSizeInUnit:(unsigned long long)speed];
    NSString *suffixes = [sessionModel calculateUint:(unsigned long long)speed];
    NSString *speedStr = [NSString stringWithFormat:@"%.2f%@/s",speedSec,suffixes];
    NSMutableString *remaingTimeStr = [[NSMutableString alloc] init];
    unsigned long long remainingContentLength = expectedSize - receiveLength;
    int remainingTime = (int) (remainingContentLength / speed);
    int hours = remainingTime / 3600;
    int minutes = (remainingTime  - hours * 3600) / 60;
    int seconds = remainingTime - hours * 3600 - minutes * 60;
    if (hours > 0) {
        [remaingTimeStr appendFormat:@"%d小时",hours];
    }
    if (minutes > 0) {
        [remaingTimeStr appendFormat:@"%d分",minutes];
    }
    if (seconds > 0) {
        [remaingTimeStr appendFormat:@"%d秒",seconds];
    }
    NSString *writtenSize = [NSString stringWithFormat:@"%.2f %@",[sessionModel calculateFileSizeInUnit:(unsigned long long)receiveLength],[sessionModel calculateUint:(unsigned long long)receiveLength]];
    if (sessionModel.stateBlcok) {
        sessionModel.stateBlcok(DownloadStateStart);
    }
    if (sessionModel.progress) {
        sessionModel.progress(progress , speedStr , remaingTimeStr , writtenSize,sessionModel.totalSize);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(downloadResponse:)]) {
            [self.delegate downloadResponse:sessionModel];
        }
    });
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    SessionModel *sessionModel = [self getSessionModel:task.taskIdentifier];
    if (!sessionModel) {
        return;
    }
    
    if ([self isCompletion:sessionModel.url]) {
        sessionModel.stateBlcok(DownloadStateCompleted);
    }else if (error){
        sessionModel.stateBlcok(DownloadStateFailed);
    }
    
    [sessionModel.stream close];
    sessionModel.stream = nil;
    [self.tasks removeObjectForKey:subFileName(sessionModel.url)];
    [self.sessionModels removeObjectForKey:@(task.taskIdentifier).stringValue];
}
@end
