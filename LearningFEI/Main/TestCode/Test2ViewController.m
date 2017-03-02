//
//  Test2ViewController.m
//  LearningFEI
//
//  Created by 周飞 on 2017/3/1.
//  Copyright © 2017年 ZF. All rights reserved.
//

#import "Test2ViewController.h"
#import "NetworkingManager.h"
#import "WebViewController.h"
@interface Test2ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSMutableArray *infos;

@property(nonatomic,retain)UITableView *tableView;



@end

@implementation Test2ViewController

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
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    NSMutableDictionary *pars = [NSMutableDictionary dictionaryWithCapacity:1];
    [pars setObject:self.url forKey:@"urlStr"];
    [[NetworkingManager standard] request:LINKURL_jobbole_contentInfo Parameters:pars Success:^(AFNResponseModel *model) {
        NSLog(@"------arr----%@",model.arr);
        
        //        NSDictionary *dict = model.arr[0];
        //
        //        self.infos = [NSMutableArray arrayWithArray:[dict objectForKey:@"subCategory"]];
        self.infos = [NSMutableArray arrayWithArray:model.arr];
        [self.tableView reloadData];
    } Failture:^(id error) {
        NSLog(@"%@",error);
        
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
    
    
    WebViewController *test = [[WebViewController alloc] init];
    test.title =[self.infos[indexPath.row] objectForKey:@"title"];
    test.url =[self.infos[indexPath.row] objectForKey:@"url"];
    
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
