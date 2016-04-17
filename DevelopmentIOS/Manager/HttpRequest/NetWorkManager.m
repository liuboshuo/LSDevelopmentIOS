//
//  LSNetWorkManager.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/21.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "NetWorkManager.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFHTTPSessionManager.h"
#import "LSDevelopmetIOS.h"
static NSString *_privateNetWorkBaseUrl = nil;
static BOOL _shouldAutoEncode = NO;
static NSDictionary *_httpHeader = nil;
static LSResponseType _responseType = kLSResponseTypeJSON;
static LSRequestType _requestType = kLSRequestJSON;

@interface NetWorkManager ()


@property(nonatomic , strong)NSOperationQueue *netWorkOperationQueue;



@end

@implementation NetWorkManager


+(void)initialize
{
    
    //加载地址，只需要在配置文件利配置即可
    NSDictionary *params = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:LSManagerPropertyConfigFile ofType:nil]];
    if (params != nil) {
        NSDictionary *dict = params[LSNetWorkMgrKey];
        if (dict != nil) {
            NSString *baseUrl = dict[LSNetWorkMgrBaseURL];
            if (baseUrl != nil) {
                [self updateBaseURL:baseUrl];
            }
        }
    }
}


singletonImplementation(LSNetWorkManager);

/**
 *  更新网络基地址
 *
 *  @param baseUrl <#baseUrl description#>
 */
+(void)updateBaseURL:(NSString *)baseUrl
{
    _privateNetWorkBaseUrl = baseUrl;
}

/**
 *  拿到地址
 *
 *  @return <#return value description#>
 */
+(NSString *)baseURL
{
    return _privateNetWorkBaseUrl;
}
/**
 *  配置网络响应格式
 *
 *  @param type <#type description#>
 */
+(void)configResponseType:(LSResponseType)type
{
    _responseType = type;
}
/**
 *  设置请求头
 *
 *  @param header <#header description#>
 */
+(void)configCommonHttpHeaders:(NSDictionary *)header
{
    _httpHeader = header;
}
/**
 *  设置网络请求的格式
 *
 *  @param type <#type description#>
 */
+(void)configRequestType:(LSRequestType)type
{
    _requestType = type;
}
/**
 *  设置是否对你网络地址转码
 *
 *  @param shouldAutoEncode <#shouldAutoEncode description#>
 */
