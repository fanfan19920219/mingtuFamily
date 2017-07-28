//
//  SPeedMaxViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/6/26.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "SPeedMaxViewController.h"
#import "SpeedSecondViewController.h"
#import "Header.h"

@interface SPeedMaxViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong)NSMutableArray *titleArray;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIView *selfTabbar;


@end

@implementation SPeedMaxViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMethod];
    [self.view addSubview:self.selfTabbar];
    // Do any additional setup after loading the view from its nib.
    
}


-(void)initMethod{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _titleArray = (NSMutableArray*)@[@"沁园春剃刀1:22",@"熔岩古墓1:25"];
    [self.view addSubview:self.tableView];
}


-(UIView*)selfTabbar{
    if(!_selfTabbar){
        _selfTabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 64)];
        _selfTabbar.backgroundColor = RGBA(137, 137, 137, 0.7);
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        titleLabel.center = CGPointMake(VIEW_WIDTH/2, 40);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:16 weight:0.1];
        titleLabel.textColor = RGBA(255, 255, 255, 1);
        titleLabel.text = self.title;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(20, 30, 40, 20);
        [backButton setTitle:@"上一页" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:.1];
        [backButton setTitleColor:RGBA(255, 255, 255, 1) forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
        [_selfTabbar addSubview:backButton];
        [_selfTabbar addSubview:titleLabel];
        
    }
    
    return _selfTabbar;
}


-(void)backMethod{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}



-(UITableView*)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT  - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        UIImageView *tableBackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"赛道之王背景1.png"]];
        tableBackImageView.contentMode = UIViewContentModeScaleAspectFill;
        _tableView.backgroundView = tableBackImageView;
        UIView *cleanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 64)];
        cleanView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = cleanView;
        
        
        
    }
    return _tableView;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *titleString;
    NSString *showName;
    switch (indexPath.row) {
        case 0:{
            titleString = @"lh_qyc";
            showName = @"沁园春剃刀1:22";
        }break;
            
        case 1:{
            titleString = @"zzh_gumu";
            showName = @"熔岩古墓雷诺1:25";
        }break;

        case 2:{
            titleString = @"飞驰之王";
        }break;

            
        case 3:{
            titleString = @"极限之王";
        }break;
            
        default:
            break;
    }
    
    AVPlayerViewController1 *avPlayer = [[AVPlayerViewController1 alloc]init];
    avPlayer.videoLocalName = titleString;
    avPlayer.videoShowName = showName;
    [self.navigationController pushViewController:avPlayer animated:YES];
    
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
    cell.textLabel.textColor = RGBA(183, 68, 117, 1);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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
