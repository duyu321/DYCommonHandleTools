//
//  DYImageProcessingViewController.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/29.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYImageProcessingViewController.h"

@interface DYImageProcessingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UIImageView *exposureImg;
@property (weak, nonatomic) IBOutlet UIImageView *singleImg;
@property (weak, nonatomic) IBOutlet UIImageView *watermarkImg;

@end

@implementation DYImageProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片处理";
    
    // 设置圆形头像图片裁剪
    [self setIcon];
    
    // 图片颜色处理
    [self setMultiple];
    
    // 图片水印处理
    [self setWatermark];
}

- (void)setIcon
{
    self.iconImg.image = [UIImage circleWithImage:[UIImage imageNamed:@"index"] borderWidth:3 borderColor:[UIColor colorFromHexRGB:@"dddddd"]];
}

- (void)setMultiple
{
    self.exposureImg.image = [UIImage grayscale:[UIImage imageNamed:@"index"] type:ImageTypeExposure];
    
    self.singleImg.image = [UIImage grayscale:[UIImage imageNamed:@"index"] type:ImageTypeWhiteBlace];
}

- (void)setWatermark
{
    self.watermarkImg.image = [UIImage waterImageWithBg:[UIImage imageNamed:@"index"] logo:[UIImage imageNamed:@"shuiyin"]];
}

@end
