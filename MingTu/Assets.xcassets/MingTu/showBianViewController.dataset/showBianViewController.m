//
//  showBianViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/3/3.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "showBianViewController.h"
#import "Header.h"
#import "yue_scrollView.h"

#define SLIDECOLOR RGBA(222, 200, 200, 0.6)

@interface showBianViewController (){
    
    UITextView *_contentView;
    UITextField *_localLabel;
    UITextField *_timeLabel;
    UIButton     *_personButton;
    UIButton     *_sendButton;
    
    yue_scrollView *_backScrollview;
    
    personModel *person;
    
    NSMutableArray *_modelArray;
    
}
@end

@implementation showBianViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self create_Views];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.model.time;
    
}



-(void)create_Views{
    
    _backScrollview = [[yue_scrollView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64 - 44)];
    [self.view addSubview:_backScrollview];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];
    titleLabel.text = @" 记录:";
    titleLabel.font = [UIFont systemFontOfSize:13 weight:0.001];
    titleLabel.textColor = RGBA(122, 122, 122, 1);
    [_backScrollview addSubview:titleLabel];
    
    
    _contentView = [[UITextView alloc]initWithFrame:CGRectMake(20,30 , VIEW_WIDTH  - 40, 240)];
    _contentView.text = self.model.content;
    _contentView.editable = NO;
    _contentView.layer.cornerRadius = 5;
    _contentView.clipsToBounds = YES;
    _contentView.textColor = RGBA(87, 87, 87, 1);
    _contentView.font = [UIFont systemFontOfSize:13 weight:0.001];
    [self setSlide:_contentView];
    [_backScrollview addSubview:_contentView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setSlide:(UIView*)view{
    //button设置边框
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:1];   //边框宽度
    [view.layer setBorderColor:SLIDECOLOR.CGColor];//边框颜色
    
    //[NSHomeDirectory() stringByAppendingString:@"/name.plist"
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
