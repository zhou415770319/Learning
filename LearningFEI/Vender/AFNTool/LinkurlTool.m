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
                        ,@"http://code4app.qiniudn.com"
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
            req.idStr = urlStr;
            req.Parameters = parameters;

            break;
    }
    
    return req;
}
//组装responseModel
+(AFNResponseModel *)responseModel:(LINKURL)url ResponseObject:(id)responseObject{
    
    AFNResponseModel *res = [[AFNResponseModel alloc] init];
    
    
    switch (url) {
        case LINKURL_cocoaChina:
            res.arr = [self cocoaChinaResponseObject:responseObject];

            break;
            
        case LINKURL_code4app:
            res.arr = [self code4appResponseObject:responseObject];
            
            break;
        case LINKURL_gold:
            res.arr = [self goldResponseObject:responseObject];

            break;
        case LINKURL_health:
            
            break;
            
        case LINKURL_code4app_contentInfo:
            res.arr = [self code4appContentResponseObject:responseObject];

            break;
            
        case LINKURL_cocoaChina_contentInfo:
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
                NSDictionary *dic = @{@"title":title,@"url":[NSString stringWithFormat:@"http://code4app.com/%@",url]};
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
        NSDictionary *dic = @{@"title":title,@"url":[NSString stringWithFormat:@"http://code4app.com/%@",url]};
        [ma addObject:dic];
    }
    return ma;
}


+(NSMutableArray *)cocoaChinaResponseObject:(id)responseObject{
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:responseObject];
    
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    TFHppleElement *categoryE =[[hpple searchWithXPathQuery:@"//div[@class='nav-header-bottom']"] firstObject];
    TFHpple *h =[TFHpple hppleWithHTMLData:[categoryE.raw dataUsingEncoding:NSUTF8StringEncoding]];

    NSArray *arr = [h searchWithXPathQuery:@"//li/a"];
    
    for (TFHppleElement *e2 in arr) {
        NSString *title = [e2 text];
        NSString *url = [e2 objectForKey:@"href"];
        NSDictionary *dic = @{@"title":title,@"url":[NSString stringWithFormat:@"http://www.cocoachina.com%@",url]};
        [ma addObject:dic];
    }
    return ma;
}

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
        NSDictionary *dic = @{@"title":title,@"url":[NSString stringWithFormat:@"http://www.cocoachina.com%@",url]};
        [ma addObject:dic];
    }
    return ma;
}

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
            NSDictionary *dic = @{@"title":title,@"url":[NSString stringWithFormat:@"https://gold.xitu.io/welcome/%@",url]};
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
                
                NSDictionary *dic = @{@"title":title};
                [ma1 addObject:dic];
            }

            NSDictionary *dic = @{@"title":title,@"categoryArr":ma1};
            [ma addObject:dic];

        }
                i=i+1;

    }
    return ma;
}


@end


