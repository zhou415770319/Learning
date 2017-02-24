//
//  ZFTableViewCellFrameModel.h
//  ZFSwiftCode
//
//  Created by w on 16/7/9.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFTableViewCellModel.h"
@interface ZFTableViewCellFrameModel : NSObject

@property(nonatomic,strong)ZFTableViewCellModel *cellInfo;
//固定参数
/** lineView的frame*/
@property (nonatomic, assign) CGRect lineViewF;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeightF;



/** 标题的frame  */
@property (nonatomic, assign) CGRect titleF;

/** 描述的frame  */
@property (nonatomic, assign) CGRect desF;

/*图片frame*/
@property (nonatomic, assign) CGRect iconF;

/** post 时间frame*/
@property (nonatomic, assign) CGRect timeF;

/** 分类的frame*/
@property (nonatomic, assign) CGRect categoryF;
/** 来源的frame*/
@property (nonatomic, assign) CGRect sourceF;





@end
