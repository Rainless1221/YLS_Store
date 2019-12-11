//
//  YLSAddPayViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSAddPayViewController.h"

@interface YLSAddPayViewController ()<UITextFieldDelegate>

@end

@implementation YLSAddPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定支付宝帐户";
    
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    
    UIView *AddView = [[UIView alloc] init];
    AddView.frame = CGRectMake(15,15,ScreenW-30,252);
    AddView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    AddView.layer.cornerRadius = 5;
    [self.view addSubview:AddView];
    [AddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(252);
    }];
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(10,0,200,50);
    label1.numberOfLines = 0;
    label1.text = @"国家和地区";
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:15];
    [AddView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(AddView.width-200,0,190,50);
    label2.numberOfLines = 2;
    label2.textAlignment = 2;
    label2.text = @"中国";
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont systemFontOfSize:15];
    [AddView addSubview:label2];
    
    /**
     商家手机号
     */
    UIView *Phoneview = [[UIView alloc] init];
    Phoneview.frame = CGRectMake(10,label1.bottom+1,AddView.width-20,50);
    Phoneview.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [AddView addSubview:Phoneview];
    
    UILabel *quhao = [[UILabel alloc] init];
    quhao.frame = CGRectMake(0,0,50.5,50);
    quhao.numberOfLines = 0;
    quhao.font = [UIFont systemFontOfSize:16];
    quhao.text = @"+89";
    [Phoneview addSubview:quhao];
    
    self.PayPhone = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 0, 159, 50)];
    self.PayPhone.font = [UIFont systemFontOfSize:16];
    self.PayPhone.textColor = [UIColor blackColor];
    UserModel *model = [UserModel getUseData];
    self.PayPhone.text = [NSString stringWithFormat:@"%@",model.mobile];
    [Phoneview addSubview:self.PayPhone];
    /**
     绑定资料
     */
    [AddView addSubview:self.AccountTF];
    [self.AccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Phoneview.mas_bottom).offset(0);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    UIView *line1 = [[UIView alloc] init];
    line1.frame = CGRectMake(10,self.AccountTF.bottom,AddView.width-20,0.5);
    line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [AddView addSubview:line1];
    
    [AddView addSubview:self.PayNameTF];
    [self.PayNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AccountTF.mas_bottom).offset(0);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.frame = CGRectMake(10,self.PayNameTF.bottom,AddView.width-20,0.5);
    line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [AddView addSubview:line2];
    
    [AddView addSubview:self.MSMTF];
    [self.MSMTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.PayNameTF.mas_bottom).offset(0);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    
    
    [self.AccountTF addTarget:self  action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.PayNameTF addTarget:self  action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.MSMTF addTarget:self  action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    /**获取验证码按钮*/
    UIButton *MSMButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [MSMButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [MSMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    MSMButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    MSMButton.layer.cornerRadius = 5;
    MSMButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [MSMButton addTarget:self action:@selector(MSMAction:) forControlEvents:UIControlEventTouchUpInside];
    [AddView addSubview:MSMButton];
    [MSMButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.MSMTF.mas_centerY).offset(0);
        make.right.mas_offset(-10);
        make.width.mas_offset(80);
        make.height.mas_offset(32);
    }];
    
    
    /** 确认添加按钮*/
    self.AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.AddButton setTitle:@"确认添加" forState:UIControlStateNormal];
    [self.AddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.AddButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    self.AddButton.layer.cornerRadius = 10;
    [self.AddButton addTarget:self action:@selector(BindingPinterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.AddButton];
    [self.AddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AddView.mas_bottom).offset(20);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(44);
    }];
    self.AddButton.userInteractionEnabled = NO;//交互关闭
    self.AddButton.alpha=0.5;//透明度
}
#pragma mark - 绑定
-(void)BindingPinterAction{

    if (self.AccountTF.text==nil||self.AccountTF.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入支付宝帐号"];
        return ;
    }
    if (self.PayNameTF.text==nil||self.PayNameTF.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return ;
    }
    if (self.MSMTF.text==nil||self.MSMTF.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return ;
    }
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    NSDictionary *dict = @{
                           @"alipay_account":[NSString stringWithFormat:@"%@",self.AccountTF.text],//支付宝账号
                           @"name":[NSString stringWithFormat:@"%@",self.PayNameTF.text],//姓名
                           @"mobile_code":[NSString stringWithFormat:@"%@",self.MSMTF.text]//验证码
                           };
    [[FBHAppViewModel shareViewModel]insert_alipay_account:model.merchant_id  andjoinDict:dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"alipay_account" object:@""];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
    
}
#pragma mark - 获取验证码
- (void)MSMAction:(UIButton *)sender {
    
    if (self.PayPhone.text==nil||self.PayPhone.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    
    [[FBHAppViewModel shareViewModel] geTcaptchaWithphone:self.PayPhone.text andtype:@"10" Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            [self countDownWithTime:sender];
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
- (void)countDownWithTime:(UIButton *)Button{
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
                [Button setTitle:@"重新获取" forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                Button.userInteractionEnabled = YES;
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
                
                [Button setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                Button.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}
- (void) textFieldDidChange:(UITextField*) sender {
    if (self.AccountTF.text.length > 0 &&self.PayNameTF.text.length>0 &&self.MSMTF.text .length>0) {
       
        self.AddButton.userInteractionEnabled = YES;//交互关闭
        self.AddButton.alpha=1;//透明度
        
    }else {
        self.AddButton.userInteractionEnabled = NO;//交互关闭
        self.AddButton.alpha=0.5;//透明度
    }
}
#pragma mark - 懒加载
-(UITextField *)AccountTF{
    if (!_AccountTF) {
        _AccountTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 101, 200, 50)];
        _AccountTF.font = [UIFont systemFontOfSize:15];
        _AccountTF.textColor = UIColorFromRGB(0x222222);
        _AccountTF.placeholder = @"请输入支付宝帐号";
        _AccountTF.delegate =self;
    }
    return _AccountTF;
}
-(UITextField *)PayNameTF{
    if (!_PayNameTF) {
        _PayNameTF = [[UITextField alloc]initWithFrame:CGRectMake(0, self.AccountTF.bottom, 200, 50)];
        _PayNameTF.font = [UIFont systemFontOfSize:15];
        _PayNameTF.textColor = UIColorFromRGB(0x222222);
        _PayNameTF.placeholder = @"请输入支付宝账号真实姓名";
        _PayNameTF.delegate =self;

    }
    return _PayNameTF;
}
-(UITextField *)MSMTF{
    if (!_MSMTF) {
        _MSMTF = [[UITextField alloc]initWithFrame:CGRectMake(0, self.PayNameTF.bottom, 200, 50)];
        _MSMTF.font = [UIFont systemFontOfSize:15];
        _MSMTF.textColor = UIColorFromRGB(0x222222);
        _MSMTF.placeholder = @"请输入验证码";
        _MSMTF.keyboardType = UIKeyboardTypePhonePad;
        _MSMTF.delegate =self;

    }
    return _MSMTF;
}
@end
