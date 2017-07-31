//
//  SmileViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/2/16.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "SmileViewController.h"
#import "Header.h"
#import "smileModel.h"

#define APPKEY @"0340c380afd65873ebd7a9c40cf39420"

@interface SmileViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITextView *_showTextView;
    NSMutableArray *_modelArray;
    NSInteger indexNum;
    
    UIButton *_nextButton;
    UIButton *_lastButton;
    UIButton *_shareButton;
    UIButton *_refreshButton;
    NSString *_page;
    
}
@end

@implementation SmileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    _page =  [[NSUserDefaults standardUserDefaults]objectForKey:@"page"];
    if(_page==nil){
        _page=@"1";
    }
    _modelArray = [[NSMutableArray alloc]init];
    [self create_Views];
    [self loadRequest];
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"xiaohua_index"] integerValue]){
        indexNum=[[[NSUserDefaults standardUserDefaults]objectForKey:@"xiaohua_index"] integerValue];
    }else{
        indexNum = 0;
    }
    
    
    
}

-(void)refreshTextView{
    
    if(_modelArray.count==0)return;
    smileModel *model = [_modelArray objectAtIndex:indexNum];
    _showTextView.text = model.content;
//    _showTextView.userInteractionEnabled = YES;
}


-(void)loadRequest{
    
    [MBProgressHUD showTipMessageInWindow:@"加载中"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
//    NSLog(@"timeString --- %@",timeString);
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    NSString *urlString = [NSString stringWithFormat:@"http://japi.juhe.cn/joke/content/list.from?key=%@&page=%@&pagesize=20&sort=asc&time=%@",APPKEY,_page,@"1418816972"];
    
    //以GET的形式提交，只需要将上面的请求地址给GET做参数就可以
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功了 ---obj --- %@",responseObject);
        //responseObject = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"success --- obj --- %@",responseObject);
        @try {
            NSDictionary *responseDIC =responseObject;
            NSLog(@"responseDIC --- %@",responseDIC);
            NSArray *returnArray = [[responseObject objectForKey:@"result"] objectForKey:@"data"];
            NSLog(@"returnarray.count ---- %lu",(unsigned long)returnArray.count);
            for(NSDictionary *dic in  returnArray){
                smileModel *model = [[smileModel alloc]init];
                [model setValue:dic];
                [_modelArray addObject:model];
                [MBProgressHUD hideHUD];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshTextView];
            });
        } @catch (NSException *exception) {
        } @finally {
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];
}


-(void)create_Views{
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"贴吧背景图.png"]];
    backImageView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 60);
    backImageView.userInteractionEnabled = YES;
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backImageView];
    
    
    _showTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 20, VIEW_WIDTH - 20, VIEW_HEIGHT - 60 - 64)];
    _showTextView.backgroundColor = RGBA(1, 1, 1, 0.8);
    _showTextView.font = [UIFont systemFontOfSize:14 weight:0.001];
    _showTextView.textColor = RGBA(255, 255, 255, 1);
    _showTextView.editable = NO;
    _showTextView.text = @"暂时没有数据哦";
    _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_showTextView];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.frame = CGRectMake(10, _showTextView.frame.origin.y + _showTextView.frame.size.height + 5, 100, 20);
    [_nextButton setTitle:@"Last" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [_nextButton setTitleColor:RGBA(250, 250, 250, 1) forState:UIControlStateNormal];
    _nextButton.backgroundColor = [UIColor blackColor];
    _nextButton.alpha = 0.8;
    [self.view addSubview:_nextButton];
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButton.frame = CGRectMake(0, _showTextView.frame.origin.y + _showTextView.frame.size.height + 5, 100, 20);
    _shareButton.center = CGPointMake(_showTextView.frame.size.width/2 + 10, _shareButton.center.y);
    [_shareButton setTitle:@"Share`" forState:UIControlStateNormal];
    _shareButton.contentMode = UIViewContentModeCenter;
    _shareButton.backgroundColor = [UIColor blackColor];
    [_shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [_shareButton setTitleColor:RGBA(250, 250, 250, 1) forState:UIControlStateNormal];
    _shareButton.alpha = 0.8;
    [self.view addSubview:_shareButton];
    
    
    
    
    _lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lastButton.frame = CGRectMake(VIEW_WIDTH - 110, _showTextView.frame.origin.y + _showTextView.frame.size.height +5, 100, 20);
    _lastButton.backgroundColor = [UIColor redColor];
    [_lastButton addTarget:self action:@selector(last) forControlEvents:UIControlEventTouchUpInside];
    [_lastButton setTitleColor:RGBA(250, 250, 250, 1) forState:UIControlStateNormal];
    _lastButton.backgroundColor = [UIColor blackColor];
    [_lastButton setTitle:@"Next" forState:UIControlStateNormal];
    _lastButton.alpha = 0.8;
    [self.view addSubview:_lastButton];
    
}



-(void)share{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _showTextView.text;
    // for iOS 8
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"复制成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) { }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)last{
    indexNum++;
    if(indexNum>=_modelArray.count){
        [self refresh];
        return;
    }
    [self refreshTextView];
}

-(void)next{
    indexNum--;
    if(indexNum<=0){
        indexNum = 0;
    }
    [self refreshTextView];
}

-(void)refresh{
    indexNum=0;
    _page = [NSString stringWithFormat:@"%ld",[_page integerValue]+1];
    [_modelArray removeAllObjects];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
    NSLog(@"timeString --- %@",timeString);
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    NSString *urlString = [NSString stringWithFormat:@"http://japi.juhe.cn/joke/content/list.from?key=%@&page=%@&pagesize=20&sort=asc&time=%@",APPKEY,_page,@"1418816972"];
    
    //以GET的形式提交，只需要将上面的请求地址给GET做参数就可以
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功了 ---obj --- %@",responseObject);
        //responseObject = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"success --- obj --- %@",responseObject);
        @try {
            NSDictionary *responseDIC =responseObject;
            NSLog(@"responseDIC --- %@",responseDIC);
            NSArray *returnArray = [[responseObject objectForKey:@"result"] objectForKey:@"data"];
            NSLog(@"returnarray.count ---- %lu",(unsigned long)returnArray.count);
            for(NSDictionary *dic in  returnArray){
                smileModel *model = [[smileModel alloc]init];
                [model setValue:dic];
                [_modelArray addObject:model];
            }
            [self refreshTextView];
        } @catch (NSException *exception) {
            
        } @finally {
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell ==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    smileModel *model = [_modelArray objectAtIndex:indexPath.row];
    cell.textLabel.text =[model.content substringToIndex:7];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",(long)indexNum] forKey:@"xiaohua_index"];
    [[NSUserDefaults standardUserDefaults]setObject:_page forKey:@"page"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