+(void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
{
    _shouldAutoEncode = shouldAutoEncode;
}

+(BOOL)shouldAutoEncode
{
    return _shouldAutoEncode;
}
/**
 *  get请求  无参数参数在
 *
 *  @param url     地址
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask *)getWithUrl:(NSString *)url success:(LSResponseSuccess)success fail:(LSResponseFail)fail
{
    return [self getWithUrl:url params:nil success:success fail:fail];
}
/**
 *  get请求 需要参数
 *
 *  @param url      地址
 *  @param params   参数
 *  @param progress 进度
 *  @param success  <#success description#>
 *  @param fail     <#fail description#>
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask*)getWithUrl:(NSString *)url params:(NSDictionary *)params progress:(LSGetProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail
{
    return [self request:url httpMethod:1 params:params progress:progress success:success fail:fail];
}

/**
 *  网络请求
 *
 *  @param url     <#url description#>
 *  @param params  <#params description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask*)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(LSResponseSuccess)success fail:(LSResponseFail)fail
{
    return [self postWithUrl:url params:params progress:nil success:success fail:fail];
}

/**
 *  网络请求
 *
 *  @param url      地址
 *  @param params   参数
 *  @param progress 网络访问进度
 *  @param success  <#success description#>
 *  @param fail     <#fail description#>
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask *)postWithUrl:(NSString *)url params:(NSDictionary *)params progress:(LSGetProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail
{
    return [self request:url httpMethod:2 params:params progress:progress success:success fail:fail];
}


/**
 *  get
 *
 *  @param url     地址
 *  @param params  参数
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask *)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(LSResponseSuccess)success fail:(LSResponseFail)fail
{
    return [self getWithUrl:url params:params progress:nil success:success fail:fail];
}


/**
 *  进行网络请求 GET/POST
 *
 *  @param url        地址
 *  @param httpMethod GET(1)/POST(2)
 *  @param params     参数
 *  @param progress   网络访问进度
 *  @param success    <#success description#>
 *  @param fail       <#fail description#>
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask*)request:(NSString *)url httpMethod:(NSUInteger)httpMethod params:(NSDictionary *)params progress:(LSDownloadProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail
{
    if ([self baseURL] == nil) {
        if ([NSURL URLWithString:url] == nil) {
#if DEBUG
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
#else
#endif
            return nil;
        }
    }else{
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[self baseURL],url]] == nil) {
#if DEBUG
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
#else
#endif
            return nil;
        }
    }
    
    AFHTTPSessionManager *mgr = [self manager];
    
    
    if ([self shouldAutoEncode]) {
        url = [self ls_URLEncode:url];
    }
    
    LSURLSessionTask *session = nil;
    if (httpMethod == 1) {
        session = [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callBack:success];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error) {
                fail(error);
            }
        }];
    }else if (httpMethod == 2){
        session = [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callBack:success];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
        }];
    }
    
    return session;
}


/**
 *  文件上传
 *
 *  @param url      地址
 *  @param file     文件地址
 *  @param progress 上传进度
 *  @param success  网络访问成功回调
 *  @param fail     <#fail description#>
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask *)uploadFileWithUrl:(NSString *)url file:(NSString *)file progress:(LSUploadProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail
{
    if ([NSURL URLWithString:file] == nil) {
#if DEBUG
        NSLog(@"uploadingFile无效，无法生成URL。请检查待上传文件是否存在");
#else
        
#endif
        return nil;
    }
    NSURL *uploadURL = nil;
    if ([self baseURL] == nil) {
        uploadURL = [NSURL URLWithString:url];
    }else{
        uploadURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[self baseURL], url]];
    }
    
    if (uploadURL == nil) {
#if DEBUG
        NSLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
#else
        
#endif
        return nil;
    }
    if ([self shouldAutoEncode]) {
        url = [self encodeUrl:url];
    }
    AFHTTPSessionManager *mgr = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
    LSURLSessionTask *se = [mgr uploadTaskWithRequest:request fromFile:[NSURL URLWithString:file] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        [self successResponse:responseObject callBack:success];
        
        if (error) {
            if (fail) {
                fail(error);
            }
        }else{
            
        }
    }];
    return se;
}
/**
 *  上传本地图片
 *
 *  @param image      图片
 *  @param url        地址
 *  @param filename   文件名
 *  @param name       后台服务的key
 *  @param mimeType   后缀类型
 *  @param parameters 参数
 *  @param progress   上传进度
 *  @param success    <#success description#>
 *  @param fail       <#fail description#>
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask *)uploadWithImage:(UIImage *)image url:(NSString *)url filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(LSUploadProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail
{
    if ([self baseURL] == nil) {
        if ([NSURL URLWithString:url] == nil) {
#if DEBUG
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
#else
            
#endif
            return nil;
        }
    }else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], url]] == nil) {
#if DEBUG
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
#else
            
#endif
            return nil;
        }
    }
    if ([self shouldAutoEncode]) {
        url = [self encodeUrl:url];
    }
    AFHTTPSessionManager *mgr = [self manager];
    LSURLSessionTask *session = [mgr POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData;
        
        if ([mimeType containsString:@"png"]) {
            imageData = UIImagePNGRepresentation(image);
        }else{
            imageData = UIImageJPEGRepresentation(image, 1);
        }
        
        NSString *imageFileName = filename;
        
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg",str];
        }
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponse:responseObject callBack:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    return session;
}
/**
 *  下载
 *
 *  @param url      地址
 *  @param svaePath 保存的路径
 *  @param progress 下载文件的进度
 *  @param success  <#success description#>
 *  @param fail     <#fail description#>
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask *)downloadWithUrl:(NSString *)url savePath:(NSString *)svaePath progress:(LSDownloadProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail
{
    if ([self baseURL] == nil) {
        if ([NSURL URLWithString:url] == nil) {
#if DEBUG
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
#else
            
#endif
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], url]] == nil) {
#if DEBUG
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
#else
            
#endif
            return nil;
        }
    }
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *mgr= [self manager];
    LSURLSessionTask *session = [mgr downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:svaePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (success) {
            success(filePath.absoluteString);
        }
        
        if (error) {
            if (fail) {
                fail(error);
            }
        }
    }];
    return session;
}
/**
 *  转码
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)encodeUrl:(NSString *)url {
    return [self ls_URLEncode:url];
}
/**
 *  manager
 *
 *  @return <#return value description#>
 */
+(AFHTTPSessionManager*)manager
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = nil;
    
    if ([self baseURL]!=nil) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseURL]]];
    }else{
        manager = [AFHTTPSessionManager manager];
    }
    switch (_requestType) {
        case kLSRequestJSON:
        {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
        }
        case kLSRequestPlainText:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        default:
            break;
    }
    
    switch (_responseType) {
        case kLSResponseTypeJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case kLSResponseXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case kLSResponseData:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    for (NSString *key in _httpHeader.allKeys) {
        if (_httpHeader[key] != nil) {
            [manager.requestSerializer setValue:_httpHeader[key] forHTTPHeaderField:key];
        }
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    manager.operationQueue.maxConcurrentOperationCount = 3;
    return manager;
}

/**
 *  成功
 *
 *  @param responseData 网络访问结果
 *  @param success      成功回调
 */
+(void)successResponse:(id)responseData callBack:(LSResponseSuccess)success
{
    if (success) {
        success([self parseData:responseData]);
    }
}
/**
 *  打印地址和参数
 *
 *  @param url    <#url description#>
 *  @param params <#params description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)generateGetAbsoluteURL:(NSString *)url params:(NSDictionary *)params
{
    if (params.count == 0) {
        return url;
    }
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        }else if ([value isKindOfClass:[NSArray class]]){
            continue;
        }else if ([value isKindOfClass:[NSSet class]]){
            continue;
        }else{
            queries = [NSString stringWithFormat:@"%@%@=%@&",(queries.length == 0 ? @"&" : queries), key, value];
        }
    }
    if(queries.length > 1){
        queries = [queries substringToIndex:queries.length - 1];
    }
    if (([url rangeOfString:@"http://"].location != NSNotFound || [url rangeOfString:@"https://"].location == NSNotFound) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@",url,queries];
        }else{
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@",url , queries];
        }
    }
    return url.length == 0 ? queries : url;
}

/**
 *  数据处理
 *
 *  @param responseData <#responseData description#>
 *
 *  @return <#return value description#>
 */
+(id)parseData:(id)responseData
{
    if ([responseData isKindOfClass:[NSData class]]) {
        //尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        }else if([responseData isKindOfClass:[NSNull class]]){
            return nil;
        }else{
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
            
            if (error != nil) {
                return responseData;
            }else{
                return response;
            }
        }
    }else{
        return responseData;
    }
}

/**
 *  URLEncode
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)ls_URLEncode:(NSString *)url
{
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return url;
}













@end
