//
//  LinkurlTool.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/22.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "LinkurlTool.h"
#import "TFHpple.h"


@implementation LinkurlTool

//组装requestModel
+(AFNRequestModel *)requestModel:(LINKURL)url Parameters:(NSMutableDictionary *)parameters{
    NSArray *urlArr = @[@"http://www.cocoachina.com"
                        ,@"http://code.cocoachina.com"
                        ,@"http://code4app.qiniudn.com"
                        ,@"http://www.jobbole.com"

                        ,@"https://gold.xitu.io"
                        ,@"health"];
    NSString *urlStr;
    AFNRequestModel *req = [[AFNRequestModel alloc] init];

    switch (url) {
        case LINKURL_code4app_contentInfo:
            
        case LINKURL_cocoaChina_contentInfo:
            
        case LINKURL_gold_contentInfo:

            urlStr = [parameters objectForKey:@"urlStr"];
            req.Parameters = nil;
            req.urlStr = urlStr;
            req.idStr = urlStr;
            break;
        default:
            urlStr = urlArr[url];
            req.urlStr = urlStr;
            req.idStr = nil;
            req.Parameters = parameters;

            break;
    }
    
    return req;
}
//组装responseModel
+(AFNResponseModel *)responseModel:(LINKURL)url ResponseObject:(id)responseObject{
    
    AFNResponseModel *res = [[AFNResponseModel alloc] init];
    
    
    switch (url) {
        case LINKURL_cocoaChina://cocoaChina主页数据
            res.dict = [self cocoaChinaResponseObject:responseObject];

            break;
        case LINKURL_cocoaChina_codeCategory://cocoaChina code页面分类数据
            res.dict = [self cocoaChinaCodeCategory:responseObject];
            
            break;

        case LINKURL_code4app://code4app主页数据
            res.arr = [self code4appResponseObject:responseObject];
            
        case LINKURL_jobbole://jobbole(伯乐在线)主页数据
            res.arr = [self jobboleResponseObject:responseObject];
            
            break;
        case LINKURL_gold://gold（掘金）主页数据
            res.arr = [self goldResponseObject:responseObject];

            break;
        case LINKURL_health://（养生app）主页数据
            
            break;
            
        case LINKURL_code4app_contentInfo://code4app (code分类信息列表)
            res.arr = [self code4appContentResponseObject:responseObject];

            break;
            
        case LINKURL_cocoaChina_contentInfo://code4app (navi分类信息列表)
            res.arr = [self cocoaChinaContentResponseObject:responseObject];

            break;
        case LINKURL_gold_contentInfo:
            res.arr = [self goldContentResponseObject:responseObject];
            
            break;
        default:
            break;
    }
    return res;
}

#pragma mark code4app 相关请求
+(NSMutableArray *)code4appResponseObject:(id)responseObject{
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:responseObject];
    
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    NSArray *arr = [hpple searchWithXPathQuery:@"//ul[@class='ttp bm cl']"];
    int i= 0;
    for (TFHppleElement *e in arr) {
        if (i != 0) {
            //                NSLog(@"%@", e);
            TFHpple *h =[TFHpple hppleWithHTMLData:[e.raw dataUsingEncoding:NSUTF8StringEncoding]];
            TFHppleElement *categoryE =[[h searchWithXPathQuery:@"//a[@href='javascript:;']"] firstObject];
            
            NSString *category =[categoryE text];
            NSArray *a1 = [h searchWithXPathQuery:@"//a[@href!='javascript:;']"];
            
            NSMutableArray *ma1 = [NSMutableArray arrayWithCapacity:1];
            for (TFHppleElement *e2 in a1) {
                NSString *title = [e2 text];
                NSString *url = [e2 objectForKey:@"href"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",[NSString stringWithFormat:@"http://code4app.com/%@",url],@"url", nil];

                [ma1 addObject:dic];
            }
            NSDictionary *dic1 = @{@"category":category,@"subCategory":ma1};
            
            [ma addObject:dic1];
        }
        i = i+1;
    }
    
    return ma;
}

+(NSMutableArray *)code4appContentResponseObject:(id)responseObject{
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:responseObject];
    
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    NSArray *arr = [hpple searchWithXPathQuery:@"//div[@class='dr']"];
    
    for (TFHppleElement *e2 in arr) {
        TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
        TFHppleElement *categoryE1 =[[h2 searchWithXPathQuery:@"//h3"] firstObject];
        TFHppleElement *categoryE2 =[[h2 searchWithXPathQuery:@"//div/a"] firstObject];

        NSString *title = [categoryE1 text];
        NSString *url = [categoryE2 objectForKey:@"href"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",[NSString stringWithFormat:@"http://code4app.com/%@",url],@"url", nil];

        [ma addObject:dic];
    }
    return ma;
}

#pragma mark cocoaChina 相关请求

