//
//  AFNTestViewController.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/10.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "AFNTestViewController.h"
#import "NetworkingManager.h"

@interface AFNTestViewController ()

@end

@implementation AFNTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor blueColor];
//    btn.frame = CGRectMake(0, 100, 80, 40);
//    [btn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    

    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    NSString *url = @"http://www.cocoachina.com/swift/";
    
    NSMutableDictionary *pars = [NSMutableDictionary dictionaryWithCapacity:1];
    [pars setObject:url forKey:@"urlStr"];
    [[NetworkingManager standard] request:LINKURL_cocoaChina_contentInfo Parameters:pars Success:^(AFNResponseModel *model) {
        NSLog(@"------arr----%@",model.arr);
    } Failture:^(id error) {
        NSLog(@"%@",error);

    }];
    
}


-(void)backBtnClick:(UIButton *)sender{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
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
