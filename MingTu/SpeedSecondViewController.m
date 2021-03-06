//
//  SpeedSecondViewController.m
//  MingTu
//
//  Created by Star J on 2017/7/1.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "SpeedSecondViewController.h"
#import "AVPlayerViewController1.h"
@interface SpeedSecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)NSMutableArray *titleArray;
@property (nonatomic , strong)NSMutableArray *urlArray;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIView *selfTabbar;




@end

@implementation SpeedSecondViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMethod];
    [self.view addSubview:self.selfTabbar];
    // Do any additional setup after loading the view from its nib.
}


-(void)initMethod{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _titleArray = (NSMutableArray*)@[@"海洋公园",@"十一城",@"老街迷宫",@"瓦特厂房"];
    //赛道之王",@"极速之王",@"飞驰之王
    if([self.title isEqualToString:@"赛道之王"]){
        _urlArray = (NSMutableArray*)@[HYGY_SDZW_URL,SYS_SDZW_URL,LJMG_SDZW_URL,WTCF_SDZW_URL];
    }
    
    if([self.title isEqualToString:@"极速之王"]){
        _urlArray = (NSMutableArray*)@[HYGY_JSZW_URL,SYS_JSZW_URL,LJMG_JSZW_URL,WTCF_JSZW_URL];
    }
    
    if([self.title isEqualToString:@"飞驰之王"]){
        _urlArray = (NSMutableArray*)@[HYGY_FC_URL,SYS_FC_URL,LJMG_FC_URL,WTCF_FC_URL];
    }
    
    [self.view addSubview:self.tableView];
}


-(UIView*)selfTabbar{
    if(!_selfTabbar){
        _selfTabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 64)];
        _selfTabbar.backgroundColor = RGBA(137, 192, 246, 0.7);
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        titleLabel.center = CGPointMake(VIEW_WIDTH/2, 40);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:16 weight:0.1];
        titleLabel.textColor = RGBA(44, 44, 44, 1);
        titleLabel.text = self.title;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(20, 30, 40, 20);
        [backButton setTitle:@"上一页" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:.1];
        [backButton setTitleColor:RGBA(44, 44, 44, 1) forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
        [_selfTabbar addSubview:backButton];
        [_selfTabbar addSubview:titleLabel];
        
    }
    
    return _selfTabbar;
}
-(void)backMethod{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableView*)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT  - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        UIImageView *tableBackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"赛道之王背景.png"]];
        tableBackImageView.contentMode = UIViewContentModeScaleAspectFill;
        _tableView.backgroundView = tableBackImageView;
        UIView *cleanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 64)];
        cleanView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = cleanView;
        
        
        
    }
    return _tableView;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AVPlayerViewController1 *intoVC = [[AVPlayerViewController1 alloc]init];
    [self.navigationController pushViewController:intoVC animated:YES];
    
//    showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
//    showViewcontroller.orHTML = YES;
//    showViewcontroller.URL = [self htmlURL:[_urlArray objectAtIndex:indexPath.row]];
//    [self presentViewController:showViewcontroller animated:YES completion:^{
//        
//    }];
    
}
-(NSString*)htmlURL:(NSString*)url{
    return [NSString stringWithFormat:@"<iframe frameborder=0 width=1000 height=498 src=%@?vid=h0363yngwqp&tiny=0&auto=0 allowfullscreen></iframe>",url];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellString = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = RGBA(255, 255, 255, 0.6);
    cell.textLabel.textColor = RGBA(55, 55, 55, 1);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
