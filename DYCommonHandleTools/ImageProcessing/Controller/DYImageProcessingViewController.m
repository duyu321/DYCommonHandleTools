//
//  DYImageProcessingViewController.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/29.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYImageProcessingViewController.h"

@interface DYImageProcessingViewController ()

@property (strong, nonatomic) UIScrollView *contentView;

@property (strong, nonatomic) UILabel *firstLabel;
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UIView *line1;

@property (strong, nonatomic) UILabel *secondLabel;
@property (strong, nonatomic) UIImageView *exposureImg;
@property (strong, nonatomic) UILabel *oneLabel;
@property (strong, nonatomic) UIImageView *singleImg;
@property (strong, nonatomic) UILabel *twoLabel;
@property (strong, nonatomic) UIView *line2;

@property (strong, nonatomic) UILabel *thirdLabel;
@property (strong, nonatomic) UIImageView *watermarkImg;

@end

@implementation DYImageProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片处理";
    
    [self setupUI];
    
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

- (void)setupUI
{
    self.contentView = [[UIScrollView alloc] init];
    [self.view addSubview:self.contentView];
    
    self.firstLabel = [[UILabel alloc] init];
    self.firstLabel.text = @"圆形头像裁剪,带边框";
    self.firstLabel.numberOfLines = 1;
    self.firstLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.firstLabel];
    
    self.iconImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImg];
    
    self.line1 = [[UIImageView alloc] init];
    self.line1.backgroundColor = [UIColor colorFromHexRGB:@"dddddd"];
    [self.contentView addSubview:self.line1];
    
    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.text = @"图片颜色处理";
    self.secondLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.secondLabel];
    
    self.exposureImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.exposureImg];
    
    self.oneLabel = [[UILabel alloc] init];
    self.oneLabel.text = @"曝光";
    self.oneLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.oneLabel];
    
    self.singleImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.singleImg];
    
    self.twoLabel = [[UILabel alloc] init];
    self.twoLabel.text = @"黑白";
    self.twoLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.twoLabel];
    
    self.line2 = [[UIImageView alloc] init];
    self.line2.backgroundColor = [UIColor colorFromHexRGB:@"dddddd"];
    [self.contentView addSubview:self.line2];
    
    self.thirdLabel = [[UILabel alloc] init];
    self.thirdLabel.text = @"图片水印处理";
    self.thirdLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.thirdLabel];
    
    self.watermarkImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.watermarkImg];
    
    self.contentView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    self.firstLabel.sd_layout
    .topSpaceToView(self.contentView,30)
    .centerXEqualToView(self.contentView)
    .autoHeightRatio(0);
    // 设置单行Label宽高自适应
    [self.firstLabel setSingleLineAutoResizeWithMaxWidth:320];
    
    self.iconImg.sd_layout
    .heightIs(50)
    .widthIs(50)
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.firstLabel,40);
    
    self.line1.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1)
    .topSpaceToView(self.iconImg,25);
    
    self.secondLabel.sd_layout
    .topSpaceToView(self.iconImg,60)
    .centerXEqualToView(self.contentView)
    .autoHeightRatio(0);
    // 设置单行Label宽度自适应
    [self.secondLabel setSingleLineAutoResizeWithMaxWidth:320];
    
    self.exposureImg.sd_layout
    .heightIs(50)
    .widthIs(50)
    .topSpaceToView(self.secondLabel,30)
    .centerXIs(0.25*self.view.width);
    
    self.oneLabel.sd_layout
    .topSpaceToView(self.exposureImg,10)
    .centerXEqualToView(self.exposureImg)
    .autoHeightRatio(0);
    // 设置单行Label宽高自适应
    [self.oneLabel setSingleLineAutoResizeWithMaxWidth:320];
    
    self.singleImg.sd_layout
    .heightIs(50)
    .widthIs(50)
    .topSpaceToView(self.secondLabel,30)
    .centerXIs(0.75*self.view.width);
    
    self.twoLabel.sd_layout
    .topSpaceToView(self.singleImg,10)
    .centerXEqualToView(self.singleImg)
    .autoHeightRatio(0);
    // 设置单行Label宽高自适应
    [self.twoLabel setSingleLineAutoResizeWithMaxWidth:320];
    
    self.line2.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1)
    .topSpaceToView(self.twoLabel,25);
    
    self.thirdLabel.sd_layout
    .topSpaceToView(self.twoLabel,60)
    .centerXEqualToView(self.contentView)
    .autoHeightRatio(0);
    // 设置单行Label宽高自适应
    [self.thirdLabel setSingleLineAutoResizeWithMaxWidth:320];
    
    self.watermarkImg.sd_layout
    .heightIs(150)
    .widthIs(150)
    .topSpaceToView(self.thirdLabel,30)
    .centerXEqualToView(self.contentView);
    
    [self.contentView setupAutoContentSizeWithBottomView:self.watermarkImg bottomMargin:20];
}

@end
