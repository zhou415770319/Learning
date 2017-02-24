//
//  ZFTableView.h
//  代码片段
//
//  Created by w on 16/5/24.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTableViewCellModel.h"
#import "ZFTableViewCell.h"
@interface ZFTableView : UITableView
/**
 *  cell 信息
 */
@property(nonatomic,retain)NSArray *cellInfos;
/**
 *  是否多组
 */
@property(nonatomic,assign)BOOL isMoreSection;

/**
 *  是否自定义cell，代码自定义frame
 */
@property(nonatomic,assign)BOOL isCustomCell;


/**
 *  row 高度
 */
@property (nonatomic,assign)CGFloat heightForRow;

/**
 *  header 高度
 */
@property (nonatomic,assign)CGFloat heightForHeader;

/**
 *  footer 高度
 */
@property (nonatomic,assign)CGFloat heightForFooter;

//单个headerView 可以直接赋值，如果有多行headerView需重写delegate
@property (nonatomic,retain)UIView *headerView;

//单个FooterView 可以直接赋值，如果有多行FooterView需重写delegate
@property (nonatomic,retain)UIView *FooterView;


/**
 *  cell SelectionStyle
 */
@property (nonatomic,assign)UITableViewCellSelectionStyle tableViewCellSelectionStyle;


//- (void)reloadData;


@end
