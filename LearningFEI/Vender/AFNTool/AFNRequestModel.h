//
//  AFNRequestModel.h
//  LearningFEI
//
//  Created by 周飞 on 2017/2/20.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNRequestModel : NSObject

//请求地址
@property(nonatomic,copy)NSString *urlStr;
//是否缓存请求 若idStr == @“” 不缓存
@property(nonatomic,copy)NSString *idStr;
//请求参数
@property(nonatomic,retain)NSMutableDictionary *Parameters;


@end
