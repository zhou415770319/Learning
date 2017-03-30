//
//  TestStackViewController.m
//  LearningFEI
//
//  Created by 周飞 on 2017/3/6.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "TestStackViewController.h"
#import "CocoachinaHomeModel.h"
#import "Masonry.h"
#import "XRCarouselView.h"
@interface TestStackViewController ()
{
    NSMutableArray *_scrollArray;//轮播数据
    NSMutableArray *_cardArr;//卡片信息数据
    NSMutableArray *_rankArr;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;

@property (weak, nonatomic) IBOutlet UITableView *tableV;

@end

@implementation TestStackViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initViews];
    
    // Do any additional setup after loading the view.
}

-(void)initData{
    
    [[NetworkingManager standard] request:LINKURL_cocoaChina Parameters:nil Success:^(AFNResponseModel *model) {
        CocoachinaHomeModel *homeModel = [CocoachinaHomeModel modelWithResponseModel:model];
        //
        NSLog(@"%@",homeModel.scrollInfo);
        NSMutableArray *imgArr=[NSMutableArray arrayWithCapacity:1];
        NSMutableArray *titleArr=[NSMutableArray arrayWithCapacity:1];
        
        _scrollArray = nil;
        for (int i = 0; i<homeModel.scrollInfo.count; i++) {
            ScrollInfoModel *scrollM = homeModel.scrollInfo[i];
            [_scrollArray addObject:[UIImage imageNamed:@"0.png"]];
            //            [imgArr addObject:scrollM.imageUrl];
            //            [titleArr addObject:scrollM.contentText];
            
        }
//        self.scrollView.imageArray = _scrollArray;
//        self.scrollView.describeArray = titleArr;
//        [self.stackV addArrangedSubview:self.scrollView];
//        
//        
//        [self.stackV addArrangedSubview:self.btn2];
//        [self.stackV addArrangedSubview:self.btn3];
        //
        //        ZFScrollView *scroll = [[ZFScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        //        scroll.infos = homeModel.scrollInfo;
        //        [self.view addSubview:scroll];
        
    } Failture:^(id error) {
        NSLog(@"%@",error);
        
    }];
    
}

-(void)initViews{
    
//    [self.view addSubview:self.stackV];
//    [self.stackV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(NAVI_HEIGHT);
//        make.centerX.mas_equalTo(self.view);
//        make.width.mas_equalTo(self.view).offset(-20);
//
//        
//    }];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
