//
//  ShowZone1ViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/27.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "ShowZone1ViewController.h"
#import "UIViewController+tabbar.h"

@interface ShowZone1ViewController ()

@end

@implementation ShowZone1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *tabbarView = [self tabbarViewWithBackColor:RGBA(44, 44, 44, 0.5)];
    [self.view addSubview:tabbarView];
}

- (IBAction)gotoSecondVideo:(UIButton *)sender {
    showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
    showViewcontroller.URL = @"http://v.youku.com/v_show/id_XNTgzODY4MTU2.html";
    [self presentViewController:showViewcontroller animated:YES completion:^{
        
    }];
}

- (IBAction)gotoFirstVideo:(UIButton *)sender {
//http://v.youku.com/v_show/id_XMzUyMTU1NTYw.html
    showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
    showViewcontroller.URL = @"http://v.youku.com/v_show/id_XMzUyMTU1NTYw.html";
    [self presentViewController:showViewcontroller animated:YES completion:^{
        
    }];
}
- (IBAction)copyQQGroup:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"146769193";
    // for iOS 8
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"复制群号成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) { }];
    [alert addAction:cancelAction];
    
    UIAlertAction *paylAction = [UIAlertAction actionWithTitle:@"我要加群" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *urlString = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&version=1&src_type=web"];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
        
        
    }];
    
    
    [alert addAction:paylAction];
    [self presentViewController:alert animated:YES completion:nil];
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
