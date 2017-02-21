//
//  AppDelegate.m
//  MingTu
//
//  Created by zhangzhihua on 16/3/3.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"



@interface AppDelegate (){
    //导航器
    
    
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1824e2c7a9a60
    //e307fd8a7aaa3e85d5c6e58febf18f0c
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.backgroundColor=[UIColor whiteColor];
    
    //创建个人中心和首页的控制器
    MainViewController *main = [[MainViewController alloc]init];
    main.tabBarItem.image=[[UIImage imageNamed:@"all_bottomta.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    main.tabBarItem.selectedImage=[[UIImage imageNamed:@"all_bottomta_up.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:main];
    
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.tabBarItem.image=[[UIImage imageNamed:@"all_bottommine.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    personal.tabBarItem.selectedImage=[[UIImage imageNamed:@"all_bottommine_up.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    personal.title = @"我窝";
    UINavigationController *personalNav = [[UINavigationController alloc]initWithRootViewController:personal];
    
    NSArray *tabarr = [[NSArray alloc]initWithObjects:mainNav,personalNav,nil];
    
    UITabBarController *tabar = [[UITabBarController alloc]init];
    tabar.viewControllers = tabarr;
    tabar.tabBar.barTintColor=  RGBA(66, 60, 64, 1);
    [[UINavigationBar appearance]setBarTintColor: RGBA(252, 82, 117, 1)];
    self.window.rootViewController = tabar;
    
    
    //改变导航字体颜色
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          RGBA(255, 255, 255, 1), NSForegroundColorAttributeName,
                                                          [UIFont fontWithName:@"AmericanTypewriter" size:20], NSFontAttributeName, nil]];
    
    NSDictionary* dic=[NSDictionary dictionaryWithObjectsAndKeys:RGBA(255, 255, 255, 1),NSForegroundColorAttributeName, nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       RGBA(155, 155, 155, 1), NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    [[UINavigationBar appearance]setTintColor:RGBA(240, 240, 240, 1)];
    
    
    [self regeisterShareSdk];
    return YES;
}

-(void)regeisterShareSdk{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"1824e2c7a9a60"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeGooglePlus)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"2785762957"
                                           appSecret:@"4c01e68d019d7aa3c6b2807caa418edb"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
//             case SSDKPlatformTypeWechat:
//                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
//                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"100371282"
//                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
             default:
                 break;
         }
     }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
