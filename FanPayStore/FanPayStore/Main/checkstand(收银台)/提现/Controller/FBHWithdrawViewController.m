//
//  FBHWithdrawViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/25.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHWithdrawViewController.h"
#import "WithdrawView.h"

#import "CashTDView.h"
#import "JHCoverView.h"//提现密码输入
#import "Payment_passwordViewController.h"

@interface FBHWithdrawViewController ()<UIScrollViewDelegate,JHCoverViewDelegate,UITextFieldDelegate,WithdrawDelegate>
{
    double F;
    NSString *_fee_payable;
    NSString *_service_charges_max;
    NSString *_today_withdrawable_amount;
}
@property (strong,nonatomic)WithdrawWinView * WinView;//提现成功弹出View
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)WithdrawView * scrollView;
@property (strong,nonatomic)FBHWithdraw * YLSWithdrawView;
/** 银行卡信息 */
@property (strong,nonatomic)NSMutableArray * bankData;
/** 银行卡ID */
@property (strong,nonatomic)NSString * bankid;
/** 银行卡名称 */
@property (strong,nonatomic)NSString * bankName;
/** 提现密码输入 */
@property (nonatomic, strong) JHCoverView *coverView;
/** 是否有支付密码 */
@property (assign,nonatomic)BOOL isPay_pwd;
/** 最低提现额度 */
@property (strong,nonatomic)NSString * one_time;
/** 最高提现额度 */
@property (strong,nonatomic)NSString * Maxone_time;
/** 短信验证码 */
@property (strong,nonatomic)NSString * mobile_codeString;

@property (strong,nonatomic)UIView * MobileView;
@property (strong,nonatomic)UITextField * textF;
@end

@implementation FBHWithdrawViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
#pragma mark - 请求
/**
 *  提现页面信息
 **/
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_withdrawal_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            self.YLSWithdrawView.Data = DIC;
            
            /** 可提现金额 */
            self.scrollView.dangqiM.text = [NSString stringWithFormat:@"%@",DIC[@"withdrawable_cash"]];
            _today_withdrawable_amount = [NSString stringWithFormat:@"%@",DIC[@"today_withdrawable_amount"]];
            self.scrollView.fuwuLabel.text = [NSString stringWithFormat:@"今日可提现额度为 %@元",_today_withdrawable_amount];

            /** 提现问题提示 若无问题 则为空字符串*/
            NSString *tip = [NSString stringWithFormat:@"%@",DIC[@"tip"]];
            if ([[MethodCommon judgeStringIsNull:tip] isEqualToString:@""]) {
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"tip"]];
            }
            /** 我的银行卡信息 */
            [self.bankData removeAllObjects];
//            self.bankData =DIC[@"bank_card_info"];
            for (NSDictionary*dict in DIC[@"bank_card_info"]) {
                [self.bankData addObject:dict];
            }
            
            /** 服务费 */
            NSString *rate = [NSString stringWithFormat:@"%@",DIC[@"service_charges_rate"]];
            self->F = [rate doubleValue];
            self.scrollView.fuwu.text = [NSString stringWithFormat:@"（收取 %.2lf%@服务费）",F*100,@"%"];
            /*代付费用*/
            _fee_payable = [NSString stringWithFormat:@"%@",DIC[@"fee_payable"]];
            /*服务费最高金额*/
            _service_charges_max = [NSString stringWithFormat:@"%@",DIC[@"service_charges_max"]];

