//
//  CocoachinaHomeViewController.m
//  LearningFEI
//
//  Created by 周飞 on 2017/3/5.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "CocoachinaHomeViewController.h"
#import "CocoachinaHomeModel.h"
#import "ZFScrollView.h"
@interface CocoachinaHomeViewController ()

@property(nonatomic,retain)ZFScrollView *scrollView;

@property(nonatomic,retain)UITableView *tableView;



@end

@implementation CocoachinaHomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NetworkingManager standard] request:LINKURL_cocoaChina Parameters:nil Success:^(AFNResponseModel *model) {
        CocoachinaHomeModel *homeModel = [CocoachinaHomeModel modelWithResponseModel:model];
        
        NSLog(@"%@",homeModel.scrollInfo);
        
        ZFScrollView *scroll = [[ZFScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        scroll.infos = homeModel.scrollInfo;
        [self.view addSubview:scroll];
        
    } Failture:^(id error) {
        NSLog(@"%@",error);

    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"cocoachina";
    // Do any additional setup after loading the view.
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
