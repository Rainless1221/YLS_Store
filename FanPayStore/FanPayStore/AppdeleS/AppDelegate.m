//
//  AppDelegate.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "AppDelegate.h"
#import "QYSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - ScaleSize
- (void)initAutoScaleSize {
    
    if (SCREEN_HEIGHT == 480) {
        //4s
        self.autoSizeScaleW = SCREEN_WIDTH/375;
        self.autoSizeScaleH = SCREEN_HEIGHT/667;
    }else if(SCREEN_HEIGHT == 568) {
        //5
        self.autoSizeScaleW = SCREEN_WIDTH/375;
        self.autoSizeScaleH = SCREEN_HEIGHT/667;
    }else if(SCREEN_HEIGHT == 667){
        //6
        self.autoSizeScaleW = SCREEN_WIDTH/375;
        self.autoSizeScaleH = SCREEN_HEIGHT/667;
    }else if(SCREEN_HEIGHT == 736){
        //6p
        self.autoSizeScaleW = SCREEN_WIDTH/375;
        self.autoSizeScaleH = SCREEN_HEIGHT/667;
    }else{
        self.autoSizeScaleW = 1;
        self.autoSizeScaleH = 1;
    }
}
- (CGFloat)autoScaleW:(CGFloat)w {
    
    return w * self.autoSizeScaleW;
}

- (CGFloat)autoScaleH:(CGFloat)h {
    return h * self.autoSizeScaleH;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 启动图片延时: 1秒
    [NSThread sleepForTimeInterval:1];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    // Override point for customization after application launch.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:@"UIApplicationDidEnterBackgroundNotification" object:nil];
    
    [self post:@""];
    [self IanAdsStartPost];
#pragma mark - 服务器时间
    __block NSString *objectID;

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [[FBHAppViewModel shareViewModel]geTget_time_infoSuccess:^id(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1){
                
                objectID = [NSString stringWithFormat:@"%@",resDic[@"data"][@"now_timestamp"]];
                [PublicMethods writeToUserD:objectID andKey:@"now_timestamp" ];
            }else{
                
            }
            
            return objectID;
            
        } andfailure:^{
            return objectID;

        }];
        
    });
    
   
   
    
    [self initAutoScaleSize];
    #pragma mark -网易七鱼
    [[QYSDK sharedSDK] registerAppId:@"f5864a9890cb8d9a13d120e65545590d" appName:@"一鹿省"];
   
#pragma mark - 高德地图
    [AMapServices sharedServices].apiKey = kAppKey_gaode;
#pragma mark - 友盟
    [self registerShareAction];
#pragma mark - 极光
    [self setJPush:launchOptions];
    [self applicationWillResignActive:application];

    UserModel *model=[UserModel getUseData];

#pragma mark - 判断是否登录
    if (model.token!= nil) {
        [self setAppWindows];
        [self setRootViewController];
#pragma mark - 客服中心
        QYUserInfo *user = [QYUserInfo new];
        user.userId =model.merchant_id;
        user.data = [NSString stringWithFormat:@"[{\"key\":\"real_name\", \"value\":\"商家%@\"},{\"key\":\"mobile_phone\", \"value\":%@},{\"index\":0, \"key\":\"account\", \"label\":\"设备端\", \"value\":\"苹果手机\", }]",model.mobile,model.mobile];
        
        [[QYSDK sharedSDK] setUserInfo:user authTokenVerificationResultBlock:^(BOOL isSuccess) {
            
        }];
        
    }else
    {
        [self setAppWindows];
        [self setLoginViewController];
#pragma mark - 判断是否第一次使用
        [self setGuideView];
    }

    //
    NSError *setCategoryErr = nil;
//    ![Uploading WechatIMG395_980830.jpeg . . .]
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayback
     error: &setCategoryErr];
    
    [[AVAudioSession sharedInstance] setActive: YES error: &activationErr];
    
    
#pragma mark - 键盘
    //默认为YES，关闭为NO
    [IQKeyboardManager sharedManager].enable = YES;
    //2）键盘弹出时，点击背景，键盘收回
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";


#pragma mark - 打印
    self.manage = [JWBluetoothManage sharedInstance];
//
//    NSArray *centralManagerIdentifiers =
//    launchOptions[UIApplicationLaunchOptionsBluetoothCentralsKey];
//
//    if (centralManagerIdentifiers.count) {
//        for (NSString *identifier in centralManagerIdentifiers) {
//            NSLog(@"系统启动项目");
//            //在这里创建的蓝牙实例一定要被当前类持有，不然出了这个函数就被销毁了，蓝牙检测会出现“XPC connection invalid”
//
//            [self.manage initWithQueue:nil options:@{CBCentralManagerOptionRestoreIdentifierKey : identifier}];
//
//
//            NSLog(@"");
//        }
//    }
    
    return YES;
}


/**
 联网结果回调
 
 @param iError 联网结果错误码信息，0代表联网成功
 */