#pragma mark - 说明文本
            //withdraw_amount_limit_one_day 一个商户每日最多能提现的金额
            //withdraw_total_amount_limit_one_day 所有商户每日最多能提现的金额
            
            //withdraw_max_frequency_one_day  每日限制提现次数
            NSString *withdraw_max_frequency_one_day = [NSString stringWithFormat:@"%@",DIC[@"withdraw_max_frequency_one_day"]];
            if ([[MethodCommon judgeStringIsNull:withdraw_max_frequency_one_day] isEqualToString:@""]) {
                self.scrollView.TisiLabel3.text =  [NSString stringWithFormat:@"商家用户一天的提现次数为5次，无月累计上限"];

            }else{
                self.scrollView.TisiLabel3.text =  [NSString stringWithFormat:@"商家用户一天的提现次数为%@次，无月累计上限",DIC[@"withdraw_max_frequency_one_day"]];

            }
            
            //withdraw_min_limit_one_time   每次提现额度的最小限制
            NSString *withdraw_min_limit_one_time = [NSString stringWithFormat:@"%@",DIC[@"withdraw_min_limit_one_time"]];
            if ([[MethodCommon judgeStringIsNull:withdraw_min_limit_one_time] isEqualToString:@""]) {
                self.one_time = @"20000";

            }else{
                self.one_time = [NSString stringWithFormat:@"%@",DIC[@"withdraw_min_limit_one_time"]];

            }
            

            self.scrollView.TisiLabel5.text =  [NSString stringWithFormat:@"提现门槛，满%@元才能提现",self.one_time];
            
            //withdraw_max_limit_one_time    每次提现额度的最大限制
            //withdraw_amount_limit_one_day 一个商户每日最多能提现的金额
            //withdraw_total_amount_limit_one_day 所有商户每日最多能提现的金额
            NSString *withdraw_max_limit_one_time = [NSString stringWithFormat:@"%@",DIC[@"withdraw_max_limit_one_time"]];
            
            NSString *withdraw_amount_limit_one_day = [NSString stringWithFormat:@"%@",DIC[@"withdraw_amount_limit_one_day"]];
            if ([[MethodCommon judgeStringIsNull:withdraw_max_limit_one_time] isEqualToString:@""]) {
                withdraw_max_limit_one_time = @"20000";
                self.Maxone_time = @"20000";
            }else{
                self.Maxone_time = withdraw_max_limit_one_time;

            }
            if ([[MethodCommon judgeStringIsNull:withdraw_amount_limit_one_day] isEqualToString:@""]) {
                withdraw_amount_limit_one_day = @"100000";
            }
            self.scrollView.TisiLabel7.text =  [NSString stringWithFormat:@"每笔最高%@元，每日提现不超过%@元，每笔代付费用%@元，手续费%.2lf%@",withdraw_max_limit_one_time,withdraw_amount_limit_one_day,_fee_payable,F*100,@"%"];

            [self.scrollView.tishi setTitle:[NSString stringWithFormat:@" 提现金额大于限制额度%@元，请分多次提现",withdraw_max_limit_one_time] forState:UIControlStateNormal];
            /** 赋值 **/
            if (self.bankData.count>0) {
                NSString *title = [NSString stringWithFormat:@"%@",self.bankData[0][@"affiliated_bank"]];
//                NSString *title = [NSString stringWithFormat:@"%@(%@)",self.bankData[0][@"affiliated_bank"],self.bankData[0][@"card_no_last_four"]];
                [self.scrollView.cardTextButton setTitle:title forState:UIControlStateNormal];
                
                NSString *url = self.bankData[0][@"affiliated_bank_logo"];
                [self.scrollView.cardTextButton sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
                //银行卡ID
                self.bankid = self.bankData[0][@"bank_card_id"];
                //银行卡名称
                self.bankName = [NSString stringWithFormat:@" %@",self.bankData[0][@"affiliated_bank"]];
            }
            
            

            
            [MBProgressHUD hideHUD];


#pragma mark -  是否可以提现的信息
            NSString *err_msg = [NSString stringWithFormat:@"%@",DIC[@"err_msg"]];
            if ([err_msg isEqualToString:@""]) {
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:err_msg];
                
                MoneyCertificationController *VC1 = [MoneyCertificationController new];
                if (self.status_With == 2) {
                    
                }else{
                    
                    switch (self.cust_type_with) {
                        case 1:
                            [self.navigationController pushViewController:[Wei_StoreController new] animated:NO];
                            
                            break;
                        case 2:
                            [self.navigationController pushViewController:[Geti_StoreController new] animated:NO];
                            
                            break;
                        case 3:
                            [self.navigationController pushViewController:[Qiye_StoreController new] animated:NO];
                            
                            break;
                        case 4:
                            VC1.navigationTitle= @"提现认证";
                            [self.navigationController pushViewController:VC1 animated:NO];
                            
                            break;
                            
                        default:
                            break;
                    }
                    
                    return;
                }

            }
            

        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
    
    /**
     支付密码是否存在
     */
    [[FBHAppViewModel shareViewModel]is_exist_pay_pwd:model.merchant_id Success:^(NSDictionary *resDic) {
        
        
        if ([resDic[@"status"] integerValue] == 1){
            
            NSString *DIC = [NSString stringWithFormat:@"%@",resDic[@"data"][@"is_exist_pay_pwd"]];
            if ([DIC isEqualToString:@"1"]) {
                self.isPay_pwd = YES;
            }else{
                self.isPay_pwd = NO;
            }
            
        }else{
            
        }
        
    } andfailure:^{
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    [self merchant_center];
    /**
     * 导航栏
     **/
    [self setupNav];
    /**
     *  UI
     **/
    [self createUI];
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 66, 28)];
    [leftbutton setTitle:@"提现记录" forState:UIControlStateNormal];
    [leftbutton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.rightBarButtonItem=rightitem;
}
/** 提现记录 */
-(void)RighAction{
    [self.navigationController pushViewController:[FBHWithdrawJLViewController new] animated:YES];
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
//    [self.SJScrollView addSubview:self.YLSWithdrawView];
}
#pragma mark - 认证情况是否跳转
-(void)ifToVC{
    MoneyCertificationController *VC1 = [MoneyCertificationController new];
    if (self.status_With == 2) {
        
    }else{
        
        switch (self.cust_type_with) {
            case 1:
                [self.navigationController pushViewController:[Wei_StoreController new] animated:NO];
                
                break;
            case 2:
                [self.navigationController pushViewController:[Geti_StoreController new] animated:NO];
                
                break;
            case 3:
                [self.navigationController pushViewController:[Qiye_StoreController new] animated:NO];
                
                break;
            case 4:
                VC1.navigationTitle= @"提现认证";
                [self.navigationController pushViewController:VC1 animated:NO];
                
                break;
                
            default:
                break;
        }
        
        return;
    }
}


