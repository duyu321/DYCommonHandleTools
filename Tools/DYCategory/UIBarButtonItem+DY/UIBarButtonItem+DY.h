//
//  UIBarButtonItem+DY.h
//  A_Big_Demo
//
//  Created by 杜宇 on 16/2/26.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DY)

/**
 *  设置UIBarButtonItem的背景图片(清除默认蓝色)
 *
 *  @param image     image
 *  @param highImage highImage
 *  @param target    self
 *  @param action    sel
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
