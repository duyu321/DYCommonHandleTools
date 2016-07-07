//
//  DYBaseViewController.m
//  A_Big_Demo
//
//  Created by 杜宇 on 16/2/26.
//  Copyright © 2016年 杜宇. All rights reserved.
//

#import "DYBaseViewController.h"

@interface DYBaseViewController ()

@property (nonatomic, strong) UIViewController *currentShowVC;
@property (nonatomic, strong) UILabel *lb;

@end

@implementation DYBaseViewController

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UILabel *)lb
{
    if (_lb == nil) {
        _lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _lb.text = @"暂无数据";
        _lb.font = [UIFont systemFontOfSize:14.0f];
        _lb.textColor = [UIColor grayColor];
        _lb.center = CGPointMake(self.view.frame.size.width/2+15, self.view.frame.size.height/2-50);
        [self.view addSubview:_lb];
    }
    return _lb;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"efeff4"];
}

#pragma mark - 添加侧滑切换控制器方法
-(void)viewWillAppear:(BOOL)animated {
    
    // 设置代理
    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
    
    // 启用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器，这里我的项目是有tabbar，所以在页面切换之间设置是否显示tababr。
    if (self.navigationController.viewControllers.count == 1){
        // 将当前导航控制器置空
        self.currentShowVC = Nil;
    } else {
        // 如果不是根控制器，就设置当前导航控制器为其本身。
        self.currentShowVC = self;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        // 当前导航控制器是根视图控制器
        // the most important
        [SVProgressHUD dismiss];
        return (self.currentShowVC == self.navigationController.topViewController);
    }
    return YES;
}

#pragma mark - 以下两个方法：加载中隐藏默认UI，加载完毕后全部显示
- (void)hideAllViewTrue
{
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[UILabel class]]||[v isKindOfClass:[UIImageView class]]||[v isKindOfClass:[UITableView class]]||[v isKindOfClass:[UIButton class]]||[v isKindOfClass:[UIView class]]||[v isKindOfClass:[UICollectionViewController class]]) {
            v.hidden = YES;
        }
    }
    self.lb.hidden = NO;
}

- (void)showAllViewTrue
{
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[UILabel class]]||[v isKindOfClass:[UIImageView class]]||[v isKindOfClass:[UITableView class]]||[v isKindOfClass:[UIButton class]]||[v isKindOfClass:[UIView class]]||[v isKindOfClass:[UICollectionView class]]) {
            v.hidden = NO;
        }
    }
    self.lb.hidden = YES;
}

// 切换控制器时销毁所有http请求
- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}

@end
