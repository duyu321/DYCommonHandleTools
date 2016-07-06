//
//  DYCommonHandleTool.h
//  导航条的滚动隐藏
//
//  Created by 杜宇 on 15/9/16.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

 


typedef enum{
    
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
    
} NetworkStatus;

NS_ASSUME_NONNULL_BEGIN

/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask DKURLSessionTask;
typedef void(^RequestSucceedBlock)(id responseObject);
typedef void(^RequestFailBlock)(NSError *error);
typedef void(^ResponseOKBlock)(id responseObject);
typedef void(^UploadProgressBlock)(int64_t bytesProgress,int64_t totalBytesProgress);
typedef void(^DownloadProgressBlock)(int64_t bytesProgress,int64_t totalBytesProgress);

@interface DYAFNCommonHandleTool : NSObject

@property (copy, nonatomic) RequestSucceedBlock requestSucceedBlock;
@property (copy, nonatomic) RequestFailBlock requestFailBlock;
@property (copy, nonatomic) ResponseOKBlock responseBlock;
@property (copy, nonatomic) UploadProgressBlock uploadProgressBlock;
@property (copy, nonatomic) DownloadProgressBlock downloadProgressBlock;




#pragma mark - POST请求网络 完整返回请求到的数据
/**
 *  POST请求网络 完整返回请求到的数据
 *
 *  @param manager        AFHTTPSessionManager
 *  @param baseUrl        基本url头，与suffixUrl拼接成完整url
 *  @param suffixUrl      url后缀，与baseUrl拼接成完整url
 *  @param parameter      请求参数
 *  @param requestSuccess 网络请求成功返回信息
 *  @param requestFail    网络请求失败信息
 *
 *  @return 请求任务
 */
+ (DKURLSessionTask *)executePOSTWithManager:(AFHTTPSessionManager *)manager
                       BaseUrl:(NSString *)baseUrl
                     suffixUrl:(nullable NSString *)suffixUrl
                     paramters:(nullable id)parameter
                       success:(nullable RequestSucceedBlock)requestSuccess
                       failure:(nullable RequestFailBlock)requestFail;




#pragma mark - GET请求网络 完整返回请求到的数据
/**
 *  GET请求网络 完整返回请求到的数据
 *
 *  @param manager        AFHTTPSessionManager
 *  @param baseUrl        基本url头，与suffixUrl拼接成完整url
 *  @param suffixUrl      url后缀，与baseUrl拼接成完整url
 *  @param parameter      请求参数
 *  @param requestSuccess 网络请求成功返回信息
 *  @param requestFail    网络请求失败信息
 *
 *  @return 请求任务
 */
+ (DKURLSessionTask *)executeGETWithManager:(AFHTTPSessionManager *)manager
                      BaseUrl:(NSString *)baseUrl
                    suffixUrl:(nullable NSString *)suffixUrl
                    paramters:(nullable id)parameter
                      success:(nullable RequestSucceedBlock)requestSuccess
                      failure:(nullable RequestFailBlock)requestFail;




#pragma mark - POST上传文件数据，现在支持image/PNG类型
/**
 *  POST上传文件数据，现在支持image/jpg类型
 *
 *  @param manager     AFHTTPSessionManager
 *  @param baseUrl     基本url头，与suffixUrl拼接成完整url
 *  @param suffixUrl   url后缀，与baseUrl拼接成完整url
 *  @param parameter   请求参数
 *  @param fileName    上传的图片名
 *  @param image       上传的图片
 *  @param progress    进度
 *  @param responseOK  获取正确码得到的数据
 *  @param requestFail 请求失败信息
 *
 *  @return 请求任务
 */
+ (DKURLSessionTask *)executeUpLoadImageWithManager:(AFHTTPSessionManager *)manager
                              BaseUrl:(NSString *)baseUrl
                            suffixUrl:(nullable NSString *)suffixUrl
                            paramters:(nullable id)parameter
                             filename:(nullable NSString *)fileName
                             putImage:(UIImage *)image
                             progress:(UploadProgressBlock)progress
                             response:(nullable ResponseOKBlock)responseOK
                              failure:(nullable RequestFailBlock)requestFail;




#pragma mark - 下载文件
/**
 *  下载文件的请求
 *
 *  @param manager     AFHTTPSessionManager
 *  @param baseUrl     基本url头，与suffixUrl拼接成完整url
 *  @param suffixUrl   url后缀，与baseUrl拼接成完整url
 *  @param parameter   请求参数
 *  @param saveToPath  保存的路径
 *  @param progress    进度
 *  @param responseOK  获取正确码得到的数据
 *  @param requestFail 请求失败信息
 *
 *  @return 请求任务
 */
+ (DKURLSessionTask *)executeDownLoadWithManager:(AFHTTPSessionManager *)manager
                                         BaseUrl:(NSString *)baseUrl
                                       suffixUrl:(nullable NSString *)suffixUrl
                                      saveToPath:(NSString *)saveToPath
                                        progress:(UploadProgressBlock)progress
                                        response:(ResponseOKBlock)responseOK
                                         failure:(RequestFailBlock)requestFail;




#pragma mark - 监控当前网络变化
/**
 *  监控当前网络变化
 */
+ (void)checkNetworkStatus;

@end

NS_ASSUME_NONNULL_END
