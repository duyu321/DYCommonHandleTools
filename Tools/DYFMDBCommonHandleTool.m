//
//  DYFMDBCommonHandleTool.m
//  BasicProjectTemplate
//
//  Created by 杜宇 on 15/10/21.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

#import "DYFMDBCommonHandleTool.h"

@implementation DYFMDBCommonHandleTool

// (无sql)创建数据库和表＋添加字段
+ (void)executeAddDataWithDBName:(NSString *)dbName
                        andModel:(id)model
                       andUnique:(NSArray *)unique
                         succeed:(ExecuteSucceedBlock)succeed
                           error:(ExecuteErrorBlock)error
{
    // 设置数据库路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    // 模型转字典
    NSMutableDictionary *dictModel = [model mj_keyValues];
    
    // 遍历模型字典
    NSMutableArray *keyArray = [NSMutableArray array];
    NSMutableArray *valueArray = [NSMutableArray array];
    [dictModel enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [keyArray addObject:key];
        [valueArray addObject:obj];
    }];
    
    // 打开数据库
    if ([db open]) {
        // 拼接创建数据库的sql语句
        NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('%@' INTEGER PRIMARY KEY AUTOINCREMENT",NSStringFromClass([model class]),@"id"];
        // 遍历模型字典key
        for (id keys in keyArray) {
            // 判断是否有唯一约束的字段
            if (unique == nil || unique.count == 0) {
                // 没有传唯一约束数组
                sqlCreateTable = [sqlCreateTable stringByAppendingString:[NSString stringWithFormat:@",'%@' TEXT",keys]];
            } else {
                // 有传入唯一约束数组，遍历数组，与模型字典的key相比较
                for (NSString *uniqueStr in unique) {
                    if ([uniqueStr isEqualToString:keys]) {
                        sqlCreateTable = [sqlCreateTable stringByAppendingString:[NSString stringWithFormat:@",'%@' TEXT UNIQUE",keys]];
                    } else {
                        sqlCreateTable = [sqlCreateTable stringByAppendingString:[NSString stringWithFormat:@",'%@' TEXT",keys]];
                    }
                }
            }
        }
        sqlCreateTable = [sqlCreateTable stringByAppendingString:@")"]; // 拼接sql完成
        
        // 执行sql
        BOOL res = [db executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
        
        // 关闭数据库
        [db close];
    } else {
        NSLog(@"打开失败");
    }
    
    if ([db open]) {
        NSString *insertSql= [NSString stringWithFormat:@"INSERT INTO %@ (",NSStringFromClass([model class])];
        insertSql = [insertSql stringByAppendingString:[NSString stringWithFormat:@"%@",keyArray[0]]];
        for (int i = 1; i < keyArray.count; i++) {
            insertSql = [insertSql stringByAppendingString:[NSString stringWithFormat:@",%@",keyArray[i]]];
        }
        insertSql = [insertSql stringByAppendingString:[NSString stringWithFormat:@") VALUES ('%@'",valueArray[0]]];
        for (int j = 1; j < valueArray.count; j++) {
            insertSql = [insertSql stringByAppendingString:[NSString stringWithFormat:@",'%@'",valueArray[j]]];
        }
        insertSql = [insertSql stringByAppendingString:@")"];
        BOOL res = [db executeUpdate:insertSql];
        if (!res) {
            error(@"添加失败");
        } else {
            succeed(@"添加成功");
        }
        [db close];
    }
}

// (无sql)删除表中数据
+ (void)executeDeleteDataWithDBName:(NSString *)dbName
                           andClass:(Class)iClass
                          andValues:(NSDictionary *)values
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        BOOL res;
        NSMutableArray *keyArray = [NSMutableArray array];
        NSMutableArray *valueArray = [NSMutableArray array];
        NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@",NSStringFromClass(iClass)];
        if (values == nil || values.count == 0) {
            res = [db executeUpdate:deleteSql];
        } else {
            [values enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [keyArray addObject:key];
                [valueArray addObject:obj];
            }];
//#warning sql条件 a = '123'  a 不能写成'a' !!!
            deleteSql = [deleteSql stringByAppendingString:[NSString stringWithFormat:@" WHERE %@ = '%@'",keyArray[0],valueArray[0]]];
            for (int i = 1; i < keyArray.count; i++) {
                deleteSql = [deleteSql stringByAppendingString:[NSString stringWithFormat:@" AND %@ = '%@'",keyArray[i],valueArray[i]]];
            }
            res = [db executeUpdate:deleteSql];
        }
        if (!res) {
            error(@"删除失败");
        } else {
            succeed(@"删除成功");
        }
        [db close];
    }
}

