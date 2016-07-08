//
//  DYMainCell.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/15.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYMainCell.h"

@implementation DYMainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.icon = [[UIImageView alloc] init];
        self.icon.image = [UIImage imageNamed:@"index"];
        self.icon.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.icon];
        
        self.nameLB = [[UILabel alloc] init];
        self.nameLB.textColor = [UIColor blackColor];
        self.nameLB.font = [UIFont systemFontOfSize:16];
        self.nameLB.numberOfLines = 1;
        [self.contentView addSubview:self.nameLB];
        
        self.detailLB = [[UILabel alloc] init];
        self.detailLB.textColor = [UIColor grayColor];
        self.detailLB.font = [UIFont systemFontOfSize:13];
        self.detailLB.numberOfLines = 0;
        [self.contentView addSubview:self.detailLB];
        
        
        // 设置约束
        CGFloat margin = 10;
        
        self.icon.sd_layout
        .topSpaceToView(self.contentView,margin)
        .leftSpaceToView(self.contentView,margin)
        .widthIs(50)
        .heightIs(50);
        
        // 设置Label时,如果不设置高度,那就用autoHeightRatio(0)自适应
        self.nameLB.sd_layout
        .topEqualToView(self.icon)
        .leftSpaceToView(self.icon,margin)
        .rightSpaceToView(self.contentView,margin)
        .autoHeightRatio(0);
        
        self.detailLB.sd_layout
        .topSpaceToView(self.nameLB,margin-4)
        .leftEqualToView(self.nameLB)
        .rightEqualToView(self.nameLB)
        .autoHeightRatio(0);
//        [self.detailLB setMaxNumberOfLinesToShow:6];
        
        // Cell上的控件不需要设置距离Cell最底部的距离, 在这里bottomMargin设置
        [self setupAutoHeightWithBottomViewsArray:@[self.nameLB,self.icon,self.detailLB]
                                     bottomMargin:margin];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 3;
    
    // super必须写在后面
    [super setFrame:frame];
}

- (void)setMainModel:(DYMainModel *)mainModel
{
    _mainModel = mainModel;
    self.nameLB.text = mainModel.name;
    self.detailLB.text = mainModel.detail;
}

@end
