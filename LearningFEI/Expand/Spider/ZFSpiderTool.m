//
//  ZFSpiderTool.m
//  08-抓数据
//
//  Created by w on 16/4/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ZFSpiderTool.h"
#import "NSString+Regex.h"


@implementation ZFSpiderTool
#pragma mark - 网络爬虫
//根据pattern匹配抓取一段
+(NSString *)spiderOneStringWithHtmlUrl:(NSString *)url pattern:(NSString *)pattern{
    NSString *html = [self htmlWithURLString:url];
    
    return [html firstMatchWithPattern:pattern];
}

//根据pattern匹配抓取多个字段
+(NSArray *)spiderMoreStringWithHtmlUrl:(NSString *)url pattern:(NSString *)pattern keys:(NSArray *)keys{
    NSString *html = [self htmlWithURLString:url];
    
    return [html matchesWithPattern:pattern keys:keys];
}


//从string中根据pattern匹配抓取一段
+(NSString *)spiderOneStringWithString:(NSString *)string pattern:(NSString *)pattern{
    
    return [string firstMatchWithPattern:pattern];
}

//从string中根据pattern匹配抓取多个字段
+(NSArray *)spiderMoreStringWithString:(NSString *)string pattern:(NSString *)pattern keys:(NSArray *)keys{
    
    return [string matchesWithPattern:pattern keys:keys];
}

+(NSString *)htmlWithURLString:(NSString *)urlString
{
    // 1. url
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2. urlrequet
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. connection
    // 抓数据时，一定要做错误提示，否则会浪费很多时间
    NSError *error = nil;
    
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return nil;
    }
    
    // 4. 转换成字符串
    return [NSString UTF8StringWithHZGB2312Data:data];
}


+(NSDictionary *)getCode4APP{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *content =[ZFSpiderTool spiderOneStringWithHtmlUrl:BaseUrl_code4App pattern:[NSString stringWithFormat:@"<div class=\"mn\">((?!</div>).*)(.*?)</div>"]];
    
    NSArray *array = [ZFSpiderTool spiderMoreStringWithString:content pattern:
                      [NSString stringWithFormat:@"<ul class=\"ttp bm cl\">(.*?)</ul>"] keys:@[@"linkArr"]];

    NSArray *controlCategoryArr = [ZFSpiderTool spiderMoreStringWithString:[array[1] objectForKey:@"linkArr"] pattern:[NSString stringWithFormat:@"<li><a href=\"(.*?)\">(.*?)<span class=\"xg1 num\">(.*?)</span></a></li>"] keys:@[@"url",@"title",@"num"]];
    
    NSArray *funcCategoryArr = [ZFSpiderTool spiderMoreStringWithString:[array[2] objectForKey:@"linkArr"] pattern:[NSString stringWithFormat:@"<li><a href=\"(.*?)\">(.*?)<span class=\"xg1 num\">(.*?)</span></a></li>"] keys:@[@"url",@"title",@"num"]];
    [dic setObject:controlCategoryArr forKey:@"controlCategoryArr"];
    [dic setObject:funcCategoryArr forKey:@"funcCategoryArr"];
    
    return dic;
}

+(NSArray *)getCocoaChinaSwiftNews{
    NSString *content =[ZFSpiderTool spiderOneStringWithHtmlUrl:[NSString stringWithFormat:@"%@/swift/",BaseUrl_cocoaChina] pattern:[NSString stringWithFormat:@"<ul id=\"list_holder\">(.*?)</ul>"]];
    
    NSArray *array = [ZFSpiderTool spiderMoreStringWithString:content pattern:
                      [NSString stringWithFormat:@"<li>.*?<div class=\"clearfix newstitle\">.*?<a href=\"(.*?)\".*?title=\"(.*?)\">.*?</a>.*?</div>.*?<div class=\"clearfix\">.*?<a href=.*?>.*?<img src=\"(.*?)\".*?>.*?</a>.*?<div class=\"newsinfor\">(.*?)<a.*?>.*?</a>.*?</div>.*?<div class=\"clearfix zx_manage\">.*?<div class=\"float-l\">.*?<span class=\"post-time\">(.*?)</span>.*?<span>(.*?)</span>.*?<span>(.*?)</span>.*?</div>.*?</div>.*?</div>.*?</li>"] keys:@[@"url",@"title",@"imgUrl",@"newsInfo",@"postTime",@"category",@"source"]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    [array writeToFile:[NSString stringWithFormat:@"%@/cocoaChina.plist",path] atomically:YES];
    
    return array;
}


+(NSArray *)getCocoaChinaCodeCateGory{
    NSString *content =[ZFSpiderTool spiderOneStringWithHtmlUrl:[NSString stringWithFormat:@"%@",BaseUrl_cocoaChina] pattern:[NSString stringWithFormat:@"<div class=\"code-tags\">(.*?)</div>"]];
    
    NSArray *array = [ZFSpiderTool spiderMoreStringWithString:content pattern:
                      [NSString stringWithFormat:@"<a href=\"(.*?)\" title=\"(.*?)\".*?>.*?</a>"] keys:@[@"url",@"title"]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    [array writeToFile:[NSString stringWithFormat:@"%@/cocoaChina.plist",path] atomically:YES];
    
    return array;
}


@end
