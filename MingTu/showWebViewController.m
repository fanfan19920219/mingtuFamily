//
//  showWebViewController.m
//  MingTu
//
//  Created by zhangzhihua on 16/3/7.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "showWebViewController.h"
#import "Header.h"

@interface showWebViewController()<UIWebViewDelegate,SYLoadingLoopViewDelegate> {
    UIWebView *_showWebView;
    UIButton *_backButton;
    UIButton *_gobackButton; //返回按钮
    
    UIView *_downView;
//    SYLoadingLoopView *loadingLoopView;
}

@end

@implementation showWebViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self create_webView];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    
}

-(void)createLoadView{
//    if(loadingLoopView==nil){
//        loadingLoopView = [[SYLoadingLoopView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, VIEW_HEIGHT/2 - 50, 100, 100)];
//    }
//    loadingLoopView.roundDuration = 10;//旋转一圈所需时间
//    loadingLoopView.isDefaultEndAnimation = YES;//是否需要旋转结束后的默认动画
//    loadingLoopView.delegate = self;
//    [_showWebView addSubview:loadingLoopView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[loadingLoopView endAnimation];
    });
}

-(void)create_webView{
    _showWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 15, VIEW_WIDTH, VIEW_HEIGHT-45)];
    //_showWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT/2)];
    _showWebView.scalesPageToFit = YES;                                  //自动对页面进行缩放以适应屏幕
    _showWebView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    _showWebView.delegate = self;
    _showWebView.scrollView.bounces = NO;
    [self.view addSubview:_showWebView];
    if(!self.orHTML){
        NSString *urlString = [NSString stringWithFormat:@"%@",self.URL];
        
        urlString=  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL* url = [NSURL URLWithString:urlString];//创建URL
        NSLog(@"url 1--- %@   ----- %@",url,urlString);
    
        NSURLRequest* request = [NSURLRequest requestWithURL:url];  //创建NSURLRequest
    
        [_showWebView loadRequest:request];
    }else{
        [_showWebView loadHTMLString:self.URL baseURL:nil];
        NSLog(@"url ---- %@",self.URL);
    }
    [self createViews];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)createViews{
    //创建downView
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT -40, VIEW_WIDTH, 40)];
    _downView.backgroundColor = [UIColor clearColor];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame =CGRectMake(0, 0, VIEW_WIDTH, 64);
    //            [selfView.navigationController.view.layer addSublayer:gradient];
    // 颜色分配
    gradient.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor blackColor].CGColor];
    // 颜色分割线
    gradient.locations  = @[@(0),@(1)];
    // 起始点
    gradient.startPoint = CGPointMake(0, 0.0);
    // 结束点
    gradient.endPoint   = CGPointMake(0, 0.4);
    
    [_downView.layer addSublayer:gradient];
    [self.view addSubview:_downView];
    
    //创建返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(VIEW_WIDTH - 80, 15, 55, 25);
    _backButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:0.001];
    [_backButton setTitle:@"关闭" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backclick:) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:_backButton];
    //创建网页返回按钮
    _gobackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _gobackButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:0.001];
    _gobackButton.frame = CGRectMake(20, 15, 80, 25);
    [_gobackButton setTitle:@"上一页" forState:UIControlStateNormal];
    
    //[_gobackButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [_gobackButton addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:_gobackButton];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, VIEW_WIDTH/2, 25)];
    tipLabel.text = @"打开定位哦";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = RGBA(240, 240, 240, 1);
    tipLabel.font = [UIFont systemFontOfSize:13 weight:0.001];
    //[_downView addSubview:tipLabel];
    
}


#pragma mark - uiwebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self createLoadView];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [loadingLoopView endAnimation];
}


-(void)goback:(UIButton*)sender{
    [_showWebView goBack];
}

-(void)backclick:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
