//
//  UIImage+DY.h
//  DYMainViewController
//
//  Created by 杜宇 on 15/8/6.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ImageTypeWhiteBlace = 0,
    ImageTypeThin = 1,
    ImageTypeExposure = 2,
    ImageTypeNormal = 3
} ImageType;

@interface UIImage (DY)

@property (assign, nonatomic) ImageType type;

/**
*  图片底色处理
*
*  @param anImage 要处理的图片
*  @param type    1:黑白 2:变淡 3:曝光 其他:原图
*
*  @return 处理好的图片
*/
+ (UIImage *)grayscale:(UIImage *)anImage type:(ImageType)type;

/**
 *  图片裁剪成圆,加边框
 *
 *  @param name        图片名称
 *  @param borderWidth 外边框宽度
 *  @param borderColor 外边框颜色
 *
 *  @return 裁剪好的图片
 */
+ (UIImage *)circleWithImage:(UIImage *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  自定义大小裁剪图片
 *
 *  @param image   需要裁剪的图片
 *  @param newSize 裁剪的比例
 *
 *  @return 裁剪后的图片data
 */
+ (NSData *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 */
+ (UIImage *)waterImageWithBg:(UIImage *)bg logo:(UIImage *)logo;

@end
