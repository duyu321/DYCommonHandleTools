//
//  DYBaseViewController.h
//  A_Big_Demo
//
//  Created by 杜宇 on 16/2/26.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface DYBaseViewController : UIViewController

@property (strong, nonatomic)AFHTTPSessionManager *manager;

/**
 *  隐藏全部UI
 */
- (void)hideAllViewTrue;

/**
 *  显示全部UI
 */
- (void)showAllViewTrue;

@end
