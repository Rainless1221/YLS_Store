//
//  PaymentViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/5.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "PaymentViewController.h"
#import "Payment_passwordViewController.h"

@interface PaymentViewController ()
@property (weak, nonatomic) IBOutlet UIButton *determineButton;
@property (weak, nonatomic) IBOutlet UIButton *MSMButton;
@property (weak, nonatomic) IBOutlet UITextField *MSMtext;
@property (weak, nonatomic) IBOutlet UILabel *Phone;
/*修改按钮*/
@property (strong,nonatomic)UIButton * DeteButton;
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回提现密码";
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    UserModel *model = [UserModel getUseData];
    self.Phone.text = model.mobile;
    self.MSMtext.textColor = UIColorFromRGB(0x3D8AFF);
    self.MSMtext.keyboardType = UIKeyboardTypeDecimalPad;
    
    /*确定*/
    self.DeteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.DeteButton.frame = self.determineButton.frame;
    self.DeteButton.width = ScreenW-30;
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW-30,44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    [self.DeteButton.layer addSublayer:gl];
    
    self.DeteButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    self.DeteButton.layer.shadowOffset = CGSizeMake(0,4);
    self.DeteButton.layer.shadowOpacity = 1;
    self.DeteButton.layer.shadowRadius = 9;
    
    [self.DeteButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.DeteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.DeteButton addTarget:self action:@selector(DETEAction) forControlEvents:UIControlEventTouchUpInside];
    [self.DeteButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.DeteButton];
}
#pragma mark - 确定
-(void)DETEAction{
    if (self.MSMtext.text==nil||self.MSMtext.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return ;
    }
    [self verify_old_password];
}
- (IBAction)determineAction:(UIButton *)sender {
    if (self.MSMtext.text==nil||self.MSMtext.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return ;
    }
//    [self verify_old_password];
    
    
}
#pragma mark - 验证短信
-(void)verify_old_password{
    [MBProgressHUD MBProgress:@"验证中。。"];
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]verify_old_pwd_or_code_before_set_payment_password:model.merchant_id andkey:@"code" andsiring:self.MSMtext.text Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1){
            Payment_passwordViewController *VC =[Payment_passwordViewController new];
            VC.Passpage = 4;
            VC.Navtitle = @"重置提现密码";
            VC.prompt = @"请设置新提现密码，用于提现验证";
            VC.prompt1 = @"不能是登录密码或连续数字";
            [self.navigationController pushViewController:VC animated:NO];
            [MBProgressHUD hideHUD];
            
        }else{
            [MBProgressHUD hideHUD];
        }
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
}

#pragma mark - 短信、

- (IBAction)MSMAction:(UIButton *)sender {
    UserModel *model = [UserModel getUseData];
    
    //3为设置或重置支付密码 4为重置登录密码
    [[FBHAppViewModel shareViewModel]geTcaptchaWithphone:model.mobile andtype:@"3" Success:^(NSDictionary *resDic) {
        NSLog(@"当前获取到的数据是%@",resDic);
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
                [self.MSMButton setTitle:@"重获验证码" forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.MSMButton setBackgroundColor:UIColorFromRGB(0x3D89FF)];
                self.MSMButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];;
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                //                NSLog(@"____%@",strTime);
                
                [self.MSMButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.MSMButton setBackgroundColor:UIColorFromRGB(0xD4E5FF)];
                self.MSMButton.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}



@end
