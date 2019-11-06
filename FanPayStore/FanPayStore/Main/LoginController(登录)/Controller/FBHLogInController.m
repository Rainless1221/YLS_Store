//
//  FBHLogInController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHLogInController.h"

@interface FBHLogInController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *kuaijieBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhanghuiBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;//登录
@property (weak, nonatomic) IBOutlet UIView *kuaijeView;
@property (weak, nonatomic) IBOutlet UIView *zhanghuiView;
@property (weak, nonatomic) IBOutlet UIView *hengxian;
@property (weak, nonatomic) IBOutlet UITextField *Phone1;
@property (weak, nonatomic) IBOutlet UITextField *Pass;
@property (weak, nonatomic) IBOutlet UITextField *Phone2;
@property (weak, nonatomic) IBOutlet UITextField *yanzheng;
@property (weak, nonatomic) IBOutlet UIButton *MSMButton;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIButton *WangjiButton;

@property (assign,nonatomic)BOOL isMVM;

@end

@implementation FBHLogInController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
    [self setupNav];
    [self createUI];
    
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    NSMutableString *tmpResult = result.mutableCopy;
    // 去除“-”
    NSRange range = [tmpResult rangeOfString:@"-"];
    while (range.location != NSNotFound) {
        [tmpResult deleteCharactersInRange:range];
        range = [tmpResult rangeOfString:@"-"];
    }
    NSLog(@"UUID:%@",tmpResult);
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    [self.view addSubview:NavView];
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(NavView.width-88, STATUS_BAR_HEIGHT, 80, 40)];
    [leftbutton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftbutton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:leftbutton];
    
}
#pragma mark - 注册
-(void)RighAction{
//    FBHregisteredViewController *VC = [FBHregisteredViewController new];
    YLSRegisteredController *VC = [YLSRegisteredController new];
    BaseNavigationController *Nav = [[BaseNavigationController alloc]initWithRootViewController:VC];
    Nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:Nav animated:YES completion:nil];

}
#pragma mark - UI
-(void)createUI{
    //    self.loginButton.userInteractionEnabled = NO;
    /** 快捷登录 **/
    self.kuaijieBtn.frame = CGRectMake(40, 185+(kIs_iPhoneX ? 25:0), 70, 40);
    /** 登录 **/
    self.zhanghuiBtn.frame = CGRectMake(self.kuaijieBtn.right + 33, 185+(kIs_iPhoneX ? 25:0), 70, 40);
    //横线
    self.hengxian.frame = CGRectMake(self.kuaijieBtn.centerX - 15, self.kuaijieBtn.centerY+(30), 30, 2);
    
    //登录方式
    self.kuaijieBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.zhanghuiBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    //快捷部分
    self.kuaijeView.frame = CGRectMake(0, self.kuaijieBtn.bottom +(kIs_iPhoneX ? 30:0), ScreenW, 150);
    self.kuaijeView.backgroundColor = [UIColor clearColor];
    self.Phone2.frame = CGRectMake(50, 20, self.kuaijeView.width-100, 35);
    self.line1.frame = CGRectMake(45, self.Phone2.bottom+10, self.zhanghuiView.width-90, 1);
    
    self.yanzheng.frame = CGRectMake(50, self.line1.bottom+10, self.kuaijeView.width-190, 35);
    self.MSMButton.frame = CGRectMake(self.yanzheng.right+10, self.line1.bottom+10, 85, 29);
    self.MSMButton.centerY = self.yanzheng.centerY;
    self.line2.frame = CGRectMake(45, self.line1.bottom+50, self.zhanghuiView.width-160, 1);
    self.line1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.line2.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.MSMButton.layer.borderColor = [UIColorFromRGB(0xF7AE2B) CGColor];
    
    //账号部分
    self.zhanghuiView.frame = CGRectMake(0, self.kuaijieBtn.bottom +(kIs_iPhoneX ? 30:0), ScreenW, 150);
    self.zhanghuiView.backgroundColor = [UIColor clearColor];
    self.zhanghuiView.hidden = YES;
    self.Phone1.frame = CGRectMake(50, 20, self.zhanghuiView.width-100, 35);
    self.line3.frame = CGRectMake(45, self.Phone1.bottom+10, self.kuaijeView.width-90, 1);
    
    self.Pass.frame = CGRectMake(50, self.line3.bottom+10, self.zhanghuiView.width-100, 35);
    self.line4.frame = CGRectMake(45, self.line3.bottom+50, self.kuaijeView.width-90, 1);
    self.line3.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.line4.backgroundColor = UIColorFromRGB(0xEAEAEA);
    
    
    
#pragma mark - 登录按钮
    self.loginButton.frame = CGRectMake(48, self.kuaijieBtn.bottom + 170, ScreenW-96, 44);
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0,0,ScreenW-96,44);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(0.5),@(1.0)];
//    gl.cornerRadius = 10;
//    [self.loginButton.layer addSublayer:gl];
    
