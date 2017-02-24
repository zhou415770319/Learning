//
//  ZFTableViewCell.h
//  代码片段
//
//  Created by w on 16/5/23.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTableViewCellModel.h"
#import "ZFTableViewCellFrameModel.h"
@interface ZFTableViewCell : UITableViewCell
//数据
@property(nonatomic,retain)ZFTableViewCellModel *cellInfo;

@property(nonatomic,retain)UITextField* textField;


- (id)initWithFrameModel:(ZFTableViewCellFrameModel *)frameModel;


@end
