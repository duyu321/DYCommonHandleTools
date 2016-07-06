# DYCommonHandleTools
- Pure code automatic layout, highly adaptive UITableViewCell, network request, data persistence, image processing, such as a variety of functional integration.
- 纯代码自动布局,UITableViewCell高度自适应,网络请求,数据持久化,图像处理等多种功能集成.


GitHub：[duyu321](https://github.com/duyu321) ｜ Blog：[duyu007(Chinese)](http://www.cnblogs.com/duyuiOS) ｜ PR is welcome

## Contents 【目录】
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

---


##  <a id="Cell_AutoLayout"></a> Cell Autolayout【Cell高度自适应用法简介】  

#### <a id="Cell_Normal"></a> `普通（简化）版【推荐使用】：tableview 高度自适应设置只需要2步`

	1. >> 设置cell高度自适应：
	// cell布局设置好之后调用此方法就可以实现高度自适应（注意：	如果用高度自适应则不要再以cell的底边为参照去布局其子view）
	[cell setupAutoHeightWithBottomView:_view4 bottomMargin:10];

	2. >> 获取自动计算出的cell高度

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


#### <a id="Cell_Updated"></a> `升级版（适应于cell条数少于100的tableview）：tableview 高度自适应设置只需要2步`

	1. >> 设置cell高度自适应：
	// cell布局设置好之后调用此方法就可以实现高度自适应（注意：如果用高度自适应则不要再以cell的底边为参照去布局其子view）
	[cell setupAutoHeightWithBottomView:_view4 bottomMargin:10];

	2. >> 获取自动计算出的cell高度 

	- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
	{
		// 获取cell高度
		return [self cellHeightForIndexPath:indexPath
                   cellContentViewWidth:[UIScreen mainScreen].bounds.size.width];
	}
	
	
## <a id="Network_Request"></a> Network Request【请求网络用法介绍】

####  <a id="Network_Post"></a> `Network Post 【post请求用法】`

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
    
#### <a id="Network_Get"></a> `Network Get 【get请求用法】`
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
    
#### <a id="Network_DownLoad"></a> `Network DownLoad 【下载文件用法】`
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

## <a id="Data_Persistence"></a> Data persistence【数据持久化用法介绍】

#### <a id="CRUD_C"></a> `CRUD--->C(Create)【添加数据】`

	// 添加数据操作
	1. >> 方法一:不使用数据模型,直接书写sql语句
	// 注意此方法必须保证数据库存在,穿件数据库方法详见demo
	[DYFMDBCommonHandleTool executeAddDataWithDBName:kDBName
                                           andAddSql:@"INSERT INTO DYDataModel (name,num) VALUES ('Tom','6098018')"
                                             succeed:^(NSString * _Nonnull succeedStr) {
                                                 // success code
                                             } error:^(NSString * _Nonnull errorStr) {
                                                 // error code
                                             }];
	
	2. >> 方法二:直接传递数据模型,不需要书写sql语句,
	// 注意:此方法可直接判断数据库是否存在,不存在直接创建(不需要写任何数据库创建代码),创建的表名是模型类名.
	[DYFMDBCommonHandleTool executeAddDataWithDBName:kDBName
                                            andModel:dataModel
                                           andUnique:@[@"name"]
                                             succeed:^(NSString * _Nonnull succeedStr) {
                                                 // success code
                                             } error:^(NSString * _Nonnull errorStr) {
                                                 // error code
                                             }];
    
#### <a id="CRUD_R"></a> `CRUD--->R(Retrieve) 【查找数据】`

	// 查找数据操作
	1. >> 方法一:不使用数据模型,直接书写sql语句
	NSArray *selectArray = [DYFMDBCommonHandleTool executeSelectDataWithDBName:kDBName
                                                                      andClass:[DYDataModel class]
                                                                     andSelKey:nil
                                                                andWhereValues:nil];
	NSLog(@"%@",selectArray);

	2. >> 方法二:直接传递数据模型,不需要书写sql语句
	NSArray *selectArray = [DYFMDBCommonHandleTool executeSelectDataWithDBName:kDBName
                                                                  andSelectSql:@"select * from Table"
                                                                      andClass:[DYDataModel class]
                                                             andNeedSelectData:nil];
	NSLog(@"%@",selectArray);
	
#### <a id="CRUD_U"></a> `CRUD--->U(Updata) 【修改数据】`

	// 修改数据操作
	1. >> 方法一:不使用数据模型,直接书写sql语句
	[DYFMDBCommonHandleTool executeUpdateDataWithDBName:kDBName
                                           andUpdateSql:@"update DYDataModel set num = '123' where name = 'tom'"
                                                succeed:^(NSString * _Nonnull succeedStr) {
                                                    // success code
                                                } error:^(NSString * _Nonnull errorStr) {
                                                    // error code
                                                }];

	2. >> 方法二:直接传递数据模型,不需要书写sql语句
	[DYFMDBCommonHandleTool executeUpdateDataWithDBName:kDBName
                                               andClass:[DYDataModel class]
                                           andSetValues:@{@"num":self.newsNameTextField.text}
                                          andWhereValue:@{@"name":self.oldNameTextField.text}
                                                succeed:^(NSString * _Nonnull succeedStr) {
                                                    // success code
                                                } error:^(NSString * _Nonnull errorStr) {
                                                    // error code
                                                }];
    
#### <a id="CRUD_D"></a> `CRUD--->D(Delete) 【删除数据】`

	// 删除数据操作
	1. >> 方法一:不使用数据模型,直接书写sql语句
	[DYFMDBCommonHandleTool executeDeleteDataWithDBName:kDBName
                                           andDeleteSql:@"DELETE FROM DYDataModel WHERE name = '李文'"
                                                succeed:^(NSString * _Nonnull succeedStr) {
                                                    // success code
                                                } error:^(NSString * _Nonnull errorStr) {
                                                    // error code
                                                }];

	2. >> 方法二:直接传递数据模型,不需要书写sql语句
	[DYFMDBCommonHandleTool executeDeleteDataWithDBName:kDBName
                                               andClass:[DYDataModel class]
                                              andValues:nil
                                                succeed:^(NSString * _Nonnull succeedStr) {
                                                    // success code
                                                } error:^(NSString * _Nonnull errorStr) {
                                                    // error code
                                                }];
        
## <a id="Processing_Image"></a> Processing Image【图片处理】

#### <a id="Circle_Image"></a> Pictures cut into a circle 【图片裁剪成圆】
	// borderWidth:边框宽度(传0没有边框), borderColor:边框颜色
	self.iconImg.image = [UIImage circleWithImage:[UIImage imageNamed:@"index"]
                                      borderWidth:3
                                      borderColor:[UIColor colorFromHexRGB:@"dddddd"]];
                
#### <a id="Color_Image"></a> Processing Picture Color 【图片颜色处理】
	// type: ImageTypeWhiteBlace(黑白处理),ImageTypeExposure(曝光处理),ImageTypeThin(变淡处理)
	self.exposureImg.image = [UIImage grayscale:[UIImage imageNamed:@"index"]
                                           type:ImageTypeExposure];
                                           
#### <a id="Water_Image"></a> Processing Picture Water 【图片水印处理】
	// waterImageWithBg:需要打水印的图片, logo:水印图片
	self.watermarkImg.image = [UIImage waterImageWithBg:[UIImage imageNamed:@"index"]
                                                   logo:[UIImage imageNamed:@"shuiyin"]];
        
## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢
* 如果你想为DYCommonHandleTools输出代码，请拼命Pull Requests我