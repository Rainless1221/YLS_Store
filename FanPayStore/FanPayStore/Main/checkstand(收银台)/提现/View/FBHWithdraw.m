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
    withdrawable.textColor = UIColorFromRGB(0xFFFFFF);
    withdrawable.font = [UIFont systemFontOfSize:15];
    withdrawable.text= @"当前可提现（元）";
    [self.withdrawableView addSubview:withdrawable];
    
    [self.withdrawableView addSubview:self.withdrawable_cash];
    [self.withdrawable_cash mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(70);
        make.right.mas_offset(-15);
        make.left.mas_offset(15);
    }];
    
#pragma mark - 提现确认部分
    UIView *withdra_View=[[UIView alloc]initWithFrame:CGRectMake(0, self.withdrawableView.bottom+30, ScreenW-30, 192)];
    withdra_View.backgroundColor = [UIColor whiteColor];
    withdra_View.layer.cornerRadius = 5;
    [self addSubview:withdra_View];
    [withdra_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.withdrawableView.mas_bottom).offset(30);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(192);
        
    }];
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 86, 15)];
    label1.text = @"提现确认";
    label1.textColor = UIColorFromRGB(0x222222);
    label1.font = [UIFont systemFontOfSize:15];
    [withdra_View addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    
    /*图标and横线*/
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, 50, ScreenW-50, 1)];
    line1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [withdra_View addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.mas_offset(50);
        make.height.mas_offset(1);
    }];
    UIImageView *icon1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 24, 24)];
    icon1.image = [UIImage imageNamed:@"icn_withdraw_bank"];
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
    icon2.image = [UIImage imageNamed:@"icn_withdraw_amount"];
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
    FL_Button *button = [FL_Button buttonWithType:UIButtonTypeCustom];
    [button setTitle:@" 提现金额大于限制额度10000.00元，请分多次提现" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0xFF6969) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icn_message_warning"] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    button.status = FLAlignmentStatusImageLeft;
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.equalTo(withdra_View.mas_bottom).offset(0);
        make.height.mas_offset(36);
    }];
    
    [self addSubview:self.get_withdrawalButton];
    [self.get_withdrawalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.equalTo(button.mas_bottom).offset(15);
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
        make.left.equalTo(icon2.mas_right).offset(10);
    }];
    
    
    /*银行卡*/
    [withdra_View addSubview:self.card];
    [self.card mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon1.mas_right).offset(10);
        make.centerY.equalTo(icon1.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    [withdra_View addSubview:self.cardName];
    [self.cardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.card.mas_right).offset(10);
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
        make.top.equalTo(self.get_withdrawalButton.mas_bottom).offset(48);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    
    NSArray *titleArr = @[@"提现次数",@"提现到储蓄卡"];
    NSArray *tetleArr = @[@"商家用户一天的提现次数为100次，无月累计上限",@"因不同银行提现的额度会有所不同，具体限额以银行规 定为准"];
    
    for (int i =0; i<titleArr.count; i++) {
        
        
        
        UILabel *Title1 = [[UILabel alloc]init];
        Title1.text = [NSString stringWithFormat:@"%@",titleArr[i]];
        Title1.textColor = UIColorFromRGB(0x282828);
        Title1.font = [UIFont systemFontOfSize:15];
        [self addSubview:Title1];
        [Title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Title.mas_bottom).offset(20+i*56);
            make.left.mas_offset(31);
            make.size.mas_offset(CGSizeMake(ScreenW-31, 30));
        }];
        
        UIView *yuan = [[UIView alloc]init];
        yuan.backgroundColor= UIColorFromRGB(0xF7AE2B);
        [self addSubview:yuan];
        [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.equalTo(Title1.mas_centerY).offset(0);
            make.size.mas_offset(CGSizeMake(6, 6));
            
        }];
    }
    
    
    for (int i =0; i<tetleArr.count; i++) {
        
        UILabel *Title1 = [[UILabel alloc]init];
        Title1.text = [NSString stringWithFormat:@"%@",tetleArr[i]];
        Title1.textColor = UIColorFromRGB(0x999999);
        Title1.font = [UIFont systemFontOfSize:13];
        Title1.numberOfLines = 0;
        [self addSubview:Title1];
        [Title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Title.mas_bottom).offset(40+i*56);
            make.left.mas_offset(31);
            make.size.mas_offset(CGSizeMake(ScreenW-36, 35));
        }];
        
    }
    
}
#pragma mark - 选择银行卡
-(void)cardAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(Cardbanks)]) {
        [self.delagate Cardbanks];
        
    }
}
#pragma mark - 全部提现
-(void)AllAction{
    self.withdraw_amount.text = [NSString stringWithFormat:@"%@",self.withdrawable_cash.text];
    
//    if (self.delagate && [self.delagate respondsToSelector:@selector(WithdrawAmount:)]) {
//        [self.delagate WithdrawAmount:self.withdrawable_cash.text];
//
//    }
}
#pragma mark -赋值
-(void)setData:(NSDictionary *)Data{
    /*余额*/
    self.withdrawable_cash.text = [NSString stringWithFormat:@"%@",Data[@"withdrawable_cash"]];
    /*可提现金额 元*/
    self.cash.text = [NSString stringWithFormat:@"可提现金额%@元",Data[@"withdrawable_cash"]];
    /*服务费比例*/
    self.service_charges_rate.text = [NSString stringWithFormat:@"（收取%@%@服务费）",Data[@"service_charges_rate"],@"%"];
    
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
//        self.bankid = self.bankData[0][@"bank_card_id"];
        //银行卡名称
//        self.bankName = [NSString stringWithFormat:@"%@",self.bankData[0][@"affiliated_bank"]];
    }
    
}
#pragma mark - get
- (UIImageView *)withdrawableView{
    if (!_withdrawableView) {
        _withdrawableView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 170)];
//        _withdrawableView.image = [UIImage imageNamed:@"bg_withdraw_account_amount"];
        _withdrawableView.backgroundColor = UIColorFromRGB(0x222222);
    }
    return _withdrawableView;
}
-(UILabel *)withdrawable_cash{
    if (!_withdrawable_cash) {
        _withdrawable_cash = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 30)];
        _withdrawable_cash.textColor = UIColorFromRGB(0xFFFFFF);
        _withdrawable_cash.font = [UIFont systemFontOfSize:36];
        _withdrawable_cash.text= @"14228.00";
    }
    return _withdrawable_cash;
}
-(UIButton *)get_withdrawalButton{
    if (!_get_withdrawalButton) {
        _get_withdrawalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_get_withdrawalButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_get_withdrawalButton setTitle:@"确认提现" forState:UIControlStateNormal];
        _get_withdrawalButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
        _get_withdrawalButton.layer.cornerRadius = 10;
    }
    return _get_withdrawalButton;
}
-(UIButton *)allButton{
    if (!_allButton) {
        _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
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
        _cash.text = @"可提现金额0元";
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
        _withdraw_amount.textColor = UIColorFromRGB(0x3D8AFF);
        _withdraw_amount.font = [UIFont systemFontOfSize:15];
        _withdraw_amount.keyboardType = UIKeyboardTypePhonePad;
        _withdraw_amount.placeholder = @"请输入提现金额";
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
        [_cardButton setImage:[UIImage imageNamed:@"input_arrow_right_blue"] forState:UIControlStateNormal];
        _cardButton.status = FLAlignmentStatusRight;
        [_cardButton addTarget:self action:@selector(cardAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cardButton;
}
@end
