//
//  ShowZoneViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/14.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "ShowZoneViewController.h"
#import "Header.h"

@interface ShowZoneViewController ()

@end

@implementation ShowZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"个人中心背景.png"]];
    backImageView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.view addSubview:backImageView];
    
    self.view.backgroundColor = [UIColor whiteColor];
     [[ZZH_LoadingProject shareMBProgress]showAlkerInformation:@"此功能暂未开启" andDelayDismissTime:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
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
