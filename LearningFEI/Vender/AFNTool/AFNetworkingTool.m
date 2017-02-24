//
//  AFNetworkingTool.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/10.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "AFNetworkingTool.h"
#import "AFNetworking.h"
#import "XWDataCacheTool.h"
#import "TFHpple.h"
@implementation AFNetworkingTool


+ (void)request:(AFNRequestModel *)model Success:(void(^)(NSData *data))success Failture:(void(^)(id error))failture{
    
    //如果数据库里面有值就先读取数据库
    if(model.idStr.length>0){
        NSData *data=[XWDataCacheTool dataWithID:model.idStr];
        if(data.length != 0){
            success(data);
            return;
        }
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [model.urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //成功
        
        if(model.idStr.length>0){
            //发送网络请求获取最新数据  先清空旧的数据
            [XWDataCacheTool deleteWidthId:model.idStr];
            //做数据缓存
            [XWDataCacheTool addData:responseObject andId:model.idStr];
        }
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //失败
        failture(error.description);
    }];
    
}





@end
