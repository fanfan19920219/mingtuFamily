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
    [[UINavigationBar appearance]setBarTintColor: RGBA(252, 82, 117, 1)];
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
    return YES;
}

-(void)regeisterShareSdk{

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
