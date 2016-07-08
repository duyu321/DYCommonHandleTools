# DYCommonHandleTools
- Pure code automatic layout, highly adaptive UITableViewCell, network request, data persistence, image processing, such as a variety of functional integration.
- 纯代码自动布局,UITableViewCell高度自适应,网络请求,数据持久化,图像处理等多种功能集成.


`GitHub`：[duyu321](https://github.com/duyu321) ｜ `Blog`：[duyu007(Chinese)](http://www.cnblogs.com/duyuiOS) ｜ PR is welcome,or `QQ`：291168744

## Contents 【目录】
* [Getting Started【开始使用】】](#Getting_Started)
	* [Features【能做什么】](#Features)
	* [Installation【安装】](#Installation)
* [Examples【示例】](#Examples)
	* [Cell Autolayout【Cell高度自适应用法简介】](#Cell_AutoLayout)
		* [普通（简化）版【推荐使用】](#Cell_AutoLayout)
		* [升级版(适应于cell条数少于100的tableview)](#Cell_Updated)
	* [Network Request【请求网络用法介绍】](#Network_Request)
		* [Network Post【post请求用法】](#Network_Post)
		* [Network Get【get请求用法】](#Network_Get)
		* [Network DownLoad【下载文件用法】](#Network_DownLoad)
	* [Data persistence【数据持久化用法介绍】](#Data_Persistence)
		* [CRUD--->C(Create) 【添加数据】](#CRUD_C)
		* [CRUD--->R(Retrieve) 【查找数据】](#CRUD_R)
		* [CRUD--->U(Updata) 【修改数据】](#CRUD_U)
		* [CRUD--->D(Delete) 【删除数据】](#CRUD_D)
	* [Processing Image【图片处理】](#Processing_Image)
		* [Pictures cut into a circle 【图片裁剪成圆】](#Circle_Image)
		* [Processing Picture Color 【图片颜色处理】](#Color_Image)
		* [Processing Picture Water 【图片水印处理】](#Water_Image)
	* [Button Countdown【按钮倒计时】](#Button_Countdown)

---


# <a id="Getting_Started"></a> Getting Started【开始使用】

## <a id="Features"></a> Features【能做什么】
- DYCommonHandleTools是一套企业开发应用时常用到请求网络,自动布局,图片处理的等使用方法封装的工具库
* `AutoLayout` : `普通view布局`、`Cell高度自适应`
* `网络请求` : `get`、`post`、`文件下载`
* `数据持久化` : `Create`、`Retrieve`、`Updata `、`Delete`
* `图片处理` : `裁剪成圆`、`色调处理`、`水印处理`
* `按钮处理` : `倒计时`
* Need only one line of code, can realize the corresponding function
    * 只需要一行代码，就能实现对应功能

## <a id="Installation"></a> Installation【安装】


### Manually【手动导入】
- Drag all source files under floder `Tools` to your project.【将`Tools`文件夹中的所有源代码拽入项目中】
- Import the main header file：`#import "DYCommonHandleTools.h"`【导入主头文件：`#import "DYCommonHandleTools.h"`】

```objc
DYCommonHandleTools.h        NSObject+DY.h
DYFMDBCommonHandleTool.h     UIColor+DY.h
DYAFNCommonHandleTool.h      UIBarButtonItem+DY.h
DYCategory.h                 NSDictionary+DY.h
UIImage+DY.h                 UIButton+DY.h
UIView+DY.h                  NSArray+DY.h
```
# <a id="Examples"></a> Examples【示例】

##  <a id="Cell_AutoLayout"></a> Cell Autolayout【Cell高度自适应用法简介】  

#### <a id="Cell_Normal"></a> 普通（简化）版【推荐使用】：tableview 高度自适应设置只需要2步

```objc
// 1. >> 设置cell高度自适应：
// cell布局设置好之后调用此方法就可以实现高度自适应（注意：如果用高度自适应则不要再以cell的底边为参照去布局其子view）
[cell setupAutoHeightWithBottomView:_view4 bottomMargin:10];

// 2. >> 获取自动计算出的cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	id model = self.modelsArray[indexPath.row];
	// 获取cell高度
	return [self.tableView cellHeightForIndexPath:indexPath
                                            model:model
                                          keyPath:@"model"
                                        cellClass:[DemoVC9Cell class]
                                 contentViewWidth:cellContentViewWith];
}
```
---

#### <a id="Cell_Updated"></a> 升级版（适应于cell条数少于100的tableview）：tableview 高度自适应设置只需要2步


```objc
// 1. >> 设置cell高度自适应：
// cell布局设置好之后调用此方法就可以实现高度自适应（注意：如果用高度自适应则不要再以cell的底边为参照去布局其子view）
[cell setupAutoHeightWithBottomView:_view4 bottomMargin:10];

// 2. >> 获取自动计算出的cell高度 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 获取cell高度
	return [self cellHeightForIndexPath:indexPath
                   cellContentViewWidth:[UIScreen mainScreen].bounds.size.width];
}
```

---

#### <a id="Layout_Tips"></a> Cell高度自适应Tips

```objc
// 先给Cell上的空间分配存储空间
self.icon = [[UIView alloc] init];
self.icon.backgroundColor = [UIColor redColor];
[self.contentView addSubview:self.icon];
        
self.nameLB = [[UILabel alloc] init];
self.nameLB.textColor = [UIColor orangeColor];
self.nameLB.font = [UIFont systemFontOfSize:19];
self.nameLB.numberOfLines = 1;
[self.contentView addSubview:self.nameLB];
        
self.detailLB = [[UILabel alloc] init];
self.detailLB.textColor = [UIColor grayColor];
self.detailLB.font = [UIFont systemFontOfSize:13];
self.detailLB.numberOfLines = 0;
[self.contentView addSubview:self.detailLB];
        
        
// 设置约束
CGFloat margin = 10;
        
self.icon.sd_layout
.topSpaceToView(self.contentView,margin)
.leftSpaceToView(self.contentView,margin)
.widthIs(50)
.heightIs(50);

// 设置Label时,如果不设置高度,那就用autoHeightRatio(0)自适应
self.nameLB.sd_layout
.topEqualToView(self.icon)
.leftSpaceToView(self.icon,margin)
.rightSpaceToView(self.contentView,margin)
.autoHeightRatio(0);
        
self.detailLB.sd_layout
.topSpaceToView(self.nameLB,margin-4)
.leftEqualToView(self.nameLB)
.rightEqualToView(self.nameLB)
.autoHeightRatio(0);
//        [self.detailLB setMaxNumberOfLinesToShow:6];

// Cell上的控件不需要设置距离Cell最底部的距离, 在这里bottomMargin:margin设置,Cell自动布局参考控件写在BottomViewsArray数组中.
[self setupAutoHeightWithBottomViewsArray:@[self.nameLB,self.icon,self.detailLB]
                             bottomMargin:margin];
```

---
	
## <a id="Network_Request"></a> Network Request【请求网络用法介绍】

####  <a id="Network_Post"></a> Network Post 【post请求用法】

```objc
// post请求(此处的self.manager是AFHTTPSessionManager,在父类实例化即可,详细见demo)
[DYAFNCommonHandleTool executeGETWithManager:self.manager
                                     BaseUrl:baseUrl
                                   suffixUrl:nil
                                   paramters:requestModel
                                     success:^(id  _Nonnull responseObject) {
                                         // success code
                                     } failure:^(NSError * _Nonnull error) {
                                         // error code
                                     }];
```
---
    
#### <a id="Network_Get"></a> Network Get 【get请求用法】
```objc
// post请求(此处的self.manager是AFHTTPSessionManager,在父类实例化即可,详细见demo)
[DYAFNCommonHandleTool executeGETWithManager:self.manager
                                     BaseUrl:baseUrl
                                   suffixUrl:nil
                                   paramters:requestModel
                                     success:^(id  _Nonnull responseObject) {
                                         // success code
                                     } failure:^(NSError * _Nonnull error) {
                                         // error code
                                     }];
```
---
    
#### <a id="Network_DownLoad"></a> Network DownLoad 【下载文件用法】

```objc
// 下载文件异步操作,默认沙盒路径,可显示进度
[DYAFNCommonHandleTool executeDownLoadWithManager:self.manager
                                          BaseUrl:baseUrl
                                        suffixUrl:nil
                                       saveToPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
                                         progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                                             // 打印进度
                                             NSLog(@"%@",[NSString stringWithFormat:@"进度==%.2f%%",100.0 * bytesProgress/totalBytesProgress]);
                                         } response:^(id  _Nonnull responseObject) {
                                             // success code
                                         } failure:^(NSError * _Nonnull error) {
                                             // error code
                                         }];
```
---

## <a id="Data_Persistence"></a> Data persistence【数据持久化用法介绍】

#### <a id="CRUD_C"></a> CRUD--->C(Create)【添加数据】

```objc
// 添加数据操作
// 1. >> 方法一:不使用数据模型,直接书写sql语句
// 注意此方法必须保证数据库存在,穿件数据库方法详见demo
[DYFMDBCommonHandleTool executeAddDataWithDBName:kDBName
                                       andAddSql:@"INSERT INTO DYDataModel (name,num) VALUES ('Tom','6098018')"
                                         succeed:^(NSString * _Nonnull succeedStr) {
                                             // success code
                                         } error:^(NSString * _Nonnull errorStr) {
                                             // error code
                                         }];
	
// 2. >> 方法二:直接传递数据模型,不需要书写sql语句,
// 注意:此方法可直接判断数据库是否存在,不存在直接创建(不需要写任何数据库创建代码),创建的表名是模型类名.
[DYFMDBCommonHandleTool executeAddDataWithDBName:kDBName
                                        andModel:dataModel
                                       andUnique:@[@"name"]
                                         succeed:^(NSString * _Nonnull succeedStr) {
                                             // success code
                                         } error:^(NSString * _Nonnull errorStr) {
                                             // error code
                                         }];
```
---
    
#### <a id="CRUD_R"></a> CRUD--->R(Retrieve) 【查找数据】

```objc
// 查找数据操作
// 1. >> 方法一:不使用数据模型,直接书写sql语句
NSArray *selectArray = [DYFMDBCommonHandleTool executeSelectDataWithDBName:kDBName
                                                                  andClass:[DYDataModel class]
                                                                 andSelKey:nil
                                                            andWhereValues:nil];
NSLog(@"%@",selectArray);

// 2. >> 方法二:直接传递数据模型,不需要书写sql语句
NSArray *selectArray = [DYFMDBCommonHandleTool executeSelectDataWithDBName:kDBName
                                                              andSelectSql:@"select * from Table"
                                                                  andClass:[DYDataModel class]
                                                         andNeedSelectData:nil];
NSLog(@"%@",selectArray);
```
---
	
#### <a id="CRUD_U"></a> CRUD--->U(Updata) 【修改数据】

```objc
// 修改数据操作
// 1. >> 方法一:不使用数据模型,直接书写sql语句
[DYFMDBCommonHandleTool executeUpdateDataWithDBName:kDBName
                                       andUpdateSql:@"update DYDataModel set num = '123' where name = 'tom'"
                                            succeed:^(NSString * _Nonnull succeedStr) {
                                                // success code
                                            } error:^(NSString * _Nonnull errorStr) {
                                                // error code
                                            }];

// 2. >> 方法二:直接传递数据模型,不需要书写sql语句
[DYFMDBCommonHandleTool executeUpdateDataWithDBName:kDBName
                                           andClass:[DYDataModel class]
                                       andSetValues:@{@"num":self.newsNameTextField.text}
                                      andWhereValue:@{@"name":self.oldNameTextField.text}
                                            succeed:^(NSString * _Nonnull succeedStr) {
                                                // success code
                                            } error:^(NSString * _Nonnull errorStr) {
                                                // error code
                                            }];
```
---
    
#### <a id="CRUD_D"></a> CRUD--->D(Delete) 【删除数据】

```objc
// 删除数据操作
// 1. >> 方法一:不使用数据模型,直接书写sql语句
[DYFMDBCommonHandleTool executeDeleteDataWithDBName:kDBName
                                       andDeleteSql:@"DELETE FROM DYDataModel WHERE name = '李文'"
                                            succeed:^(NSString * _Nonnull succeedStr) {
                                                // success code
                                            } error:^(NSString * _Nonnull errorStr) {
                                                // error code
                                            }];

// 2. >> 方法二:直接传递数据模型,不需要书写sql语句
[DYFMDBCommonHandleTool executeDeleteDataWithDBName:kDBName
                                           andClass:[DYDataModel class]
                                          andValues:nil
                                            succeed:^(NSString * _Nonnull succeedStr) {
                                                // success code
                                            } error:^(NSString * _Nonnull errorStr) {
                                                // error code
                                            }];
```
---
        
## <a id="Processing_Image"></a> Processing Image【图片处理】

### <a id="Circle_Image"></a> Pictures cut into a circle 【图片裁剪成圆】

```objc
// borderWidth:边框宽度(传0没有边框), borderColor:边框颜色
self.iconImg.image = [UIImage circleWithImage:[UIImage imageNamed:@"index"]
                                  borderWidth:3
                                  borderColor:[UIColor colorFromHexRGB:@"dddddd"]];
```
---
                
#### <a id="Color_Image"></a> Processing Picture Color 【图片颜色处理】

```objc
// type: ImageTypeWhiteBlace(黑白处理),ImageTypeExposure(曝光处理),ImageTypeThin(变淡处理)
self.exposureImg.image = [UIImage grayscale:[UIImage imageNamed:@"index"]
                                       type:ImageTypeExposure];
```
---
                                           
#### <a id="Water_Image"></a> Processing Picture Water 【图片水印处理】

```objc
// waterImageWithBg:需要打水印的图片, logo:水印图片
self.watermarkImg.image = [UIImage waterImageWithBg:[UIImage imageNamed:@"index"]
                                               logo:[UIImage imageNamed:@"shuiyin"]];
```
---

## <a id="Button_Countdown"></a> Button Countdown【按钮倒计时】

```objc
/*
 *    倒计时按钮
 *    @param time  			 倒计时总时间
 *    @param title           还没倒计时的title
 *    @param countDownTitle  倒计时的子名字 如：时、分
 *    @param mainColor       还没倒计时的颜色
 *    @param countColor      倒计时的颜色
 */
[self.btn startWithTime:59
                  title:@"点击重新获取"
         countDownTitle:@"s后重新获取"
              mainColor:[UIColor colorWithRed:84 / 255.0 green:180 / 255.0 blue:98 / 255.0 alpha:1.0f]
             countColor:[UIColor grayColor]];
```
---
        
## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢
* 如果你想为DYCommonHandleTools输出代码，请拼命Pull Requests我