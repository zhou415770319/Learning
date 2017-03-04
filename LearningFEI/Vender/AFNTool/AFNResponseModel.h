//
//  AFNResponseModel.h
//  LearningFEI
//
//  Created by 周飞 on 2017/2/22.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNResponseModel : NSObject

@property(nonatomic,copy)NSString *idstr;

@property(nonatomic,retain)NSArray *arr;

@property(nonatomic,retain)NSDictionary *dict;

@end
