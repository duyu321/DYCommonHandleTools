//
//  DYFirstViewController.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/16.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYLoadHtmlViewController.h"
#import "DYFirstCell.h"
#import "DYFirstRequestModel.h"
#import "DYFirstResponseModel.h"

@interface DYLoadHtmlViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<DYFirstResponseModel *> *tagsArray;

@end

static NSString * const cellID = @"firstCell";

@implementation DYLoadHtmlViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 65;
        [self.view addSubview:_tableView];
        
        _tableView.sd_layout
        .topSpaceToView(self.view,0)
        .bottomSpaceToView(self.view,0)
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0);
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

- (void)setupUI
{
    self.title = @"网络请求";
    [self.tableView registerClass:[DYFirstCell class] forCellReuseIdentifier:cellID];
}

- (void)loadData
{
    DYFirstRequestModel *requestModel = [[DYFirstRequestModel alloc] init];
    requestModel.a = @"tag_recommend";
    requestModel.action = @"sub";
    requestModel.c = @"topic";
    
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD show];
    
    [DYAFNCommonHandleTool executeGETWithManager:self.manager BaseUrl:baseUrl suffixUrl:nil paramters:requestModel success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        self.tagsArray = [DYFirstResponseModel mj_objectArrayWithKeyValuesArray:responseObject];
        NSLog(@"");
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求出错"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tagsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DYFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.first = self.tagsArray[indexPath.row];
    return cell;
}

@end
