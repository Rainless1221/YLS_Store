//
//  AppDelegate+ViewController.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "AppDelegate.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate (ViewController)<JPUSHRegisterDelegate>
@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;

- (void)applicationWillResignActive:(UIApplication *)application;
/**
 *  window实例
 */
- (void)setAppWindows;
/**
 *  设置登陆视图
 */
- (void)setLoginViewController;
/**
 *  设置根视图
 */
- (void)setRootViewController;
/**
 *  开屏广告
 */
-(void)IanAdsStartPost;
-(void)IanAdsStart:(NSString *)ad_pic;
/**
 *  设置引导页
 */
- (void)setGuideView;
/**
 * 服务器维护展示
 */
-(void)status:(NSString *)textString;
/**
 * 系统（声音、震动）
 */
- (void)shakeText:(UIButton *)sender;
/**
 *  设置极光
 */
- (void)setJPush:(NSDictionary*)launchOptions;
//单例
+ (AppDelegate *)shareAppDelegate;

/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;


-(void)merchant_center:(NSString *)order_id;
@end
