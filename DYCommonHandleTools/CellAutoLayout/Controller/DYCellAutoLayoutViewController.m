//
//  DYMainViewController.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/15.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYCellAutoLayoutViewController.h"
#import "DYMainCell.h"
#import "DYMainModel.h"



@interface DYCellAutoLayoutViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

static NSString * const mainID = @"main";

@implementation DYCellAutoLayoutViewController

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i<50; i++) {
            DYMainModel *main = [[DYMainModel alloc] init];
            main.name = [NSString stringWithFormat:@"%zd",arc4random_uniform(10)];
            if (i == 3) {
                main.name = @"的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶的速度还是对奇偶";
            }
            [_dataArray addObject:main];
        }
    }
    return _dataArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"Cell高度自适应";
    
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1.0f];
    
    [self.tableView registerClass:[DYMainCell class] forCellReuseIdentifier:mainID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
    if (!cell) {
        cell = [[DYMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainID];
    }
    
    cell.mainModel = self.dataArray[indexPath.row];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    ///////////////////////////////////////////////////////////////////////
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYMainModel *mainModel = self.dataArray[indexPath.row];
    
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self.tableView cellHeightForIndexPath:indexPath model:mainModel keyPath:@"mainModel" cellClass:[DYMainCell class] contentViewWidth:self.view.width];
}

@end
