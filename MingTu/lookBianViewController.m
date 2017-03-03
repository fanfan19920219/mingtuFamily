//
//  lookBianViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/3/3.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "lookBianViewController.h"
#import "Header.h"
#import "BianModel.h"
#import "showBianViewController.h"

@interface lookBianViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_modelArray;
    
}
@end

@implementation lookBianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    [self getModel];
    [self create_Views];
    self.title = @"录";
}

-(void)create_Views{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64 - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.rowHeight = 54.f;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}

-(void)getModel{
    if([[ZZH_LoadingProject shareMBProgress]read:TRUEPATH(BIANNAME)]){
        _modelArray =[(NSMutableArray*)[[ZZH_LoadingProject shareMBProgress]read:TRUEPATH(BIANNAME)] mutableCopy];
        for(BianModel *model in _modelArray){
            NSLog(@"bianname --- %@",model.time);
        }
    }else{
        _modelArray = [[NSMutableArray alloc]init];
    }
}


#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    BianModel *model = [_modelArray objectAtIndex:(_modelArray.count - 1) - indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =model.time;
    cell.textLabel.textColor = RGBA(122, 122, 122, 1);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BianModel *model = [_modelArray objectAtIndex:indexPath.row];
    showBianViewController *showBian = [[showBianViewController alloc]init];
    showBian.model = model;
    [self.navigationController pushViewController:showBian animated:YES];
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
