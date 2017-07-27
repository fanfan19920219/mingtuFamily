//
//  SocialViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/27.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "SocialViewController.h"
#import "SocialTableViewCell.h"

@interface SocialViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)UITableView *showTableView;

@property (nonatomic , strong)NSMutableArray *tableViewDataArray;

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMethod];
}

-(void)initMethod{
    _tableViewDataArray = [[NSMutableArray alloc]init];
    NSDictionary *dic1 = @{@"title":@"QQ飞车吧",@"imgename":@"Logo1.png"};
    NSDictionary *dic2 = @{@"title":@"QQ飞车官方论坛",@"imgename":@"Logo2.png"};
    [_tableViewDataArray addObject:dic1];
    [_tableViewDataArray addObject:dic2];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _showTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64 - 44) style:UITableViewStylePlain];
    _showTableView.delegate = self;
    _showTableView.dataSource = self;
    _showTableView.rowHeight = 60;
    _showTableView.tableFooterView = [[UIView alloc]init];
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
