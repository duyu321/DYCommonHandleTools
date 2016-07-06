//
//  NSArray+Extension.h
//  testtools
//
//  Created by 杜宇 on 16/3/29.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/**
 *  返回当前类的所有属性
 *
 *  @param cls 类
 *
 *  @return 类的所有属性
 */
+ (instancetype)getProperties:(Class)cls;

@end
