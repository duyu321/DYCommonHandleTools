//
//  DYFirstCell.h
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/16.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYFirstResponseModel.h"

@interface DYFirstCell : UITableViewCell

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *fans;
@property (strong, nonatomic) UIButton *attention;

@property (strong, nonatomic) DYFirstResponseModel *first;

@end
