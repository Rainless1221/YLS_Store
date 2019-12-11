//
//  FBHWithdraw.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHWithdraw.h"

@implementation FBHWithdraw

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
#pragma mark - 金额部分
    [self addSubview:self.withdrawableView];
    [self.withdrawableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(170);
    }];
    UILabel *withdrawable = [[UILabel alloc]initWithFrame:CGRectMake(21, 30, ScreenW-30, 30)];
    withdrawable.textColor = UIColorFromRGB(0x999999);
    withdrawable.font = [UIFont systemFontOfSize:15];
    withdrawable.text= @"当前可提现（元）";
    [self.withdrawableView addSubview:withdrawable];
    /**提现金额*/
    [self.withdrawableView addSubview:self.withdrawable_cash];
    [self.withdrawable_cash mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(70);
        make.right.mas_offset(-15);
        make.left.mas_offset(15);
    }];
    
    /**冻结金额*/
    [self.withdrawableView addSubview:self.withdrawable_cash1];
    [self.withdrawable_cash1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
        make.right.mas_offset(-10);
        make.left.mas_offset(10);
    }];
    [self.withdrawableView addSubview:self.withdrawable_cash2];
    [self.withdrawable_cash2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.right.mas_offset(-10);
        make.left.equalTo(self.withdrawable_cash1.mas_right).offset(5);
    }];