+(NSMutableDictionary *)cocoaChinaResponseObject:(id)responseObject{
    
    NSMutableDictionary *mdict =[NSMutableDictionary dictionaryWithCapacity:1];
    TFHpple *hpple = [TFHpple hppleWithHTMLData:responseObject];
//    数据与cardArr数据重复
//    [mdict setObject:[self cocoaChinaNavHeader:hpple] forKey:@"nav-header"];
    
    [mdict setObject:[self cocoaChinaScrollInfo:hpple] forKey:@"scrollInfo"];

    [mdict setObject:[self cocoaChinaCardArrInfo:hpple] forKey:@"cardArr"];

    [mdict setObject:[self cocoaChinaRankArrInfo:hpple] forKey:@"rankArr"];

    return mdict;
}

+(NSMutableDictionary *)cocoaChinaCodeCategory:(id)responseObject{
    
    NSMutableDictionary *mdict =[NSMutableDictionary dictionaryWithCapacity:1];
    TFHpple *hpple = [TFHpple hppleWithHTMLData:responseObject];
    //    数据与cardArr数据重复
    //    [mdict setObject:[self cocoaChinaNavHeader:hpple] forKey:@"nav-header"];
    
    [mdict setObject:[self cocoaChinaCategoryArr:hpple] forKey:@"categoryArr"];
    
    [mdict setObject:[self cocoaChinaNewsArr:hpple] forKey:@"newsArr"];
    
    //hotArr数据的title不显示
//    [mdict setObject:[self cocoaChinaHotArr:hpple] forKey:@"hotArr"];
    
    return mdict;
}


/**
 获取naviHeader 数据（cocoaChina）
 */
+(NSMutableArray *)cocoaChinaNavHeader:(TFHpple *)hpple{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//div[@class='nav-header-bottom']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *arr = [h searchWithXPathQuery:@"//li/a"];
    
    for (TFHppleElement *e2 in arr) {
        NSString *title = [e2 text];
        NSString *url = [NSString stringWithFormat:@"http://www.cocoachina.com%@",[e2 objectForKey:@"href"]];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",url,@"url", nil];

        [ma addObject:dic];
    }
    return ma;
}
/**
 获取Scroll 数据（cocoaChina）
 */
+(NSMutableArray *)cocoaChinaScrollInfo:(TFHpple *)hpple{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//div[@class='forum-c']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *arr = [h searchWithXPathQuery:@"//li"];
    
    for (TFHppleElement *e2 in arr) {
        
        TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
        TFHppleElement *e3 =[[h2 searchWithXPathQuery:@"//a"] firstObject];

        NSString *title = [e3 objectForKey:@"title"];
        NSString *url = [NSString stringWithFormat:@"http://www.cocoachina.com%@",[e3 objectForKey:@"href"]];
        
        TFHppleElement *e4 =[[h2 searchWithXPathQuery:@"//img"] firstObject];
        NSString *imgUrl = [e4 objectForKey:@"src"];

        TFHppleElement *e5 =[[h2 searchWithXPathQuery:@"//a/div/p"] firstObject];
        NSString *content = [e5 text];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",url,@"url",imgUrl,@"imageUrl",content,@"contentText", nil];

        [ma addObject:dic];
    }
    return ma;
}

/**
 获取CardArr 数据（cocoaChina）
 */
+(NSMutableArray *)cocoaChinaCardArrInfo:(TFHpple *)hpple{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *ma1 = [NSMutableArray arrayWithCapacity:1];

    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//div[@class='m-board']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *arr = [h searchWithXPathQuery:@"//div[contains(@class, 'board-box')]"];
    
    for (TFHppleElement *e2 in arr) {
        
        TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
        TFHppleElement *e3 =[[h2 searchWithXPathQuery:@"//h3/a"] firstObject];
        
        NSString *categoryTitle = [e3 objectForKey:@"title"];
        NSString *categoryUrl = [NSString stringWithFormat:@"http://www.cocoachina.com%@",[e3 objectForKey:@"href"]];
        
        NSArray *arr2 =[h2 searchWithXPathQuery:@"//ul/li"];
        
        for (TFHppleElement *e4 in arr2) {
            TFHpple *h4 =[TFHpple hppleWithHTMLData:[e4.raw dataUsingEncoding:NSUTF8StringEncoding]];
            TFHppleElement *e5 =[[h4 searchWithXPathQuery:@"//a"] firstObject];

            NSString *contentTitle = [e5 objectForKey:@"title"];
            NSString *contentUrl = [e5 objectForKey:@"href"];
            NSString *contentImgUrl;
            if ([[e4 objectForKey:@"class"] isEqualToString:@"m-b-hot"]) {

                TFHppleElement *e6 =[[h4 searchWithXPathQuery:@"//img"] firstObject];
                 contentImgUrl= [e6 objectForKey:@"src"];

            }else{
                contentImgUrl = @"";
            }
            NSDictionary *dic = @{@"title":contentTitle,@"url":contentUrl,@"imageUrl":contentImgUrl};
            [ma1 addObject:dic];
        }
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:categoryTitle,@"categoryTitle",categoryUrl,@"categoryUrl",ma1,@"contentArr", nil];

        [ma addObject:dic];
    }
    return ma;
}

