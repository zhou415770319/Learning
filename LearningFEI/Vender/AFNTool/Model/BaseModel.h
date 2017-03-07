//
//  BaseModel.h
//  LearningFEI
//
//  Created by 周飞 on 2017/3/5.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNResponseModel.h"
@interface BaseModel : NSObject

+(id)modelWithResponseModel:(AFNResponseModel *)response;

@end
