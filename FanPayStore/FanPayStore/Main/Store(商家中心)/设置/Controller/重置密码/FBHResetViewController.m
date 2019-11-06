//
//  FBHResetViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHResetViewController.h"
#import "FBHupPassViewController.h"

@interface FBHResetViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *MSMButton;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *determine;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (strong, nonatomic) UITextField *Phone_TF;
/*修改按钮*/
@property (strong,nonatomic)UIButton * DeteButton;
@end

@implementation FBHResetViewController
#pragma mark - 请求
-(void)merchant_center{
    
    if ([self.isTonav isEqualToString:@"YES"]) {
        
    }else{
        if (self.Phone_TF.text==nil||self.Phone_TF.text.length==0) {
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
            return ;
        }
    }
    
    if (self.codeText.text==nil||self.codeText.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return ;
    }else if (self.pass.text==nil||self.pass.text.length==0){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return ;
        
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
    
    NSString *phone = [[NSString alloc]init];
    if ([self.isTonav isEqualToString:@"YES"]) {
        phone = [NSString stringWithFormat:@"%@",self.phone.text];

        
    }else{
        phone = [NSString stringWithFormat:@"%@",self.Phone_TF.text];
    }
    
//    UserModel *model = [UserModel getUseData];
    [MBProgressHUD MBProgress:@"数据加载中..."];

    [[FBHAppViewModel shareViewModel]reset_login_password:phone andcode:self.codeText.text andpassword:self.pass.text Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
//            NSDictionary *DIC=resDic[@"data"];
            if ([self.isTonav isEqualToString:@"YES"]) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];

        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"重置密码";
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
    
    if ([self.isTonav isEqualToString:@"YES"]) {
        [self.navigationController popViewControllerAnimated:YES];

    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}
#pragma mark - UI
-(void)createUI{
    if ([self.isTonav isEqualToString:@"YES"]) {
        UserModel *model = [UserModel getUseData];
        self.phone.text = [NSString stringWithFormat:@"%@",model.mobile];
        
    }else{
        [self.baseView addSubview:self.Phone_TF];
        [self.Phone_TF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(50);
            make.left.mas_offset(60);
            make.right.mas_offset(-10);
            make.height.mas_offset(50);
        }];
    }
    
    self.pass.delegate = self;
    self.codeText.delegate =self;
    self.MSMButton.backgroundColor = UIColorFromRGB(0x3D8AFF);
//    self.determine.backgroundColor = UIColorFromRGB(0xD4E5FF);
    self.codeText.keyboardType = UIKeyboardTypePhonePad;

    
    /*确定*/
    self.DeteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.DeteButton.frame = self.determine.frame;
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
    
    [self.DeteButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.DeteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.DeteButton addTarget:self action:@selector(DETEAction) forControlEvents:UIControlEventTouchUpInside];
    [self.DeteButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.DeteButton];
    
    
}

#pragma mark ————    textFieldDidChange  ————
- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField.text.length >0 ) {
        self.determine.backgroundColor = UIColorFromRGB(0x3D8AFF);
    } else{
        self.determine.backgroundColor = UIColorFromRGB(0xD4E5FF);

    }

}
#pragma mark - 修改登录密码
-(void)DETEAction{
    [self merchant_center];
}
- (IBAction)determineAction:(UIButton *)sender {
//    [self merchant_center];
}
#pragma mark - 短信验证
- (IBAction)ReseAction:(UIButton *)sender {

    NSString *phone = [[NSString alloc]init];
    if ([self.isTonav isEqualToString:@"YES"]) {
        
        if (self.phone.text==nil||self.phone.text.length==0) {
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
            return ;
        }
        
        phone = [NSString stringWithFormat:@"%@",self.phone.text];
        
        
    }else{
        if (self.Phone_TF.text==nil||self.Phone_TF.text.length==0) {
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
            return ;
        }
        
        phone = [NSString stringWithFormat:@"%@",self.Phone_TF.text];
    }
    
    //3为设置或重置支付密码 4为重置登录密码 
    [[FBHAppViewModel shareViewModel]geTcaptchaWithphone:phone andtype:@"4" Success:^(NSDictionary *resDic) {
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


#pragma mark - 懒加载
-(UITextField *)Phone_TF{
    if (!_Phone_TF) {
        _Phone_TF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _Phone_TF.placeholder = @"请输入手机号码";
        _Phone_TF.font = [UIFont systemFontOfSize:16];
        _Phone_TF.keyboardType = UIKeyboardTypePhonePad;

    }
    return _Phone_TF;
}
@end
