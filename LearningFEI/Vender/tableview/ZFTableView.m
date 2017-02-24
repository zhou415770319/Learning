//
//  ZFTableView.m
//  代码片段
//
//  Created by w on 16/5/24.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import "ZFTableView.h"
#import "ZFTableViewCellFrameModel.h"
#import "SwiftVInfoCellFrameModel.h"
#import "NewsCell.h"
#import "ZFPopBaseViewController.h"

@interface ZFTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZFTableView


//-(void)reloadData{
//    [self reloadData];
//}

-(BOOL)isMoreSection{
    if (!_isMoreSection) {
        _isMoreSection = NO;
    }
    return _isMoreSection;
}

-(BOOL)isCustomCell{
    if (!_isCustomCell) {
        _isCustomCell = NO;
    }
    return _isCustomCell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //去除分割线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.delegate =self;
        self.dataSource =self;
        
    }
    return self;
}

-(void)setCellInfos:(NSArray *)cellInfos{
    
    if (_cellInfos !=cellInfos) {
        _cellInfos =cellInfos;
        //cellName 注册
        NSMutableArray *arr =[NSMutableArray arrayWithCapacity:1];
        //xibcellName 注册
        NSMutableArray *xibArr =[NSMutableArray arrayWithCapacity:1];
        //自定义Frame的model数组
        NSMutableArray * frameModelArr = [NSMutableArray arrayWithCapacity:1];

        
        if (self.isMoreSection == YES) {
            
            if (self.isCustomCell == YES) {
                for (NSArray *temArr in _cellInfos) {
                    NSMutableArray * frameModelTemArr = [NSMutableArray arrayWithCapacity:1];

                    for (ZFTableViewCellModel *cellInfo in temArr) {
                        if (cellInfo.cellName) {
                            [arr addObject:cellInfo.cellName];
                        }
                        if (cellInfo.xibCellName) {
                            [xibArr addObject:cellInfo.xibCellName];
                        }
                        
                        if (self.isCustomCell == YES) {
                            ZFTableViewCellFrameModel *frameM = [[ZFTableViewCellFrameModel alloc] init];
                            frameM.cellInfo = cellInfo;
                            [frameModelTemArr addObject:frameM];
                        }
                        
                    }
                    [frameModelArr addObject:frameModelTemArr];
                }
            }else{
                for (NSArray *temArr in _cellInfos) {
                    
                    for (ZFTableViewCellModel *cellInfo in temArr) {
                        if (cellInfo.cellName) {
                            [arr addObject:cellInfo.cellName];
                        }
                        if (cellInfo.xibCellName) {
                            [xibArr addObject:cellInfo.xibCellName];
                        }
                    }
                }
            }
            
        }else{
            for (ZFTableViewCellModel *cellInfo in _cellInfos) {
                if (cellInfo.cellName) {
                    [arr addObject:cellInfo.cellName];
                }
                if (cellInfo.xibCellName) {
                    [xibArr addObject:cellInfo.xibCellName];
                }
                if (self.isCustomCell == YES) {
                    ZFTableViewCellFrameModel *frameM = [[ZFTableViewCellFrameModel alloc] init];
                    frameM.cellInfo = cellInfo;
                    [frameModelArr addObject:frameM];
                }
                
            }
            
        }
        
        if (self.isCustomCell == YES) {
            _cellInfos = frameModelArr;
        }
        NSSet *set = [NSSet setWithArray:arr];
        for (NSString * s1 in set) {
            [self registerClass:[NSClassFromString(s1) class] forCellReuseIdentifier:s1];
        }
        
        
        NSSet *xibSet = [NSSet setWithArray:xibArr];
        for (NSString * s1 in xibSet) {
            [self registerNib:[UINib nibWithNibName:s1 bundle:nil] forCellReuseIdentifier:s1];
        }
        [self reloadData];
    }    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.isMoreSection == YES) {
        return self.cellInfos.count;
    }
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isMoreSection ==YES) {
        return [self.cellInfos[section] count];
    }
    
    return self.cellInfos.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = 60 ;
    if (self.isCustomCell == YES) {
        ZFTableViewCellFrameModel *cellInfo;
        if (self.isMoreSection ==YES) {
            cellInfo = self.cellInfos[indexPath.section][indexPath.row];
        }else{
            cellInfo = self.cellInfos[indexPath.row];
        }
        return cellInfo.cellHeightF;
    }
    
    if (self.heightForRow) {
        height =self.heightForRow;
    }
    
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    float height = 10;
    if (self.heightForHeader) {
        height =self.heightForHeader;
    }
    
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    float height = 0;
    if (self.heightForFooter) {
        height =self.heightForFooter;
    }
    
    return height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFTableViewCellModel *cellInfo;
    ZFTableViewCell *cell = nil;

    if (self.isCustomCell == YES) {
        
        
        ZFTableViewCellFrameModel *cellInfo;
        if (self.isMoreSection ==YES) {
            cellInfo = self.cellInfos[indexPath.section][indexPath.row];
        }else{
            cellInfo = self.cellInfos[indexPath.row];
        }
        if ([cellInfo.cellInfo.cellName isEqualToString:@"SwiftVInfoCell"]) {
            cell =[[NSClassFromString(cellInfo.cellInfo.cellName) alloc]initWithFrameModel:(SwiftVInfoCellFrameModel *)cellInfo];

        }else{
            cell =[[NSClassFromString(cellInfo.cellInfo.cellName) alloc]initWithFrameModel:cellInfo];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 3.返回cell
        return cell;
    }

    
    if (self.isMoreSection ==YES) {
        cellInfo = self.cellInfos[indexPath.section][indexPath.row];
        
    }else{
        cellInfo = self.cellInfos[indexPath.row];

    }

    
    if (cell ==nil) {
        if (cellInfo.cellName) {//如果cellNmae存在
            //取出已注册的cell
            cell = [tableView dequeueReusableCellWithIdentifier:cellInfo.cellName forIndexPath:indexPath];
            UIView *v =[[UIView alloc]initWithFrame:CGRectMake(10, cell.frame.size.height-1, SCREENWIDTH-20, 1)];
            v.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:v];
        }else if (cellInfo.xibCellName){//如果XibcellNmae存在
            //取出已注册的cell
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellInfo.xibCellName forIndexPath:indexPath];
            UIView *v =[[UIView alloc]initWithFrame:CGRectMake(10, cell.frame.size.height-1, SCREENWIDTH-20, 1)];
            v.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:v];
        }else{
            
            cell = [[ZFTableViewCell alloc] initWithStyle:!cellInfo.tableViewCellStyle? UITableViewCellStyleDefault:cellInfo.tableViewCellStyle reuseIdentifier:@"cell"];
            if (cellInfo.title) {
                cell.textLabel.text =cellInfo.title;

            }
            if (cellInfo.des) {
                cell.detailTextLabel.text = cellInfo.des;
            }
            if (cellInfo.imgName) {
                cell.imageView.image =[UIImage imageNamed:cellInfo.imgName];
            }
#warning cell的Frame设置
            
            UIView *v =[[UIView alloc]initWithFrame:CGRectMake(10, cell.frame.size.height+15, SCREENWIDTH-20, 1)];
            v.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:v];
            
        }
    }
    
    cell.cellInfo = cellInfo;
    cell.selectionStyle = self.tableViewCellSelectionStyle;
    if (cellInfo.isJump) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ZFTableViewCellModel *cellInfo;

    if (self.isCustomCell == YES) {
        ZFTableViewCellFrameModel *cellFrameInfo;
        if (self.isMoreSection ==YES) {
            cellFrameInfo = self.cellInfos[indexPath.section][indexPath.row];
            
        }else{
            cellFrameInfo = self.cellInfos[indexPath.row];
        }
        cellInfo = cellFrameInfo.cellInfo;
    }else{
        if (self.isMoreSection ==YES) {
            cellInfo = self.cellInfos[indexPath.section][indexPath.row];
            
        }else{
            cellInfo = self.cellInfos[indexPath.row];
            
        }
    }
    

    //选择行，如果存在PopToViewController 且对应的class文件已创建则跳转到对应界面
    if (cellInfo.PopToViewController) {
        if (NSClassFromString(cellInfo.PopToViewController)) {
            ZFPopBaseViewController *pop =[[NSClassFromString(cellInfo.PopToViewController) alloc] init];
            pop.title = cellInfo.PopToViewController;
            pop.cellInfo = cellInfo;
            [[self viewController].navigationController pushViewController:pop animated:YES];
        }
    }
    
}

//获取view所在的Controller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return _headerView;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return _FooterView;
    
}


#pragma mark Edit delegate

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
        
        if (self.isMoreSection == YES) {
            NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.cellInfos[indexPath.section]];
            
            [mArr removeObjectAtIndex:indexPath.row];
            
            self.cellInfos = mArr;

        }else{
            NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.cellInfos];
            
            [mArr removeObjectAtIndex:indexPath.row];
            
            self.cellInfos = mArr;

        }
        
        NSLog(@"点击删除");
    }];//此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也可自行定义
//    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        
//    }];
//    editRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];//可以定义RowAction的颜色
    return @[deleteRoWAction];
    
}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (!self.isEditing)
//    {
//        return UITableViewCellEditingStyleDelete;
//    }
//    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
//}
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    return    UITableViewCellEditingStyleInsert;
//    
//}

@end
