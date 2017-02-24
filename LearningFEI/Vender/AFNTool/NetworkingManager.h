//
//  NetworkingManager.h
//  LearningFEI
//
//  Created by 周飞 on 2017/2/10.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkurlTool.h"
#import "AFNetworking.h"

@interface NetworkingManager : NSObject


+(NetworkingManager *)standard;

-(void)request:(LINKURL)url Parameters:(NSMutableDictionary *)parameters Success:(void(^)(id model))success Failture:(void(^)(id error))failture;
-(void)requestUrlStr:(NSString *)urlStr Parameters:(NSMutableDictionary *)parameters Success:(void(^)(id model))success Failture:(void(^)(id error))failture;

@end
