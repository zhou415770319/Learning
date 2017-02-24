//
//  LinkurlTool.h
//  LearningFEI
//
//  Created by 周飞 on 2017/2/22.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNRequestModel.h"
#import "AFNResponseModel.h"
typedef enum : NSUInteger {
    LINKURL_cocoaChina = 0,
    LINKURL_code4app,
    LINKURL_health,
    
    LINKURL_code4app_categoryInfo,
    LINKURL_cocoaChina_contentInfo,

} LINKURL;


@interface LinkurlTool : NSObject


+(AFNRequestModel *)requestModel:(LINKURL)url Parameters:(NSMutableDictionary *)parameters;


+(AFNResponseModel *)responseModel:(LINKURL)url ResponseObject:(id)responseObject;


@end
