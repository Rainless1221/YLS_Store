//
//  bankcardYanViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/19.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "bankcardYanViewController.h"

@interface bankcardYanViewController ()
@property (strong,nonatomic)UITextField * textF;

@end

@implementation bankcardYanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"身份验证";
    [self createUI];
}

#pragma mark - UI
-(void)createUI{
    
    UIView *base_view = [[UIView alloc] init];
    base_view.frame = CGRectMake(0,20,ScreenW,375.5);
    base_view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    base_view.layer.cornerRadius = 5;
    [self.view addSubview:base_view];
    
    
    //提示
    UserModel *model = [UserModel getUseData];
    NSString *phon = [NSString stringWithFormat:@"%@",model.mobile];
    NSString *string =[phon stringByReplacingOccurrencesOfString:[phon substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,20,ScreenW,12);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];
    label.text = [NSString stringWithFormat:@"将验证码发送至%@，请查收",string];
    [base_view addSubview:label];
    //灰色的横线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lineView.frame = CGRectMake(15, 122, base_view.bounds.size.width-30, 1);
    [base_view addSubview:lineView];
    //短信按钮MSM
    UIButton *MSMBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [MSMBtn setTitle:@"点击获取" forState:UIControlStateNormal];
    MSMBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [MSMBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    MSMBtn.backgroundColor =UIColorFromRGB(0xF7AE2B);
    MSMBtn.layer.cornerRadius = 2;
    [MSMBtn addTarget:self action:@selector(MSMBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [base_view addSubview:MSMBtn];
    [MSMBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView.mas_top).offset(-5);
        make.right.mas_offset(-15);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(74), IPHONEHIGHT(22)));
    }];
    
    self.textF = [[UITextField alloc]initWithFrame:CGRectMake(25, 140, 200, 48)];
    self.textF.placeholder = @"输入验证码";
    self.textF.keyboardType = UIKeyboardTypePhonePad;
    self.textF.font = [UIFont systemFontOfSize:15];
    [base_view addSubview:self.textF];
    [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView.mas_top).offset(-5);
        make.left.mas_offset(25);
        make.right.equalTo(MSMBtn.mas_left).offset(-5);
        make.height.mas_offset(IPHONEHIGHT(25));
    }];
    
    //下一步
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.backgroundColor = UIColorFromRGB(0xF7AE2B);
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];

    [base_view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-150);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 48));
        make.centerX.mas_offset(0);
    }];
}
#pragma mark - 发送短信
-(void)MSMBtnClick:(UIButton *)sender{
    UserModel *model = [UserModel getUseData];
    [MBProgressHUD MBProgress:@"发送中..."];
    
    [[FBHAppViewModel shareViewModel] geTcaptchaWithphone:model.mobile andtype:@"9" Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            [self countDownWithTime:sender];
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
#pragma mark - 下一步
-(void)BtnClick{
    if (self.textF.text==nil||self.textF.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return ;
    }
    [MBProgressHUD MBProgress:@"验证中..."];

    UserModel *model = [UserModel getUseData];
    NSDictionary *dict = @{
                           @"mobile_code":[NSString stringWithFormat:@"%@",self.textF.text]
                           };
    [[FBHAppViewModel shareViewModel]verify_code_before_insert_bank_card:model.merchant_id andstore_id:model.store_id andbankDict:dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            FBHAllcardController *VC = [FBHAllcardController new];
            VC.mobile_code_string = self.textF.text;
            [self.navigationController pushViewController:VC animated:NO];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];

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
                [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                [sender setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
                sender.backgroundColor =UIColorFromRGB(0xF7AE2B);
                sender.layer.borderWidth = 0;
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
                
                [sender setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                [sender setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
                sender.backgroundColor =UIColorFromRGB(0xFFFFFF);
                sender.layer.borderWidth = 1;
                sender.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}
@end
