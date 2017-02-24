//
//  XWDataCacheTool.m
//  新闻
//
//  Created by user on 15/10/5.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "XWDataCacheTool.h"
#import "FMDB.h"
#import "MJExtension.h"

static FMDatabaseQueue *_queue;

@implementation XWDataCacheTool

+(void)initialize
{
    NSString *path= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"news.sqlite"];
    _queue=[FMDatabaseQueue databaseQueueWithPath:path];
    //创建表
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL b=[db executeUpdate:@"create table if not exists info(ID integer primary key autoincrement,data blob,idstr text)"];
        if(!b){
            NSLog(@"创建表失败");
        }
    }];
   // NSLog(@"%@",path);
}


+(void)addModel:(AFNResponseModel *)model andId:(NSString *)idstr
{
    [_queue inDatabase:^(FMDatabase *db) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];

        [db executeUpdate:@"insert into info(data,idstr) values(?,?)",data,idstr];
        
    }];
}

+(AFNResponseModel *)modelWithID:(NSString *)ID{
    
    __block AFNResponseModel *model=[[AFNResponseModel alloc] init];
    [_queue inDatabase:^(FMDatabase *db) {
        NSDictionary *dict = [NSDictionary dictionary];

        FMResultSet *result=[db executeQuery:@"select * from info where idstr=?",ID];
        if(result){
            
            while ([result next]) {
                NSData * data =[result objectForColumnName:@"data"];
                if (data.length!=0) {
                    model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }else{
                    model = nil;
                }
            }
        }
        
    }];
    return model;
}



+(void)addArr:(NSArray *)arr andId:(NSString *)idstr
{
    //NSLog(@"data   %@",idstr);
    for(NSDictionary *dict in arr) {
        [self addDict:dict andId:idstr];
    }
}
+(void)addDict:(NSDictionary *)dict andId:(NSString *)idstr
{
    [_queue inDatabase:^(FMDatabase *db) {
            NSData *data=[NSKeyedArchiver archivedDataWithRootObject:dict];
            [db executeUpdate:@"insert into info(data,idstr) values(?,?)",data,idstr];
            
    }];
    
}

+(void)addData:(NSData *)data andId:(NSString *)idstr
{
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into info(data,idstr) values(?,?)",data,idstr];
        
    }];
}



//返回数组
+(NSData *)dataWithID:(NSString *)ID
{
    __block NSData *data=nil;
    [_queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *result=[db executeQuery:@"select * from info where idstr=?",ID];
        if(result){
            data=[[NSData alloc] init];
            while ([result next]) {
                data=[result dataForColumn:@"data"];
                // NSString *idstr=[result stringForColumn:@"idstr"];
                //转成字典
//                NSDictionary *dict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
//                [arr addObject:dict];
            }
        }
        
    }];
    return data;
}

//返回数组
+(NSArray *)dataArrWithID:(NSString *)ID
{
    __block NSMutableArray *arr=nil;
    [_queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *result=[db executeQuery:@"select * from info where idstr=?",ID];
        if(result){
            arr=[NSMutableArray array];
            while ([result next]) {
                NSData *data=[result dataForColumn:@"data"];
                // NSString *idstr=[result stringForColumn:@"idstr"];
                //转成字典
                NSDictionary *dict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
                [arr addObject:dict];
            }
        }
        
    }];
    return arr;
}

#pragma mark 删除对应的数据
+(void)deleteWidthId:(NSString *)ID
{
    
    [_queue inDatabase:^(FMDatabase *db) {
        //delete from info where idstr='T1348648517839'
        BOOL b=[db executeUpdate:@"delete  from info where idstr=?",ID];
        if(!b){
            NSLog(@"删除失败");
        }
    }];
    
}


/**
 *  将dictionary 转换成jsonString
 *
 *  @param dic <#dic description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)jsonStringWithDict:(NSDictionary *)dic{
    
    NSString *jsonStr = @"";
    
    NSArray * keys = [dic allKeys];
    
    for (NSString * key in keys) {
        if ((NSNull *)[dic objectForKey:key]!=[NSNull null]) {
            jsonStr = [NSString stringWithFormat:@"%@\"%@\":\"%@\",",jsonStr,key,[dic objectForKey:key]];
        }
        
    }
    jsonStr = [NSString stringWithFormat:@"{%@%@",[jsonStr substringWithRange:NSMakeRange(0, jsonStr.length-1)],@"}"];
    
    return jsonStr;
}


@end
