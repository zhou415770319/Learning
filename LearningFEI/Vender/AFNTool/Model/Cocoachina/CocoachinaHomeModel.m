//
//  CocoachinaHomeModel.m
//  LearningFEI
//
//  Created by 周飞 on 2017/3/5.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "CocoachinaHomeModel.h"
#import "MJExtension.h"

@implementation CocoachinaHomeModel


+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"cardArr":@"CardModel",// 或者
             @"scrollInfo":@"ScrollInfoModel",// 或者
             @"rankArr":@"RankModelModel",// 或者

             };
}

+(id)modelWithResponseModel:(AFNResponseModel *)response{
//    self.cardArr = [response.dict objectForKey:@"cardArr"];
//    
//    self.scrollInfo = [response.dict objectForKey:@"scrollInfo"];
//    self.rankArr = [response.dict objectForKey:@"rankArr"];
    CocoachinaHomeModel *model = [CocoachinaHomeModel mj_objectWithKeyValues:response.dict];
    
    return model;
}

@end
