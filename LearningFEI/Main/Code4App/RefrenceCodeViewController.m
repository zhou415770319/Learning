//
//  RefrenceCodeViewController.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/20.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "RefrenceCodeViewController.h"
#import "CommonMenuView.h"
#import "AFNetworkingTool.h"
#import "TFHpple.h"

@interface RefrenceCodeViewController ()
@property (nonatomic,assign) BOOL flag;

//导航arr
@property(nonatomic,retain)NSMutableArray *naviArr;


/** 导航信息 */
@property(nonatomic,strong) NSArray *Infos;

/** 信息 */
@property(nonatomic,strong) NSArray *newsInfos;

@property(nonatomic,copy) NSString *currentUrl;


@end

@implementation RefrenceCodeViewController{
    NSArray *_dataArray;
}


-(NSMutableArray *)naviArr{
    if (!_naviArr) {
        _naviArr = [NSMutableArray array];
    }
    return _naviArr;
}

-(NSArray *)Infos{
    if (!_Infos) {
        _Infos = [NSArray array];
    }
    return _Infos;
}


-(NSArray *)newsInfos{
    if (!_newsInfos) {
        _newsInfos = [NSArray array];
    }
    return _newsInfos;
}

-(void)getData{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    NSString *url = BaseUrl_code4App;
    NSMutableDictionary *parameters = nil;
    
    AFNRequestModel *req = [[AFNRequestModel alloc] init];
    req.urlStr = url;
    req.idStr = @"code4app-Home";
    
    req.Parameters = parameters;
    
    NSString *naviStr = @"code4app-navi";
    //如果数据库里面有值就先读取数据库
    if(naviStr.length>0){
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[XWDataCacheTool dataArrWithID:naviStr]];
        if(arr.count != 0){
            self.naviArr = arr;
            self.Infos = [arr[0] objectForKey:@"subCategory"];
            [self getNewsInfos:[self.Infos[0] objectForKey:@"url"]];
//            [self addViews];
            return;
        }
    }
    
    [AFNetworkingTool request:req Success:^(NSData *data) {
        TFHpple *hpple = [TFHpple hppleWithHTMLData:data];
        
        
        NSArray *arr = [hpple searchWithXPathQuery:@"//ul[@class='ttp bm cl']"];
        int i= 0;
        for (TFHppleElement *e in arr) {
            if (i != 0) {
                //                NSLog(@"%@", e);
                TFHpple *h =[TFHpple hppleWithHTMLData:[e.raw dataUsingEncoding:NSUTF8StringEncoding]];
                TFHppleElement *categoryE =[[h searchWithXPathQuery:@"//a[@href='javascript:;']"] firstObject];
                
                NSString *category =[categoryE text];
                NSArray *a1 = [h searchWithXPathQuery:@"//a[@href!='javascript:;']"];
                
                NSMutableArray *ma1 = [NSMutableArray arrayWithCapacity:1];
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
        self.naviArr = ma;
        self.Infos = [ma[0] objectForKey:@"subCategory"];
        
//        [self addViews];
        //发送网络请求获取最新数据  先清空旧的数据
        [XWDataCacheTool deleteWidthId:naviStr];
        //做数据缓存
        [XWDataCacheTool addArr:ma andId:naviStr];
        
    } Failture:^(id error) {
        
        NSLog(@"%@",error);
        
    }];
    
}
-(void)getNewsInfos:(NSString *)url{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:1];
    
    NSMutableDictionary *parameters = nil;
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",@"http://code4app.com",url];
    AFNRequestModel *req = [[AFNRequestModel alloc] init];
    req.urlStr = urlStr;
    req.idStr = url;
    
    req.Parameters = parameters;
    
//    NSString *naviStr = @"code4app-navi";
//    //如果数据库里面有值就先读取数据库
//    if(naviStr.length>0){
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:[XWDataCacheTool dataArrWithID:naviStr]];
//        if(arr.count != 0){
//            
//            return arr;
//        }
//    }
    
    [AFNetworkingTool request:req Success:^(NSData *data) {
        TFHpple *hpple = [TFHpple hppleWithHTMLData:data];
        
        TFHppleElement *contentE =[[hpple searchWithXPathQuery:@"//div[@class='left_content']"] firstObject];

        TFHpple *h =[TFHpple hppleWithHTMLData:[contentE.raw dataUsingEncoding:NSUTF8StringEncoding]];

        NSArray *arr1 = [h searchWithXPathQuery:@"//div[@class='dr']"];

        for (TFHppleElement *e in arr1) {
            TFHpple *itemH =[TFHpple hppleWithHTMLData:[e.raw dataUsingEncoding:NSUTF8StringEncoding]];
            TFHppleElement *imgE =[[itemH searchWithXPathQuery:@"//a/img"] firstObject];

            NSString *imgUrl = [imgE objectForKey:@"src"];
            
            TFHppleElement *h3E =[[itemH searchWithXPathQuery:@"//h3"] firstObject];
            
            NSString *title = [h3E text];
            TFHppleElement *contentE =[[itemH searchWithXPathQuery:@"//div[@class='content']"] firstObject];
            
            NSString *content = [contentE text];
            
            TFHppleElement *userNameE =[[itemH searchWithXPathQuery:@"//div[@class='il']/span"] firstObject];
            
            NSString *userName = [userNameE text];
            
            TFHppleElement *userIconE =[[itemH searchWithXPathQuery:@"//div[@class='il']/img"] firstObject];
            
            NSString *userIcon = [userIconE objectForKey:@"src"];
            
            NSDictionary *dic = @{@"title":title,@"url":imgUrl,@"content":content,@"userName":userName,@"userIcon":userIcon};
            [ma addObject:dic];
        }
        
        
        self.newsInfos = ma;
//        //发送网络请求获取最新数据  先清空旧的数据
//        [XWDataCacheTool deleteWidthId:naviStr];
//        //做数据缓存
//        [XWDataCacheTool addArr:ma andId:naviStr];
        
    } Failture:^(id error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


//-(NSArray *)newsInfos{
//    _newsInfos = [self getNewsInfos:self.currentUrl];
//    
//    return _newsInfos;
//}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
//    [self getNewsInfos:<#(NSString *)#>]
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  rightBarButton的点击标记，每次点击更改flag值。
     *  如果您用普通的button就不需要设置flag，通过按钮的seleted属性来控制即可
     */
    self.flag = YES;
    
    /**
     *  这些数据是菜单显示的图片名称和菜单文字，请各位大牛指教，如果有更好的方法：
     *  GitHub : https://github.com/KongPro/PopMenuTableView
     */
        NSArray *dataArray = @[];
    _dataArray = dataArray;
    
    __weak __typeof(&*self)weakSelf = self;
    /**
     *  创建普通的MenuView，frame可以传递空值，宽度默认120，高度自适应
     */
    [CommonMenuView createMenuWithFrame:CGRectMake(0, 0, 200, 300) target:self dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag]; // do something
    } backViewTap:^{
        weakSelf.flag = YES; // 这里的目的是，让rightButton点击，可再次pop出menu
    }];

    
    // Do any additional setup after loading the view.
}

