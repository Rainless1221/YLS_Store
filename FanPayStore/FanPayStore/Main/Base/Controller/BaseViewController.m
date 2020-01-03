//
//  BaseViewController.m
//  FanBeiHua
//
//  Created by 苹果笔记本 on 2019/2/19.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<AVAudioPlayerDelegate>
{
    NSInteger viewCtrlCount;//控制器个数
}

@property (strong,nonatomic)AVAudioPlayer * audioPlayer;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self get_completion_ysepay_mer_info];

    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.view.backgroundColor = UIColorFromRGB(0xF6F6F6);
    //返回按钮
//    [self setNavigationBackButton];
    self.manage = [JWBluetoothManage sharedInstance];


    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icn_nav_back_black_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    //隐藏默认的返回箭头
    self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];

    //系统声音震动初始化
    self.isShakeOpen = YES;
    self.isSoundOpen = YES;
    self.isProjectSoundOpen = YES;
    self.isRemindOpen =  YES;

    //打印
    self.manage = [JWBluetoothManage sharedInstance];

    /*打印开关的状态*/
    [self isBluetooth];
    
    
//    后台播放音乐
//    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(dispatchQueue, ^(void) {
//        NSError *audioSessionError = nil;
//        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//        if ([audioSession setCategory:AVAudioSessionCategoryPlayback error:&audioSessionError]){
//            NSLog(@"Successfully set the audio session.");
//        } else {
//            NSLog(@"Could not set the audio session");
//        }
//
//
//        NSBundle *mainBundle = [NSBundle mainBundle];
//        NSString *filePath = [mainBundle pathForResource:@"叮咚，您有新的订单请及时处理" ofType:@"mp3"];
//        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
//        NSError *error = nil;
//
//        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
//
//        if (self.audioPlayer != nil){
//            self.audioPlayer.delegate = self;
//
//            [self.audioPlayer setNumberOfLoops:-1];
//            if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]){
//                NSLog(@"Successfully started playing...");
//            } else {
//                NSLog(@"Failed to play.");
//            }
//        } else {
//
//        }
//    });
    
    /*最新版本*/
    [self get_mer_version_info];
    
}

-(void)setNavigationBackButton{
    //设置添加按钮的条件
    NSArray *viewCtrls = self.navigationController.viewControllers;
    viewCtrlCount = viewCtrls.count;
    if (viewCtrlCount > 1){
        //
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"1"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:nil
                                                                   action:nil];
        self.navigationController.navigationBar.tintColor =
        [UIColor colorWithRed:0.99 green:0.50 blue:0.09 alpha:1.00];
        //主要是以下两个图片设置
        self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"icn_nav_back_black_normal"];
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"icn_nav_back_black_normal"];
        self.navigationItem.backBarButtonItem = backItem;
    }
}
#pragma mark 【 Click Action 】
//返回按钮的点击事件
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  懒加载UITableView
 *
 *  @return UITableView
 */
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 44 - 20) style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        //头部刷新
//        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
//        header.automaticallyChangeAlpha = YES;
//        header.lastUpdatedTimeLabel.hidden = YES;
//        _tableView.header = header;
        
        //底部刷新
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
        _tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
        
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.scrollsToTop = YES;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
-(void)footerRereshing{
    
}
#pragma mark - 键盘回收
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 退出登录
-(void)Exit_log{
    
    FBHLogInController *tabBarCtr = [[FBHLogInController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtr;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    [UserModel clearUserData];
    [insert_storeM clearUserData];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode == 0) {
            NSLog(@"删除别名成功");
        }
    } seq:1];
    
}
#pragma mark - 震动测试
- (void)shakeText:(UIButton *)sender {
    SoundControlSingle * single = [SoundControlSingle sharedInstanceForVibrate];
    if (self.isShakeOpen) {
        [single play];
    }else{
        
    }
    
}
#pragma mark -声音测试
- (void)soundText:(UIButton *)sender {
    SoundControlSingle * single1 = [SoundControlSingle sharedInstanceForSound];//获取声音对象
//    SoundControlSingle * single2 = [SoundControlSingle sharedInstanceForProjectSound];//获取自定义声音对象
//    if (self.isSoundOpen) {//声音控制打开----可以播放声音
//        if (self.isProjectSoundOpen) {//播放自定义的声音
//            [single2 play];//播放
//        } else {//播放系统的声音
//            [single1 play];//播放
//        }
//    }
    //    if (self.isProjectSoundOpen) {//如果播放自定义提示音的开关是打开的
    //        [single2 play];//播放
    //        return;
    //    }
        if (self.isSoundOpen) {//播放提示音的开关是打开的
            [single1 play];//播放
        }
}
#pragma mark - 密码判断
- (NSString *)isOrNoPasswordStyle:(NSString *)passWordName
{
    
    NSString * message;
    
//    if (passWordName.length<6 message = "@'密码不能少于6位，请您重新输入';" else="" if="" passwordname="" length="">18)
//
//    {
//
//        message = @"密码最大长度为18位，请您重新输入";
//
//    }
    
     if ([self JudgeTheillegalCharacter:passWordName])
        
    {
        
        message = @"密码不能包含特殊字符，请您重新输入";
        
    }
    
    else if (![self judgePassWordLegal:passWordName])
        
    {
        
        message = @"密码必须同时包含字母和数字";
        
    }
    
    return message;
    
}

