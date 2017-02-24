//
//  ZFSpiderTool.h
//  08-抓数据
//
//  Created by w on 16/4/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFSpiderTool : NSObject

+(NSString *)htmlWithURLString:(NSString *)urlString;

// 网络爬虫
//根据pattern匹配抓取一段
+(NSString *)spiderOneStringWithHtmlUrl:(NSString *)url pattern:(NSString *)pattern;
//根据pattern匹配抓取多个字段
+(NSArray *)spiderMoreStringWithHtmlUrl:(NSString *)url pattern:(NSString *)pattern keys:(NSArray *)keys;

//从string中根据pattern匹配抓取一段
+(NSString *)spiderOneStringWithString:(NSString *)string pattern:(NSString *)pattern;
//从string中根据pattern匹配抓取多个字段
+(NSArray *)spiderMoreStringWithString:(NSString *)string pattern:(NSString *)pattern keys:(NSArray *)keys;


//获取code4app页面数据
+(NSDictionary *)getCode4APP;
//swift最新消息
+(NSArray *)getCocoaChinaSwiftNews;
//代码分类
+(NSArray *)getCocoaChinaCodeCateGory;

@end
