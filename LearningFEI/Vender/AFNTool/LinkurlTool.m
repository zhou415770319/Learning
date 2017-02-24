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


+(AFNRequestModel *)requestModel:(LINKURL)url Parameters:(NSMutableDictionary *)parameters{
    NSArray *urlArr = @[@"http://www.cocoachina.com",@"http://code4app.qiniudn.com",@"health"];
    NSString *urlStr;
    AFNRequestModel *req = [[AFNRequestModel alloc] init];

    switch (url) {
        case LINKURL_code4app_categoryInfo:
            
        case LINKURL_cocoaChina_contentInfo:
            
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

+(AFNResponseModel *)responseModel:(LINKURL)url ResponseObject:(id)responseObject{
    
    AFNResponseModel *res = [[AFNResponseModel alloc] init];
    
    
    switch (url) {
        case LINKURL_cocoaChina:
            res.arr = [self cocoaChinaResponseObject:responseObject];

        
            break;
            
        case LINKURL_code4app:
            res.arr = [self code4appResponseObject:responseObject];
            
            break;
        case LINKURL_health:
            
            break;
            
        case LINKURL_code4app_categoryInfo:
            
            break;
            
        case LINKURL_cocoaChina_contentInfo:
            res.arr = [self cocoaChinaContentResponseObject:responseObject];

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
                NSDictionary *dic = @{@"title":title,@"url":url};
                [ma1 addObject:dic];
            }
            NSDictionary *dic1 = @{@"category":category,@"subCategory":ma1};
            
            [ma addObject:dic1];
        }
        i = i+1;
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
        NSDictionary *dic = @{@"title":title,@"url":url};
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
        NSDictionary *dic = @{@"title":title,@"url":url};
        [ma addObject:dic];
    }
    return ma;
}


@end
