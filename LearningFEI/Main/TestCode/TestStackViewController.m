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

@property(nonatomic,retain)UIStackView *stackV;

@property(nonatomic,retain)XRCarouselView *scrollView;


@property(nonatomic,retain)UIButton *btn2;


@property(nonatomic,retain)UIButton *btn3;


@end

@implementation TestStackViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NetworkingManager standard] request:LINKURL_cocoaChina Parameters:nil Success:^(AFNResponseModel *model) {
        CocoachinaHomeModel *homeModel = [CocoachinaHomeModel modelWithResponseModel:model];
//
        NSLog(@"%@",homeModel.scrollInfo);
        NSMutableArray *imgArr=[NSMutableArray arrayWithCapacity:1];
        NSMutableArray *titleArr=[NSMutableArray arrayWithCapacity:1];

        for (int i = 0; i<homeModel.scrollInfo.count; i++) {
            ScrollInfoModel *scrollM = homeModel.scrollInfo[i];
            [imgArr addObject:[UIImage imageNamed:@"0.png"]];
//            [imgArr addObject:scrollM.imageUrl];
//            [titleArr addObject:scrollM.contentText];
            
        }
        self.scrollView.imageArray = imgArr;
        self.scrollView.describeArray = titleArr;
        [self.stackV addArrangedSubview:self.scrollView];

        
        [self.stackV addArrangedSubview:self.btn2];
        [self.stackV addArrangedSubview:self.btn3];
//        
//        ZFScrollView *scroll = [[ZFScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//        scroll.infos = homeModel.scrollInfo;
//        [self.view addSubview:scroll];
        
    } Failture:^(id error) {
        NSLog(@"%@",error);
        
    }];
    
}

-(UIStackView *)stackV{
    if (!_stackV) {
        _stackV = [[UIStackView alloc] init];
        
        
        
        // 子视图间隔
        _stackV.spacing = 2;
        // 布局方向 (默认横向布局) 纵向
        _stackV.axis = UILayoutConstraintAxisVertical;
        // 子视图对齐方式 (枚举值
        _stackV.alignment = UIStackViewAlignmentFill;
        // 子视图分部方式 (枚举值)
        _stackV.distribution = UIStackViewDistributionFill;
        //方法
        // 将子视图，添加到 stackView 的 arrangedSubviews列表中
        

        // 删除 stackView的 arrangedSubviews列表中的 view
//        [_stackV removeArrangedSubview:self.btn1];
        //插入一个视图到 stackView的 arrangedSubviews列表中
//        [_stackV insertArrangedSubview:self.btn2 atIndex:0];
    }
    return _stackV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    // Do any additional setup after loading the view.
}

-(XRCarouselView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
        _scrollView.backgroundColor = [UIColor redColor];
    }
    return _scrollView;
}

-(UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.backgroundColor = [UIColor blueColor];

        _btn2.frame = CGRectMake(0, 0, SCREENWIDTH, 40);
    }
    return _btn2;
}
-(UIButton *)btn3{
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.backgroundColor = [UIColor orangeColor];

        _btn3.frame = CGRectMake(0, 0, SCREENWIDTH, 40);
    }
    return _btn3;
}

-(void)initViews{
    
    [self.view addSubview:self.stackV];
    [self.stackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(NAVI_HEIGHT);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).offset(-20);

        
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