#pragma mark - 提现操作等
/** 选择银行卡 **/
-(void)CardAction{
    
//    [self ifToVC];
    MoneyCertificationController *VC1 = [MoneyCertificationController new];
    if (self.status_With == 2) {
        
    }else{
        
        switch (self.cust_type_with) {
            case 1:
                [self.navigationController pushViewController:[Wei_StoreController new] animated:NO];
                
                break;
            case 2:
                [self.navigationController pushViewController:[Geti_StoreController new] animated:NO];
                
                break;
            case 3:
                [self.navigationController pushViewController:[Qiye_StoreController new] animated:NO];
                
                break;
            case 4:
                VC1.navigationTitle= @"提现认证";
                [self.navigationController pushViewController:VC1 animated:NO];
                
                break;
                
            default:
                break;
        }
        
        return;
    }
    
    
    YBWeakSelf
    CashTDView *tipView = [[NSBundle mainBundle] loadNibNamed:@"CashTDView" owner:self options:nil].lastObject;
    tipView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tipView.Data = self.bankData;
    /*添加*/
    tipView.AllbankBlock = ^{
        [weakSelf.navigationController pushViewController:[FBHAllcardController new] animated:NO];
        
    };
    /*选中*/
    tipView.selebankBlock = ^(NSInteger row) {
    
        NSString *title = [NSString stringWithFormat:@"%@",self.bankData[row][@"affiliated_bank"]];
        if ([[MethodCommon judgeStringIsNull:title] isEqualToString:@""]) {
            title = [NSString stringWithFormat:@"%@",self.bankData[row][@"affiliated_bank_name"]];
        }
        [self.scrollView.cardTextButton setTitle:title forState:UIControlStateNormal];
        self.YLSWithdrawView.cardName.text = [NSString stringWithFormat:@"%@",title];
        
        NSString *url = self.bankData[row][@"affiliated_bank_logo"];
        [self.scrollView.cardTextButton sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
        [self.YLSWithdrawView.card setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageNamed:@""]];

        //银行卡ID
        self.bankid = self.bankData[row][@"bank_card_id"];
        self.YLSWithdrawView.bankid = self.bankData[row][@"bank_card_id"];
        //银行卡名称
        NSString *affiliated_bank = [NSString stringWithFormat:@" %@",self.bankData[row][@"affiliated_bank"]];
        if ([[MethodCommon judgeStringIsNull:affiliated_bank] isEqualToString:@""]) {
            affiliated_bank = [NSString stringWithFormat:@"%@",self.bankData[row][@"affiliated_bank_name"]];
        }
        self.bankName = affiliated_bank;
    };
    [self.view.window addSubview:tipView];

}
/** 全部额度 **/
-(void)allAction{
    double fuwu = [self.scrollView.dangqiM.text doubleValue];
    fuwu = fuwu*F+[_fee_payable doubleValue];
    if (fuwu>[_service_charges_max doubleValue]) {
        fuwu = [_service_charges_max doubleValue];
    }
    self.scrollView.fuwuLabel.textColor =UIColorFromRGBA(0x222222, 1);
    _scrollView.fuwuLabel.text = [NSString stringWithFormat:@"服务费: %.2lf元",fuwu];
    self.scrollView.JEField.text = [NSString stringWithFormat:@"%@",self.scrollView.dangqiM.text];
}
#pragma mark 1、点击提现
-(void)notarizeAction{
    
    NSInteger dangqian =  [self.scrollView.dangqiM.text integerValue];

    NSInteger jiner =  [self.scrollView.JEField.text integerValue];
    if (self.scrollView.JEField.text==nil||self.scrollView.JEField.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入金额"];
        return;
    }
    NSInteger Mon = [self.one_time integerValue];
    if (jiner<Mon) {
        NSString *status = [NSString stringWithFormat:@"输入金额请大于%@元",self.one_time];
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:status];
        return;
    }