-(void)addViews{
    
}

- (IBAction)menu1Click:(id)sender {
    self.Infos = [self.naviArr[1] objectForKey:@"subCategory"];

    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i< self.Infos.count; i++) {
        NSDictionary *addDict = @{@"imageName" : @"icon_button_recall",
                                  @"itemName" : [self.Infos[i] objectForKey:@"title"]
                                  };

        [arr addObject:addDict];
    }
    
    [CommonMenuView updateMenuItemsWith:arr];
    [self popMenu:CGPointMake(self.navigationController.view.frame.size.width - 50, 50)];

}
- (IBAction)menu2Click:(id)sender {
    self.Infos = [self.naviArr[0] objectForKey:@"subCategory"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i< self.Infos.count; i++) {
        NSDictionary *addDict = @{@"imageName" : @"icon_button_recall",
                                  @"itemName" : [self.Infos[i] objectForKey:@"title"]
                                  };
        
        [arr addObject:addDict];
    }
    
    [CommonMenuView updateMenuItemsWith:arr];

    [self popMenu:CGPointMake(50, 50)];

}

- (void)popMenu:(CGPoint)point{
    if (self.flag) {
        [CommonMenuView showMenuAtPoint:point];
        self.flag = NO;
    }else{
        [CommonMenuView hidden];
        self.flag = YES;
    }
}

#pragma mark -- 回调事件(自定义)
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    self.currentUrl = [self.Infos[tag-1] objectForKey:@"url"];
    [self getNewsInfos:self.currentUrl];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:str message:[NSString stringWithFormat:@"点击了第%ld个菜单项",tag] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
    [CommonMenuView hidden];
    self.flag = YES;
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
