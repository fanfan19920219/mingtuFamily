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
#import "SocialTableViewCell.h"

@interface SPeedMaxViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong)NSMutableArray *tableViewDataArray;
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
    
    _tableViewDataArray = [[NSMutableArray alloc]init];
    /*
     titleString = @"lh_qyc";
     showName = @"沁园春剃刀1:22";
     */
    NSDictionary *dic1 = @{@"title":@"沁园春剃刀1:22",@"imgename":@"沁园春赛道.png",@"titleString":@"lh_qyc",@"detail":@"|收藏幸运|"};
    /*
     titleString = @"zzh_gumu";
     showName = @"熔岩古墓雷诺1:25";
     */
    NSDictionary *dic2 = @{@"title":@"熔岩古墓雷诺1:25",@"imgename":@"熔岩古墓赛道.png",@"titleString":@"zzh_gumu",@"detail":@"命徒丶张蔚然"};
    [_tableViewDataArray addObject:dic1];
    [_tableViewDataArray addObject:dic2];

    
    
    [self.view addSubview:self.tableView];
}


-(UIView*)selfTabbar{
    if(!_selfTabbar){
        _selfTabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 64)];
        _selfTabbar.backgroundColor = RGBA(137, 137, 137, 0.5);
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        titleLabel.center = CGPointMake(VIEW_WIDTH/2, 40);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:16 weight:0.1];
        titleLabel.textColor = RGBA(255, 255, 255, 1);
        titleLabel.text = self.title;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(20, 30, 50, 30);
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
        UIImageView *tableBackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"赛道之王背景图1.jpg"]];
        tableBackImageView.contentMode = UIViewContentModeScaleAspectFill;
        _tableView.backgroundView = tableBackImageView;
        _tableView.rowHeight = 60;
        _tableView.separatorColor = RGBA(44, 44, 44, 1);
        UIView *cleanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 64)];
        cleanView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = cleanView;
        
        
        
    }
    return _tableView;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *titleString;
    NSString *showName;
    NSDictionary *dic = [_tableViewDataArray objectAtIndex:indexPath.row];
    //@{@"title":@"沁园春剃刀1:22",@"imgename":@"Logo1.png",@"titleString":@"lh_qyc"};
    titleString = [dic objectForKey:@"titleString"];
    showName = [dic objectForKey:@"title"];
    
    AVPlayerViewController1 *avPlayer = [[AVPlayerViewController1 alloc]init];
    avPlayer.videoLocalName = titleString;
    avPlayer.videoShowName = showName;
    [self.navigationController pushViewController:avPlayer animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"SocialTableViewCell";//这里的cellID就是cell的xib对应的名称
    SocialTableViewCell *cell = (SocialTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(nil == cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIndentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDictionary *dic = [_tableViewDataArray objectAtIndex:indexPath.row];
    cell.socialTitleLabel.text = [dic objectForKey:@"title"];
    cell.socialTitleLabel.textColor = RGBA(222, 222, 222, 1);
    cell.showImageView.image = [UIImage imageNamed:[dic objectForKey:@"imgename"]];
    cell.socialDetailLabel.text = [dic objectForKey:@"detail"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = RGBA(255, 255, 255, 0.3);
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
