//
//  ZFTableViewCellModel.h
//  代码片段
//
//  Created by w on 16/5/23.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZFTableViewCellModel : NSObject
// cell类型 如果没有设置则默认为系统cell
//class
@property(nonatomic,copy)NSString *cellName;
//xib
@property(nonatomic,copy)NSString *xibCellName;

//没有设置cell类型的情况下可以设置tableViewCellStyle 默认为UITableViewCellStyleDefault
@property(nonatomic)UITableViewCellStyle tableViewCellStyle;
//UITableViewCellAccessoryType
@property(nonatomic)UITableViewCellAccessoryType tableViewCellAccessoryType;

//didSelectRow 需要跳转的controller
@property(nonatomic,copy)NSString *PopToViewController;


//扩展参数

//标题
@property(nonatomic,copy)NSString *title;
//图片名字
@property(nonatomic,copy)NSString *imgName;
//子标题
@property(nonatomic,copy)NSString *des;

@property(nonatomic,copy)NSString *url;


//textField placeholder
@property(nonatomic,copy)NSString *textFieldPlace;

@property(nonatomic)UIKeyboardType keyboardType;

//cell  代理controller
@property(nonatomic,retain)UIViewController *ownViewController;



//newsInfo
@property(nonatomic,copy)NSString *category;

@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *newsInfo;
@property(nonatomic,copy)NSString *postTime;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *number;


//子标题
@property(nonatomic,copy)NSString *num;

//FunctionRealizationViewController
@property(nonatomic,assign)BOOL isPop;


@property(nonatomic,assign)BOOL isOpen;

@property(nonatomic,retain)NSArray *funcArr;

//AccountViewController
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userIconUrl;

//是否显示向右箭头
@property(nonatomic,assign)BOOL isJump;

//是否开启通知
@property(nonatomic,assign)BOOL isNoti;

@end
