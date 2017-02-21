//
//  selectPersonViewController.m
//  MingTu
//
//  Created by M-SJ077 on 2017/2/8.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "selectPersonViewController.h"
#import "Header.h"
#import <MessageUI/MessageUI.h>

@interface selectPersonViewController ()<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic , strong)UITableView *showTableView;
@property (nonatomic , strong)NSMutableArray *friendArray;


@end

@implementation selectPersonViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self create_Views];
    [self create_rightButton];
    _friendArray = GETFRIEND;
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
    titleLabel.text = @"小姐姐联系人";
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friendArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    personModel *person  = (personModel*)[[ZZH_LoadingProject shareMBProgress]read:TRUEPATH([_friendArray objectAtIndex:indexPath.row])];
    
    if(self.orLocation){
        [self.delegate setPerson:person];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    NSLog(@"person.phont --- %@",person.phone);
    //1
    if([self.methodString isEqualToString:@"qq"]){
        NSString *urlString = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",person.qq];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    }
    
    if([self.methodString isEqualToString:@"phone"]){
        NSString *urlString = [NSString stringWithFormat:@"tel://%@",person.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    
    if([self.methodString isEqualToString:@"sms"]){
        [self showMessageView:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",person.phone], nil] title:@"test" body:@"我好无聊,来陪我!"];
    }
    
    //2
    
    //3
    
}

//smsDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[NSString stringWithFormat:@"发送成功"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}


-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.title = @"短信";
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        //[[[[controller viewControllers] lastObject] navigationItem] setTitle:@"短信"];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
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
