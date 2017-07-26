//
//  AppDelegate.m
//  MingTu
//
//  Created by zhangzhihua on 16/3/3.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "UMessage.h"

#define UMENGAPP_KEY @"595c87ab310c93254e0011aa"



@interface AppDelegate ()<UNUserNotificationCenterDelegate>{
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
    main.tabBarItem.image=[[UIImage imageNamed:@"tabBar_home_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    main.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabBar_home_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [main.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
    
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:main];
    
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    personal.tabBarItem.image=[[UIImage imageNamed:@"tabBar_myJD_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    personal.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabBar_myJD_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [personal.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
//    personal.title = @"窝";
    UINavigationController *personalNav = [[UINavigationController alloc]initWithRootViewController:personal];
    
    NSArray *tabarr = [[NSArray alloc]initWithObjects:mainNav,personalNav,nil];
    
    UITabBarController *tabar = [[UITabBarController alloc]init];
    tabar.viewControllers = tabarr;
    tabar.tabBar.barTintColor=  RGBA(88, 80, 84, 1);
    
    [[UINavigationBar appearance]setBarTintColor: RGBA(88, 80, 84, 1)];
//    [[UINavigationBar appearance]setBarTintColor: RGBA(252, 82, 117, 1)];
//    [[UINavigationBar appearance]setBarTintColor: RGBA(44, 44, 44, 1)];
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
    [UMessage startWithAppkey:@"595c87ab310c93254e0011aa" launchOptions:launchOptions];
    [self initUmengPush];
    
    return YES;
}

-(void)regeisterShareSdk{
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMENGAPP_KEY];
    
    
    //集成iqKeyBoard
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

//初始化友盟推送
-(void)initUmengPush{
    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
    
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
    
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    
    //输出deviceToken
//    NSLog(@"deviceToken=====%@",deviceToken);
//    NSString*device = [[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<"withString:@""]stringByReplacingOccurrencesOfString:@" "withString:@""]stringByReplacingOccurrencesOfString:@">"withString:@""];
//    NSLog(@"deviceToken=====%@",device);
    
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
