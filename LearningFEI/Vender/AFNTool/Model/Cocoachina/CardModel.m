//
//  CardModel.m
//  LearningFEI
//
//  Created by 周飞 on 2017/3/5.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "CardModel.h"

@implementation CardModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"contentArr":@"LinkModel",// 或者
             //             @"users":[User class],
             };
}


@end
