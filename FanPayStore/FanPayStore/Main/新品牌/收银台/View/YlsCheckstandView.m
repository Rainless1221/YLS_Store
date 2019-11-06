//
//  YlsCheckstandView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/4.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YlsCheckstandView.h"

@implementation YlsCheckstandView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
#pragma mark - 当前余额：
    [self addSubview:self.checkView1];
    [self.checkView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(12);
        make.left.mas_offset(IPHONEWIDTH(15));
        make.right.mas_offset(-IPHONEWIDTH(15));
        make.height.mas_offset(IPHONEHIGHT(209));
    }];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, 15)];
    label1.text = @"当前余额：";
    label1.textColor = UIColorFromRGB(0x282828);
    label1.font = [UIFont systemFontOfSize:IPHONEWIDTH(15)];
    [self.checkView1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONEWIDTH(11));
        make.top.mas_offset(IPHONEHIGHT(15));
    }];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"icn_eye_open"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"icn_eye_close"] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(isSetLook:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkView1 addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(-2);
        make.centerY.equalTo(label1.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(25, 30));
    }];
    
    FL_Button *button2 = [FL_Button buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"去提现" forState:UIControlStateNormal];
    [button2 setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"input_arrow_right_blue"] forState:UIControlStateNormal];
    button2.layer.borderWidth = 1;
    button2.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
    button2.status = FLAlignmentStatusCenter;
    button2.fl_padding = 5;
    button2.layer.cornerRadius = 22/2;
    button2.titleLabel.font = [UIFont systemFontOfSize:IPHONEWIDTH(12)];
    [button2 addTarget:self action:@selector(WithdrawAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkView1 addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-IPHONEWIDTH(10));
        make.centerY.equalTo(label1.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(64, 22));
    }];
    //余额
    [self.checkView1 addSubview:self.current_balance];
    [self.current_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(IPHONEHIGHT(63));
        make.left.right.mas_offset(0);
    }];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
    label2.text = @"今日营收（元）";
    label2.textColor = UIColorFromRGB(0x999999);
    label2.font = [UIFont systemFontOfSize:12];
    label2.textAlignment = 1;
    [self.checkView1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.current_balance.mas_bottom).offset(30);
        make.left.mas_offset(0);
        make.size.mas_offset(CGSizeMake((ScreenW-30)/2, 15));
    }];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
    label3.text = @"累计营收（元）";
    label3.textColor = UIColorFromRGB(0x999999);
    label3.font = [UIFont systemFontOfSize:12];
    label3.textAlignment = 1;
    [self.checkView1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.current_balance.mas_bottom).offset(30);
        make.left.equalTo(label2.mas_right).offset(0);
        make.size.mas_offset(CGSizeMake((ScreenW-30)/2, 15));
    }];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 36)];
    line1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.checkView1 addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2.mas_right).offset(0);
        make.top.equalTo(label2.mas_top).offset(0);
        make.size.mas_offset(CGSizeMake(1, 36));
    }];
#pragma mark - 商家订单
    [self addSubview:self.checkView2];
    [self.checkView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkView1.mas_bottom).offset(15);
        make.left.mas_offset(IPHONEWIDTH(15));
        make.right.mas_offset(-IPHONEWIDTH(15));
        make.height.mas_offset(IPHONEHIGHT(139));
    }];
    CGFloat Bwidth = (ScreenW-50)/4;
    CGFloat Bheight = 88;

    NSArray *orderArray = @[@"全部",@"待支付",@"已支付",@"已评价"];
    NSArray *order_imageAry = @[@"icn_b_order_all",@"icn_b_order_tobepaid",@"icn_b_order_paid",@"icn_b_order_evaluated"];
    
    UILabel *centerlabel4= [[UILabel alloc]init];
    centerlabel4.text =@"商家订单";
    centerlabel4.textColor = UIColorFromRGB(0x282828);
    centerlabel4.font = [UIFont systemFontOfSize:15];
    [self.checkView2 addSubview:centerlabel4];
    [centerlabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    for (int i = 0; i<orderArray.count; i++) {
        FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(i*Bwidth+10, 35, Bwidth, Bheight);
        [thirdBtn setImage:[UIImage imageNamed:order_imageAry[i]] forState:UIControlStateNormal];
        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",orderArray[i]] forState:UIControlStateNormal];
        [thirdBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
        //样式
        thirdBtn.status = FLAlignmentStatusTop;
        thirdBtn.fl_padding = 10;
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.checkView2 addSubview:thirdBtn];
//        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        thirdBtn.tag = i+20;
        
    }
#pragma mark - 统计
    UIButton *button_TJ = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_TJ  setImage:[UIImage imageNamed:@"revenue_statistics_entrance"] forState:UIControlStateNormal];
    [button_TJ  setImage:[UIImage imageNamed:@"revenue_statistics_entrance"] forState:UIControlStateHighlighted];
