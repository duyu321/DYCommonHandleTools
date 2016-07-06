//
//  NSObject+DY.h
//  DYMainViewController
//
//  Created by 杜宇 on 15/8/7.
//  Copyright (c) 2015年 Pactera. All rights reserved.
//

#import "NSObject+DY.h"
#import "GTMBase64.h"

@implementation NSObject (DY)

#pragma mark -文字编码
+ (NSString *)encodeStringBase64WithString:(NSString *)oldStr
{
    NSData *Data=[oldStr dataUsingEncoding:NSUTF8StringEncoding];
    Data =[GTMBase64 encodeData:Data];
    return [[NSString alloc] initWithData:Data encoding:NSUTF8StringEncoding];
}

#pragma mark -图片编码
+ (NSString *)encodeStringBase64WithJPEGImage:(UIImage *)image
{
    NSData *data=UIImageJPEGRepresentation(image, 1.0);//UIImageJPEGRepresentation返回图片较小，但是清晰度模糊
    data= [GTMBase64 encodeData:data];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark -图片编码
+ (NSString *)encodeStringBase64WithPNGImage:(UIImage *)image
{
    NSData *data=UIImagePNGRepresentation(image);//UIImagePNGRepresentation图片大，清晰
    data= [GTMBase64 encodeData:data];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

//=====================================华丽的分割线=====================================//

#pragma mark -文字解码
+ (NSString *)decodeStringBase64WithString:(NSString *)oldStr
{
    NSData *data=[oldStr dataUsingEncoding:NSUTF8StringEncoding];
    data=  [GTMBase64 decodeData:data];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark -图片解码
+ (UIImage *)decodeStringBase64WithImage:(NSString *)str
{
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    data=[GTMBase64 decodeData:data];
    return [UIImage imageWithData:data];
}

@end
