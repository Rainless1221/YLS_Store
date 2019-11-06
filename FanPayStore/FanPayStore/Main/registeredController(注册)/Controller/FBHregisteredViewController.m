//
//  FBHregisteredViewController.m
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHregisteredViewController.h"

@interface FBHregisteredViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *MSMButton;
@property (weak, nonatomic) IBOutlet UITextField *Phone;
@property (weak, nonatomic) IBOutlet UITextField *yanzheng;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UIButton *xieyiButton;

/** 横线 */
@property (weak, nonatomic) IBOutlet UIView *phoneline;
@property (weak, nonatomic) IBOutlet UIView *yanzhengline;
@property (weak, nonatomic) IBOutlet UIView *passline;
@property (weak, nonatomic) IBOutlet UIButton *RegisButton;

@end

@implementation FBHregisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MSMButton.layer.borderColor = [UIColorFromRGB(0xF7AE2B) CGColor];
    [self.view setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
    
    [self setupNav];
    [self createUI];
}
#pragma mark - 导航栏
-(void)setupNav{
    //按钮
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 44, 44);
    [thirdBtn setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    [thirdBtn addTarget:self action:@selector(LethAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:thirdBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
}
-(void)LethAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UI
-(void)createUI{
    self.Phone.keyboardType = UIKeyboardTypeDecimalPad;
    self.yanzheng.keyboardType = UIKeyboardTypeDecimalPad;
    
    self.Phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.yanzheng.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pass.clearButtonMode = UITextFieldViewModeWhileEditing;

    self.Phone.delegate = self;
    self.yanzheng.delegate = self;
    self.pass.delegate = self;
    [self.Phone addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    [self.yanzheng addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    [self.pass addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    
    
#pragma mark - 注册按钮
    //    self.RegisButton.backgroundColor = UIColorFromRGB(0x3D8AFF);
    
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0,0,self.RegisButton.width,44);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(0.5),@(1.0)];
//    gl.cornerRadius = 10;
//    [self.RegisButton.layer addSublayer:gl];
//
//    self.RegisButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//    self.RegisButton.layer.shadowOffset = CGSizeMake(0,4);
//    self.RegisButton.layer.shadowOpacity = 1;
//    self.RegisButton.layer.shadowRadius = 9;
    self.RegisButton.layer.cornerRadius = 10;
    [self.RegisButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.RegisButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
}
- (void)myNameStarAction:(UITextField *)textField
{
    if (textField == self.Phone) {
        self.phoneline.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }else if (textField == self.yanzheng){
        self.yanzhengline.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }else{
        self.passline.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }
}
// 失去焦点
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.phoneline.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.yanzhengline.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.passline.backgroundColor = UIColorFromRGB(0xEAEAEA);
}
/** 短信验证码 **/
- (IBAction)codeAction:(id)sender {
    
    if (self.Phone.text==nil||self.Phone.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    
    [[FBHAppViewModel shareViewModel] geTcaptchaWithphone:self.Phone.text andtype:@"1" Success:^(NSDictionary *resDic) {
        //        NSLog(@"当前获取到的数据是%@",resDic);
        if ([resDic[@"status"] integerValue]==1) {
            //            NSDictionary *DIC=resDic[@"data"];
            [self countDownWithTime];
            //            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}

/** 用户注册 **/
- (IBAction)RegisAction:(id)sender {
    
    if (self.Phone.text==nil||self.Phone.text.length==0 ) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }else if (self.yanzheng.text==nil||self.yanzheng.text.length==0){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }else if (self.pass.text==nil||self.pass.text.length==0){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }else if (self.pass.text.length<6){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码不能少于6位"];
        return ;
        
    }else if (self.pass.text.length>16){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码不能多于16位"];
        return ;
        
    }
    
#pragma mark - 密码复杂程度判断
    BOOL Passcheck = [self judgePassWordLegal:self.pass.text];
    if (!Passcheck) {
        
        return;
    }
    
    
    [MBProgressHUD MBProgress:@"注册中..."];
    
    [[FBHAppViewModel shareViewModel]getRegisteruser:self.Phone.text andcode:self.yanzheng.text andpassword:self.pass.text Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            UserModel *model=[UserModel mj_objectWithKeyValues:DIC];
            //保存用户信息
            [model saveUserData];
            /**
             *  用户注册成功
             *  1、可能需要自动登录
             *  2、返回到登录界面
             */
            //步骤 1
            //            NSString *userPhone = [NSString stringWithFormat:@"%@",DIC[@"mobile"]];
            //            NSString *userpass = [NSString stringWithFormat:@"%@",self.pass.text];
            //            [self UserLoging:userPhone andPass:userpass];
            //步骤 2
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
}
#pragma mark - 自动登录
-(void)UserLoging:(NSString *)Phone andPass:(NSString *)pass{
    
    [[FBHAppViewModel shareViewModel] userloginWithphone:Phone andcaptcha:pass Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            UserModel *model=[UserModel mj_objectWithKeyValues:DIC];
            if (kStringIsEmpty(model.store_id)) {
                KPostNotification(@"IsStore", @NO)
            }else{
                KPostNotification(@"IsStore", @YES)
            }
            
            //保存用户信息
            [model saveUserData];
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            //暂时后退
            //                [self.navigationController popViewControllerAnimated:YES];
            
            BaseTabBarController *vc=[BaseTabBarController new];
            [self presentViewController:vc animated:YES completion:nil];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}
/**
 *  已经有账号跳转
 */
- (IBAction)fanhui:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  注册协议
 */
- (IBAction)XieyiAction:(id)sender {
    FBHinformationViewController *VC = [FBHinformationViewController new];
    VC.Navtitle = @"入驻协议";
    VC.agreeUrl = FBHApi_HTML_Ruzhu;
    [self.navigationController pushViewController:VC animated:NO];
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
                
                
                [self.MSMButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.MSMButton.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

@end