#pragma mark - 提现确认部分
    UIView *withdra_View=[[UIView alloc]initWithFrame:CGRectMake(0, self.withdrawableView.bottom+15, ScreenW-30, 192+53)];
    withdra_View.backgroundColor = [UIColor whiteColor];
    withdra_View.layer.cornerRadius = 5;
    [self addSubview:withdra_View];
    [withdra_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.withdrawableView.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(192+53);
        
    }];
    /**
     切换按钮
     **/
    self.QieButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.QieButton1.frame = CGRectMake(0, 0, (ScreenW-30)/2, 57);
    [self.QieButton1 setTitle:@"普通提现" forState:UIControlStateNormal];
    [self.QieButton1 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [self.QieButton1 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateSelected];
    self.QieButton1.titleLabel.font = [UIFont systemFontOfSize:15];
    self.QieButton1.selected =YES;
    self.QieButton1.tag = 1;
    [self.QieButton1 addTarget:self action:@selector(QieAction:) forControlEvents:UIControlEventTouchUpInside];
    [withdra_View addSubview:self.QieButton1];
    [self.QieButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.height.mas_offset(57);
        make.width.mas_offset((ScreenW-30)/2);
    }];
    
    self.QieButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.QieButton2 setTitle:@"大额提现" forState:UIControlStateNormal];
    [self.QieButton2 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [self.QieButton2 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateSelected];
    self.QieButton2.titleLabel.font = [UIFont systemFontOfSize:15];
    self.QieButton2.tag = 2;
    [self.QieButton2 addTarget:self action:@selector(QieAction:) forControlEvents:UIControlEventTouchUpInside];
    [withdra_View addSubview:self.QieButton2];
    [self.QieButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.QieButton1.mas_right).offset(0);
        make.top.mas_offset(0);
        make.height.mas_offset(57);
        make.width.mas_offset((ScreenW-30)/2);
    }];
    
    self.view_line = [[UIView alloc] init];
    self.view_line.frame = CGRectMake(0,47,16,2);
    self.view_line.backgroundColor = UIColorFromRGB(0xF7AE2B);
    self.view_line.layer.shadowColor = UIColorFromRGB(0xF7AE2B).CGColor;
    self.view_line.layer.shadowOffset = CGSizeMake(0,1);
    self.view_line.layer.shadowOpacity = 1;
    self.view_line.layer.shadowRadius = 3;
    self.view_line.layer.cornerRadius = 1;
    self.view_line.centerX = self.QieButton1.centerX;
    [withdra_View addSubview:self.view_line];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 86, 15)];
    label1.text = @"提现确认";
    label1.textColor = UIColorFromRGB(0x222222);
    label1.font = [UIFont systemFontOfSize:15];
    [withdra_View addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(53);
        make.height.mas_offset(50);
    }];
    
    /*图标and横线*/
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, 50, ScreenW-50, 1)];
    line1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [withdra_View addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(label1.mas_bottom).offset(0);
        make.height.mas_offset(1);
    }];
    UIImageView *icon1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 24, 24)];
    icon1.image = [UIImage imageNamed:@"icn_withdraw_bank-1"];
    [withdra_View addSubview:icon1];
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line1.mas_bottom).offset(13);
        make.size.mas_offset(CGSizeMake(24, 24));
    }];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, line1.bottom+50, ScreenW-50, 1)];
    line2.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [withdra_View addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(line1.mas_bottom).offset(50);
        make.height.mas_offset(1);
    }];
    UIImageView *icon2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 24, 24)];
    icon2.image = [UIImage imageNamed:@"icn_withdraw_amount-1"];
    [withdra_View addSubview:icon2];
    [icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line2.mas_bottom).offset(13);
        make.size.mas_offset(CGSizeMake(24, 24));
    }];
    
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(10, line2.bottom+50, ScreenW-50, 1)];
    line3.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [withdra_View addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(line2.mas_bottom).offset(50);
        make.height.mas_offset(1);
    }];
    
    
    
    
    
    /**提现金额大于限制额度10000.00元，请分多次提现*/
   self.button = [FL_Button buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@" 提现金额大于限制额度10000.00元，请分多次提现" forState:UIControlStateNormal];
    [self.button setTitleColor:UIColorFromRGB(0xFF6969) forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"icn_message_warning"] forState:UIControlStateNormal];
    [self.button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    self.button.status = FLAlignmentStatusImageLeft;
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.equalTo(withdra_View.mas_bottom).offset(0);
        make.height.mas_offset(36);
    }];
    
    [self addSubview:self.get_withdrawalButton];
    [self.get_withdrawalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.equalTo(self.button.mas_bottom).offset(15);
        make.height.mas_offset(44);
    }];
    
    
    /* 服务费提示 */
    [withdra_View addSubview:self.service_charges_rate];
    [self.service_charges_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY).offset(0);
        make.left.equalTo(label1.mas_right).offset(5);
        make.right.mas_offset(-5);
    }];
    
    [withdra_View addSubview:self.cash];
    [self.cash mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left).offset(0);
        make.top.equalTo(line3.mas_bottom).offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(-50);
    }];
    
    /*全部按钮*/
    [withdra_View addSubview:self.allButton];
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(0);
        make.bottom.mas_offset(0);
        make.width.mas_offset(40);
        make.right.mas_offset(-10);
    }];
    
    /** 输入的金额 */
    [withdra_View addSubview:self.withdraw_amount];
    [self.withdraw_amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(line2.mas_bottom).offset(0);
        make.bottom.equalTo(line3.mas_top).offset(0);
        make.left.equalTo(icon2.mas_right).offset(20);
    }];
    
    
    /*银行卡*/
    [withdra_View addSubview:self.card];
    [self.card mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon1.mas_right).offset(20);
        make.centerY.equalTo(icon1.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    [withdra_View addSubview:self.cardName];
    [self.cardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.card.mas_right).offset(0);
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.bottom.equalTo(line2.mas_top).offset(0);
        make.right.mas_offset(-20);
    }];
    
    [withdra_View addSubview:self.cardButton];
    [self.cardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon1.mas_right).offset(10);
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.bottom.equalTo(line2.mas_top).offset(0);
        make.right.mas_offset(-10);
    }];
    
    
