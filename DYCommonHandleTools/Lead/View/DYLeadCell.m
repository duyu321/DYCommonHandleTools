//
//  DYLeadCell.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/22.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYLeadCell.h"

@interface DYLeadCell ()

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *detail;
@property (strong, nonatomic) UIView *line;

@end

@implementation DYLeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.name = [[UILabel alloc] init];
        self.detail.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.name];
        
        self.detail = [[UILabel alloc] init];
        self.detail.font = [UIFont systemFontOfSize:14];
        self.detail.textColor = [UIColor lightGrayColor];
        self.detail.numberOfLines = 0;
        [self.contentView addSubview:self.detail];
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor colorFromHexRGB:@"dddddd"];
        [self.contentView addSubview:self.line];
        
        CGFloat margin = 10;
        
        self.name.sd_layout
        .leftSpaceToView(self.contentView,margin)
        .rightSpaceToView(self.contentView,margin)
        .topSpaceToView(self.contentView,margin)
        .autoHeightRatio(0);
        
        self.detail.sd_layout
        .leftEqualToView(self.name)
        .rightEqualToView(self.name)
        .topSpaceToView(self.name,margin)
        .autoHeightRatio(0);
        
        self.line.sd_layout
        .leftSpaceToView(self.contentView,12)
        .rightSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.detail,5)
        .heightIs(.5f);
        
        [self setupAutoHeightWithBottomViewsArray:@[self.name,self.detail,self.line] bottomMargin:margin];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 3;
    
    [super setFrame:frame];
}

- (void)setLeadModel:(DYLeadModel *)leadModel
{
    _leadModel = leadModel;
    self.name.text = leadModel.name;
    self.detail.text = leadModel.detail;
}

@end
