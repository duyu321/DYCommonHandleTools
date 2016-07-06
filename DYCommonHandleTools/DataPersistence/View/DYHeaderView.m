//
//  DYHeaderView.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/20.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYHeaderView.h"

@implementation DYHeaderView

+ (instancetype)header
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DYHeaderView class]) owner:nil options:nil] firstObject];
}

@end
