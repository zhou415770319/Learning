//
//  AFNetworkingTool.h
//  LearningFEI
//
//  Created by 周飞 on 2017/2/10.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNRequestModel.h"
#import "XWDataCacheTool.h"


@interface AFNetworkingTool : NSObject

+ (void)request:(AFNRequestModel *)model Success:(void(^)(NSData *data))success Failture:(void(^)(id error))failture;



@end
