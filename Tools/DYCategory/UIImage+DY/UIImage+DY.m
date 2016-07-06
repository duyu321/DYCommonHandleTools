//
//  UIImage+DY.m
//  DYMainViewController
//
//  Created by 杜宇 on 15/8/6.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

#import "UIImage+DY.h"

// 图片底色处理
@implementation UIImage (DY)

@dynamic type;

+ (UIImage *)grayscale:(UIImage *)anImage type:(ImageType)type
{
    CGImageRef imageRef = anImage.CGImage;
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    UInt8 *buffer = (UInt8*)CFDataGetBytePtr(data);
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8 *tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            UInt8 brightness;
            switch (type) {
                case ImageTypeWhiteBlace:
                    // 黑白
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                case ImageTypeThin:
                    // 原图（变淡）
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                case ImageTypeExposure:
                    // 曝光
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
        }
    }
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    CGImageRef effectedCgImage = CGImageCreate(width, height,bitsPerComponent, bitsPerPixel, bytesPerRow,colorSpace, bitmapInfo, effectedDataProvider,NULL, shouldInterpolate, intent);
    UIImage *effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    return effectedImage;
}

// 图片裁剪成圆,加边框
+ (UIImage *)circleWithImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
//    UIImage *oldImage = oldImage;
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 自定义大小裁剪图片
+ (NSData *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImagePNGRepresentation(image) ? UIImagePNGRepresentation(image) : UIImageJPEGRepresentation(newImage, 0.8);
}

// 打水印
+ (UIImage *)waterImageWithBg:(UIImage *)bg logo:(UIImage *)logo
{
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    UIGraphicsBeginImageContextWithOptions(bg.size, NO, 0.0);
    
    // 2.画背景
    [bg drawInRect:CGRectMake(0, 0, bg.size.width, bg.size.height)];
    
    // 3.画右下角的水印
    CGFloat scale = 0.2;
    CGFloat margin = 5;
    CGFloat waterW = logo.size.width * scale;
    CGFloat waterH = logo.size.height * scale;
    CGFloat waterX = bg.size.width - waterW - margin;
    CGFloat waterY = bg.size.height - waterH - margin;
    [logo drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
