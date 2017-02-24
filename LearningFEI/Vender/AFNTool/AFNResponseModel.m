//
//  AFNResponseModel.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/22.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "AFNResponseModel.h"

@implementation AFNResponseModel


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_arr forKey:@"arr"];
    [aCoder encodeObject:_dict forKey:@"dict"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _arr = [aDecoder decodeObjectForKey:@"arr"];
        _dict = [aDecoder decodeObjectForKey:@"dict"];
    }
    return self;
}



@end