#pragma mark - 温馨提醒部分
    UILabel *Title = [[UILabel alloc]init];
    Title.text = @"温馨提醒";
    Title.textColor = UIColorFromRGB(0x282828);
    Title.font = [UIFont systemFontOfSize:20];
    [self addSubview:Title];
    [Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.get_withdrawalButton.mas_bottom).offset(40);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(200, 18));
    }];
    
    
    
        
        UILabel *Title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, Title.bottom+20, ScreenW-31, 15)];
        Title1.text = @"提现次数";
        Title1.textColor = UIColorFromRGB(0x282828);
        Title1.font = [UIFont systemFontOfSize:15];
        [self addSubview:Title1];
        [Title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Title.mas_bottom).offset(20);
            make.left.mas_offset(31);
            make.size.mas_offset(CGSizeMake(ScreenW-31, 15));
        }];
    UIView *yuan1 = [[UIView alloc]init];
    yuan1.backgroundColor= UIColorFromRGB(0xF7AE2B);
    yuan1.layer.masksToBounds = YES;
    yuan1.layer.cornerRadius = 3;
    [self addSubview:yuan1];
    [yuan1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.equalTo(Title1.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(6, 6));
    }];
    
       self. Remindlabel1 = [[UILabel alloc]init];
        self. Remindlabel1.text = @"商家用户一天的提现次数为5次，无月累计上线";
        self. Remindlabel1.textColor = UIColorFromRGB(0x999999);
        self. Remindlabel1.font = [UIFont systemFontOfSize:13];
        self. Remindlabel1.numberOfLines = 0;
        [self addSubview:self. Remindlabel1];
        [self. Remindlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Title1.mas_bottom).offset(5);
            make.left.mas_offset(31);
            make.width.mas_offset(ScreenW-46);
        }];
        
        
        /*
         22
         */
        UILabel *Title2 = [[UILabel alloc]initWithFrame:CGRectMake(0, self. Remindlabel1.bottom+20, ScreenW-31, 15)];
        Title2.text = @"提现门槛";
        Title2.textColor = UIColorFromRGB(0x282828);
        Title2.font = [UIFont systemFontOfSize:15];
        [self addSubview:Title2];
        [Title2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self. Remindlabel1.mas_bottom).offset(20);
            make.left.mas_offset(31);
            make.size.mas_offset(CGSizeMake(ScreenW-31, 15));
        }];
    UIView *yuan2 = [[UIView alloc]init];
    yuan2.backgroundColor= UIColorFromRGB(0xF7AE2B);
    yuan2.layer.masksToBounds = YES;
    yuan2.layer.cornerRadius = 3;
    [self addSubview:yuan2];
    [yuan2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.equalTo(Title2.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(6, 6));
    }];
    
        self. Remindlabel2 = [[UILabel alloc]init];
        self. Remindlabel2.text = @"提现门槛，满100才能提现";
        self. Remindlabel2.textColor = UIColorFromRGB(0x999999);
        self. Remindlabel2.font = [UIFont systemFontOfSize:13];
        self. Remindlabel2.numberOfLines = 0;
        [self addSubview:self. Remindlabel2];
        [self. Remindlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Title2.mas_bottom).offset(5);
            make.left.mas_offset(31);
            make.width.mas_offset(ScreenW-46);
        }];
        /**
         333
         */
        UILabel *Title3 = [[UILabel alloc]initWithFrame:CGRectMake(0, self. Remindlabel2.bottom+20, ScreenW-31, 15)];
        Title3.text = @"提现额度说明";
        Title3.textColor = UIColorFromRGB(0x282828);
        Title3.font = [UIFont systemFontOfSize:15];
        [self addSubview:Title3];
        [Title3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self. Remindlabel2.mas_bottom).offset(20);
            make.left.mas_offset(31);
            make.size.mas_offset(CGSizeMake(ScreenW-31, 15));
        }];
    UIView *yuan3 = [[UIView alloc]init];
    yuan3.backgroundColor= UIColorFromRGB(0xF7AE2B);
    yuan3.layer.masksToBounds = YES;
    yuan3.layer.cornerRadius = 3;
    [self addSubview:yuan3];
    [yuan3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.equalTo(Title3.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(6, 6));
    }];
        self. Remindlabel3 = [[UILabel alloc]init];
        self. Remindlabel3.text = @"每笔最高20000，每日提现不超过100000，每笔代付费用2元，手续费0.6%";
        self. Remindlabel3.textColor = UIColorFromRGB(0x999999);
        self. Remindlabel3.font = [UIFont systemFontOfSize:13];
        self. Remindlabel3.numberOfLines = 0;
        [self addSubview:self. Remindlabel3];
        [self. Remindlabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Title3.mas_bottom).offset(5);
            make.left.mas_offset(31);
            make.width.mas_offset(ScreenW-46);
        }];
        
      
    
    /**
     444
     */
    UILabel *Title4 = [[UILabel alloc]initWithFrame:CGRectMake(0, self. Remindlabel3.bottom+20, ScreenW-31, 15)];
    Title4.text = @"提现到储蓄卡";
    Title4.textColor = UIColorFromRGB(0x282828);
    Title4.font = [UIFont systemFontOfSize:15];
    [self addSubview:Title4];
    [Title4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self. Remindlabel3.mas_bottom).offset(20);
        make.left.mas_offset(31);
        make.size.mas_offset(CGSizeMake(ScreenW-31, 15));
    }];
    UIView *yuan4 = [[UIView alloc]init];
    yuan4.backgroundColor= UIColorFromRGB(0xF7AE2B);
    yuan4.layer.masksToBounds = YES;
    yuan4.layer.cornerRadius = 3;
    [self addSubview:yuan4];
    [yuan4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.equalTo(Title4.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(6, 6));
    }];
    self. Remindlabel4 = [[UILabel alloc]init];
    self. Remindlabel4.text = @"由于不同银行审批限制，提现申请将在24小时内到账；如遇高峰期，可能延迟到账，请耐心等待";
    self. Remindlabel4.textColor = UIColorFromRGB(0x999999);
    self. Remindlabel4.font = [UIFont systemFontOfSize:13];
    self. Remindlabel4.numberOfLines = 0;
    [self addSubview:self. Remindlabel4];
    [self. Remindlabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Title4.mas_bottom).offset(5);
        make.left.mas_offset(31);
        make.width.mas_offset(ScreenW-46);
    }];
       
    /**
     5555
     */
    UILabel *Title5 = [[UILabel alloc]initWithFrame:CGRectMake(0, self. Remindlabel4.bottom+20, ScreenW-31, 15)];
    Title5.text = @"提现延迟";
    Title5.textColor = UIColorFromRGB(0x282828);
    Title5.font = [UIFont systemFontOfSize:15];
    [self addSubview:Title5];
    [Title5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self. Remindlabel4.mas_bottom).offset(20);
        make.left.mas_offset(31);
        make.size.mas_offset(CGSizeMake(ScreenW-31, 15));
    }];
    UIView *yuan5 = [[UIView alloc]init];
    yuan5.backgroundColor= UIColorFromRGB(0xF7AE2B);
    yuan5.layer.masksToBounds = YES;
    yuan5.layer.cornerRadius = 3;
    [self addSubview:yuan5];
    [yuan5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.equalTo(Title5.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(6, 6));
    }];
    self. Remindlabel5 = [[UILabel alloc]init];
    self. Remindlabel5.text = @"平台将对提现资金进行审核，部分金额将在次日审核通过，到账时间请以实际到账时间为准";
    self. Remindlabel5.textColor = UIColorFromRGB(0x999999);
    self. Remindlabel5.font = [UIFont systemFontOfSize:13];
    self. Remindlabel5.numberOfLines = 0;
    [self addSubview:self. Remindlabel5];
    [self. Remindlabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Title5.mas_bottom).offset(5);
        make.left.mas_offset(31);
        make.width.mas_offset(ScreenW-46);
    }];
    
    

    
}

