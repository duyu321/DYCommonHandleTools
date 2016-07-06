//
//  DYFMDBCommonHandleTool.h
//  BasicProjectTemplate
//
//  Created by 杜宇 on 15/10/21.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

 
NS_ASSUME_NONNULL_BEGIN

typedef void(^ExecuteSucceedBlock)(NSString * succeedStr);
typedef void(^ExecuteErrorBlock)(NSString * errorStr);

@interface DYFMDBCommonHandleTool : NSObject

/**
 *  (无sql)创建数据库和表＋添加字段
 *
 *  @param dbName  数据库名
 *  @param model   模型
 *  @param unique  唯一约束组成的array，可传空
 *  @param succeed 成功的block
 *  @param error   失败的block
 */
+ (void)executeAddDataWithDBName:(NSString *)dbName
                        andModel:(id)model
                       andUnique:(nullable NSArray<NSString *> *)unique
                         succeed:(ExecuteSucceedBlock)succeed
                           error:(ExecuteErrorBlock)error;

/**
 *  (无sql)删除表中数据
 *
 *  @param dbName  数据库名
 *  @param model   模型
 *  @param values  要删除数据的条件，可传空（删除整张表数据）
 *  @param succeed 成功的block
 *  @param error   失败的block
 */
+ (void)executeDeleteDataWithDBName:(NSString *)dbName
                           andClass:(Class)iClass
                          andValues:(nullable NSDictionary<NSString *,NSString *> *)values
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error;

/**
 *  (无sql)修改表中数据
 *
 *  @param dbName      数据库名
 *  @param model       模型
 *  @param setValues   要修改的键值段，不可为空
 *  @param whereValues 修改的条件，可为空
 *  @param succeed     成功的block
 *  @param error       失败的block
 */
+ (void)executeUpdateDataWithDBName:(NSString *)dbName
                           andClass:(Class)iClass
                       andSetValues:(NSDictionary<NSString *,NSString *> *)setValues
                      andWhereValue:(nullable NSDictionary<NSString *,NSString *> *)whereValues
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error;

/**
 *  (无sql)查找表中数据
 *
 *  @param dbName      数据库名
 *  @param model       模型
 *  @param selKey      要查找的字段，可为空
 *  @param whereValues 要查找的条件，可为空
 *
 *  @return 查询出的字典组成的数组
 */
+ (nullable NSArray *)executeSelectDataWithDBName:(NSString *)dbName
                                         andClass:(Class)iClass
                                        andSelKey:(nullable NSArray<NSString *> *)selKey
                                   andWhereValues:(nullable NSDictionary<NSString *,NSString *> *)whereValues;

/**
 *  创建数据库和表
 *
 *  @param dbName        数据库名
 *  @param CreatTableSql 创建表的sql语句
 *  @param succeed       成功的block
 *  @param error         失败的block
 */
+ (void)executeCreatTableWithDBName:(NSString *)dbName
                   andCreatTableSql:(NSString *)CreatTableSql
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error;

/**
 *  添加数据
 *
 *  @param dbName  数据库名
 *  @param addSql  添加数据的sql语句
 *  @param succeed 成功的block
 *  @param error   失败的block
 */
+ (void)executeAddDataWithDBName:(NSString *)dbName
                       andAddSql:(NSString *)addSql
                         succeed:(ExecuteSucceedBlock)succeed
                           error:(ExecuteErrorBlock)error;

/**
 *  删除数据
 *
 *  @param dbName    数据库名
 *  @param deleteSql 删除数据的sql语句
 *  @param succeed   成功的block
 *  @param error     失败的block
 */
+ (void)executeDeleteDataWithDBName:(NSString *)dbName
                       andDeleteSql:(NSString *)deleteSql
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error;

/**
 *  修改数据
 *
 *  @param dbName    数据库名
 *  @param updateSql 更新数据的sql语句
 *  @param succeed   成功的block
 *  @param error     失败的block
 */
+ (void)executeUpdateDataWithDBName:(NSString *)dbName
                       andUpdateSql:(NSString *)updateSql
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error;

/**
 *  查询数据
 *
 *  @param dbName    数据库名
 *  @param selectSql 查询的sql语句
 *  @param iClass    要查的属性对应的模型 可传空(当且仅当dataArray不为空时可以传空)
 *  @param dataArray 需要查询的字段组成的数组 可传空
 *
 *  @return 查询出的字典组成的数组
 */
+ (NSArray *)executeSelectDataWithDBName:(NSString *)dbName
                            andSelectSql:(NSString *)selectSql
                                andClass:(nullable Class)iClass
                       andNeedSelectData:(nullable NSArray<NSString *> *)dataArray;

@end

NS_ASSUME_NONNULL_END