- (void)onGetNetworkState:(int)iError {
    if (0 == iError) {
        NSLog(@"联网成功");
    } else {
        NSLog(@"联网失败：%d", iError);
    }
}
/**
 鉴权结果回调
 
 @param iError 鉴权结果错误码信息，0代表鉴权成功
 */
- (void)onGetPermissionState:(int)iError {
    if (0 == iError) {
        NSLog(@"授权成功");
    } else {
        NSLog(@"授权失败：%d", iError);
    }
}


-(void)post:(NSString *)urlStr{
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];

    //2.根据会话对象创建task
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    NSString *process = [NSString stringWithFormat:@"fanbuyhainan%@",timeString];
    NSString *pro= [MD5Sign MD5:process];

    NSString *string = [NSString stringWithFormat:@"http://103.27.7.20/api/upgrade/get_upgrade_info?"];
    
    //server=formal&client=user_ios&timestamp=%@&process=%@&token=%@
    NSURL *url=[NSURL URLWithString:string];
 
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";

    //5.设置请求体
//    NSLog(@"POST-Header:%@",request.allHTTPHeaderFields);
//formal    text
    NSString *dict = [NSString stringWithFormat:@"server=formal&client=user_ios&timestamp=%@&process=%@",timeString,pro];
    
    request.HTTPBody = [dict dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
         
              第一个参数：请求对象
         
              第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
         
              data：响应体信息（期望的数据）
         
              response：响应头信息，主要是对服务器端的描述
         
              error：错误信息，如果请求失败，则error有值
         
              */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        if (error) {
//            NSLog(@"NSURLSessionDataTaskerror:%@",error);
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //8.解析数据
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //        NSLog(@"%@",dict);
            NSString *Statu = [NSString stringWithFormat:@"%@",dic[@"status"]];
            if ([Statu isEqualToString:@"1"]) {
                NSString *status = [NSString stringWithFormat:@"%@",dic[@"data"][@"upgrade_status"]];
                if ([status isEqualToString:@"YES"]) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self status:@""];
                        });
                    });
                }
                
                
            }else{
                
            }
           
            
        }

        
        
    }];
    //7.执行任务
    [dataTask resume];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

#pragma mark APP进入后台触发的方法
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    // 进入后台，处理后台任务
    [self comeToBackgroundMode];
    
}
#pragma mark 处理后台任务
- (void)comeToBackgroundMode {
    self.count = 0;
    // 初始化一个后台任务BackgroundTask，这个后台任务的作用就是告诉系统当前App在后台有任务处理，需要时间
    [self beginBackgroundTask];

}
#pragma mark 开启一个后台任务
- (void)beginBackgroundTask {
    UIApplication *app = [UIApplication sharedApplication];
    self.bgTask = [app beginBackgroundTaskWithExpirationHandler:^{

    }];
//    // 开启定时器，不断向系统请求后台任务执行的时间
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(applyForMoreTime) userInfo:nil repeats:YES];

}
#pragma mark 结束一个后台任务
- (void)endBackgroundTask {
    self.count = 0;
    UIApplication *app = [UIApplication sharedApplication];
    [app endBackgroundTask:self.bgTask];
    self.bgTask = UIBackgroundTaskInvalid;
    // 结束计时
    [self.timer invalidate];
}
#pragma mark 申请后台运行时间
- (void)applyForMoreTime {
    self.count ++;
    NSLog(@"%ld，剩余时间：%f", (long)self.count, [UIApplication sharedApplication].backgroundTimeRemaining);
    
//    YBWeakSelf

    if ([UIApplication sharedApplication].backgroundTimeRemaining ==0) {

    }
    
    if (self.count % 150 == 0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 结束当前后台任务
            [self endBackgroundTask];
            // 开启一个新的后台任务
            [self beginBackgroundTask];
            
            [self Music];
            
//            if (self.manage.stage != JWScanStageCharacteristics) {
//                [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
//                    if (!error) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//
//                        });
//                    }else{
//
//                    }
//                }];
//            }
            
        });
    }

}

#pragma mark APP进入前台

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    // 结束后台任务
    [self endBackgroundTask];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"程序被杀死");
    
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
                
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });

    
    [self comeToBackgroundMode];
    
    [self Music];
    
}
#pragma mark - 后台音乐播放
-(void)Music{
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        NSError *audioSessionError = nil;
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession setCategory:AVAudioSessionCategoryPlayback error:&audioSessionError]){
            NSLog(@"Successfully set the audio session.");
        } else {
            NSLog(@"Could not set the audio session");
        }
        
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *filePath = [mainBundle pathForResource:@"mySong" ofType:@"mp3"];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
        
        if (self.audioPlayer != nil){
            self.audioPlayer.delegate = self;
            
            [self.audioPlayer setNumberOfLoops:-1];
            if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]){
                NSLog(@"Successfully started playing...");
            } else {
                NSLog(@"Failed to play.");
            }
        } else {
            
        }
    });
    
}

@end
