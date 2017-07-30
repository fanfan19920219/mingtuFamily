//
//  addFriendViewController.m
//  MingTu
//
//  Created by M-SJ077 on 2 017/2/7.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "addFriendViewController.h"
#import "Header.h"


#define HEADERBUTTON_SIZE 100.f
#define HEADERVIEW_HEIGHT 240.f
#define TOPBUTTONSIZE 33.f
#define TOPBUTTONFONT [UIFont systemFontOfSize:13 weight:0.001]


@interface addFriendViewController (){
    UIView *_headerView;
    UIButton *_headerButton;
    UILabel *_headerLabel;
    
    UIScrollView *_bottomView;
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
    UILabel *_qqLabel;
    
    UIButton *_nameButton;
    UIButton *_phoneButton;
    UIButton *_qqButton;
    
    UIButton *_topMessageButton;
    UIButton *_topPhoneButton;
    UIButton *_topYueButton;
    
    
    UIButton *_backButton;
    personModel*person;
    
}
@end

@implementation addFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"myName --- %@",self.name);
    if(!(self.name==nil)){
        person = (personModel*)[[ZZH_LoadingProject shareMBProgress]read:TRUEPATH(self.name)];
        NSLog(@"person.name --- %@ --- %@ ----- %@ -----%@",person.name,person.qq,person.phone,person.headImageView);
    }
    
    if(self.or_addPerson==YES){
        person = [[personModel alloc]init];
    }
    
    [self createView];
    
    _friendArray = [[NSMutableArray alloc]initWithArray:_friendArray];
    
    
}


-(void)createView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, HEADERVIEW_HEIGHT)];
    _headerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_headerView];
    
    _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton.frame = CGRectMake((VIEW_WIDTH/2) - HEADERBUTTON_SIZE/2, 74, HEADERBUTTON_SIZE, HEADERBUTTON_SIZE);
    [_headerButton setImage:[UIImage imageNamed:@"wx_header"] forState:UIControlStateNormal];
