//
//  UIColor+DY.m
//  DYCategoryInfo
//
//  Created by 杜宇 on 15/8/9.
//  Copyright (c) 2015年 Pactera. All rights reserved.
//

#import "UIColor+DY.h"

@implementation UIColor (DY)

#pragma mark 16#转rgb
+ (UIColor *)colorFromHexRGB:(NSString *)ColorString{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != ColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:ColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

#pragma mark - 随机颜色
+ (UIColor *)colorWithRandomColor
{
    CGFloat red = arc4random_uniform(255)/255.0;
    CGFloat green = arc4random_uniform(255)/255.0;
    CGFloat blue = arc4random_uniform(255)/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
