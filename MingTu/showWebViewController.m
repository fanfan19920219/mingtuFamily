//
//  showWebViewController.m
//  MingTu
//
//  Created by zhangzhihua on 16/3/7.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "showWebViewController.h"
#import "Header.h"
#import <WebKit/WebKit.h>
@interface showWebViewController()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate> {
    WKWebView *_showWebView;
    UIButton *_backButton;
    UIButton *_gobackButton; //返回按钮
    
    UIView *_downView;
    CAGradientLayer *_gradient;
//    SYLoadingLoopView *loadingLoopView;
}
@property (nonatomic , strong)UIProgressView *progressView;
@property (nonatomic , strong)LDProgressView *LDProgressView;
@end

@implementation showWebViewController

-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUD];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self create_webView];
    self.view.backgroundColor = [UIColor blackColor];
//    [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
    
}

-(void)createLoadView{
//    [MBProgressHUD showActivityMessageInView:@"加载中.."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

    });
}

-(void)create_webView{
    

    _showWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 15, VIEW_WIDTH, VIEW_HEIGHT-45)];
    _showWebView.UIDelegate = self;
    _showWebView.navigationDelegate = self;
    _showWebView.scrollView.bounces = NO;
    [self.view addSubview:_showWebView];
    
    // flat, green, animated
    _LDProgressView = [[LDProgressView alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2 - 100, VIEW_HEIGHT/2 - 20, 200, 22)];
    _LDProgressView.color = RGBA(35, 131, 221, 1);
    _LDProgressView.flat = @YES;
    
    _LDProgressView.animate = @YES;
    [self.view addSubview:_LDProgressView];
    
    
    
    [_showWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    
    
    
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
    _gradient = [CAGradientLayer layer];
    _gradient.frame =CGRectMake(0, 0, VIEW_WIDTH, 64);
    //            [selfView.navigationController.view.layer addSublayer:gradient];
    // 颜色分配
    _gradient.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor blackColor].CGColor];
    // 颜色分割线
    _gradient.locations  = @[@(0),@(1)];
    // 起始点
    _gradient.startPoint = CGPointMake(0, 0.0);
    // 结束点
    _gradient.endPoint   = CGPointMake(0, 0.4);
    
    [_downView.layer addSublayer:_gradient];
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
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    NSLog(@" %s,change = %@",__FUNCTION__,change);
//    
//    NSLog(@"dic ----- %.2f",_showWebView.estimatedProgress);
    
    if ([keyPath isEqual: @"estimatedProgress"] && object == _showWebView) {
        
        _LDProgressView.alpha = 0.8;
//        [self.progressView setAlpha:1.0f];
        _LDProgressView.progress =_showWebView.estimatedProgress;
//        [self.progressView setProgress:_showWebView.estimatedProgress animated:YES];
        if(_showWebView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                [self.progressView setAlpha:0.0f];
                _LDProgressView.alpha = 0;
                _gradient.colors = @[(__bridge id)[self colorOfPoint:CGPointMake(VIEW_WIDTH/2, 20)].CGColor,(__bridge id)[UIColor blackColor].CGColor];
                
            } completion:^(BOOL finished) {
//                [self.progressView setProgress:0.0f animated:NO];
                _LDProgressView.progress = 0 ;
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


-(void)goback:(UIButton*)sender{
    [_showWebView goBack];
}

-(void)backclick:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//吸取颜色的办法
- (UIColor *) colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [_showWebView.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}


- (void)dealloc {
    [_showWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    // if you have set either WKWebView delegate also set these to nil here
    [_showWebView setNavigationDelegate:nil];
    [_showWebView setUIDelegate:nil];
}

@end