/**
 获取RankArr 数据（cocoaChina）
 */
+(NSMutableArray *)cocoaChinaRankArrInfo:(TFHpple *)hpple{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *ma1 = [NSMutableArray arrayWithCapacity:1];
    
    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//div[@class='m-rank']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *arr = [h searchWithXPathQuery:@"//div[contains(@class, 'rank')]"];
    
    for (int i = 0; i<arr.count; i++) {
        if (i != 0) {
            TFHppleElement *e2 = arr[i];
            TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
            TFHppleElement *e3 =[[h2 searchWithXPathQuery:@"//h3"] firstObject];
            
            NSString *categoryTitle = [e3 text];
            //        NSString *categoryUrl = [NSString stringWithFormat:@"http://www.cocoachina.com%@",[e3 objectForKey:@"href"]];
            
            NSArray *arr2 =[h2 searchWithXPathQuery:@"//ol/li"];
            
            for (TFHppleElement *e4 in arr2) {
                TFHpple *h4 =[TFHpple hppleWithHTMLData:[e4.raw dataUsingEncoding:NSUTF8StringEncoding]];
                TFHppleElement *e5 =[[h4 searchWithXPathQuery:@"//a"] firstObject];
                
                NSString *contentTitle = [e5 objectForKey:@"title"];
                NSString *contentUrl = [e5 objectForKey:@"href"];
                TFHppleElement *e6 = [[h4 searchWithXPathQuery:@"//a/span"] firstObject];
                NSString *readCount = [e6 text];
                TFHppleElement *e7 = [[h4 searchWithXPathQuery:@"//a/i"] firstObject];
                NSString *serialNumber = [e7 text];

                NSDictionary *dic = @{@"title":contentTitle,@"url":contentUrl,@"readCount":readCount,@"serialNumber":serialNumber};
                [ma1 addObject:dic];
            }
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:categoryTitle,@"categoryTitle",ma1,@"contentArr", nil];

            [ma addObject:dic];
        }
    }
    
    return ma;
}

/**
 获取CategoryArr code分类 数据（cocoaChina）
 */
+(NSMutableArray *)cocoaChinaCategoryArr:(TFHpple *)hpple{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//div[@class='categorylist']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *arr = [h searchWithXPathQuery:@"//li"];

    for (TFHppleElement *e2 in arr) {
        
        TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
        TFHppleElement *e3 =[[h2 searchWithXPathQuery:@"//a"] firstObject];
        
        NSString *url = [NSString stringWithFormat:@"http://www.cocoachina.com%@",[e3 objectForKey:@"href"]];
        
        TFHppleElement *e4 =[[h2 searchWithXPathQuery:@"//span[@class='zh']"] firstObject];
        NSString *title = [e4 text];
        TFHppleElement *e5 =[[h2 searchWithXPathQuery:@"//span[@class='en']"] firstObject];
        NSString *subTitle = [e5 text];
        TFHppleElement *e6 =[[h2 searchWithXPathQuery:@"//span[@class='cnt']"] firstObject];
        NSString *count = [e6 text];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",url,@"url",subTitle,@"subTitle",count,@"count", nil];

        [ma addObject:dic];
    }

    return ma;
}

/**
 获取NewsArr 最新代码 数据（cocoaChina）
 */
+(NSMutableArray *)cocoaChinaNewsArr:(TFHpple *)hpple{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//div[@class='waterfall-container']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *arr = [h searchWithXPathQuery:@"//div[@class='waterfall-box']"];
    
    for (TFHppleElement *e2 in arr) {
        
        TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
        TFHppleElement *e3 =[[h2 searchWithXPathQuery:@"//div[@class='w-name']/a"] firstObject];
        NSString *title = [e3 text];
        NSString *url = [NSString stringWithFormat:@"http://code.cocoachina.com%@",[e3 objectForKey:@"href"]];
        
//        TFHppleElement *e4 =[[h2 searchWithXPathQuery:@"//span[@class='zh']"] firstObject];
//        NSString *title = [e4 text];
//        TFHppleElement *e5 =[[h2 searchWithXPathQuery:@"//span[@class='en']"] firstObject];
//        NSString *subTitle = [e5 text];
//        TFHppleElement *e6 =[[h2 searchWithXPathQuery:@"//span[@class='cnt']"] firstObject];
//        NSString *count = [e6 text];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",url,@"url", nil];

        [ma addObject:dic];
    }

    
    return ma;
}