- (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    
    //提示标签不能输入特殊字符
    
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    if (![emailTest evaluateWithObject:content]) {
        
        return YES;
        
    }
    
    return NO;
    
}

//- (BOOL)judgePassWordLegal:(NSString *)pass{
//
//    BOOL result ;
//
//    // 判断长度大于6位后再接着判断是否同时包含数字和大小写字母
//
//    NSString * regex =@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
//
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//
//    result = [pred evaluateWithObject:pass];
//
//    NSLog(@"%hhd",result);
//
//    return result;
//
//}
#pragma mark - 密码的  大小写数字判断
- (BOOL)judgePassWordLegal:(NSString *)pass {
    
    // 验证密码长度
    if(pass.length < 6 || pass.length > 16) {
        NSLog(@"请输入6-16的密码");
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入6-16的密码"];
        return NO;
    }
    
    // 验证密码是否包含数字
    NSString *numPattern = @".*\\d+.*";
    NSPredicate *numPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numPattern];
    if (![numPred evaluateWithObject:pass]) {
        NSLog(@"密码必须包含数字");
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码必须包含数字"];
        return NO;
    }
    
    // 验证密码是否包含小写字母
    NSString *lowerPattern = @".*[a-z]+.*";
    NSPredicate *lowerPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lowerPattern];
    if (![lowerPred evaluateWithObject:pass]) {
        NSLog(@"密码必须包含小写字母");
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码必须包含小写字母"];
        return NO;
    }
    
    // 验证密码是否包含大写字母
    NSString *upperPattern = @".*[A-Z]+.*";
    NSPredicate *upperPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", upperPattern];
    if (![upperPred evaluateWithObject:pass]) {
        NSLog(@"密码必须包含大写字母");
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码必须包含大写字母"];
        return NO;
    }
    return YES;
}
#pragma mark - 提现账户信息完成情况
-(void)get_completion_ysepay_mer_info{
    
    
    UserModel *model = [UserModel getUseData];
    
    
    [[FBHAppViewModel shareViewModel]get_completion_ysepay_mer_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            
            NSString *sting = [NSString stringWithFormat:@"%@",DIC[@"status"]];
            NSString *sting_cust_type = [NSString stringWithFormat:@"%@",DIC[@"cust_type"]];
            
            if ([[MethodCommon judgeStringIsNull:sting] isEqualToString:@""]) {
                self.status_With = 4;
                self.cust_type_with = 4;
            }else{
                self.status_With = [sting integerValue];
                self.cust_type_with = [sting_cust_type integerValue];
            }

        }else{
//            [SVProgressHUD setMinimumDismissTimeInterval:2];
//            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            
        }
        
    } andfailure:^{
        
        
    }];
    
    
    
}
#pragma mark -打印开关状态
-(void)isBluetooth{
    storeBaseModel *model = [storeBaseModel getUseData];
    if ([model.open_status isEqualToString:@"2"]) {
        [PublicMethods writeToUserD:@"NO" andKey:@"isbluetooth"];
    }else if([model.open_status isEqualToString:@"1"]) {
        [PublicMethods writeToUserD:@"YES" andKey:@"isbluetooth"];
    }else{
        
    }
    
    
    if ([model.choice_printer isEqualToString:@"1"]) {

        [PublicMethods writeToUserD:@"1" andKey:@"YunLanSound"];

    }else if([model.choice_printer isEqualToString:@"2"]) {

        [PublicMethods writeToUserD:@"2" andKey:@"YunLanSound"];

    }else{

        
    }
}