//    [button_TJ addTarget:self action:@selector(TJAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button_TJ];
    [button_TJ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkView2.mas_bottom).offset(15);
        make.left.right.mas_offset(0);
        make.height.mas_offset(65);
    }];
    
#pragma mark - 营收记录
    [self addSubview:self.checkView3];
    [self.checkView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button_TJ.mas_bottom).offset(15);
        make.left.mas_offset(IPHONEWIDTH(15));
        make.right.mas_offset(-IPHONEWIDTH(15));
        make.height.mas_offset(IPHONEHIGHT(139));
    }];
    
}

#pragma mark - 余额是否可见
- (void)isSetLook:(UIButton *)sender{
    
    if (sender.selected == YES) {
        [PublicMethods writeToUserD:@"YES" andKey:@"islook"];
        sender.selected = NO;
//        self.current_balance.text = @"****";
        
    }else{
        [PublicMethods writeToUserD:@"NO" andKey:@"islook"];
        sender.selected = YES;
//        if ([[MethodCommon judgeStringIsNull:self.current_balance_String] isEqualToString:@""]) {
//            self.current_balance.text =  [NSString stringWithFormat:@"¥ 00.00"];
//        }else{
//            self.current_balance.text =  [NSString stringWithFormat:@" %@",self.current_balance_String];
//        }

    }
    
}
#pragma mark -去提现
-(void)WithdrawAction:(UIButton *)sender{
//    if (self.delagate && [self.delagate respondsToSelector:@selector(getWithdraw)]) {
//        [self.delagate getWithdraw];
//    }
}
#pragma mark - 懒加载
- (UIView *)checkView1{
    if (!_checkView1) {
        _checkView1 = [[UIView alloc]init];
        _checkView1.backgroundColor = [UIColor whiteColor];
        _checkView1.layer.cornerRadius = 5;
    }
    return _checkView1;
}
- (UIView *)checkView2{
    if (!_checkView2) {
        _checkView2 = [[UIView alloc]init];
        _checkView2.backgroundColor = [UIColor whiteColor];
        _checkView2.layer.cornerRadius = 5;
    }
    return _checkView2;
}
- (UIView *)checkView3{
    if (!_checkView3) {
        _checkView3 = [[UIView alloc]init];
        _checkView3.backgroundColor = [UIColor whiteColor];
        _checkView3.layer.cornerRadius = 5;
    }
    return _checkView3;
}


- (UILabel *)current_balance{
    if (!_current_balance) {
        _current_balance = [[UILabel alloc]init];
        _current_balance.textColor =UIColorFromRGB(0xF7AE2A);
        _current_balance.font = [UIFont systemFontOfSize:IPHONEHIGHT(36)];
        _current_balance.textAlignment = 1;
        _current_balance.text = @"0.00";
    }
    return _current_balance;
}
- (UILabel *)Label_balance{
    if (!_Label_balance) {
        _Label_balance = [[UILabel alloc]init];
        _Label_balance.textColor =UIColorFromRGB(0xF7AE2A);
        _Label_balance.font = [UIFont systemFontOfSize:IPHONEHIGHT(36)];
        _Label_balance.textAlignment = 1;
        _Label_balance.text = @"0.00";
    }
    return _Label_balance;
}
@end
