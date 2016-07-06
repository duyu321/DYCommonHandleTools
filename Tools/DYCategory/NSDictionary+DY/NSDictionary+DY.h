//
//  NSDictionary+DY.h
//  A_Big_Demo
//
//  Created by 杜宇 on 16/3/1.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DY)

/**
 *  字符串转字典
 *
 *  @param jsonString json格式的字符串
 *
 *  @return 通过字符串转换后的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
