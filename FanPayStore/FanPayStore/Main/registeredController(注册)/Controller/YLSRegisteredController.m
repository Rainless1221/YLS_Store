//
//  YLSRegisteredController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSRegisteredController.h"
#import "RegisteredView.h"

@interface YLSRegisteredController ()<RegisteredViewDelegate>
@property (strong,nonatomic) RegisteredView* Registered;

@end

@implementation YLSRegisteredController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColorFromRGB(0xFFFFFF)];

    /**
        UI
     */
    [self createUI];
     /**
       导航栏
       */
     [self setupNav];
    
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
    [self.view addSubview:self.Registered];
    
}
#pragma mark - RegisteredViewDelegate 代理方法
#pragma mark - *注册*
-(void)RegisDelegateAction:(NSDictionary *)UserDict{
    [MBProgressHUD MBProgress:@"注册中..."];
    NSString *phone = [NSString stringWithFormat:@"%@",UserDict[@"phone"]];
    NSString *msm = [NSString stringWithFormat:@"%@",UserDict[@"msm"]];
    NSString *pawss = [NSString stringWithFormat:@"%@",UserDict[@"pawss"]];

    [[FBHAppViewModel shareViewModel]getRegisteruser:phone andcode:msm andpassword:pawss Success:^(NSDictionary *resDic) {
        
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
#pragma mark - *获取验证码*
-(void)MSMDelegateAction:(NSString *)Phone MSMButton:(UIButton *)sender {
  
    [[FBHAppViewModel shareViewModel] geTcaptchaWithphone:Phone andtype:@"1" Success:^(NSDictionary *resDic) {
        //        NSLog(@"当前获取到的数据是%@",resDic);
        if ([resDic[@"status"] integerValue]==1) {
            [self countDownWithTime:sender];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}
/**
 倒计时
 
 */
- (void)countDownWithTime:(UIButton *)sender{
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
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
            
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [sender setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}
#pragma mark - *已有账号，去登录*
-(void)LoginDelegateAction{
    [self LethAction];
}
#pragma mark - *协议*
-(void)XieDelegateAction{
    FBHinformationViewController *VC = [FBHinformationViewController new];
    VC.Navtitle = @"入驻协议";
    VC.agreeUrl = FBHApi_HTML_Ruzhu;
    [self.navigationController pushViewController:VC animated:NO];
}
#pragma mark - 懒加载
-(RegisteredView *)Registered{
    if (!_Registered) {
        _Registered = [[RegisteredView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-44)];
        _Registered.delegate = self;
    }
    return _Registered;
}
@end
