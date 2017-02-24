//
//  Code4AppHomeViewController.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/17.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "Code4AppHomeViewController.h"
#import "AFNetworkingTool.h"
#import "AFNetworking.h"
#import "TFHpple.h"
#import "SXTitleLable.h"
#import "NewsBokeViewController.h"

@interface Code4AppHomeViewController ()
//导航arr
@property(nonatomic,retain)NSMutableArray *naviArr;

//segment选择视图
@property (nonatomic,weak) UISegmentedControl *segment;

//大的滑动视图
@property (nonatomic,weak) UIScrollView *bigScroll;
//小的滑动视图
@property (nonatomic,weak) UIScrollView *smallScroll;

@property(nonatomic,strong) SXTitleLable *oldTitleLable;
@property (nonatomic,assign) CGFloat beginOffsetX;

/** news信息 */
@property(nonatomic,strong) NSMutableArray *Infos;

@end

//上面滑动栏的高度
#define ZF_SmallScrollMenuH  40

@implementation Code4AppHomeViewController

-(NSMutableArray *)naviArr{
    if (!_naviArr) {
        _naviArr = [NSMutableArray array];
    }
    return _naviArr;
}

-(NSMutableArray *)Infos{
    if (!_Infos) {
        _Infos = [NSMutableArray array];
    }
    return _Infos;
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
            
            [self addViews];
            return;
        }
    }
    
    [AFNetworkingTool request:req Success:^(NSData *data) {
        TFHpple *hpple = [TFHpple hppleWithHTMLData:data];
        
        
        NSArray *arr = [hpple searchWithXPathQuery:@"//ul[@class='ttp bm cl']"];
        int i= 0;
        if (arr.count > 0) {
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
        }
        
        self.naviArr = ma;
        self.Infos = [ma[0] objectForKey:@"subCategory"];
        
        [self addViews];
        //发送网络请求获取最新数据  先清空旧的数据
        [XWDataCacheTool deleteWidthId:naviStr];
        //做数据缓存
        [XWDataCacheTool addArr:ma andId:naviStr];
        
    } Failture:^(id error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取数据
    [self getData];
    
//    NSLog(@"naviArr----------%@",self.naviArr);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    // Do any additional setup after loading the view.
}

-(void)addViews{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i<self.naviArr.count; i++) {
        [items addObject:[self.naviArr[i] objectForKey:@"category"]];
    }
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    segment.tintColor = [UIColor redColor];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    self.segment = segment;
    self.navigationItem.titleView = segment;
    [self setupScrollView];

}


#pragma mark 添加滑动视图
-(void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //1.添加小的滚动菜单栏
    UIScrollView *smallScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, ZF_SmallScrollMenuH)];
    [self.view addSubview:smallScroll];
    smallScroll.showsHorizontalScrollIndicator=NO;
    smallScroll.showsVerticalScrollIndicator=NO;
    self.smallScroll=smallScroll;
    
    //2. 添加大的滚动菜单栏
    UIScrollView *bigScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+ZF_SmallScrollMenuH, SCREENWIDTH, (SCREENHEIGHT-ZF_SmallScrollMenuH-64))];
    bigScroll.showsHorizontalScrollIndicator=NO;
    bigScroll.delegate=self;
    [self.view addSubview:bigScroll];
    self.bigScroll=bigScroll;
    
    
    //3.添加子控制器
    [self addController];
    //4.添加标题栏
    [self addLabel];
    //5.设置大的scrollview的滚动范围
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScroll.contentSize = CGSizeMake(contentX, 0);
    self.bigScroll.pagingEnabled = YES;
    
    //6.添加默认子控制器 (也就是第一个)
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScroll.bounds;
    [self.bigScroll addSubview:vc.view];
    SXTitleLable *lable = [self.smallScroll.subviews firstObject];
    lable.scale = 1.0;
    
}

//删除所有的View
-(void)removeViewFromSuperView{
    [self.smallScroll removeFromSuperview];
    [self.bigScroll removeFromSuperview];
}

#pragma mark 添加子控制器
-(void)addController
{
    if (self.childViewControllers.count >=1) {
        for (UIViewController *VC in self.childViewControllers) {
            [VC removeFromParentViewController];
        }
    }
    
    switch (self.segment.selectedSegmentIndex) {
            case 0:
            for (int i=0 ; i<self.Infos.count ;i++){
                NewsBokeViewController *vc = [[NewsBokeViewController alloc]init];
                
                vc.title = self.Infos[i][@"title"];
                vc.urlString = self.Infos[i][@"url"];
                
                [self addChildViewController:vc];
            }
            break;
            case 1:
            for (int i=0 ; i<self.Infos.count ;i++){
                NewsBokeViewController *vc = [[NewsBokeViewController alloc]init];
                
                vc.title = self.Infos[i][@"title"];
                vc.urlString = self.Infos[i][@"url"];
                
                [self addChildViewController:vc];
            }
            break;
        default:
            break;
    }
    
}

#pragma mark 添加标题栏
-(void)addLabel
{
    CGFloat lblW = 70;
    CGFloat lblH = 40;
    CGFloat lblY = 0;
    CGFloat lblX =0;
    for (int i=0 ; i<self.Infos.count ;i++){
        SXTitleLable *lbl1 = [[SXTitleLable alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text =vc.title;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
        CGSize size=[lbl1.text sizeWithAttributes:attrs];
        CGFloat width = size.width;

        lbl1.frame = CGRectMake(lblX, lblY, width, lblH);
        
        lblX = lblX +width;

        lbl1.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [self.smallScroll addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    //设置小scroll滚动的范围
    self.smallScroll.contentSize=CGSizeMake(lblX, 0);
    
    
    
}

#pragma mark 标签栏的点击事件
-(void)lblClick:(UITapGestureRecognizer *)recognizer
{
    SXTitleLable *titlelable = (SXTitleLable *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bigScroll.frame.size.width;
    
    CGFloat offsetY = self.bigScroll.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScroll setContentOffset:offset animated:YES];
}


#pragma mark - ******************** scrollView代理方法
/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 滚动结束后调用（代码导致） */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView

{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScroll.frame.size.width;
    
    // 滚动标题栏
    SXTitleLable *titleLable = (SXTitleLable *)self.smallScroll.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.smallScroll.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScroll.contentSize.width - self.smallScroll.frame.size.width;
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScroll.contentOffset.y);
    //  NSLog(@"%@",NSStringFromCGPoint(offset));
    [self.smallScroll setContentOffset:offset animated:YES];
    // 添加控制器
    NewsBokeViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    
    
    
    [self.smallScroll.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            SXTitleLable *temlabel = self.smallScroll.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.bigScroll addSubview:newsVc.view];
}



/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    SXTitleLable *labelLeft = self.smallScroll.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScroll.subviews.count) {
        
        SXTitleLable *labelRight = self.smallScroll.subviews[rightIndex];
        
        labelRight.scale = scaleRight;
    }
    
}


-(void)segmentClick:(UISegmentedControl *)segment{
    
    switch (segment.selectedSegmentIndex) {
            case 0:
            
            [self updateInfos:0];
            
            break;
            case 1:
            [self updateInfos:1];
//            self.Infos = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"SwiftVNewsInfos.plist" ofType:nil]];
//            //1.添加滑动视图
//            [self removeViewFromSuperView];
//            [self setupScrollView];
            break;
        default:
            break;
    }
    
    
}

-(void)updateInfos:(int)index{
    NSDictionary *dic = self.naviArr[index];
    self.Infos =[dic objectForKey:@"subCategory"];
    //1.添加滑动视图
    [self removeViewFromSuperView];
    [self setupScrollView];
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