//    else if (jiner>[self.Maxone_time doubleValue]){
//        NSString *status = [NSString stringWithFormat:@"输入金额请小于%@元",self.Maxone_time];
//        [SVProgressHUD setMinimumDismissTimeInterval:2];
//        [SVProgressHUD showErrorWithStatus:status];
//        return;
//    }
    else if (jiner>dangqian){
        NSString *status = [NSString stringWithFormat:@"输入金额请小于当前余额"];
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:status];
        return;
    }
    
#pragma mark  2、是否已经认证
//    [self ifToVC];
    MoneyCertificationController *VC1 = [MoneyCertificationController new];
    if (self.status_With == 2) {
        
    }else{
        switch (self.cust_type_with) {
            case 1:
                [self.navigationController pushViewController:[Wei_StoreController new] animated:NO];
                
                break;
            case 2:
                [self.navigationController pushViewController:[Geti_StoreController new] animated:NO];
                
                break;
            case 3:
                [self.navigationController pushViewController:[Qiye_StoreController new] animated:NO];
                
                break;
            case 4:
                VC1.navigationTitle= @"提现认证";
                [self.navigationController pushViewController:VC1 animated:NO];
                
                break;
                
            default:
                break;
        }
        
        return;
    }
#pragma mark  3、是否有支付密码
    /**
     * 是否有支付密码
     *  1、有：开始输入密码提现
     *  2、无：先设置提现密码
     */
    
    if (self.isPay_pwd) {
        [self mobile_code];
    }else{
        Payment_passwordViewController *VC =[Payment_passwordViewController new];
        
        /** 首次设置 */
        VC.Passpage = 0;
        VC.Navtitle = @"设置提现密码";
        VC.prompt = @"请设置提现密码，用于提现验证";
        VC.prompt1 = @"不能是登录密码或连续数字";
        [self.navigationController pushViewController:VC animated:NO];
    }
    
    
}
#pragma mark - 4、弹出短信验证
-(void)mobile_code{
    self.MobileView = [[UIView alloc] init];
    self.MobileView.frame = CGRectMake(0,0,ScreenW,ScreenH);
    self.MobileView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view.window addSubview:self.MobileView];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, ScreenW, IPHONEHIGHT(467))];
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.MobileView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(IPHONEHIGHT(467));
    }];
    //输入验证码提示
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    promptLabel.text = @"输入验证码";
    promptLabel.textColor = [UIColor blackColor];
    promptLabel.font = [UIFont systemFontOfSize:17];
    promptLabel.textAlignment = 1;

    [view addSubview:promptLabel];
    //灰色的横线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lineView.frame = CGRectMake(0, 50, view.bounds.size.width, 1);
    [view addSubview:lineView];
      //删除(左上角的叉号)
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [deleteBtn setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:deleteBtn];
    UserModel *model = [UserModel getUseData];
    NSString *phon = [NSString stringWithFormat:@"%@",model.mobile];
     NSString *string =[phon stringByReplacingOccurrencesOfString:[phon substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,lineView.bottom+20,ScreenW,12);
    label.numberOfLines = 0;
    label.text= [NSString stringWithFormat:@"将验证码发送至 %@，请查收",string];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:13];
    [view addSubview:label];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lineView1.frame = CGRectMake(0, lineView.bottom+122, view.bounds.size.width, 1);
    [view addSubview:lineView1];
    
    //短信按钮MSM
    UIButton *MSMBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [MSMBtn setTitle:@"点击获取" forState:UIControlStateNormal];
    MSMBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [MSMBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [MSMBtn addTarget:self action:@selector(MSMBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:MSMBtn];
    [MSMBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView1.mas_top).offset(0);
        make.right.mas_offset(-15);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(65), IPHONEHIGHT(48)));
    }];
    
    self.textF = [[UITextField alloc]initWithFrame:CGRectMake(25, 140, 200, 48)];
    self.textF.placeholder = @"输入验证码";
    self.textF.keyboardType = UIKeyboardTypePhonePad;
    [view addSubview:self.textF];
    [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView1.mas_top).offset(0);
        make.left.mas_offset(25);
        make.right.equalTo(MSMBtn.mas_left).offset(-5);
        make.height.mas_offset(IPHONEHIGHT(48));
    }];
    //下一步按钮
    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    Btn.backgroundColor= UIColorFromRGBA(0xF7AE2B, 1.0);
    [Btn setTitle:@"下一步" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Btn.layer.cornerRadius = 5;
    [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
    [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-30);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(IPHONEHIGHT(48));
    }];
    

    
}
-(void)MSMBtnClick:(UIButton *)sender{
    UserModel *model = [UserModel getUseData];
    [MBProgressHUD MBProgress:@"发送中..."];

    [[FBHAppViewModel shareViewModel] geTcaptchaWithphone:model.mobile andtype:@"8" Success:^(NSDictionary *resDic) {
        
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
//下一步
-(void)BtnClick:(UIButton *)sender{

    if (self.textF.text==nil||self.textF.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    [MBProgressHUD MBProgress:@"验证中..."];

    UserModel *model = [UserModel getUseData];
    self.mobile_codeString = self.textF.text;
    
    NSString *amount = [NSString stringWithFormat:@"%@",self.scrollView.JEField.text];
    NSDictionary *dict = @{
                           @"account_name":[NSString stringWithFormat:@"%@",self.bankName],
                           @"bank_card_id":[NSString stringWithFormat:@"%@",self.bankid],
                           @"withdraw_amount":amount,
                           @"mobile_code":[NSString stringWithFormat:@"%@",self.mobile_codeString]
                           };
    [[FBHAppViewModel shareViewModel]verify_code_before_insert_withdraw_info:model.merchant_id andstore_id:model.store_id andlistDict:dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
             [self.MobileView removeFromSuperview];
            [self setJHCover];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
}
-(void)deleteClick:(UIButton *)sender{
    
    [self.MobileView removeFromSuperview];
}
- (void)removeCoverView:(JHCoverView *)View{
    
    [self mobile_code];
    [View removeFromSuperview];
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
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

#pragma mark - 5、弹出密码验证
-(void)setJHCover{
    JHCoverView *coverView = [[JHCoverView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    coverView.delegate = self;
    /** 提示 **/
    double fuwu = [self.scrollView.JEField.text doubleValue];
    fuwu = fuwu*F+[_fee_payable doubleValue];
    if (fuwu>[_service_charges_max doubleValue]) {
        fuwu = [_service_charges_max doubleValue];
    }
    coverView.tisi.text = [NSString stringWithFormat:@"提现金额，%@元。服务费%.2lf元",self.scrollView.JEField.text,fuwu];
    double siji = [self.scrollView.JEField.text doubleValue];
    siji = siji-fuwu;
    //实际到帐
    coverView.tisitext.text = [NSString stringWithFormat:@"实际到帐%.2lf元",siji];
    
    self.coverView = coverView;
    [self.coverView.payTextField becomeFirstResponder];
    
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view.window addSubview:coverView];
}
/**
 忘记密码
 */
- (void)forgetPassWordCoverView:(JHCoverView *)control
{
//    JHForgetPWViewController *forgetControl = [[JHForgetPWViewController alloc] init];
    [self.navigationController pushViewController:[PaymentViewController new] animated:YES];
}
/**
 JHCoverViewDelegate的代理方法,密码输入错误
 */
- (void)coverView:(JHCoverView *)control error:(NSString *)errorString
{
    UIAlertController *altertConl = [UIAlertController alertControllerWithTitle:@"" message:errorString  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *againInputAction = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //通知重新输入密码的时候，以前输入的密码清空
        [[NSNotificationCenter defaultCenter] postNotificationName:@"againInputPassWord" object:nil];
        [self setJHCover];
        
    }];
    UIAlertAction *forgetPWAction = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        JHForgetPWViewController *forgetControl = [[JHForgetPWViewController alloc] init];
        //跳转忘记密码界面的时候，通知 输入密码关闭
        [[NSNotificationCenter defaultCenter] postNotificationName:@"forgetInputPassWord" object:nil];
        
        [self.navigationController pushViewController:[PaymentViewController new] animated:YES];
        
    }];
    [altertConl addAction:againInputAction];
    [altertConl addAction:forgetPWAction];
    [self presentViewController:altertConl animated:YES completion:nil];
    
}

/**
 JHCoverViewDelegate的代理方法，密码输入正确
 */
- (void)inputCorrectCoverView:(JHCoverView *)control andPass:(NSString *)pass
{
    NSLog(@" ===== ==  %@",pass);
    
    NSInteger jiner =  [self.scrollView.JEField.text integerValue];
    if (self.scrollView.JEField.text==nil||self.scrollView.JEField.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入金额"];
        return;
    }
    NSInteger Mon = [self.one_time integerValue];
    if (jiner<Mon) {
        NSString *status = [NSString stringWithFormat:@"输入金额请大于%@元",self.one_time];
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:status];
        return;
    }else if (jiner>[self.Maxone_time doubleValue]){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"输入金额请小于%@元",self.Maxone_time]];
        return;
    }
    
    [MBProgressHUD MBProgress:@"数据加载中..."];

    /** 提现请求 **/
    UserModel *model = [UserModel getUseData];
    NSString *payment_pwd = [MD5Sign MD5:pass];
    
    NSString *amount = [NSString stringWithFormat:@"%@",self.scrollView.JEField.text];
    NSDictionary *dict = @{
                           @"account_name":[NSString stringWithFormat:@"%@",self.bankName],
                           @"bank_card_id":[NSString stringWithFormat:@"%@",self.bankid],
                           @"withdraw_amount":amount,
                           @"payment_pwd":[NSString stringWithFormat:@"%@",payment_pwd],
                           @"mobile_code":[NSString stringWithFormat:@"%@",self.mobile_codeString]
                           };
    
    
    
    [[FBHAppViewModel shareViewModel]insert_withdraw_info:model.merchant_id andstore_id:model.store_id andlistDict:dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            WithdrawWinView *tipView = [[NSBundle mainBundle] loadNibNamed:@"WithdrawWinView" owner:self options:nil].lastObject;
            tipView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            tipView.WinActionBlock = ^{
                [self.navigationController popViewControllerAnimated:YES];
            };
            [self.view.window addSubview:tipView];
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"list_new" object:@""];
            [self merchant_center];

        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}


#pragma mark -监听uitextfield的值得变化
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"textField4 - 正在编辑, 当前输入框内容为: %@",text);
    if (text.length>0){
        double fuwu = [text doubleValue];
        if (fuwu>[self.Maxone_time doubleValue]) {
            text = self.Maxone_time;
        }else if (fuwu<10){

        }
        
        fuwu = fuwu*F+[_fee_payable doubleValue];
        if (fuwu>[_service_charges_max doubleValue]) {
            fuwu = [_service_charges_max doubleValue];
        }
        
        self.scrollView.fuwuLabel.textColor =UIColorFromRGBA(0x222222, 1);
        _scrollView.fuwuLabel.text = [NSString stringWithFormat:@"服务费: %.2lf元",fuwu];
    }else{
        self.scrollView.fuwuLabel.textColor =UIColorFromRGBA(0xCCCCCC, 1);
        _scrollView.fuwuLabel.text =[NSString stringWithFormat:@"今日可提现额度为 %@元",_today_withdrawable_amount];
    }
    return YES;
}
#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1100);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}
-(WithdrawView *)scrollView{
    if (!_scrollView) {
        _scrollView =
        [[NSBundle mainBundle] loadNibNamed:@"WithdrawView" owner:nil options:nil][0];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 910);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.JEField.delegate = self;
        YBWeakSelf
        /** 全部额度 **/
        _scrollView.allBlock = ^{
            [weakSelf allAction];
        };
        
        /** 选择银行卡 **/
        _scrollView.CardBlock = ^{
            [weakSelf CardAction];
        };
        
        /** 提现 **/
        _scrollView.notarizeBlock = ^{
            [weakSelf notarizeAction];
        };
        
    }
    return _scrollView;
}
- (NSMutableArray *)bankData{
    if (!_bankData) {
        _bankData = [NSMutableArray array];
    }
    return _bankData;
}
-(FBHWithdraw *)YLSWithdrawView{
    if (!_YLSWithdrawView) {
        _YLSWithdrawView = [[FBHWithdraw alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 1200)];
        _YLSWithdrawView.delagate = self;
    }
    return _YLSWithdrawView;
}
@end
