//
//  DYCommonHandleTool.m
//  导航条的滚动隐藏
//
//  Created by 杜宇 on 15/9/16.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

#import "DYAFNCommonHandleTool.h"

@implementation DYAFNCommonHandleTool

#pragma mark - POST请求网络 完整返回请求到的数据
+ (DKURLSessionTask *)executePOSTWithManager:(AFHTTPSessionManager *)manager
                                     BaseUrl:(NSString *)baseUrl
                                   suffixUrl:(nullable NSString *)suffixUrl
                                   paramters:(id)parameter
                                     success:(RequestSucceedBlock)requestSuccess
                                     failure:(RequestFailBlock)requestFail
{
    // 拼接url
    baseUrl = [NSString stringWithFormat:@"%@%@",baseUrl,suffixUrl.length == 0 ? @"" : suffixUrl];
    
    // 设置manager的属性
    [self setManagerAttribute:manager];
    
    // 将参数转换为字典
    NSDictionary *parameters = [parameter mj_keyValues];
    
    // 显示指示器
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD show];
    
    // 请求网络
    DKURLSessionTask *sessionTask = [manager POST:baseUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 取消指示器
        [SVProgressHUD dismiss];
        
        if (requestSuccess) {
            /*
            // 如果返回参数首位带有小括号,开启此方法。
            if (dict == nil) {
                NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSRange range = {1, string.length - 2};  //去掉首尾的小括号
                NSString *jsonStr = [string substringWithRange:range];
                dict = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            }*/
            // 成功的block回调
            requestSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 取消指示器
        [SVProgressHUD dismiss];
        
        // 提示用户请求失败
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
        
        if (requestFail) {
            
            // 网络请求失败的block回调
            requestFail(error);
        }
    }];
    return sessionTask;
}

#pragma mark - GET请求网络 完整返回请求到的数据
+ (DKURLSessionTask *)executeGETWithManager:(AFHTTPSessionManager *)manager
                                    BaseUrl:(NSString *)baseUrl
                                  suffixUrl:(nullable NSString *)suffixUrl
                                  paramters:(nullable id)parameter
                                    success:(nullable RequestSucceedBlock)requestSuccess
                                    failure:(nullable RequestFailBlock)requestFail
{
    // 拼接url
    baseUrl = [NSString stringWithFormat:@"%@%@",baseUrl,suffixUrl.length == 0 ? @"" : suffixUrl];
    
    // 检查地址中是否有中文
    baseUrl = [NSURL URLWithString:baseUrl] ? baseUrl : [self strUTF8Encoding:baseUrl];
    
    // 设置manager的属性
    [self setManagerAttribute:manager];
    
    // 将参数转换为字典
    NSDictionary *parameters = [parameter mj_keyValues];
    
    // 显示指示器
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD show];
    
    // 请求网络
    DKURLSessionTask *sessionTask = [manager GET:baseUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 取消指示器
//        [SVProgressHUD dismiss];
        
        if (requestSuccess) {
            
            /*
             // 如果返回参数首位带有小括号,开启此方法。
             if (responseObject == nil) {
             NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSRange range = {1, string.length - 2};  //去掉首尾的小括号
             NSString *jsonStr = [string substringWithRange:range];
             dict = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
             }*/
            // 成功的block回调
            requestSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 取消指示器
//        [SVProgressHUD dismiss];
        
        // 提示用户请求失败
//        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
        
        if (requestFail) {
            
            // 网络请求失败的block回调
            requestFail(error);
        }
    }];
    return sessionTask;
}

