//
//  SocialViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/27.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "SocialViewController.h"
#import "SocialTableViewCell.h"
#import "UIViewController+tabbar.h"

@interface SocialViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)UITableView *showTableView;

@property (nonatomic , strong)NSMutableArray *tableViewDataArray;

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMethod];
    UIView *tabbarView = [self tabbarViewWithBackColor:RGBA(44, 44, 44, 0.5)];
    [self.view addSubview:tabbarView];
}



-(void)initMethod{
    _tableViewDataArray = [[NSMutableArray alloc]init];
    NSDictionary *dic1 = @{@"title":@"QQ飞车吧",@"imgename":@"Logo1.png",@"url":SPEEDBA};
    NSDictionary *dic2 = @{@"title":@"QQ飞车官方论坛",@"imgename":@"Logo2.png",@"url":SPEEDLUNTAN};
    NSDictionary *dic3 = @{@"title":@"晓枫寒叶吧",@"imgename":@"Logo3.png",@"url":SPEED_XFHY};
    NSDictionary *dic4 = @{@"title":@"飞车美衣吧",@"imgename":@"Logo4.png",@"url":SPEED_MEIYI};
    NSDictionary *dic5 = @{@"title":@"飞车交易吧",@"imgename":@"Logo5.png",@"url":SPEED_TRANSACTION};
    NSDictionary *dic6 = @{@"title":@"飞车卖号吧",@"imgename":@"Logo6.png",@"url":SPEED_SALE};

    [_tableViewDataArray addObject:dic1];
    [_tableViewDataArray addObject:dic2];
    [_tableViewDataArray addObject:dic3];
    [_tableViewDataArray addObject:dic4];
    [_tableViewDataArray addObject:dic5];
    [_tableViewDataArray addObject:dic6];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _showTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 44) style:UITableViewStylePlain];
    _showTableView.delegate = self;
    _showTableView.dataSource = self;
    _showTableView.rowHeight = 60;
    _showTableView.tableFooterView = [[UIView alloc]init];
    _showTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 64)];
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"贴吧背景图"]];
    backImageView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    backImageView.userInteractionEnabled = YES;
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    _showTableView.backgroundView = backImageView;
    [self.view addSubview:_showTableView];
}

#pragma mark - tableViewDelegate
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
    cell.showImageView.image = [UIImage imageNamed:[dic objectForKey:@"imgename"]];
    cell.socialDetailLabel.text = @"";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = RGBA(255, 255, 255, 0.4);
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
    showViewcontroller.URL = [[_tableViewDataArray objectAtIndex:indexPath.row] objectForKey:@"url"];
    [self presentViewController:showViewcontroller animated:YES completion:^{
        
    }];
    
}
//关闭返回手势
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
//开启返回手势
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
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
