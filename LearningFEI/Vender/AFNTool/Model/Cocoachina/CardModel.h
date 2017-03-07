//
//  CardModel.h
//  LearningFEI
//
//  Created by 周飞 on 2017/3/5.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardModel : NSObject

@property(nonatomic,copy)NSString *categoryTitle;


@property(nonatomic,copy)NSString *categoryUrl;

@property(nonatomic,retain)NSMutableArray *contentArr;

@end