#pragma mark - 打印小票
-(void)JWPrinter_Printer:(NSDictionary *)Dict{
    
    
    JWPrinter *printer = [[JWPrinter alloc] init];
//    [printer appendNewLine];
    [printer appendText:@"一鹿省商家小票" alignment:HLTextAlignmentLeft];
//    [printer appendNewLine];
//    [printer appendSeperatorLine];
    [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
    NSString *table_number = [NSString stringWithFormat:@"%@",Dict[@"table_number"]];
    if ([[MethodCommon judgeStringIsNull:table_number] isEqualToString:@""]) {
        table_number = @"#";
    }
    [printer appendText:[NSString stringWithFormat:@"桌号：%@",table_number] alignment:HLTextAlignmentCenter fontSize:0x11];
    [printer appendText:[NSString stringWithFormat:@"*%@*",Dict[@"store_name"]] alignment:HLTextAlignmentCenter];
//    [printer appendSeperatorLine];
    [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
    [printer appendText:[NSString stringWithFormat:@"序号:#%@ ",Dict[@"sort"]] alignment:HLTextAlignmentCenter fontSize:0x11];
//    [printer appendSeperatorLine];
    [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
    NSString *Time = [NSString stringWithFormat:@"%@",Dict[@"add_time_full"]];
    NSArray *TimeArray = [Time componentsSeparatedByString:@" "];
    [printer appendTitle:[NSString stringWithFormat:@"下单时间：%@",TimeArray[0]] value:@"人数"];
    [printer appendTitle:[NSString stringWithFormat:@"%@",TimeArray[1]] value:[NSString stringWithFormat:@"%@",Dict[@"people_count"]] fontSize:0x11];
    [printer appendText:@"*******************************" alignment:HLTextAlignmentCenter];
//    [printer appendSeperator_xing];
    [printer appendText:@"-----------订单信息-----------" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
    [printer appendLeftText:@"名称" middleText:@"单价" rightText:@"数量" isTitle:YES];
    NSArray *goodsArr = Dict[@"goods_info"];
    for (int i =0; i<goodsArr.count; i++) {
        NSString *name = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
        NSString *goods_attributes = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_attributes"]];
        if ([[MethodCommon judgeStringIsNull:goods_attributes] isEqualToString:@""]) {
            
        }else{
            goods_attributes = [NSString stringWithFormat:@"(%@)",goods_attributes];
        }
        NSString *price = [NSString stringWithFormat:@"%@ ",goodsArr[i][@"goods_price"]];
        NSString *num =  [NSString stringWithFormat:@" x%@",goodsArr[i][@"goods_num"]];
        [printer YLSappendLeftText:[NSString stringWithFormat:@"%@%@",name,goods_attributes]  alignment:HLTextAlignmentLeft fontSize:0x03 isTitle:NO];
        [printer setOffset:240];
        [printer YLSappendLeftText:price  alignment:HLTextAlignmentLeft fontSize:0x00 isTitle:NO];
        [printer setOffset:320 ];
        [printer YLSappendLeftText:num alignment:HLTextAlignmentLeft  fontSize:0x00 isTitle:YES];
    }
//    [printer appendNewLine];
    [printer appendSeperatorLine];
    [printer appendTitle:@"门店金额：" value:Dict[@"account_money"]];
//    [printer appendTitle:@"服务费用：" value:Dict[@"service_money"]];
    [printer appendTitle:@"平台金额：" value:Dict[@"plat_price"]];
    [printer appendTitle:@"本单节省：" value:Dict[@"save_money"]];
//    [printer appendTitle:@"用户实付：" value:[NSString stringWithFormat:@"%@",Dict[@"actual_money"]]];
//    [printer appendSeperatorLine];
    [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
//    double i = [Dict[@"actual_money"] doubleValue];
//    double j = [Dict[@"service_money"] doubleValue];
//    double qian = i - j;
    //    [printer YLSappendLeftText:@"商家实收："  alignment:HLTextAlignmentLeft fontSize:10 isTitle:NO];
    //    [printer setOffset:270];
    //    [printer YLSappendLeftText:[NSString stringWithFormat:@"%.2f",qian]  alignment:HLTextAlignmentRight fontSize:20 isTitle:YES];
    [printer appendTitle:@"实付金额：" value:[NSString stringWithFormat:@"%@",Dict[@"actual_money"]] fontSize:0x01];
//    [printer appendSeperatorLine];
     [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
    [printer appendText:[NSString stringWithFormat:@"备注：%@",Dict[@"remark"]] alignment:HLTextAlignmentLeft fontSize:0x01];
    [printer appendText:@"*******************************" alignment:HLTextAlignmentCenter];
    [printer appendText:@"-----------其他信息-----------" alignment:HLTextAlignmentCenter];
//    [printer appendText:[NSString stringWithFormat:@"消费地址：%@",Dict[@"store_address"]] alignment:HLTextAlignmentLeft];
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
//    [printer appendNewLine];
    [printer appendText:@"感谢使用一鹿省，祝您生活愉快!\n下载一鹿省app全国走到哪省到哪" alignment:HLTextAlignmentCenter fontSize:0x00];
//    [printer appendNewLine];
//    [printer appendNewLine];
//    [printer appendNewLine];
    
    
    
    
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
    
}
#pragma mark - 获取应用在 appStore的信息
-(void)lookup{
    
    NSString *urlString = @"http://itunes.apple.com/lookup?id=1465861059";
    //自己应用在App Store里的地址
    NSURL *url = [NSURL URLWithString:urlString];
    //这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。
    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    //    解析json数据
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = json[@"results"];
    for (NSDictionary *dic in array) {
        NSString *newVersion = [dic valueForKey:@"version"];// appStore 的版本号
        NSLog(@"appStore 的版本号 :%@",newVersion);
        NSLog(@"appStore 的版本信息 :%@",dic);
        //        self.banben.text = [NSString stringWithFormat:@"v%@",newVersion];
        
        /**
         * 本地版本
         */
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"当前应用软件版本:%@",appCurVersion);
        
        /**
         版本更新内容
         */
        NSString *title = [NSString stringWithFormat:@"%@",[dic valueForKey:@"releaseNotes"]];
        
        if (newVersion == appCurVersion) {
            [SVProgressHUD showSuccessWithStatus:@"目前已是最新版本"];
        }else{
            
            [[WMZAlert shareInstance]showAlertWithType:AlertTypeNornal sueprVC:self leftTitle:@"前往更新" rightTitle:@"下次提示" headTitle:@"商户端最新版本" textTitle:title headTitleColor:[UIColor blackColor] textTitleColor:[UIColor blackColor] backColor:[UIColor whiteColor] okBtnColor:UIColorFromRGB(0x3D8AFF) cancelBtnColor:UIColorFromRGB(0x3D8AFF) leftHandle:^(id anyID) {
                NSString *url = [dic valueForKey:@"trackViewUrl"];
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
            } rightHandle:^(id anyID) {
                
            }];
            
        }
        
        
    }
    
    
}
#pragma mark - 获取当前版本信息 商户端
-(void)get_mer_version_info{
    UserModel *Model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_mer_version_info:Model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
//            NSDictionary *DIC=resDic[@"data"];
        }
        
    } andfailure:^{
        
    }];
}
@end
