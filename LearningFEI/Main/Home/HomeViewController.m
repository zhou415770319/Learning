//
//  HomeViewController.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/10.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "HomeViewController.h"
#import "TFHpple.h"
#import "ZFSpiderTool.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [self hpple];
}

-(void)hpple{
    NSURL *url = [NSURL URLWithString:BaseUrl_code4App];
    
    // 2. urlrequet
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return;
    }
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:data];
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *ma1 = [NSMutableArray arrayWithCapacity:1];

    NSArray *arr = [hpple searchWithXPathQuery:@"//ul[@class='ttp bm cl']"];
    int i= 0;
    for (TFHppleElement *e in arr) {
        if (i != 0) {
            NSLog(@"%@", e);
            TFHpple *h =[TFHpple hppleWithHTMLData:[e.raw dataUsingEncoding:NSUTF8StringEncoding]];
            TFHppleElement *categoryE =[[h searchWithXPathQuery:@"//a[@href='javascript:;']"] firstObject];
            
            NSString *category =[categoryE text];
            NSArray *a1 = [h searchWithXPathQuery:@"//a[@href!='javascript:;']"];
            for (TFHppleElement *e2 in a1) {
                NSString *title = [e2 text];
                NSString *url = [e2 objectForKey:@"href"];
                NSDictionary *dic = @{@"title":title,@"url":url};
                [ma1 addObject:dic];
            }
            NSDictionary *dic1 = @{@"category":category,@"subCategory":ma1};

            [ma addObject:dic1];
        }
        i = i+1;
    }
    
    
    NSLog(@"%@", ma);

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