#pragma mark - POST上传文件数据，现在支持image/PNG类型
+ (DKURLSessionTask *)executeUpLoadImageWithManager:(AFHTTPSessionManager *)manager
                              BaseUrl:(NSString *)baseUrl
                            suffixUrl:(nullable NSString *)suffixUrl
                            paramters:(nullable id)parameter
                             filename:(nullable NSString *)fileName
                             putImage:(UIImage *)image
                             progress:(UploadProgressBlock)progress
                             response:(ResponseOKBlock)responseOK
                              failure:(RequestFailBlock)requestFail
{
    // 设置manager的属性
    [self setManagerAttribute:manager];
    
    // 如果图片名为nil,使用时间为图片命名
    if (fileName == nil || ![fileName isKindOfClass:[NSString class]] || fileName.length == 0) {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        fileName = [formatter stringFromDate:date];
    }
    
    // 拼接url
    baseUrl = [NSString stringWithFormat:@"%@%@",baseUrl,suffixUrl.length == 0 ? @"" : suffixUrl];
    
    // 将参数转换为字典
    NSDictionary *parameters = [parameter mj_keyValues];
    
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // 请求网络
    DKURLSessionTask *sessionTask = [manager POST:baseUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        //添加上传DATA的信息默认只能上传图片信息
        [formData appendPartWithFileData:imageData
                                    name:@"pic"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 取消指示器
        [SVProgressHUD dismiss];
        
        if (responseOK) {
            
            // 解析json
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([dict[@"retCode"] isEqualToString:@"0000"]) {
                
                // 成功的回调block
                responseOK(dict);
            }else
            {
                //显示网络请求返回其他的错误码所对应的提示信息
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 取消指示器
        [SVProgressHUD dismiss];
        
        // 提示用户请求失败
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
        
        if (requestFail) {
            
            // 网络请求失败的回调block
            requestFail(error);
        }
    }];
    return sessionTask;
}

+ (DKURLSessionTask *)executeDownLoadWithManager:(AFHTTPSessionManager *)manager
                                         BaseUrl:(NSString *)baseUrl
                                       suffixUrl:(nullable NSString *)suffixUrl
                                      saveToPath:(NSString *)saveToPath
                                        progress:(UploadProgressBlock)progress
                                        response:(ResponseOKBlock)responseOK
                                         failure:(RequestFailBlock)requestFail
{
    // 设置manager的属性
    [self setManagerAttribute:manager];
    
    // 拼接url
    baseUrl = [NSString stringWithFormat:@"%@%@",baseUrl,suffixUrl.length == 0 ? @"" : suffixUrl];
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:baseUrl]];
    
    DKURLSessionTask *sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error == nil) {
            if (responseOK) {
                responseOK([filePath path]);//返回完整路径
            }
        } else {
            if (requestFail) {
                requestFail(error);
            }
        }
    }];
    
    //开始启动任务
    [sessionTask resume];
    
    return sessionTask;
}

#pragma mark - 监控当前网络变化
+ (void)checkNetworkStatus
{
    NSURL *url=[NSURL URLWithString:@"www.baidu.com"];
    AFHTTPSessionManager *operationManager=[[AFHTTPSessionManager alloc]initWithBaseURL:url];
    /*
     AFNetworkReachabilityStatusUnknown          = -1,
     AFNetworkReachabilityStatusNotReachable     = 0,
     AFNetworkReachabilityStatusReachableViaWWAN = 1,
     AFNetworkReachabilityStatusReachableViaWiFi = 2,
     
     [operationManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
     switch (status) {
     case AFNetworkReachabilityStatusReachableViaWiFi:
     NSLog(@"WIFI Connection");
     break;
     case AFNetworkReachabilityStatusReachableViaWWAN:
     NSLog(@"2G/3G/4G Connection");
     break;
     case AFNetworkReachabilityStatusNotReachable:
     NSLog(@"Network not found");
     break;
     default:
     NSLog(@"Unknown");
     break;
     }
     }];*/
    //开始监控
    [operationManager.reachabilityManager startMonitoring];
}

#pragma mark - 把url中的中文转为utf-8编码
+ (NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 设置manager的属性
+ (void)setManagerAttribute:(AFHTTPSessionManager *)manager {
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 40;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
}

@end
