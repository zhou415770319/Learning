//
//  WebViewController.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/24.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()
@property(nonatomic,retain)UIWebView *web;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setLeftNavigation:@"返回"];
//    self.isHidenTabBar = YES;
    self.web = [[UIWebView alloc] init];
    self.web.frame = CGRectMake(0, 0,SCREENWIDTH, SCREENHEIGHT+64);
    self.web.backgroundColor = [UIColor whiteColor];
    self.web.delegate = self;
    [self.web setScalesPageToFit:YES];
    
    [self.view addSubview:self.web];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    
    
    NSLog(@"urlStr----->%@",self.url);
    NSURL *url = [[NSURL alloc]initWithString:self.url];
    
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    
    
    [self.web loadRequest:reqest];
//    [self showProgressHUD];
}





-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
//    [self hideProgressHUD];
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
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
