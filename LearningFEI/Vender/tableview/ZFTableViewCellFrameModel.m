//
//  ZFTableViewCellFrameModel.m
//  ZFSwiftCode
//
//  Created by w on 16/7/9.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import "ZFTableViewCellFrameModel.h"
#import "ZFStringTool.h"
#define PADDING_VIEW_VIEW 5

#define ICONWIDTH 100

#define LABLE_WIDTH (SCREENWIDTH-20)/3

#define TEXTSIZEMAX [UIFont systemFontOfSize:20.0]
#define TEXTSIZEBIG [UIFont systemFontOfSize:18.0]
#define TEXTSIZEMIDDLE [UIFont systemFontOfSize:16.0]
#define TEXTSIZESMALL [UIFont systemFontOfSize:14.0]

@interface ZFTableViewCellFrameModel()


@end


@implementation ZFTableViewCellFrameModel

-(void)setCellInfo:(ZFTableViewCellModel *)cellInfo{
    _cellInfo =cellInfo;
    //计算 标题的frame
    [self setupTitleFrame];
    
    //计算 描述的frame
    [self setupdesFrame];
    
    //计算 图片的frame
    [self setupIconFrame];
    
    //计算 postTime的frame
    [self setupPostTimeFrame];

    //计算 分类的Frame
    [self setupCategoryFrame];
    
    //计算 来源的frame
    [self setupSourceFrame];
    
    
    
    //计算 lineViewF的frame
    [self setupLineViewFrame];
    
    
    _cellHeightF =CGRectGetMaxY(_lineViewF);

    
}


-(void)setupTitleFrame{
    _titleF =CGRectMake(PADDING_VIEW_VIEW, PADDING_VIEW_VIEW, SCREENWIDTH-2*PADDING_VIEW_VIEW, [ZFStringTool getStrSize:self.cellInfo.title andTexFont:TEXTSIZEBIG andMaxSize:CGSizeMake(SCREENWIDTH-2*PADDING_VIEW_VIEW, 90)].height);
}

-(void)setupdesFrame{
    _desF =CGRectMake(PADDING_VIEW_VIEW*2+ICONWIDTH, CGRectGetMaxY(_titleF)+PADDING_VIEW_VIEW, SCREENWIDTH-(PADDING_VIEW_VIEW*3+ICONWIDTH), 60);
}

-(void)setupIconFrame{
    
    if ([self.cellInfo.cellName isEqualToString:@"SwiftVInfoCell"]) {
        if (CGRectGetMaxY(_desF)-CGRectGetMinY(_desF)>ICONWIDTH) {
            _iconF =CGRectMake(PADDING_VIEW_VIEW, (CGRectGetMaxY(_desF)-CGRectGetMinY(_desF)-ICONWIDTH)/2+CGRectGetMaxY(_titleF)+PADDING_VIEW_VIEW, SCREENWIDTH, ICONWIDTH);
        }else{
            _iconF =CGRectMake(PADDING_VIEW_VIEW, CGRectGetMaxY(_titleF)+PADDING_VIEW_VIEW, SCREENWIDTH, ICONWIDTH);
        }
    }else{
        
        if (CGRectGetMaxY(_desF)-CGRectGetMinY(_desF)>ICONWIDTH) {
            _iconF =CGRectMake(PADDING_VIEW_VIEW, (CGRectGetMaxY(_desF)-CGRectGetMinY(_desF)-ICONWIDTH)/2+CGRectGetMaxY(_titleF)+PADDING_VIEW_VIEW, ICONWIDTH, ICONWIDTH);
        }else{
            _iconF =CGRectMake(PADDING_VIEW_VIEW, CGRectGetMaxY(_titleF)+PADDING_VIEW_VIEW, ICONWIDTH, ICONWIDTH);
        }
    }

    
    
    
}


-(void)setupPostTimeFrame{
    
    if (!self.cellInfo.postTime) {
        return;
    }
    
    if (CGRectGetMaxY(_desF) > CGRectGetMaxY(_iconF)) {
        _timeF =CGRectMake(PADDING_VIEW_VIEW, CGRectGetMaxY(_desF)+PADDING_VIEW_VIEW, [ZFStringTool getStrSize:self.cellInfo.postTime andTexFont:TEXTSIZESMALL andMaxSize:CGSizeMake(LABLE_WIDTH, MAXFLOAT)].width, 30);

    }else{
        _timeF =CGRectMake(PADDING_VIEW_VIEW, CGRectGetMaxY(_iconF)+PADDING_VIEW_VIEW, [ZFStringTool getStrSize:self.cellInfo.postTime andTexFont:TEXTSIZESMALL andMaxSize:CGSizeMake(LABLE_WIDTH, MAXFLOAT)].width, 30);
    }
    
}
-(void)setupCategoryFrame{
    if (!self.cellInfo.category) {
        return;
    }

    _categoryF =CGRectMake(CGRectGetMaxX(_timeF)+PADDING_VIEW_VIEW, CGRectGetMinY(_timeF), [ZFStringTool getStrSize:self.cellInfo.category andTexFont:TEXTSIZESMALL andMaxSize:CGSizeMake(LABLE_WIDTH, MAXFLOAT)].width, 30);
}
-(void)setupSourceFrame{
    if (!self.cellInfo.source) {
        return;
    }
    _sourceF =CGRectMake(CGRectGetMaxX(_categoryF)+PADDING_VIEW_VIEW, CGRectGetMinY(_timeF), [ZFStringTool getStrSize:self.cellInfo.source andTexFont:TEXTSIZESMALL andMaxSize:CGSizeMake(200, MAXFLOAT)].width, 30);
}
-(void)setupLineViewFrame{
    if ([self.cellInfo.cellName isEqualToString:@"SwiftVInfoCell"]) {
        _lineViewF =CGRectMake(PADDING_VIEW_VIEW, CGRectGetMaxY(_iconF)+PADDING_VIEW_VIEW, SCREENWIDTH-2*PADDING_VIEW_VIEW, 1);

    }else{
        _lineViewF =CGRectMake(PADDING_VIEW_VIEW, CGRectGetMaxY(_timeF)+PADDING_VIEW_VIEW, SCREENWIDTH-2*PADDING_VIEW_VIEW, 1);

    }
}



@end