#pragma mark -监听uitextfield的值得变化
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"textField4 - 正在编辑, 当前输入框内容为: %@",text);
    if (text.length>0){
        double fuwu = [text doubleValue];
        if (fuwu>[self.withdraw_max_limit_one_time doubleValue]) {
            text = self.withdraw_max_limit_one_time;
        }else if (fuwu<10){

        }

        fuwu = fuwu*[self.service_charges_rateD doubleValue]+[self.fee_payable doubleValue];
        if (fuwu>[_service_charges_max doubleValue]) {
            fuwu = [_service_charges_max doubleValue];
        }
        
        self.cash.textColor =UIColorFromRGBA(0x222222, 1);
        self.cash.text = [NSString stringWithFormat:@"服务费: %.2lf元",fuwu];
    }else{
        self.cash.textColor =UIColorFromRGBA(0xCCCCCC, 1);
        self.cash.text =[NSString stringWithFormat:@"今日可提现额度为 %@元",self.today_withdrawable_amount];
    }
    return YES;
}
#pragma mark - 选择银行卡
-(void)cardAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(CardAction)]) {
        [self.delagate CardAction];
        
    }
}
#pragma mark - 全部提现
-(void)AllAction{
    self.withdraw_amount.text = [NSString stringWithFormat:@"%@",self.today_withdrawable_amount];
    double fuwu = [self.withdraw_amount.text doubleValue];
    if (fuwu>[self.withdraw_max_limit_one_time doubleValue]) {
        self.withdraw_amount.text = self.withdraw_max_limit_one_time;
    }else if (fuwu<10){
        
    }
    
    fuwu = fuwu*[self.service_charges_rateD doubleValue]+[self.fee_payable doubleValue];
    if (fuwu>[_service_charges_max doubleValue]) {
        fuwu = [_service_charges_max doubleValue];
    }
    
    self.cash.textColor =UIColorFromRGBA(0x222222, 1);
    self.cash.text = [NSString stringWithFormat:@"服务费: %.2lf元",fuwu];
}
#pragma mark - 切换提现类型
-(void)QieAction:(UIButton *)sender{
    for (int i = 0; i<2; i++) {
        if (sender.tag == i+1) {
            sender.selected = YES;
           self.view_line.centerX = sender.centerX;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+1];
        but.selected = NO;
    }
}
#pragma mark - 提现事件
-(void)getWithdrawAction{
    
}
#pragma mark -赋值
-(void)setData:(NSDictionary *)Data{
    /*余额*/
    self.withdrawable_cash.text = [NSString stringWithFormat:@"%@",Data[@"withdrawable_cash"]];
    /** 服务费率 */
    self.service_charges_rateD = [NSString stringWithFormat:@"%@",Data[@"service_charges_rate"]];
    self.service_charges_rate.text = [NSString stringWithFormat:@"（收取%.2lf%@服务费）",[self.service_charges_rateD doubleValue]*100,@"%"];
    
    /*可提现金额 元*/
    self.today_withdrawable_amount = [NSString stringWithFormat:@"%@",Data[@"today_withdrawable_amount"]];
    self.cash.text = [NSString stringWithFormat:@"今日可提现额度为%@元",self.today_withdrawable_amount];

    /*银行卡信息*/
    NSMutableArray *bankData = [NSMutableArray array];
    for (NSDictionary *dict in Data[@"bank_card_info"]) {
        [bankData addObject:dict];
    }
    if (bankData.count>0) {
        
        NSString *title = [NSString stringWithFormat:@"%@(%@)",bankData[0][@"affiliated_bank"],bankData[0][@"card_no_last_four"]];
        self.cardName.text = [NSString stringWithFormat:@"%@",title];
        NSString *url = bankData[0][@"affiliated_bank_logo"];
        [self.card setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageNamed:@""]];
        //银行卡ID
        self.bankid = bankData[0][@"bank_card_id"];
        //银行卡名称
        self.cardName.text = [NSString stringWithFormat:@"%@",bankData[0][@"affiliated_bank"]];
        [self.card mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(25, 25));
        }];
        _cardName.textColor = UIColorFromRGB(0x222222);
    }else{
        
        [self.card mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(0, 25));
        }];
        _cardName.textColor = UIColorFromRGB(0xCCCCCC);
    }

    
    /**
     温馨提醒
     **/
   //每日限制提现次数  withdraw_max_frequency_one_day
    NSString *withdraw_max_frequency_one_day = [NSString stringWithFormat:@"%@",Data[@"withdraw_max_frequency_one_day"]];
    self.Remindlabel1.text = [NSString stringWithFormat:@"商家用户一天的提现次数为%@次，无月累计上线",withdraw_max_frequency_one_day];
    // 每次提现额度的最小限制  withdraw_min_limit_one_time
    self.withdraw_min_limit_one_time = [NSString stringWithFormat:@"%@",Data[@"withdraw_min_limit_one_time"]];
    self.Remindlabel2.text = [NSString stringWithFormat:@"提现门槛，满%@才能提现",self.withdraw_min_limit_one_time];
    
    //每次提现额度的最大限制 withdraw_max_limit_one_time
    self.withdraw_max_limit_one_time = [NSString stringWithFormat:@"%@",Data[@"withdraw_max_limit_one_time"]];
    //一个商户每日最多能提现的金额  withdraw_amount_limit_one_day
    NSString *withdraw_amount_limit_one_day = [NSString stringWithFormat:@"%@",Data[@"withdraw_amount_limit_one_day"]];
    //服务费最高金额  service_charges_max
    self.service_charges_max = [NSString stringWithFormat:@"%@",Data[@"service_charges_max"]];
    //代付费用  fee_payable
    self.fee_payable = [NSString stringWithFormat:@"%@",Data[@"fee_payable"]];
    
     self. Remindlabel3.text = [NSString stringWithFormat:@"每笔最高%@，每日提现不超过%@，每笔代付费用%@元，手续费%.2lf%@",self.withdraw_max_limit_one_time,withdraw_amount_limit_one_day,self.fee_payable,[self.service_charges_rateD doubleValue]*100,@"%"];
    
    
    [self.button setTitle:[NSString stringWithFormat:@" 提现金额大于限制额度%@元，请分多次提现",self.withdraw_max_limit_one_time] forState:UIControlStateNormal];

    
    
    
}
#pragma mark - 懒加载
- (UIImageView *)withdrawableView{
    if (!_withdrawableView) {
        _withdrawableView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 170)];
        _withdrawableView.image = [UIImage imageNamed:@"bg_withdraw_account_amount-2"];
    }
    return _withdrawableView;
}
-(UILabel *)withdrawable_cash{
    if (!_withdrawable_cash) {
        _withdrawable_cash = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 30)];
        _withdrawable_cash.textColor = UIColorFromRGB(0xF7AE2B);
        _withdrawable_cash.font = [UIFont systemFontOfSize:36];