//    [_headerButton setTitle:@"QQ" forState:UIControlStateNormal];
//    [_headerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]
    
    _headerButton.layer.cornerRadius = HEADERBUTTON_SIZE/2;
    [_headerButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self setSlide:_headerButton];
    [_headerView addSubview:_headerButton];
    _headerLabel = [[UILabel alloc]initWithFrame:CGRectMake((VIEW_WIDTH/2) - HEADERBUTTON_SIZE/2, 74 + HEADERBUTTON_SIZE + 20, HEADERBUTTON_SIZE, 20)];
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    _headerLabel.text = person.name;
    _headerLabel.textColor = RGBA(250, 250, 250, 1);
    [_headerView addSubview:_headerLabel];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0, 20, 80, 40);
    _backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_backButton setTitle:@" << Back " forState:UIControlStateNormal];
    [_backButton setTitleColor:RGBA(250, 250, 250, 1) forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_backButton];
    
    
    
    if(!self.or_addPerson==YES){
        _topMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topMessageButton.frame = CGRectMake(VIEW_WIDTH - 50, _headerView.frame.size.height - 120, TOPBUTTONSIZE, TOPBUTTONSIZE);
        _topMessageButton.tag = 0;
        _topMessageButton.contentMode = UIViewContentModeRight;
        _topMessageButton.titleLabel.font = TOPBUTTONFONT;
        [_topMessageButton addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_topMessageButton setBackgroundImage:[UIImage imageNamed:@"shopping_folder_chat_pres.png"] forState:UIControlStateNormal];
        [_topMessageButton setTitle:@"QQ >" forState:UIControlStateNormal];
        [_topMessageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_headerView addSubview:_topMessageButton];
        
        
        
        ///
        _topYueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topYueButton.tag=1;
        _topYueButton.frame = CGRectMake(VIEW_WIDTH - 50, _headerView.frame.size.height - 80, TOPBUTTONSIZE, TOPBUTTONSIZE);
//        [_topYueButton setBackgroundImage:[UIImage imageNamed:@"header_icon_group.png"] forState:UIControlStateNormal];
        [_topYueButton setTitle:@"MSG >" forState:UIControlStateNormal];
        [_topYueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_topYueButton addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _topYueButton.contentMode = UIViewContentModeRight;
        _topYueButton.titleLabel.font = TOPBUTTONFONT;
        
        [_headerView addSubview:_topYueButton];
        
        
        //////
        _topPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topPhoneButton.tag=2;
        _topPhoneButton.frame = CGRectMake(VIEW_WIDTH - 70, _headerView.frame.size.height - 40, TOPBUTTONSIZE + 20, TOPBUTTONSIZE);
        _topPhoneButton.contentMode = UIViewContentModeRight;
        _topPhoneButton.titleLabel.font = TOPBUTTONFONT;
        [_topPhoneButton addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topPhoneButton setBackgroundImage:[UIImage imageNamed:@"phone1.png"] forState:UIControlStateNormal];
        [_topPhoneButton setTitle:@"Phone >" forState:UIControlStateNormal];
        [_topPhoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_headerView addSubview:_topPhoneButton];
    }
    
    
    
    
    _bottomView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HEADERVIEW_HEIGHT, VIEW_WIDTH, VIEW_HEIGHT - HEADERVIEW_HEIGHT - 44)];
    [self.view addSubview:_bottomView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, 70, 20)];
    _nameLabel.text = @"name :";
    _nameLabel.textColor = TEXT_COLOR;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:_nameLabel];
    
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, 70, 20)];
    _phoneLabel.text = @"phone :";
    _phoneLabel.textColor = TEXT_COLOR;
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:_phoneLabel];
    
    _qqLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 130, 70, 20)];
    _qqLabel.text = @"qq :";
    _qqLabel.textColor = TEXT_COLOR;
    _qqLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:_qqLabel];
    
    //button
    _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nameButton.frame = CGRectMake(90, 20, VIEW_WIDTH - 110, 40);
    _nameButton.layer.cornerRadius = 3;
    _nameButton.backgroundColor = RGBA(250, 250, 250, 1);
    if(self.or_addPerson){
        [_nameButton addTarget:self action:@selector(setbuttonString:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_nameButton setTitle:person.name forState:UIControlStateNormal];
    [_nameButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [_bottomView addSubview:_nameButton];
    
    _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneButton.frame = CGRectMake(90, 70, VIEW_WIDTH - 110, 40);
    _phoneButton.layer.cornerRadius = 3;
    _phoneButton.backgroundColor = RGBA(250, 250, 250, 1);
    [_phoneButton addTarget:self action:@selector(setbuttonString:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneButton setTitle:person.phone forState:UIControlStateNormal];
    [_phoneButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [_bottomView addSubview:_phoneButton];
    
    
    _qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _qqButton.frame = CGRectMake(90, 120, VIEW_WIDTH - 110, 40);
    _qqButton.layer.cornerRadius = 3;
    _qqButton.backgroundColor = RGBA(250, 250, 250, 1);
    [_qqButton addTarget:self action:@selector(setbuttonString:) forControlEvents:UIControlEventTouchUpInside];
    [_qqButton setTitle:person.qq forState:UIControlStateNormal];
    [_qqButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [_bottomView addSubview:_qqButton];
    
    
}

-(void)headerButtonClick:(UIButton*)sender{
    
    switch (sender.tag) {
        case 0:{
            NSString *urlString = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",[_qqButton titleForState:UIControlStateNormal]];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
        }
            break;
            
        case 1:{
            [self showMessageView:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[_phoneButton titleForState:UIControlStateNormal]], nil] title:@"test" body:@""];
        }   break;
            
        case 2:{
            NSString *urlString = [NSString stringWithFormat:@"tel://%@",[_phoneButton titleForState:UIControlStateNormal]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
            break;
            
        default:
            break;
    }
    

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

-(void)setSlide:(UIView*)view{
    //button设置边框
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:1.0];   //边框宽度
    [view.layer setBorderColor:RGBA(250, 250, 250, 1).CGColor];//边框颜色
    
    //[NSHomeDirectory() stringByAppendingString:@"/name.plist"]
    
}


-(void)setbuttonString:(UIButton*)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([sender isEqual:_nameButton]){
            _headerLabel.text = [[alert.textFields lastObject] text];
        }
        [sender setTitle:[[alert.textFields lastObject] text] forState:UIControlStateNormal];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}



-(void)back{
    //存
    NSLog(@"saveArray --- %@",_friendArray);
    
        
    
    person.name = [_nameButton titleForState:UIControlStateNormal];
    
    person.qq = [_qqButton titleForState:UIControlStateNormal];
    
    person.phone = [_phoneButton titleForState:UIControlStateNormal];
    NSString *nameString = [NSString stringWithFormat:@"%@",person.name];
    if(person.name.length>0){
    if(![_friendArray containsObject:nameString]){
        
        [_friendArray addObject:[NSString stringWithFormat:@"%@",person.name]];
        
        [[ZZH_LoadingProject shareMBProgress]save:TRUEPATH(person.name) andSaveObject:person];
        
        [[ZZH_LoadingProject shareMBProgress] saveImage:[_headerButton imageForState:UIControlStateNormal] andPath:PERSONAL_IMG_PATHNAME(person.name)];
        SAVEFRIEND(_friendArray);
    }else{
        
        
        [[ZZH_LoadingProject shareMBProgress]save:TRUEPATH(person.name) andSaveObject:person];
        
        [[ZZH_LoadingProject shareMBProgress] saveImage:[_headerButton imageForState:UIControlStateNormal] andPath:PERSONAL_IMG_PATHNAME(person.name)];
    
    }
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(NSString *)truePath:(NSString*)name{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    cacheDirectory = [cacheDirectory stringByAppendingPathComponent:name];
    return cacheDirectory;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
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