//    self.loginButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//    self.loginButton.layer.shadowOffset = CGSizeMake(0,4);
//    self.loginButton.layer.shadowOpacity = 1;
//    self.loginButton.layer.shadowRadius = 9;
    
    self.loginButton.layer.cornerRadius = 10;
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    
#pragma mark -- 忘记密码按钮
    self.WangjiButton.frame = CGRectMake(0, self.loginButton.bottom +12, 85, 15);
    self.WangjiButton.right = self.loginButton.right;
    
    self.hengxian.centerY = self.kuaijieBtn.bottom;
    self.hengxian.centerX = self.kuaijieBtn.centerX;
    
    self.Phone1.keyboardType = UIKeyboardTypePhonePad;
    self.Phone2.keyboardType = UIKeyboardTypePhonePad;
    self.yanzheng.keyboardType = UIKeyboardTypePhonePad;
    
    self.Phone1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.Phone2.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.yanzheng.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.Pass.clearButtonMode = UITextFieldViewModeWhileEditing;

    
    self.Phone1.delegate= self;
    self.Phone2.delegate= self;
    self.Pass.delegate= self;
    self.yanzheng.delegate= self;
    [self.Phone1 addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    [self.Phone2 addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    [self.Pass addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    [self.yanzheng addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
}
- (void)myNameStarAction:(UITextField *)textField
{
    if (textField == self.Phone1) {
        self.line3.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }else if (textField == self.yanzheng){
        self.line2.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }else if (textField == self.Pass){
        self.line4.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }else{
        self.line1.backgroundColor = UIColorFromRGB(0xF7AE2B);
        
    }
}
// 失去焦点
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.line1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.line2.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.line3.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.line4.backgroundColor = UIColorFromRGB(0xEAEAEA);
    
}
//快捷
- (IBAction)kuaijieAction:(id)sender {
    self.isMVM = NO;
    self.hengxian.centerY = self.kuaijieBtn.bottom;
    self.hengxian.centerX = self.kuaijieBtn.centerX;
    self.kuaijieBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.zhanghuiBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.zhanghuiView.hidden = YES;
    self.kuaijeView.hidden = NO;
    
    [self.Phone2 becomeFirstResponder];
}
//帐号
- (IBAction)zhanghuiAction:(id)sender {
    self.isMVM = YES;
    self.hengxian.centerY = self.zhanghuiBtn.bottom;
    self.hengxian.centerX = self.zhanghuiBtn.centerX;
    self.kuaijieBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.zhanghuiBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.zhanghuiView.hidden = NO;
    self.kuaijeView.hidden = YES;
    
    [self.Phone1 becomeFirstResponder];
    
}
//短信
- (IBAction)MSMAction:(id)sender {
    
    if (self.Phone2.text==nil||self.Phone2.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    
    [[FBHAppViewModel shareViewModel] geTcaptchaWithphone:self.Phone2.text andtype:@"2" Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            [self countDownWithTime];
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}
#pragma mark - 用户登录
- (IBAction)LoginAction:(id)sender {
    
    
    
    if (self.isMVM) {
        if (self.Phone1.text==nil||self.Phone1.text.length==0) {
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
            return ;
        }
        
        [MBProgressHUD MBProgress:@"正在登录中..."];
        
        [[FBHAppViewModel shareViewModel] userloginWithphone:self.Phone1.text andcaptcha:self.Pass.text Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
                NSDictionary *DIC=resDic[@"data"];
                UserModel *model=[UserModel mj_objectWithKeyValues:DIC];
                
                //保存用户信息
                [model saveUserData];
                [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
#pragma mark - 客服中心
                QYUserInfo *user = [QYUserInfo new];
                user.userId =model.merchant_id;
                user.data = [NSString stringWithFormat:@"[{\"key\":\"real_name\", \"value\":\"商家%@\"},{\"key\":\"mobile_phone\", \"value\":%@},{\"index\":0, \"key\":\"account\", \"label\":\"设备端\", \"value\":\"苹果手机\", }]",model.mobile,model.mobile];
                
//                @"[{\"key\":\"real_name\", \"value\":\"土豪\"},"
//                "{\"key\":\"mobile_phone\", \"hidden\":true},"
//                "{\"key\":\"email\", \"value\":\"13800000000@163.com\"},"
//                "{\"index\":0, \"key\":\"account\", \"label\":\"账号\", \"value\":\"zhangsan\", \"href\":\"http://example.domain/user/zhangsan\"},"
//                "{\"index\":1, \"key\":\"sex\", \"label\":\"性别\", \"value\":\"先生\"},"
//                "{\"index\":5, \"key\":\"reg_date\", \"label\":\"注册日期\", \"value\":\"2015-11-16\"},"
//                "{\"index\":6, \"key\":\"last_login\", \"label\":\"上次登录时间\", \"value\":\"2015-12-22 15:38:54\"}]";
                
                

                [[QYSDK sharedSDK] setUserInfo:user authTokenVerificationResultBlock:^(BOOL isSuccess) {
                    
                }];
                //暂时后退
//                [self.navigationController popViewControllerAnimated:YES];
                
                
                NSString *tagS = [NSString stringWithFormat:@"%@",model.merchant_id];
                [JPUSHService setAlias:tagS completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    
                    if (iResCode == 0) {//对应的状态码返回为0，代表成功
                        NSLog(@"成功");
                        
                    }
                    
                } seq:1];
                
                
                BaseTabBarController *vc = [BaseTabBarController new];
//                [self presentViewController:vc animated:YES completion:nil];
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                app.window.rootViewController = vc;
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            [MBProgressHUD hideHUD];
        } andfailure:^{
            [MBProgressHUD hideHUD];
            
        }];
    }else{
        if (self.Phone2.text==nil||self.Phone2.text.length == 0) {
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
            return ;
        }
        
        [SVProgressHUD showWithStatus:@"正在登录中..."];
        [[FBHAppViewModel shareViewModel]userloginWithphone:self.Phone2.text andCodecaptcha:self.yanzheng.text Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
                NSDictionary *DIC=resDic[@"data"];
                UserModel *model=[UserModel mj_objectWithKeyValues:DIC];
                
                
                //                YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
                
                //保存用户信息
                [model saveUserData];
                [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
#pragma mark - 客服中心
                QYUserInfo *user = [QYUserInfo new];
                user.userId =model.merchant_id;
                user.data = [NSString stringWithFormat:@"[{\"key\":\"real_name\", \"value\":\"商家%@\"},{\"key\":\"mobile_phone\", \"value\":%@},{\"index\":0, \"key\":\"account\", \"label\":\"设备端\", \"value\":\"苹果手机\", }]",model.mobile,model.mobile];

                [[QYSDK sharedSDK] setUserInfo:user authTokenVerificationResultBlock:^(BOOL isSuccess) {
                    
                }];
                //暂时后退
                //                [self.navigationController popViewControllerAnimated:YES];
                
                NSString *tagS = [NSString stringWithFormat:@"%@",model.merchant_id];
                [JPUSHService setAlias:tagS completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    
                    if (iResCode == 0) {//对应的状态码返回为0，代表成功
                        NSLog(@"成功");

                        
                    }
                } seq:1];
                
                
                BaseTabBarController *vc=[BaseTabBarController new];
//                [self presentViewController:vc animated:YES completion:nil];
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                   app.window.rootViewController = vc;
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            [MBProgressHUD hideHUD];
            
        } andfailure:^{
            [MBProgressHUD hideHUD];
            
        }];
    }
    

    
}
#pragma mark - 忘记密码
- (IBAction)WangjiAction:(id)sender {
    
    
    FBHResetViewController *VC = [FBHResetViewController new];
    VC.isTonav = @"NO";
    BaseNavigationController *Nav = [[BaseNavigationController alloc]initWithRootViewController:VC];
    [self presentViewController:Nav animated:YES completion:nil];
    
    
}

/**
 倒计时
 
 */
- (void)countDownWithTime{
    __block NSInteger timeout = 59; // 倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                //设置按钮的样式
                [self.MSMButton setTitle:@"重新发送" forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.MSMButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                //                NSLog(@"____%@",strTime);
                
                [self.MSMButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.MSMButton.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}


- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
    
}


@end
