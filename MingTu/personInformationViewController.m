//
//  personInformationViewController.m
//  MingTu
//
//  Created by M-SJ077 on 2017/2/7.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "personInformationViewController.h"
#import "Header.h"
@interface personInformationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong)UITableView *showTableView;
@property (nonatomic , strong)NSMutableArray *friendArray;

@end

@implementation personInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self create_Views];
    [self create_rightButton];
    _friendArray = [[[NSMutableArray alloc]initWithArray:GETFRIEND] mutableCopy];
    if(_friendArray==nil){
        _friendArray =[[NSMutableArray alloc]init];
    }
    NSLog(@"array ---- %@",_friendArray);
    
}

-(void)create_Views{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _showTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64 - 44) style:UITableViewStylePlain];
    _showTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _showTableView.separatorColor = RGBA(240, 240, 240, 1);
    _showTableView.delegate = self;
    _showTableView.dataSource = self;
    _showTableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:_showTableView];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -20, VIEW_WIDTH, 50)];
    titleLabel.text = @"常用联系人";
    titleLabel.font = [UIFont systemFontOfSize:14 weight:0.001];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = MainColor;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, VIEW_WIDTH, 1)];
    lineView.backgroundColor = RGBA(222, 222, 222, 1);
    [titleLabel addSubview:lineView];
    _showTableView.tableHeaderView = titleLabel;
    
    
}

-(void)create_rightButton{
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
    
    rightBtnItem.tintColor=[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)addFriend{
    addFriendViewController *addVC = [[addFriendViewController alloc]init];
    addVC.friendArray = _friendArray;
    addVC.or_addPerson = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[_friendArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13 weight:0.001];
    cell.textLabel.textColor = RGBA(152, 122, 122, 1);
    //cell.accessoryType = UITableViewCellAccessoryCheckmark ;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friendArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    addFriendViewController *addVC = [[addFriendViewController alloc]init];
    addVC.friendArray = _friendArray;
    addVC.name = [_friendArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:addVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    _friendArray = GETFRIEND;
    [_showTableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deleteName = [_friendArray objectAtIndex:indexPath.row];
    
    NSMutableArray *deleteArray = [[NSMutableArray alloc]initWithArray:_friendArray];
    
    [[ZZH_LoadingProject shareMBProgress]removeObjectforFilePath:TRUEPATH(deleteName)];
    [deleteArray removeObjectAtIndex:indexPath.row];
    SAVEFRIEND(deleteArray);
    NSLog(@"_friendArray --- %@",deleteArray);
    
    _friendArray = [[NSMutableArray alloc]initWithArray:deleteArray];
    [_showTableView reloadData];
    
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