// (无sql)修改表中数据
+ (void)executeUpdateDataWithDBName:(NSString *)dbName
                           andClass:(Class)iClass
                       andSetValues:(NSDictionary *)setValues
                      andWhereValue:(nullable NSDictionary *)whereValues
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    if ([db open]) {
        
        NSMutableArray *setKeyArray = [NSMutableArray array];
        NSMutableArray *setValueArray = [NSMutableArray array];
        [setValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [setKeyArray addObject:key];
            [setValueArray addObject:obj];
        }];
        NSString *updateSql = [NSString stringWithFormat:@"update %@ set ",NSStringFromClass(iClass)];
        updateSql = [updateSql stringByAppendingString:[NSString stringWithFormat:@"%@ = '%@'", setKeyArray[0],setValueArray[0]]];
        for (int i = 1; i < setKeyArray.count; i++) {
            updateSql = [updateSql stringByAppendingString:[NSString stringWithFormat:@" and %@ = '%@'",setKeyArray[i],setValueArray[i]]];
        }
        
        if (whereValues.count != 0 && whereValues != nil) {
            NSMutableArray *whereKeyArray = [NSMutableArray array];
            NSMutableArray *whereValueArray = [NSMutableArray array];
            [whereValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [whereKeyArray addObject:key];
                [whereValueArray addObject:obj];
            }];
            updateSql = [updateSql stringByAppendingString:[NSString stringWithFormat:@" where %@ = '%@'",whereKeyArray[0],whereValueArray[0]]];
            for (int j = 1; j < whereValueArray.count; j++) {
                updateSql = [updateSql stringByAppendingString:[NSString stringWithFormat:@" and %@ = '%@'",whereKeyArray[j],whereValueArray[j]]];
            }
        }
        
        BOOL res = [db executeUpdate:updateSql];
        if (!res) {
            error(@"更新数据失败");
        } else {
            succeed(@"更新数据成功");
        }
        [db close];
    }
}

// (无sql)查找表中数据
+ (NSArray *)executeSelectDataWithDBName:(NSString *)dbName
                                andClass:(Class)iClass
                               andSelKey:(nullable NSArray *)selKey
                          andWhereValues:(nullable NSDictionary *)whereValues
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    NSMutableArray *resArray = [NSMutableArray array];
    if ([db open]) {
        NSString *selectSql = @"select";
        if (selKey.count == 0 || selKey == nil) {
            selectSql = [selectSql stringByAppendingString:[NSString stringWithFormat:@" * from %@",NSStringFromClass(iClass)]];
        } else {
            selectSql = [selectSql stringByAppendingString:[NSString stringWithFormat:@" %@",selKey[0]]];
            for (int i = 1; i < selKey.count; i++) {
                selectSql = [selectSql stringByAppendingString:[NSString stringWithFormat:@",%@",selKey[i]]];
            }
            selectSql = [selectSql stringByAppendingString:[NSString stringWithFormat:@" from %@",NSStringFromClass(iClass)]];
        }
        
        if (whereValues.count != 0 && whereValues != nil) {
            NSMutableArray *keyArray = [NSMutableArray array];
            NSMutableArray *valueArray = [NSMutableArray array];
            [whereValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [keyArray addObject:key];
                [valueArray addObject:obj];
            }];
            selectSql = [selectSql stringByAppendingString:[NSString stringWithFormat:@" where %@ = '%@'",keyArray[0],valueArray[0]]];
            for (int i = 1; i<keyArray.count; i++) {
                selectSql = [selectSql stringByAppendingString:[NSString stringWithFormat:@" and %@ = '%@'",keyArray[i],valueArray[i]]];
            }
        }
        
        FMResultSet * rs = [db executeQuery:selectSql];
        while ([rs next]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            if (selKey.count == 0 || selKey == nil) {
                selKey = [NSArray getProperties:iClass];
            }
            for (NSString *name in selKey) {
                [dict setObject:[rs stringForColumn:name] forKey:name];
            }
            [resArray addObject:dict];
        }
        [db close];
    }
    return resArray;
}

// 创建数据库和表
+ (void)executeCreatTableWithDBName:(NSString *)dbName
                   andCreatTableSql:(NSString *)CreatTableSql
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        BOOL res = [db executeUpdate:CreatTableSql];
        if (!res) {
            error(@"创建表失败");
        } else {
            succeed(@"创建表成功");
        }
        [db close];
    }
}

// 添加数据
+ (void)executeAddDataWithDBName:(NSString *)dbName
                       andAddSql:(NSString *)addSql
                         succeed:(ExecuteSucceedBlock)succeed
                           error:(ExecuteErrorBlock)error
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        BOOL res = [db executeUpdate:addSql];
        if (!res) {
            error(@"添加数据失败");
        } else {
            succeed(@"添加数据成功");
        }
        [db close];
    }
}

// 删除数据
+ (void)executeDeleteDataWithDBName:(NSString *)dbName
                       andDeleteSql:(NSString *)deleteSql
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        BOOL res = [db executeUpdate:deleteSql];
        if (!res) {
            error(@"删除数据失败");
        } else {
            succeed(@"删除数据成功");
        }
        [db close];
    }
}

// 修改数据
+ (void)executeUpdateDataWithDBName:(NSString *)dbName
                       andUpdateSql:(NSString *)updateSql
                            succeed:(ExecuteSucceedBlock)succeed
                              error:(ExecuteErrorBlock)error
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        BOOL res = [db executeUpdate:updateSql];
        if (!res) {
            error(@"更新数据失败");
        } else {
            succeed(@"更新数据成功");
        }
        [db close];
    }
}

// 查询数据
+ (NSArray *)executeSelectDataWithDBName:(NSString *)dbName
                            andSelectSql:(NSString *)selectSql
                                andClass:(nullable Class)iClass
                       andNeedSelectData:(nullable NSArray *)dataArray
{
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    NSMutableArray *array = [NSMutableArray array];
    if ([db open]) {
        FMResultSet * rs = [db executeQuery:selectSql];
        while ([rs next]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            if (dataArray.count == 0 || dataArray == nil) {
                dataArray = [NSArray getProperties:iClass];
            }
            for (NSString *name in dataArray) {
                [dict setObject:[rs stringForColumn:name] forKey:name];
            }
            [array addObject:dict];
        }
        [db close];
    }
    return array;
}

@end