//        _withdrawable_cash.text= @"14228.00";
    }
    return _withdrawable_cash;
}
-(UILabel *)withdrawable_cash1{
    if (!_withdrawable_cash1) {
        _withdrawable_cash1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 30)];
        _withdrawable_cash1.textColor = UIColorFromRGB(0x999999);
        _withdrawable_cash1.font = [UIFont systemFontOfSize:12];
        _withdrawable_cash1.text= @"提现冻结金额：";
    }
    return _withdrawable_cash1;
}
-(UILabel *)withdrawable_cash2{
    if (!_withdrawable_cash2) {
        _withdrawable_cash2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 30)];
        _withdrawable_cash2.textColor = UIColorFromRGB(0x222222);
        _withdrawable_cash2.font = [UIFont systemFontOfSize:12];
        _withdrawable_cash2.text= @"00.00";
    }
    return _withdrawable_cash2;
}
-(UIButton *)get_withdrawalButton{
    if (!_get_withdrawalButton) {
        _get_withdrawalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_get_withdrawalButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_get_withdrawalButton setTitle:@"确认提现" forState:UIControlStateNormal];
        _get_withdrawalButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
        _get_withdrawalButton.layer.cornerRadius = 10;
        [_get_withdrawalButton addTarget:self action:@selector(getWithdrawAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _get_withdrawalButton;
}
-(UIButton *)allButton{
    if (!_allButton) {
        _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allButton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
        [_allButton setTitle:@"全部" forState:UIControlStateNormal];
        [_allButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_allButton addTarget:self action:@selector(AllAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}
-(UILabel *)cash{
    if (!_cash) {
        _cash = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
        _cash.textColor = UIColorFromRGB(0xCCCCCC);
        _cash.font = [UIFont systemFontOfSize:15];
        _cash.text = @"今日可提现额度为0元";
    }
    return _cash;
}
-(UILabel *)service_charges_rate{
    if (!_service_charges_rate) {
        _service_charges_rate = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
        _service_charges_rate.textColor = UIColorFromRGB(0xCCCCCC);
        _service_charges_rate.font = [UIFont systemFontOfSize:15];
        _service_charges_rate.text = @"（收取 服务费）";
        
    }
    return _service_charges_rate;
}
-(UITextField *)withdraw_amount{
    if (!_withdraw_amount) {
        _withdraw_amount = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _withdraw_amount.textColor = UIColorFromRGB(0x222222);
        _withdraw_amount.font = [UIFont systemFontOfSize:15];
        _withdraw_amount.keyboardType = UIKeyboardTypePhonePad;
        _withdraw_amount.placeholder = @"请输入提现金额";
        _withdraw_amount.delegate = self;
    }
    return _withdraw_amount;
}
-(UIImageView *)card{
    if (!_card) {
        _card = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
//        _card.image = [UIImage imageNamed:@"icn_bank_abc"];
    }
    return _card;
}
-(UILabel *)cardName{
    if (!_cardName) {
        _cardName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _cardName.textColor = UIColorFromRGB(0x222222);
        _cardName.font = [UIFont systemFontOfSize:15];
        _cardName.text = @"请选择银行卡";
    }
    return _cardName;
}

-(FL_Button *)cardButton{
    if (!_cardButton) {
        _cardButton = [FL_Button buttonWithType:UIButtonTypeCustom];
        [_cardButton setImage:[UIImage imageNamed:@"input_arrow_right_deepgray"] forState:UIControlStateNormal];
        _cardButton.status = FLAlignmentStatusRight;
        [_cardButton addTarget:self action:@selector(cardAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cardButton;
}
@end
