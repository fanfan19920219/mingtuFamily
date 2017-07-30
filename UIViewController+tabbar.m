//
//  UIViewController+tabbar.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/28.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "UIViewController+tabbar.h"
#import "Header.h"

@implementation UIViewController (tabbar)
-(UIView*)tabbarViewWithBackColor:(UIColor*)color{
    UIView* _tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    _tabbarView.backgroundColor = color;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLabel.center = CGPointMake(VIEW_WIDTH/2, 40);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16 weight:0.1];
    titleLabel.textColor = RGBA(255, 255, 255, 1);
    titleLabel.text = self.title;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 30, 50, 30);
    [backButton setTitle:@"上一页" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:.1];
    [backButton setTitleColor:RGBA(255, 255, 255, 1) forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [_tabbarView addSubview:backButton];
    [_tabbarView addSubview:titleLabel];
    self.navigationController.navigationBarHidden = YES;
    
    return _tabbarView;
}
-(void)backMethod{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
