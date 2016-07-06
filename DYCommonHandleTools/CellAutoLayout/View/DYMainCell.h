//
//  DYMainCell.h
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/15.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMainModel.h"

@interface DYMainCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLB;
@property (strong, nonatomic) UIView *icon;
@property (strong, nonatomic) DYMainModel *mainModel;

@end
