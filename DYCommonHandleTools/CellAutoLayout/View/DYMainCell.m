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
        
        self.nameLB = [[UILabel alloc] init];
        self.nameLB.textColor = [UIColor grayColor];
        self.nameLB.font = [UIFont systemFontOfSize:13];
        self.nameLB.numberOfLines = 0;
        [self.contentView addSubview:self.nameLB];
        
        self.icon = [[UIView alloc] init];
        self.icon.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.icon];
        
        // 设置约束
        CGFloat margin = 10;
        
        self.icon.sd_layout
        .topSpaceToView(self.contentView,margin)
        .leftSpaceToView(self.contentView,margin)
        .widthIs(50)
        .heightIs(50);
        
        self.nameLB.sd_layout
        .topEqualToView(self.icon)
        .leftSpaceToView(self.icon,margin)
        .rightSpaceToView(self.contentView,margin)
        .autoHeightRatio(0);
//        [self.nameLB setMaxNumberOfLinesToShow:6];
        
        
        [self setupAutoHeightWithBottomViewsArray:@[self.nameLB,self.icon] bottomMargin:margin];
        
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
}

@end
