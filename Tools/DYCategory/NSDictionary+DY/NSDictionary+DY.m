//
//  NSDictionary+DY.m
//  A_Big_Demo
//
//  Created by 杜宇 on 16/3/1.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "NSDictionary+DY.h"

@implementation NSDictionary (DY)

// jsonStr转Dictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
