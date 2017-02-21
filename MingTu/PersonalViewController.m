//
//  PersonalViewController.m
//  MingTu
//
//  Created by zhangzhihua on 16/3/3.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//


#define HEADERIMG_SIZE 140.f
#define TITLELABEL_WIDTH 200
#define TITLELABEL_HEIGHT 20
#define HEADERVIEW_HEIGHT 240.f

#import "PersonalViewController.h"
#import "Header.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIView *_headerView;
    UIButton *_headerButton;
    UILabel *_titlelabel;
    
    UITableView *_tableView;
    NSArray *_titleArray;
}

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self create_Views];
    [self create_tableView];
}

-(void)create_Views{
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64,VIEW_WIDTH, HEADERVIEW_HEIGHT)];
    _headerView.backgroundColor = RGBA(255, 250, 250, 1);
    [self.view addSubview:_headerView];
    
    _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton.frame = CGRectMake((VIEW_WIDTH/2) - HEADERIMG_SIZE/2, 40, HEADERIMG_SIZE, HEADERIMG_SIZE);
    _headerButton.layer.cornerRadius = HEADERIMG_SIZE/2;
    [_headerButton setImage:[UIImage imageNamed:@"水冰月.jpeg"] forState:UIControlStateNormal];
    [_headerButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_headerView addSubview:_headerButton];
    [self setSlide:_headerButton];
    
    _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake((VIEW_WIDTH - TITLELABEL_WIDTH)/2, _headerButton.frame.origin.y + HEADERIMG_SIZE + 20, TITLELABEL_WIDTH, TITLELABEL_HEIGHT)];
    _titlelabel.textAlignment = NSTextAlignmentCenter;
    _titlelabel.font = [UIFont systemFontOfSize:14 weight:0.01];
    _titlelabel.textColor = RGBA(44, 44, 44, 1);
    _titlelabel.text = @"小姐姐";
    [_headerView addSubview:_titlelabel];
    
}

-(void)create_tableView{
    
    _titleArray = @[@"常用联系人"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headerView.frame.origin.y + HEADERVIEW_HEIGHT, VIEW_WIDTH, VIEW_HEIGHT - (_headerView.frame.origin.y + HEADERVIEW_HEIGHT) - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70.f;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
}

-(void)setSlide:(UIView*)view{
    //button设置边框
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:1.5];   //边框宽度
    [view.layer setBorderColor:RGBA(255, 255, 255, 1).CGColor];//边框颜色
    
    //[NSHomeDirectory() stringByAppendingString:@"/name.plist"]
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13 weight:0.001];
    cell.textLabel.textColor = RGBA(152, 122, 122, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    personInformationViewController *personVC = [[personInformationViewController alloc]init];
    [self.navigationController pushViewController:personVC animated:YES];
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
