//
//  AppDelegate.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//  15359349507

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"
#import "FBHLogInController.h"
#import "YLSLogInController.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>
    
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BaseTabBarController *MainTabBar;

@property (strong, nonatomic) FBHLogInController *LogInController;

@property (strong,nonatomic)JWBluetoothManage * manage;

@property (assign,nonatomic)NSInteger  count;
@property (strong,nonatomic)NSTimer * timer;
@property (nonatomic,assign) UIBackgroundTaskIdentifier bgTask;
@property (nonatomic, strong) AVSpeechSynthesizer *aVSpeechSynthesizer;

@property (strong,nonatomic)AVAudioPlayer * audioPlayer;


- (CGFloat)autoScaleW:(CGFloat)w;

- (CGFloat)autoScaleH:(CGFloat)h;
-(void)ord:(NSString *)order_id;

//当前屏幕与设计尺寸(iPhone6)宽度比例
@property(nonatomic,assign) CGFloat autoSizeScaleW;

//当前屏幕与设计尺寸(iPhone6)高度比例
@property(nonatomic,assign) CGFloat autoSizeScaleH;

@end

