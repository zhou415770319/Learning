//
//  CocoachinaHomeModel.h
//  LearningFEI
//
//  Created by 周飞 on 2017/3/5.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScrollInfoModel.h"
#import "CardModel.h"
#import "RankModel.h"
#import "BaseModel.h"
@interface CocoachinaHomeModel : BaseModel

@property(nonatomic,retain)NSMutableArray *scrollInfo;

@property(nonatomic,retain)NSMutableArray *cardArr;

@property(nonatomic,retain)NSMutableArray *rankArr;


@end
