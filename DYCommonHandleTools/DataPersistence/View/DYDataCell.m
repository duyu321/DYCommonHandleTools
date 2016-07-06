//
//  DYDataCell.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/20.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYDataCell.h"

@interface DYDataCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation DYDataCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setData:(DYDataModel *)data
{
    _data = data;
    _nameLabel.text = data.name;
    _numLabel.text = data.num;
}

@end
