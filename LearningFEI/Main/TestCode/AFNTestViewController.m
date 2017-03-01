//
//  AFNTestViewController.m
//  LearningFEI
//
//  Created by 周飞 on 2017/2/10.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "AFNTestViewController.h"
#import "TestContentViewController.h"
#import "NetworkingManager.h"

@interface AFNTestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)NSMutableArray *infos;

@property(nonatomic,retain)UITableView *tableView;

@end

@implementation AFNTestViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource =self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor blueColor];
//    btn.frame = CGRectMake(0, 100, 80, 40);
//    [btn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    NSString *url = @"http://www.cocoachina.com/swift/";
    
    NSMutableDictionary *pars = [NSMutableDictionary dictionaryWithCapacity:1];
//    [pars setObject:url forKey:@"urlStr"];
    [[NetworkingManager standard] request:LINKURL_jobbole Parameters:pars Success:^(AFNResponseModel *model) {
        
//        NSDictionary *dict = model.arr[0];
//        
//        self.infos = [NSMutableArray arrayWithArray:[dict objectForKey:@"subCategory"]];
//        self.infos = [model.dict objectForKey:@"nav-header"];
        self.infos = [NSMutableArray arrayWithArray:model.arr];
        [self.tableView reloadData];
        NSLog(@"------arr----%@",model.arr);
    } Failture:^(id error) {
        NSLog(@"%@",error);

    }];
    
}


-(void)backBtnClick:(UIButton *)sender{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.infos.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    NSDictionary *dict = self.infos[indexPath.row];
    
    cell.textLabel.text =[dict objectForKey:@"title"];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TestContentViewController *test = [[TestContentViewController alloc] init];
    NSString *urlStr =[self.infos[indexPath.row] objectForKey:@"url"];
    test.url =urlStr;
    NSLog(@"urlStr------%@",urlStr);
    [self.navigationController pushViewController:test animated:YES];
    
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
