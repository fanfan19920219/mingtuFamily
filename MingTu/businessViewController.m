//
//  businessViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/28.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "businessViewController.h"

@interface businessViewController ()

@end

@implementation businessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)gotoFeiCheJiaoYi:(UIButton *)sender {
    showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
    showViewcontroller.URL = SPEED_TRANSACTION;
    [self presentViewController:showViewcontroller animated:YES completion:^{
        
    }];
}

- (IBAction)gotoFeiCheMaiHao:(UIButton *)sender {
    showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
    showViewcontroller.URL = SPEED_SALE;
    [self presentViewController:showViewcontroller animated:YES completion:^{
        
    }];
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
