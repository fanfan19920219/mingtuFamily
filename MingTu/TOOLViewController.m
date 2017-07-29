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

@interface TOOLViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
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
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initalMethod];
    
    _tabbarView = [self tabbarViewWithBackColor:RGBA(44, 44, 44, 0.7)];
    [self.view addSubview:_tabbarView];
    
}


-(void)initalMethod{
    _tableViewDataArray = [[NSMutableArray alloc]init];
    NSDictionary *dic1 = @{@"title":@"QQ飞车吧",@"imgename":@"Logo1.png",@"url":SPEEDBA};
    NSDictionary *dic2 = @{@"title":@"QQ飞车官方论坛",@"imgename":@"Logo2.png",@"url":SPEEDLUNTAN};
    [_tableViewDataArray addObject:dic1];
    [_tableViewDataArray addObject:dic2];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, VIEW_WIDTH, VIEW_HEIGHT - 44)];
    [self.view addSubview:_backView];
    smallVC = [[SmileViewController alloc]init];
    smallVC.view.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT );
    [self addChildViewController:smallVC];
    
    [_backView addSubview:smallVC.view];
    
    _topView = [TOOLViewTopView TView];
    _topView.frame = CGRectMake(0, -27, VIEW_WIDTH, 79);
    _topView.downButton.layer.cornerRadius = 4;
    _topView.downButton.clipsToBounds = YES;
    _topView.alpha = 0.3;
    [_topView.downButton addTarget:self action:@selector(controlTop:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_topView];
    
    [_topView.leftButton addTarget:self action:@selector(TopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topView.centerButton addTarget:self action:@selector(TopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)TopButtonClick:(UIButton*)sender{
    if(sender.tag==0){
        [_backView addSubview:smallVC.view];
    }else{
        
        _selectView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _backView.frame.size.width, _backView.frame.size.height) style:UITableViewStylePlain];
        _selectView.delegate = self;
        _selectView.dataSource = self;
        _selectView.tableFooterView = [[UIView alloc]init];
        _selectView.rowHeight = 60;
        [_backView addSubview:_selectView];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
        showViewcontroller.URL = E_L_M;
        //            [self.navigationController pushViewController:showViewcontroller animated:YES];
        [self presentViewController:showViewcontroller animated:YES completion:^{
            [[ZZH_LoadingProject shareMBProgress]showAlkerInformation:@"打开定位哦" andDelayDismissTime:1.5];
            AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
            manager.responseSerializer=[AFHTTPResponseSerializer serializer];
            
            //以GET的形式提交，只需要将上面的请求地址给GET做参数就可以
            [manager GET:TESTURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"成功了");
                responseObject = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"success --- obj --- %@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
        }];
    }
    
    if(indexPath.row==1){
        
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
