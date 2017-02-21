//
//  playerViewController.m
//  MingTu
//
//  Created by zhangzhihua on 16/3/8.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "playerViewController.h"
@interface playerViewController() <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)UITableView *tableView;

@end

@implementation playerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self create_tableView];
    [self  loadfriend];
}

-(void)loadfriend{
    
}


-(void)create_tableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = @"获得积分";
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

@end
