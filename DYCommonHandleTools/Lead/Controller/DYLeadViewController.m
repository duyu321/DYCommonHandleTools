//
//  DYLeadViewController.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/17.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYLeadViewController.h"
#import "DYCellAutoLayoutViewController.h"
#import "DYLoadHtmlViewController.h"
#import "DYDataPersistenceViewController.h"
#import "DYImageProcessingViewController.h"
#import "DYCountDownViewController.h"
#import "DYLeadModel.h"
#import "DYLeadCell.h"

@interface DYLeadViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *leadArray;
@property (strong, nonatomic) UITableView *tableView;

@end

static NSString * const leadCellID = @"lead";

@implementation DYLeadViewController

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@{@"name":@"Cell高度自适应",@"detail":@"仅需几行代码,即可对tableviewcell高度自适应,优化了滑动卡顿的现象.使得滑动更加流畅."},
                       @{@"name":@"网络请求",@"detail":@"封装AFN的网络请求,包含post,get,上传,下载等异步操作,添加切换控制器杀掉请求的方法,完美解决了切换控制器程序崩溃的bug,使用非常简单,仅需一个方法,具体使用详见code."},
                       @{@"name":@"数据持久化",@"detail":@"封装FMDB的数据持久化工具类,提供了两套CRUD操作数据库的方法,一套是不适用数据模型情况下直接书写SQL完成CRUD,另一套是利用Rumtime运行时机制,直接传递数据模型进行数据持久化,使用非常简单,具体使用详见code."},
                       @{@"name":@"图片处理",@"detail":@"提供了一套简单的图片处理的UIImage分类工具,功能有图片裁剪成圆(可带边框),图片颜色处理(黑白,曝光,图片颜色变浅等),图片打水印等功能,使用简单,UIImage直接调用类方法即可."},
                       @{@"name":@"按钮倒计时",@"detail":@"给UIButton封装了一个类似于获取验证码的倒计时的分类工具,使用简单,UIButton直接调用,一行代码搞定!"}];
    }
    return _dataArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CommonHandleTool";
    
    self.leadArray = [DYLeadModel mj_objectArrayWithKeyValuesArray:self.dataArray];
    
    [self.tableView registerClass:[DYLeadCell class] forCellReuseIdentifier:leadCellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leadArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYLeadCell *cell = [tableView dequeueReusableCellWithIdentifier:leadCellID];
    if (!cell) {
        cell = [[DYLeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leadCellID];
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.leadModel = self.leadArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYLeadModel *leadModel = self.leadArray[indexPath.row];
    
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self.tableView cellHeightForIndexPath:indexPath model:leadModel keyPath:@"leadModel" cellClass:[DYLeadCell class] contentViewWidth:self.view.width];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    indexPath.row == 0 ? [self.navigationController pushViewController:[[DYCellAutoLayoutViewController alloc] init] animated:YES] : indexPath.row == 1 ? [self.navigationController pushViewController:[[DYLoadHtmlViewController alloc] init] animated:YES] : indexPath.row == 2 ? [self.navigationController pushViewController:[[DYDataPersistenceViewController alloc] init] animated:YES] : indexPath.row == 3 ? [self.navigationController pushViewController:[[DYImageProcessingViewController alloc] init] animated:YES] : [self.navigationController pushViewController:[[DYCountDownViewController alloc] init] animated:YES];
    
}

@end