/**
 获取HotArr 热门下载数据（cocoaChina）
 */
+(NSMutableArray *)cocoaChinaHotArr:(TFHpple *)hpple{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//div[@class='code-hotdownload top17']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *arr = [h searchWithXPathQuery:@"//li[@class='ellipsis-on']"];
    
    for (TFHppleElement *e2 in arr) {
        
        TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
        TFHppleElement *e3 =[[h2 searchWithXPathQuery:@"//a"] firstObject];
        
        NSString *url = [NSString stringWithFormat:@"http://www.cocoachina.com%@",[e3 objectForKey:@"href"]];
        NSString *title = [e3 text];

        TFHppleElement *e4 =[[h2 searchWithXPathQuery:@"//span"] firstObject];
        NSString *serialNumber = [e4 text];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",url,@"url",serialNumber,@"serialNumber", nil];

        [ma addObject:dic];
    }

    return ma;
}


/**
 获取navi 对应页面的Content数组 数据（cocoaChina）
 */
+(NSMutableArray *)cocoaChinaContentResponseObject:(id)responseObject{
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:responseObject];
    
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//ul[@id='list_holder']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *arr = [h searchWithXPathQuery:@"//li"];
    
    for (TFHppleElement *e2 in arr) {
        TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
        TFHppleElement *categoryE2 =[[h2 searchWithXPathQuery:@"//a"] firstObject];

        NSString *title = [categoryE2 text];
        NSString *url = [categoryE2 objectForKey:@"href"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",[NSString stringWithFormat:@"http://www.cocoachina.com%@",url],@"url", nil];

        [ma addObject:dic];
    }
    return ma;
}
#pragma mark gold（掘金） 相关请求
+(NSMutableArray *)goldResponseObject:(id)responseObject{
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:responseObject];
    
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//ul[@class='aside-list']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *arr = [h searchWithXPathQuery:@"//li"];
    int i= 0;

    for (TFHppleElement *e2 in arr) {
        if (i!=0) {
            TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
            TFHppleElement *categoryE2 =[[h2 searchWithXPathQuery:@"//span"] firstObject];

            NSString *title = [categoryE2 text];
            NSString *url = [e2 objectForKey:@"class"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",[NSString stringWithFormat:@"https://gold.xitu.io/welcome/%@",url],@"url", nil];

            [ma addObject:dic];
        }
        i=i+1;
    }
    return ma;
}

+(NSMutableArray *)goldContentResponseObject:(id)responseObject{
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:responseObject];
    
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    
    NSArray *arr = [hpple searchWithXPathQuery:@"//div[@class='entry-box']"];
    int i= 0;

    for (TFHppleElement *e2 in arr) {
        if (i!=0) {
            TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
            TFHppleElement *categoryE2 =[[h2 searchWithXPathQuery:@"//div[@class='float-left']"] firstObject];
            
            NSString *title = [categoryE2 text];
            NSArray *a1 = [hpple searchWithXPathQuery:@"//div[@class='entries']"];
            NSMutableArray *ma1 = [NSMutableArray arrayWithCapacity:1];
            for (TFHppleElement *e3 in a1) {
                TFHpple *h3 =[TFHpple hppleWithHTMLData:[e3.raw dataUsingEncoding:NSUTF8StringEncoding]];

                TFHppleElement *categoryE3 =[[h3 searchWithXPathQuery:@"//div[@class='entry-title ellipsis']"] firstObject];

                NSString *title = [categoryE3 text];
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title", nil];
                [ma1 addObject:dic];
            }
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",ma1,@"categoryArr", nil];

            [ma addObject:dic];

        }
                i=i+1;

    }
    return ma;
}

#pragma mark jobbole（伯乐在线） 相关请求
+(NSMutableArray *)jobboleResponseObject:(id)responseObject{
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:responseObject];
    
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
//    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//div[contains(@class, 'grid-7')]"] firstObject];
//    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];
    TFHppleElement *categoryE1 =[[hpple searchWithXPathQuery:@"//ul[contains(@class, 'sub-menu')]"] firstObject];
    TFHpple *h1 =[TFHpple hppleWithHTMLData:[categoryE1.raw dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *arr = [h1 searchWithXPathQuery:@"//li"];
    
    for (TFHppleElement *e2 in arr) {
            TFHpple *h2 =[TFHpple hppleWithHTMLData:[e2.raw dataUsingEncoding:NSUTF8StringEncoding]];
            TFHppleElement *categoryE2 =[[h2 searchWithXPathQuery:@"//a"] firstObject];
            
            NSString *title = [categoryE2 text];
            NSString *url = [categoryE2 objectForKey:@"href"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",url,@"url", nil];
            [ma addObject:dic];
    }
    return ma;
}

@end


