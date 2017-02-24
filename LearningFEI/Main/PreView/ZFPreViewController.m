//
//  ZFPreViewController.m
//  ZFSwiftCode
//
//  Created by w on 16/7/4.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import "ZFPreViewController.h"
#import "ZFScrollView.h"
#import "LearningFEI-Swift.h"

#import "TFHpple.h"

@interface ZFPreViewController ()<ZFScrollViewDelegate>
@property (nonatomic,retain)ZFScrollView *scrollV;


@property (nonatomic,retain)NSMutableArray *infos;

@end

@implementation ZFPreViewController


-(NSArray *)infos{
    
    if (!_infos) {
        _infos = [NSMutableArray arrayWithObjects:@"0",@"1", nil];

//        _infos = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
        
    }
    
    return _infos;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:YES];

    
    ZFScrollView *scrollV = [[ZFScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    scrollV.infos =self.infos;
    scrollV.backgroundColor =[UIColor whiteColor];
    scrollV.isAddTimer =YES;
    //默认2.0秒
        scrollV.animationDuration =.5;
    scrollV.delegate = self;
    scrollV.isAddButton = YES;
    [self.view addSubview:scrollV];
    
    
    //UIViewController的属性propertyautomaticallyAdjustsScrollViewInsets默认增加了填充，若要照自己设置的全屏滚动修改
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    // Do any additional setup after loading the view.
}


#pragma mark ZFScrollViewDelegate方法
-(void)clickNextBtn{
    UIStoryboard *login = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    UIViewController *LoginVC = [login instantiateViewControllerWithIdentifier:@"login"];
    
    [self presentViewController:LoginVC animated:YES completion:^{
    
    }];
//    [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
    
    NSLog(@"clickNextBtn");
}

-(void)clickImgWithBtn:(UIButton *)btn{
    
    NSLog(@"clickimage");

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
