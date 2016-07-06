//
//  UIButton+DY.h
//  A_Big_Demo
//
//  Created by 杜宇 on 16/3/1.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DY)

/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */
- (void)startWithTime:(NSInteger)timeLine
                title:(NSString *)title
       countDownTitle:(NSString *)subTitle
            mainColor:(UIColor *)mColor
           countColor:(UIColor *)color;

@end
