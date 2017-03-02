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
    NSArray*cookies =[[NSUserDefaults standardUserDefaults]objectForKey:@"cookies"];
    if (cookies!= nil && (cookies.count>3)) {
        NSMutableDictionary*cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:[cookies objectAtIndex:0]forKey:NSHTTPCookieName];
        [cookieProperties setObject:[cookies objectAtIndex:1]forKey:NSHTTPCookieValue];
        [cookieProperties setObject:[cookies objectAtIndex:3]forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:[cookies objectAtIndex:4]forKey:NSHTTPCookiePath];
        NSHTTPCookie*cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:cookieuser];
    }
    
    NSLog(@"urlStr----->%@",self.url);
    NSURL *url = [[NSURL alloc]initWithString:self.url];
    
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    
    
    [self.web loadRequest:reqest];
//    [self showProgressHUD];
}





-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
}

- (void)webViewDidFinishLoad:(UIWebView*)webView{
    NSArray*nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies];
    NSHTTPCookie*cookie;
    for(id c in nCookies)
    {
        if([c isKindOfClass:[NSHTTPCookie class]])
        {
            cookie=(NSHTTPCookie*) c;
            if([cookie.name isEqualToString:@"PHPSESSID"]) {
                NSNumber*sessionOnly = [NSNumber numberWithBool:cookie.sessionOnly];
                NSNumber*isSecure = [NSNumber numberWithBool:cookie.isSecure];
                NSArray*cookies = [NSArray arrayWithObjects:cookie.name, cookie.value, sessionOnly, cookie.domain, cookie.path, isSecure,nil];
                [[NSUserDefaults standardUserDefaults]setObject:cookies forKey:@"cookies"];
                break;
            }
        }
    }
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
