//
//  exchangeViewController.m
//  MingTu
//
//  Created by M-SJ077 on 16/7/20.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "exchangeViewController.h"
#import "Header.h"
@interface exchangeViewController () <UITableViewDelegate , UITableViewDataSource>{
    UITableView *_showTableView;
    NSArray *_titleArray;
    
    UIImageView *_qqtip;
    UIImageView *_phonetip;
    UIImageView *_smstip;
    
}
@end

@implementation exchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _titleArray = @[@"      电话呼叫",@"      短信呼叫",@"      QQ"];
    // Do any additional setup after loading the view.
    [self create_Views];
}

-(void)create_Views{
    _showTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44 , VIEW_WIDTH, VIEW_HEIGHT - 64 - 44) style:UITableViewStyleGrouped];
    _showTableView.dataSource = self;
    _showTableView.delegate = self;
    [self.view addSubview:_showTableView];
    
    _qqtip = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more_reply.png"]];
    _phonetip = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"oto_tel.png"]];
    _smstip = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anlysis_advice.png"]];
    _qqtip.frame = CGRectMake(5, 5, 30, 30);
    _phonetip.frame = CGRectMake(5, 5, 30, 30);
    _smstip.frame = CGRectMake(5, 5, 30, 30);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    //231 88 128
    cell.textLabel.textColor =RGBA(231, 88, 128, 1);
    switch (indexPath.row) {
        case 0:{
            [cell.contentView addSubview:_phonetip];
        }
            break;
        case 1:{
            [cell.contentView addSubview:_smstip];
        }
            break;
        case 2:{
            [cell.contentView addSubview:_qqtip];
        }
            break;
            
        default:
            break;
    }
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//231 88 128

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *methodString;
    switch (indexPath.row) {
            case 0:
            methodString = @"phone";
            break;
            
            case 1:
            methodString = @"sms";
            break;
            
            case 2:
            methodString = @"qq";
            break;
            
        default:
            break;
    }
    
    selectPersonViewController *selectVC = [[selectPersonViewController alloc]init];
    selectVC.methodString = methodString;
    [self.navigationController pushViewController:selectVC animated:YES];
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
