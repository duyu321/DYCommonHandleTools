//
//  DYFirstCell.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/16.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYFirstCell.h"

@implementation DYFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.icon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.icon];
        
        self.name = [[UILabel alloc] init];
        self.name.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.name];
        
        self.fans = [[UILabel alloc] init];
        self.fans.font = [UIFont systemFontOfSize:13];
        self.fans.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.fans];
        
        self.attention = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.attention setBackgroundImage:[UIImage imageNamed:@"FollowBtnBg"] forState:UIControlStateNormal];
        [self.attention setTitle:@"+ 关注" forState:UIControlStateNormal];
        [self.attention setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.attention setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.attention.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.attention];
        
        CGFloat margin = 10;
        
        self.attention.sd_layout
        .widthIs(50)
        .heightIs(25)
        .rightSpaceToView(self.contentView,margin)
        .centerXEqualToView(self.contentView)
        .centerYEqualToView(self.contentView);
        
        self.icon.sd_layout
        .widthIs(50)
        .heightIs(50)
        .leftSpaceToView(self.contentView,margin)
        .centerYEqualToView(self.contentView)
        .centerXEqualToView(self.contentView);
        
        self.name.sd_layout
        .leftSpaceToView(self.icon,margin)
        .rightSpaceToView(self.attention,margin)
        .topEqualToView(self.icon)
        .autoHeightRatio(0);
        
        self.fans.sd_layout
        .leftSpaceToView(self.icon,margin)
        .bottomEqualToView(self.icon)
        .widthIs(100)
        .autoHeightRatio(0);
    }
    return self;
}

- (void)setFirst:(DYFirstResponseModel *)first
{
    _first = first;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:first.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.name.text = first.theme_name;
    self.fans.text = [NSString stringWithFormat:@"%zd",first.sub_number];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 3;
    
    // super必须写在后面
    [super setFrame:frame];
}

@end
