//
//  DYDataPersistenceViewController.m
//  DYCommonHandleTools
//
//  Created by 杜宇 on 16/6/17.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYDataPersistenceViewController.h"
#import "DYHeaderView.h"
#import "DYDataCell.h"
#import "DYDataModel.h"

@interface DYDataPersistenceViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *deleteTextField;
@property (weak, nonatomic) IBOutlet UITextField *oldNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *newsNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<NSString *> *FirstNameArray;
@property (strong, nonatomic) NSArray<NSString *> *LastNameArray;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

#define kDBName @"data.db"

static NSString * const cellID = @"dataCell";

@implementation DYDataPersistenceViewController

- (NSArray *)FirstNameArray
{
    if (!_FirstNameArray) {
        _FirstNameArray = @[@"张",@"王",@"李",@"赵",@"钱",@"孙",@"周",@"吴",@"郑",@"齐",@"孔",@"朱"];
    }
    return _FirstNameArray;
}

- (NSArray *)LastNameArray
{
    if (!_LastNameArray) {
        _LastNameArray = @[@"宇",@"文",@"斌",@"武",@"国庆",@"鹏",@"刚",@"学琴"];
    }
    return _LastNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"数据持久化";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYDataCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self select];
}

- (IBAction)add
{
    DYDataModel *dataModel = [[DYDataModel alloc] init];
    
    dataModel.name = [NSString stringWithFormat:@"%@%@",self.FirstNameArray[arc4random_uniform((int)self.FirstNameArray.count)],self.LastNameArray[arc4random_uniform((int)self.LastNameArray.count)]];
    dataModel.num = [NSString stringWithFormat:@"%zd",6000000+arc4random_uniform(1000000)];
    
    [DYFMDBCommonHandleTool executeAddDataWithDBName:kDBName andModel:dataModel andUnique:@[@"name"] succeed:^(NSString * _Nonnull succeedStr) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showSuccessWithStatus:@"添加成功!"];
    } error:^(NSString * _Nonnull errorStr) {
        [SVProgressHUD showErrorWithStatus:@"添加失败"];
    }];
    [self select];
}

- (IBAction)delete
{
    if (self.deleteTextField.text.length == 0) {
        [DYFMDBCommonHandleTool executeDeleteDataWithDBName:kDBName andClass:[DYDataModel class] andValues:nil succeed:^(NSString * _Nonnull succeedStr) {
            [SVProgressHUD showSuccessWithStatus:succeedStr];
            
            // 先删除数据库数据,然后清空dataArray的数据,再tableview删除row(有动画),不用再查数据库
            NSMutableArray *indexArray = [NSMutableArray array];
            for (int i = 0; i < self.dataArray.count; i++) {
                [indexArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            [self.dataArray removeAllObjects];
            [self.tableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop];
            
        } error:^(NSString * _Nonnull errorStr) {
            [SVProgressHUD showErrorWithStatus:errorStr];
        }];
        
        
    } else {
        [DYFMDBCommonHandleTool executeDeleteDataWithDBName:kDBName andClass:[DYDataModel class] andValues:@{@"name":self.deleteTextField.text} succeed:^(NSString * _Nonnull succeedStr) {
            [SVProgressHUD showSuccessWithStatus:succeedStr];
            
            // 先删除数据库数据,然后清空dataArray的数据,再tableview删除row(有动画),不用再查数据库
            for (int i = 0; i < self.dataArray.count; i++) {
                DYDataModel *data = self.dataArray[i];
                if ([data.name isEqualToString:self.deleteTextField.text]) {
                    [self.dataArray removeObjectAtIndex:i];
                    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
                }
            }
            
        } error:^(NSString * _Nonnull errorStr) {
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }];
    }
//    [self select];
}

- (IBAction)update
{
    if (self.newsNameTextField.text.length == 0 || self.oldNameTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写完整要修改的信息"];
        return;
    }
    [DYFMDBCommonHandleTool executeUpdateDataWithDBName:kDBName andClass:[DYDataModel class] andSetValues:@{@"num":self.newsNameTextField.text} andWhereValue:@{@"name":self.oldNameTextField.text} succeed:^(NSString * _Nonnull succeedStr) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    } error:^(NSString * _Nonnull errorStr) {
        [SVProgressHUD showSuccessWithStatus:@"修改失败"];
    }];
    [self select];
}

- (IBAction)select
{
    NSArray *selectArray = [DYFMDBCommonHandleTool executeSelectDataWithDBName:kDBName andClass:[DYDataModel class] andSelKey:nil andWhereValues:nil];
    self.dataArray = [DYDataModel mj_objectArrayWithKeyValuesArray:selectArray];
    [self.tableView reloadData];
    if (self.dataArray.count != 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DYHeaderView *header = [DYHeaderView header];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

@end
