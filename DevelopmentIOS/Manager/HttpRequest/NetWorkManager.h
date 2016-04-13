//
//  LSNetWorkManager.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/21.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"
#import "ManagerPropertyConstant.h"
/**
 *  下载
 *
 */
typedef void(^LSDownloadProgress)(int64_t bytesRead,
                                  int64_t totalBytesRead);
typedef LSDownloadProgress LSPostProgress;
typedef LSDownloadProgress LSGetProgress;


/**
 *  上传
 */
typedef void(^LSUploadProgress)(int64_t bytesRead,
                                int64_t totalBytesRead);


typedef enum : NSUInteger {
    kLSResponseTypeJSON = 1,
    kLSResponseXML = 2,
    kLSResponseData = 3
} LSResponseType;

typedef enum : NSUInteger {
    kLSRequestJSON = 1,
    kLSRequestPlainText = 2,
}LSRequestType;


@class NSURLSessionTask;
//所有接口的类型都是基于NSURLSessionData,减少对第三方的依赖,在接口的强转数必须自己处理


typedef NSURLSessionTask LSURLSessionTask;
//网络请求成功
typedef void(^LSResponseSuccess)(id response);
//网络请求失败
typedef void(^LSResponseFail)(NSError *error);

@interface NetWorkManager : NSObject

singletonInterface(LSNetWorkManager);



/**
 *  通常在AppDelegate只需要设置一次,ruguo
 *
 *  @param baseUrl
 */
+(void)updateBaseURL:(NSString *)baseUrl;



+(NSString *)baseURL;

/**
 *  配置返回格式
 *
 *  @param type 默认JSON
 */
+(void)configResponseType:(LSResponseType)type;;
/**
 *  配置请求格式
 *
 *  @param type 默认
 */
+(void)configRequestType:(LSRequestType)type;

/**
 *  
 *  开启或关闭自动使用URL转码
 *
 *  @param shouldAutoEncode <#shouldAutoEncode description#>
 */
+(void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode;


/**
 *  配置请求头 只调用一次,；通常放在应用启动的时候，加载
 */
+(void)configCommonHttpHeaders:(NSDictionary *)header;


/**
 *  GET 若不指定baseurl ,可传完整url
 *  @param url     借口路径 如/patj/getArticleList?categoryid=1
 */
+(LSURLSessionTask*)getWithUrl:(NSString *)url success:(LSResponseSuccess)success fail:(LSResponseFail)fail;

/**
 *  GET 若不指定baseurl ,可传完整url
 *  @param url     借口路径 如/patj/getArticleList?categoryid=1
 *  @param params  借口中的需要的参数
 */
+(LSURLSessionTask*)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(LSResponseSuccess)success fail:(LSResponseFail)fail;

/**
 *  GET 若不指定baseurl ,可传完整url
 *  @param url     借口路径 如/patj/getArticleList?categoryid=1
 *  @param params  借口中的需要的参数
 *  @param progress 上传进度
 */
+(LSURLSessionTask*)getWithUrl:(NSString *)url params:(NSDictionary *)params progress:(LSGetProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail;

/**
 *  POST请求接口
 *
 *  @param url      <#url description#>
 *  @param params   <#params description#>
 *  @param success  <#success description#>
 *  @param NSString <#NSString description#>
 */
+(LSURLSessionTask*)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(LSResponseSuccess)success fail:(LSResponseFail)fail;


+(LSURLSessionTask*)postWithUrl:(NSString *)url params:(NSDictionary *)params progress:(LSGetProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail;

/**
 *  上传文件
 *
 *  @param image      图片
 *  @param url        上传的地址
 *  @param filename   文件名
 *  @param mimeType   文件类型
 *  @param parameters 上传参数
 *  @param progress   上传进度
 *  @param success    网络接口访问成功回调
 *  @param fail       网络接口访问失败回调
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask *)uploadWithImage:(UIImage *)image url:(NSString *)url filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(LSUploadProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail;


/**
 *  上传文件操作
 *
 *  @param url      上传路径
 *  @param file     待上传的路径
 *  @param progress 上传进度
 *  @param success  上传成功回调
 *  @param fail     上传失败回调
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask *)uploadFileWithUrl:(NSString *)url file:(NSString *)file progress:(LSUploadProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail;



/**
 *  下载文件
 *
 *  @param url      下载url
 *  @param svaePath 下载到哪
 *  @param progress 下载进度
 *  @param success  下载成功回调
 *  @param fail     下载失败回调
 *
 *  @return <#return value description#>
 */
+(LSURLSessionTask *)downloadWithUrl:(NSString*)url savePath:(NSString *)svaePath progress:(LSDownloadProgress)progress success:(LSResponseSuccess)success fail:(LSResponseFail)fail;

@end
