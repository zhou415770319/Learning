//
//  NetworkingManager.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/10.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "NetworkingManager.h"
#import "XWDataCacheTool.h"
@implementation NetworkingManager

+(NetworkingManager *)standard{
    __strong static NetworkingManager *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[NetworkingManager alloc] init];
    });
    
    return sharedManager;
    
}


-(void)request:(LINKURL)url Parameters:(NSMutableDictionary *)parameters Success:(void(^)(id model))success Failture:(void(^)(id error))failture{
    
    AFNRequestModel *model = [LinkurlTool requestModel:url Parameters:parameters];

    [self requestModel:model Link:url Success:^(id model) {
        success(model);
    } Failture:^(id error) {
        failture(error);
    }];
    
}


-(void)requestUrlStr:(NSString *)urlStr Parameters:(NSMutableDictionary *)parameters Success:(void(^)(id model))success Failture:(void(^)(id error))failture{
    AFNRequestModel *model = [[AFNRequestModel alloc] init];
    model.urlStr = urlStr;
    model.idStr = urlStr;
    model.Parameters = parameters;
    [self requestModel:model Link:LINKURL_health Success:^(id model) {
        success(model);
    } Failture:^(id error) {
        failture(error);
    }];
    
}

-(void)requestModel:(AFNRequestModel *)model Link:(LINKURL)link Success:(void(^)(id model))success Failture:(void(^)(id error))failture{
    
    //如果数据库里面有值就先读取数据库
    if(model.idStr.length>0){
        NSDictionary *dict = [XWDataCacheTool dictionaryWithID:model.idStr];
        if (dict != nil) {
            AFNResponseModel *resModel = [AFNResponseModel mj_objectWithKeyValues:dict];
            
            if((resModel.arr != nil &&resModel.arr.count !=0) || resModel.dict !=nil ){
                success(resModel);
                return;
            }
        }
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStr = [model.urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [manager GET:urlStr parameters:model.Parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        //成功
        
        AFNResponseModel *resModel = [LinkurlTool responseModel:link ResponseObject:responseObject];
        if(model.idStr.length>0){
            //发送网络请求获取最新数据  先清空旧的数据
            [XWDataCacheTool deleteWidthId:model.idStr];
            //做数据缓存
            [XWDataCacheTool addDict:resModel.mj_keyValues andId:model.idStr];
//            [XWDataCacheTool addModel:resModel.mj_keyValues andId:model.idStr];
        }
        success(resModel);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //失败
        failture(error.description);
    }];
        
}



@end
