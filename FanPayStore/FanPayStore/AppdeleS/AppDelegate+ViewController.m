//
//  AppDelegate+ViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "AppDelegate+ViewController.h"
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"


@implementation AppDelegate (ViewController)
- (void)setAppWindows
{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.window makeKeyAndVisible];
}

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification{
    BOOL loginSuccess = [notification.object boolValue];
    if (loginSuccess) {//登陆成功
        NSLog(@"11111");
    }else {//登陆失败
        NSLog(@"2222");
    }
    
}
/** 登录 **/
- (void)setLoginViewController
{
    self.LogInController = [FBHLogInController new];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.window.rootViewController = self.LogInController;
}
/** 设置根视图 */
- (void)setRootViewController
{
    self.MainTabBar = [BaseTabBarController new];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.window.rootViewController = self.MainTabBar;
    
}
#pragma mark - 开屏广告
-(void)IanAdsStart:(NSString *)ad_pic{
    
    IanAdsStartView *startView = [IanAdsStartView startAdsViewWithBgImageUrl:ad_pic withClickImageAction:^{
        
    }];
    
    [startView startAnimationTime:3 WithCompletionBlock:^(IanAdsStartView *startView){
        NSLog(@"广告结束后，执行事件");
    }];
    
}
-(void)IanAdsStartPost{
    //1.创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    NSString *process = [NSString stringWithFormat:@"fanbuyhainan%@",timeString];
    NSString *pro= [MD5Sign MD5:process];
    
    NSString *string = [NSString stringWithFormat:@"http://103.27.7.20/api/users/get_open_ad"];
    
    //server=formal&client=user_ios&timestamp=%@&process=%@&token=%@
    NSURL *url=[NSURL URLWithString:string];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    //    NSLog(@"POST-Header:%@",request.allHTTPHeaderFields);
    //formal    text
    NSString *dict = [NSString stringWithFormat:@""];
    
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
                NSString *video_url = [NSString stringWithFormat:@"%@",dic[@"data"][@"video_url"]];
                if ([video_url isEqualToString:@""]) {
                    NSString *ad_pic = [NSString stringWithFormat:@"%@",dic[@"data"][@"ad_pic"]];
                    
                    if ([PublicMethods isUrl:ad_pic]) {
                        
                    }else{
                        ad_pic = [NSString stringWithFormat:@"%@%@",FBHApi_Url,ad_pic];
                    }
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 第一次先下载广告
                            [IanAdsStartView downloadStartImage:ad_pic];
                            
                            [PublicMethods writeToUserD:ad_pic andKey:@"ad_pic_URL"];
                            
                        });
                        
                        
                    });
                }else{
                    
                }
                
                
            }else{
                
            }
            
            
        }
        
        
        
    }];
    //7.执行任务
    [dataTask resume];
}
#pragma mark - /** 引导页 */
- (void)setGuideView
{
    /**
     * https://github.com/potato512/SYGuideView
     **/
    // 首次使用，显示引导页：使用默认按钮，且放大淡化
    // 判断是否首次使用
    BOOL isFirstUsing = SYGuideView.readAppStatus;
    if (!isFirstUsing)
    {
        // 非首次使用
        
        // 保存首次使用的状态
        [SYGuideView saveAppStatus];
        
        // 实例化引导页
        NSArray *images = @[@"guideImage_1", @"guideImage_2", @"guideImage_3"];


        SYGuideView *guideView = [[SYGuideView alloc] initWithImages:images];
        guideView.buttonClick = ^(){

        };
        
        
    }else{
         NSString *url = [PublicMethods readFromUserD:@"ad_pic_URL"];
        if ([url isEqualToString:@""]) {
            
        }else{
            [self IanAdsStart:url];
        }

    }
    
    
}
#pragma mark - 服务器维护展示
-(void)status:(NSString *)textString{
    StopTheService *samView = [[StopTheService alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
}
#pragma mark - 系统（声音、震动）
- (void)shakeText:(UIButton *)sender {
    SoundControlSingle * single = [SoundControlSingle sharedInstanceForVibrate];
//    SoundControlSingle * single1 = [SoundControlSingle sharedInstanceForSound];
    NSString * shake = [PublicMethods readFromUserD:@"isShakeOpen"];
//    NSString * Sound = [PublicMethods readFromUserD:@"isSoundOpen"];
    if ([shake isEqualToString:@"NO"]) {
        
    }else{
        [single play];
    }
//    if ([Sound isEqualToString:@"NO"]) {
//
//    }else{
//        [single1 play];
//    }
    
}
#pragma mark - 极光
- (void)setJPush:(NSDictionary*)launchOptions{
    
    
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:kAppKey_JPush
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:advertisingId];
    

    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        if (resCode == 0) {
            // [USERDEFAULT setValue:registrationID forKey:kJPushRegistrationID];
            // [USERDEFAULT synchronize];
        }else {
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
#pragma mark - 添加标签
    [JPUSHService setTags:[NSSet setWithObject:@""] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSLog(@"添加标签  ：%tu,%@,%tu",iResCode,iTags,seq);
        
         } seq:0];
    

}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark【 JPUSHRegisterDelegate 】
// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}
#pragma mark - 在前台推送处理
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
//    [UIApplication sharedApplication].applicationState == UIApplicationStateActive
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
//    NSLog(@"userInfo111:%@\n%@\n%@\n%@",userInfo,userInfo[@"title"],userInfo[@"content"],userInfo[@"extras"]);

    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        
    }else{
        
    }

    
    
    
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    

    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            // 程序运行时收到通知，先弹出消息框
            NSLog(@"程序在前台");
        }else{
            // 跳转到指定页面
            // 这里也可以发送个通知,跳转到指定页面
            [self goToMssageViewControllerWith:userInfo];
        }
    }
    completionHandler();  // 系统要求执行这个方法
    

}
#pragma mark - 在后台推送处理
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
- (void)application:(UIApplication *)application didReceiveRemoteNotification: (NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED
{
//    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
//        // 程序运行时收到通知，先弹出消息框
//        NSLog(@"程序在前台");
//        return;
//    }
//    [self Speaking];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"list_new" object:@""];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"conversion" object:@""];

    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@" 传过来的值 ；%@",userInfo);
#pragma mark -- 判断订单
//    NSString *yu = [[NSString alloc]init];
    NSString *type = userInfo[@"type"];
    /*1、推送信息b判断、是否是订单*/
    if([type isEqualToString:@"get_paid_order"]){
        NSDictionary *dict =  userInfo[@"txt"];
        NSString * isbluetooth = [PublicMethods readFromUserD:@"isbluetooth"];
        /*2、打印信息判断、是否开启*/
        if ([isbluetooth isEqualToString:@"NO"]) {
            NSLog(@"没开启打印机连接开关!");
        }else{
            if (self.manage.stage != JWScanStageCharacteristics) {
                [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
                    if (!error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                        });
                    }else{
                        
                    }
                }];

            }else{
                [self printe:dict];

            }
            
        }
        
        /*3、语言判断、是否开启*/
        NSString * shake = [PublicMethods readFromUserD:@"isShakeOpen"];
        self.aVSpeechSynthesizer = [[AVSpeechSynthesizer alloc] init];

        if ([shake isEqualToString:@"NO"]) {
            NSLog(@"没开启语言开关!");

        }else{

//            double i = [dict[@"actual_money"] doubleValue];
//            double j = [dict[@"service_money"] doubleValue];
//            double qian = i - j;
            NSString * jinEr=[NSString stringWithFormat:@"您有新的一鹿省订单,请及时处理!"];
            AVSpeechUtterance * aVSpeechUtterance = [[AVSpeechUtterance alloc] initWithString:jinEr];
            
            aVSpeechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate;
            aVSpeechUtterance.volume = 1;
            aVSpeechUtterance.voice =[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
            
            
            [self.aVSpeechSynthesizer speakUtterance:aVSpeechUtterance];
        }
        
    }else{
        
//        yu = [NSString stringWithFormat:@"%@",dict[@"alert"]];
        
    }
    /*系统震动*/
    [self shakeText:nil];


    
}



- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(9_0) {
    

    if ([identifier isEqualToString:@"comment-reply"]) {
 
        NSString *response = responseInfo[UIUserNotificationActionResponseTypedTextKey];
        //对输入的文字作处理
    }
    completionHandler();
}

- (void)goToMssageViewControllerWith:(NSDictionary*)userInfo {
    // 用于处理点击消息跳转某个界面
}

#pragma mark - 打印
- (void)printe:(NSDictionary *)Dict{

#pragma mark - 打印小票的样式排版
    
    
    JWPrinter *printer = [[JWPrinter alloc] init];
    [printer appendNewLine];
    [printer appendText:@"一鹿省商家小票" alignment:HLTextAlignmentLeft];
    [printer appendNewLine];
    [printer appendSeperatorLine];
    [printer appendNewLine];
    NSString *table_number = [NSString stringWithFormat:@"%@",Dict[@"table_number"]];
    if ([[MethodCommon judgeStringIsNull:table_number] isEqualToString:@""]) {
        table_number = @"#";
    }
    [printer appendText:[NSString stringWithFormat:@"桌号：%@",table_number] alignment:HLTextAlignmentCenter fontSize:0x11];
    [printer appendText:[NSString stringWithFormat:@"*%@*",Dict[@"store_name"]] alignment:HLTextAlignmentCenter];
    [printer appendSeperatorLine];
    [printer appendText:[NSString stringWithFormat:@"序号:#%@ ",Dict[@"sort"]] alignment:HLTextAlignmentCenter fontSize:0x11];
    [printer appendSeperatorLine];
    NSString *Time = [NSString stringWithFormat:@"%@",Dict[@"add_time_full"]];
    NSArray *TimeArray = [Time componentsSeparatedByString:@" "];
    [printer appendTitle:[NSString stringWithFormat:@"下单时间：%@",TimeArray[0]] value:@"人数"];
    [printer appendTitle:[NSString stringWithFormat:@"%@",TimeArray[1]] value:[NSString stringWithFormat:@"%@",Dict[@"people_count"]] fontSize:0x11];
    [printer appendText:@"*******************************" alignment:HLTextAlignmentCenter];
    //    [printer appendSeperator_xing];
    [printer appendText:@"-----------订单信息-----------" alignment:HLTextAlignmentCenter];
    [printer appendNewLine];
    [printer appendLeftText:@"名称" middleText:@"单价" rightText:@"数量" isTitle:YES];
    NSArray *goodsArr = Dict[@"goods_info"];
    for (int i =0; i<goodsArr.count; i++) {
        NSString *name = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
        NSString *price = [NSString stringWithFormat:@"%@ ",goodsArr[i][@"goods_price"]];
        NSString *num =  [NSString stringWithFormat:@" x%@",goodsArr[i][@"goods_num"]];
        [printer YLSappendLeftText:name  alignment:HLTextAlignmentLeft fontSize:0x03 isTitle:NO];
        [printer setOffset:230];
        [printer YLSappendLeftText:price  alignment:HLTextAlignmentLeft fontSize:0x00 isTitle:NO];
        [printer setOffset:320 ];
        [printer YLSappendLeftText:num alignment:HLTextAlignmentLeft  fontSize:0x00 isTitle:YES];
    }
    [printer appendNewLine];
    [printer appendSeperatorLine];
    [printer appendTitle:@"门店金额：" value:Dict[@"account_money"]];
    [printer appendTitle:@"服务费用：" value:Dict[@"service_money"]];
    [printer appendTitle:@"本单节省：" value:Dict[@"save_money"]];
    [printer appendTitle:@"用户实付：" value:[NSString stringWithFormat:@"%@",Dict[@"actual_money"]]];
    [printer appendSeperatorLine];
    double i = [Dict[@"actual_money"] doubleValue];
    double j = [Dict[@"service_money"] doubleValue];
    double qian = i - j;
    //    [printer YLSappendLeftText:@"商家实收："  alignment:HLTextAlignmentLeft fontSize:10 isTitle:NO];
    //    [printer setOffset:270];
    //    [printer YLSappendLeftText:[NSString stringWithFormat:@"%.2f",qian]  alignment:HLTextAlignmentRight fontSize:20 isTitle:YES];
    [printer appendTitle:@"商家实收：" value:[NSString stringWithFormat:@"%.2f",qian] fontSize:0x01];
    [printer appendSeperatorLine];
    [printer appendNewLine];
    [printer appendText:[NSString stringWithFormat:@"备注：%@",Dict[@"remark"]] alignment:HLTextAlignmentLeft fontSize:0x01];
    [printer appendText:@"*******************************" alignment:HLTextAlignmentCenter];
    [printer appendText:@"-----------其他信息-----------" alignment:HLTextAlignmentCenter];
    [printer appendText:[NSString stringWithFormat:@"消费地址：%@",Dict[@"store_address"]] alignment:HLTextAlignmentLeft];
    NSString *phon = [NSString stringWithFormat:@"%@",Dict[@"user_info"][@"mobile"]];
    NSString *string = [NSString new];
    if ([[MethodCommon judgeStringIsNull:phon] isEqualToString:@""]) {
        phon = @"";
    }else{
        string = [phon stringByReplacingOccurrencesOfString:[phon substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    }
    NSString *UserString = [NSString stringWithFormat:@"%@(%@)",Dict[@"user_info"][@"user_name"],Dict[@"user_info"][@"sex"]];
    [printer appendText:[NSString stringWithFormat:@"用户信息：%@",UserString] alignment:HLTextAlignmentLeft];
    [printer appendText:[NSString stringWithFormat:@"用户号码：%@",string] alignment:HLTextAlignmentLeft];
    [printer appendText:[NSString stringWithFormat:@"订单编号：%@",Dict[@"order_sn"]] alignment:HLTextAlignmentLeft];
    NSString *paid = [NSString new];
    NSString *pid = [NSString stringWithFormat:@"%@",Dict[@"paid_type"]];
    if ([pid isEqualToString:@"4"]) {
        paid = @"余额支付";
    }else if ([pid isEqualToString:@"1"]){
        paid = @"支付宝支付";
    }else if ([pid isEqualToString:@"2"]){
        paid = @"微信支付";
    }else{
        paid = @"银行卡快捷支付";
    }
    [printer appendText:[NSString stringWithFormat:@"交易类型：%@",paid] alignment:HLTextAlignmentLeft];
    [printer appendSeperatorLine];
    [printer appendNewLine];
    [printer appendText:@"感谢使用一鹿省，祝您生活愉快!\n下载一鹿省app全国走到哪省到哪" alignment:HLTextAlignmentCenter fontSize:0x00];
    [printer appendNewLine];
    [printer appendNewLine];
    [printer appendNewLine];
    
    
    
    
    NSData *mainData = [printer getFinalData];
    
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
            if (self.manage.stage != JWScanStageCharacteristics) {
                [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
                    if (!error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                        });
                    }else{
                        
                    }
                }];
            }
//            [self printe:Dict];
            
        }
        
    }];
    
    
}




+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}



#pragma mark -  当前顶层控制器

-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}
@end
