//
//  UIColor+DY.h
//  DYCategoryInfo
//
//  Created by 杜宇 on 15/8/9.
//  Copyright (c) 2015年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DY)
/**
 *  16#转RGB
 *
 *  @param inColorString 16#
 *
 *  @return 转换完的颜色
 */
+ (UIColor *)colorFromHexRGB:(NSString *)ColorString;
/**
 *  随机颜色
 *
 *  @return 随机颜色
 */
+ (UIColor *)colorWithRandomColor;
@end
