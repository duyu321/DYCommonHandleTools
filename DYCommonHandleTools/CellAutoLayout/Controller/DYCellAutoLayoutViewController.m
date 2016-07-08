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
@property (strong, nonatomic) NSArray *nameArray;
@property (strong, nonatomic) NSArray *detailArray;

@end

static NSString * const mainID = @"main";

@implementation DYCellAutoLayoutViewController

- (NSArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = @[@"Cell高度自适应",@"网络请求",@"数据持久化",@"图片处理",@"按钮倒计时"];
    }
    return _nameArray;
}

- (NSArray *)detailArray
{
    if (!_detailArray) {
        _detailArray = @[@"仅需几行代码,即可对tableviewcell高度自适应,优化了滑动卡顿的现象.使得滑动更加流畅.",@"封装AFN的网络请求,包含post,get,上传,下载等异步操作,添加切换控制器杀掉请求的方法,完美解决了切换控制器程序崩溃的bug,使用非常简单,仅需一个方法,具体使用详见code.",@"封装FMDB的数据持久化工具类,提供了两套CRUD操作数据库的方法,",@"一套是不适用数据模型情况下直接书写SQL完成CRUD,另一套是利用Rumtime运行时机制,直接传递数据模型进行数据持久化,使用非常简单,具体使用详见code.",@"提供了一套简单的图片处理的UIImage分类工具,功能有图片裁剪成圆(可带边框),图片颜色处理(黑白,曝光,图片颜色变浅等),图片打水印等功能,使用简单,UIImage直接调用类方法即可.",@"给UIButton封装了一个类似于获取验证码的倒计时的分类工具,使用简单,UIButton直接调用,一行代码搞定!"];
    }
    return _detailArray;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [self addData];
    }
    return _dataArray;
}

- (void)addData
{
    for (int i = 0; i<6; i++) {
        DYMainModel *main = [[DYMainModel alloc] init];
        main.name = self.nameArray[arc4random_uniform((int)self.nameArray.count)];
        main.detail = self.detailArray[arc4random_uniform((int)self.detailArray.count)];
        [_dataArray addObject:main];
    }
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
    
    [self setupRefresh];
}

- (void)setupUI
{
    self.title = @"Cell高度自适应";
    
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1.0f];
    
    [self.tableView registerClass:[DYMainCell class] forCellReuseIdentifier:mainID];
}

- (void)setupRefresh
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshTableview)];
}

- (void)refreshTableview
{
    [self addData];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
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
