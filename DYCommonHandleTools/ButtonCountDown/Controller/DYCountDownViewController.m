//
//  DYCountDownViewController.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/7/4.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYCountDownViewController.h"

@interface DYCountDownViewController ()
@property (strong, nonatomic) UIButton *btn;
@end

@implementation DYCountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"按钮处理";
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.btn.backgroundColor = [UIColor colorWithRed:84 / 255.0 green:180 / 255.0 blue:98 / 255.0 alpha:1.0f];
    [self.btn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 5;
    [self.view addSubview:self.btn];
    
    self.btn.sd_layout
    .widthIs(100)
    .heightIs(30)
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view);
}

- (void)btnClick
{
    [self.btn startWithTime:59
                    title:@"点击重新获取"
           countDownTitle:@"s后重新获取"
                mainColor:[UIColor colorWithRed:84 / 255.0 green:180 / 255.0 blue:98 / 255.0 alpha:1.0f]
               countColor:[UIColor grayColor]];
}

@end
