//
//  TOOLViewController.m
//  MingTu
//
//  Created by Star J on 2017/7/29.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "TOOLViewController.h"
#import "UIViewController+tabbar.h"
#import "SocialTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
//CLLocationManager

@interface TOOLViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    SmileViewController *smallVC;
}

@property (nonatomic , strong)TOOLViewTopView *topView;
@property (nonatomic , strong)UIView *tabbarView;
@property (nonatomic , strong)UIView *backView;
@property (nonatomic , strong)UITableView *selectView;
@property (nonatomic , strong)NSMutableArray *tableViewDataArray;

@end

@implementation TOOLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tabbarView = [self tabbarViewWithBackColor:RGBA(44, 44, 44, 0.7)];
    [self initalMethod];
    
    
    _topView.frame = CGRectMake(0, 0, VIEW_WIDTH, 109);
    _tabbarView.alpha = 0;
    _topView.alpha = 1;
}


-(void)initalMethod{
    _tableViewDataArray = [[NSMutableArray alloc]init];
    NSDictionary *dic2 = @{@"title":@"饿了么",@"imgename":@"Logo2.png",@"url":SPEEDLUNTAN};
    [_tableViewDataArray addObject:dic2];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.view addSubview:_backView];
    smallVC = [[SmileViewController alloc]init];
    
    
    
    [self addChildViewController:smallVC];
    
    
    
    _topView = [TOOLViewTopView TView];
    _topView.frame = CGRectMake(0, -27, VIEW_WIDTH, 109);
    _topView.downButton.layer.cornerRadius = 4;
    _topView.downButton.clipsToBounds = YES;
    _topView.alpha = 0.3;
    [_topView.downButton addTarget:self action:@selector(controlTop:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [_topView.leftButton addTarget:self action:@selector(TopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topView.centerButton addTarget:self action:@selector(TopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        smallVC.view.frame = CGRectMake(0, 10, VIEW_WIDTH, VIEW_HEIGHT );
        [_backView addSubview:smallVC.view];
        [self.view addSubview:_topView];
        [self.view addSubview:_tabbarView];
    });
    
}

-(void)TopButtonClick:(UIButton*)sender{
    if(sender.tag==0){
        [_backView addSubview:smallVC.view];
    }else{
        
        _selectView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, _backView.frame.size.width, _backView.frame.size.height) style:UITableViewStylePlain];
        _selectView.delegate = self;
        _selectView.dataSource = self;
        _selectView.tableFooterView = [[UIView alloc]init];
        _selectView.rowHeight = 60;
        [_backView addSubview:_selectView];
    }
    [UIView animateWithDuration:0.5 animations:^{
        _topView.frame = CGRectMake(0, -27, VIEW_WIDTH, 109);
        _tabbarView.alpha = 1;
        _topView.alpha = 0.3;
        _topView.downButton.tag=0;
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
        showViewcontroller.URL = E_L_M;
        //            [self.navigationController pushViewController:showViewcontroller animated:YES];
        [self presentViewController:showViewcontroller animated:YES completion:^{
            [self judgmentLocal];
        }];
    }
    
    if(indexPath.row==1){
        
    }
}


//判断定位的方法
-(void)judgmentLocal{
    //判断定位是否开启
    if ([CLLocationManager locationServicesEnabled])
    {
        //  判断用户是否允许程序获取位置权限
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways)
        {
            //用户允许获取位置权限
            NSLog(@"用户允许权限定位");
        }else
        {
            //用户拒绝开启用户权限
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"打开[定位服务权限]来允许[XXX]确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            alertView.delegate=self;
            alertView.tag=2;
            [alertView show];
        }
    }
    else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"打开[定位服务]来允许[XXX]确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>XXX>始终)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        alertView.delegate=self;
        alertView.tag=1;
        [alertView show];
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
                //跳转到定位权限页面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }else {
                //跳转到定位开关界面
                NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
                if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            //跳转到定位权限页面
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}

-(void)controlTop:(UIButton*)sender{
    
    if(sender.tag==0){
        sender.tag=1;
        [UIView animateWithDuration:0.5 animations:^{
            _topView.frame = CGRectMake(0, 0, VIEW_WIDTH, 109);
            _tabbarView.alpha = 0;
            _topView.alpha = 1;
            [sender setTitle:@"收起栏目" forState:UIControlStateNormal];
            
        }];
    }else{
        sender.tag=0;
        [UIView animateWithDuration:0.5 animations:^{
            _topView.frame = CGRectMake(0, -27, VIEW_WIDTH, 109);
            _tabbarView.alpha = 1;
            _topView.alpha = 0.3;
            [sender setTitle:@"展开栏目" forState:UIControlStateNormal];
        }];
    }
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
    cell.showImageView.image = [UIImage imageNamed:[dic objectForKey:@"imgename"]];
    cell.socialDetailLabel.text = @"";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = RGBA(255, 255, 255, 0.4);
    return cell;
    
}



- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
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
