//
//  AppDelegate+AppLifeCircle.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "AppDelegate+AppLifeCircle.h"

@implementation AppDelegate (AppLifeCircle)

// 当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可
- (void)applicationWillResignActive:(UIApplication *)application {
    [JPUSHService resetBadge];
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

// 当应用程序进入活动状态执行
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


// 告诉代理启动基本完成程序准备开始运行
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    [application cancelAllLocalNotifications];
}

// 当应用程序将要入非活动状态执行，在此期间，应用程序不接收消息或事件，比如来电话了
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

//- (void)applicationWillTerminate:(UIApplication *)application {
//    /*在这里添加退出前的清理代码以及其他工作代码*/
//    NSLog(@"程序被杀死");
//}

@end
