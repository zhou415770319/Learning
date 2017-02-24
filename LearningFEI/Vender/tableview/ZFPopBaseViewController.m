//
//  ZFPopBaseViewController.m
//  ZFSwiftCode
//
//  Created by w on 16/7/10.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import "ZFPopBaseViewController.h"
#import "ZFTabBarViewController.h"
@interface ZFPopBaseViewController ()

@end

@implementation ZFPopBaseViewController


//-(void)setIsHidenTabBar:(BOOL)isHidenTabBar{
//    
//    if (_isHidenTabBar != isHidenTabBar) {
//        _isHidenTabBar = isHidenTabBar;
//        if ([self.tabBarController isKindOfClass:[ZFTabBarViewController class]]) {
//            ZFTabBarViewController *VC = (ZFTabBarViewController *)self.tabBarController;
//            VC.tabBarView.hidden = isHidenTabBar;
//        }
//    }
//    
//}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (self.isHidenTabBar == YES) {
        if ([self.tabBarController isKindOfClass:[ZFTabBarViewController class]]) {
            ZFTabBarViewController *VC = (ZFTabBarViewController *)self.tabBarController;
            VC.tabBarView.hidden = NO;
        }
    }else{
        if ([self.tabBarController isKindOfClass:[ZFTabBarViewController class]]) {
            ZFTabBarViewController *VC = (ZFTabBarViewController *)self.tabBarController;
            VC.tabBarView.hidden = NO;
        }
        
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if (self.isHidenTabBar == YES) {
        if ([self.tabBarController isKindOfClass:[ZFTabBarViewController class]]) {
            ZFTabBarViewController *VC = (ZFTabBarViewController *)self.tabBarController;
            VC.tabBarView.hidden = YES;
        }
    }else{
        if ([self.tabBarController isKindOfClass:[ZFTabBarViewController class]]) {
            ZFTabBarViewController *VC = (ZFTabBarViewController *)self.tabBarController;
            VC.tabBarView.hidden = NO;
        }
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenTabBar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
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
