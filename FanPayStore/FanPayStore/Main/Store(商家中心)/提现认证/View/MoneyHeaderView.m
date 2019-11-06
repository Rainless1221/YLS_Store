//
//  MoneyHeaderView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "MoneyHeaderView.h"

@implementation MoneyHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}
// 创建子视图
- (void)createSubViews {
    [self addSubview:self.CellBase];
 
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(14.5,self.CellBase.bottom+15,120,15);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"账户管理信息";
    [self addSubview:label];
    
    [self.CellBase addSubview:self.line_1];
    [self.CellBase addSubview:self.line_2];
    [self.CellBase addSubview:self.icon_1];
    [self.CellBase addSubview:self.icon_2];
    [self.CellBase addSubview:self.icon_3];

    [self.CellBase addSubview:self.legal_name];
    [self.CellBase addSubview:self.cust_type];
    [self.CellBase addSubview:self.legal_tel];
    [self.CellBase addSubview:self.cell_card];
    [self.CellBase addSubview:self.cell_text];
    [self.CellBase addSubview:self.cell_setup];
    [self.CellBase addSubview:self.cell_details];
    
    
    [self.icon_3 addSubview:self.bank_type];
    [self.icon_3 addSubview:self.bank_card_type];
    [self.icon_3 addSubview:self.cell_bank1];
    [self.icon_3 addSubview:self.bank_account_no];
    [self.icon_3 addSubview:self.cell_amount1];
    [self.icon_3 addSubview:self.withdraw_amount];
    

    self.cell_text.text = @"营收的金额会自动提现到绑定的银行卡";
    
    self.cell_bank1.text = @"卡号";
    self.cell_amount1.text = @"统计金额";

}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data
{
    /*法人*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data[@"legal_name"]]] isEqualToString:@""]) {
        
    }else{
        self.legal_name.text = [NSString stringWithFormat:@"%@",Data[@"legal_name"]];
        [self.legal_name sizeToFit];
    }
    
    /*类型*/
    NSString *str = [NSString stringWithFormat:@"%@",Data[@"cust_type"]];
    
    if ([str isEqualToString:@"1"]) {
        self.cust_type.text = @"小微商户";
    }else if ([str isEqualToString:@"2"]){
        self.cust_type.text = @"个体商户";
    }else if([str isEqualToString:@"3"]){
        self.cust_type.text = @"企业商户";

    }else{
        
    }
    [self.cust_type sizeToFit];
    self.cust_type.mj_x = self.legal_name.right+10;
    self.cust_type.height = self.legal_name.height;
    self.cust_type.width = self.cust_type.width+5;
    
    /*手机号*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data[@"legal_tel"]]] isEqualToString:@""]) {
        
    }else{
        self.legal_tel.text = [NSString stringWithFormat:@"%@",Data[@"legal_tel"]];

    }

    /*审核状态：1未提交 2审核通过 3审核驳回*/
    NSString *status = [NSString stringWithFormat:@"%@",Data[@"status"]];
    
    //审核状态：审核通过
    //审核状态：审核驳回
    //审核状态：未提交
    NSString *protocol1 = [[NSString alloc]init];
    if ([status isEqualToString:@"2"]) {
        protocol1 = [NSString stringWithFormat:@"审核状态：审核通过"];
    }else if ([status isEqualToString:@"3"]){
        protocol1 = [NSString stringWithFormat:@"审核状态：审核驳回"];
    }else{
        protocol1 = [NSString stringWithFormat:@"审核状态：未提交"];
    }
    
    YYLabel *cellnote = [[YYLabel alloc]initWithFrame:CGRectMake(self.legal_tel.right, self.legal_tel.tag, 150, 18)];
    cellnote.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    cellnote.font = [UIFont systemFontOfSize:13];
    cellnote.textAlignment = 2;
    [self.CellBase addSubview:cellnote];
    [cellnote mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-9);
        make.top.mas_offset(42);
    }];
    NSMutableAttributedString *attri_str1=[[NSMutableAttributedString alloc] initWithString:protocol1];
    //设置字体颜色
    [attri_str1 setFont:[UIFont systemFontOfSize:12]];
    [attri_str1 setColor:[UIColor colorWithHexString:@"3D8AFF"]];
    NSRange ProRange1 = [protocol1 rangeOfString:@"审核驳回"];
    //    [attri_str1 setFont:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
    [attri_str1 setTextHighlightRange:ProRange1 color:[UIColor colorWithHexString:@"FF6969"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    
    cellnote.attributedText = attri_str1;
    
    
    /*身份证*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data[@"cert_no"]]] isEqualToString:@""]) {
        
    }else{
        self.cell_card.text = [NSString stringWithFormat:@"%@",Data[@"cert_no"]];

    }

    /*银行卡所属银行*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data[@"bank_type"]]] isEqualToString:@""]) {
        
    }else{
        self.bank_type.text = [NSString stringWithFormat:@"%@",Data[@"bank_type"]];
        [self.bank_type sizeToFit];
        self.bank_card_type.mj_x = self.bank_type.right+5;
        self.bank_card_type.height = self.bank_type.height;
    }
    

    /*银行卡性质
     ：1借记卡 2贷记卡 3单位结算卡
     */
    NSString *str1 = [NSString stringWithFormat:@"%@",Data[@"bank_card_type"]];
    if ([str1 isEqualToString:@"1"]) {
        self.bank_card_type.text = @"借记卡";
    }else if ([str1 isEqualToString:@"2"]){
        self.bank_card_type.text = @"贷记卡";
    }else if ([str1 isEqualToString:@"3"]){
        self.bank_card_type.text = @"单位结算卡";

    }else{
        self.bank_card_type.text = @"";

    }
    
    /*卡号*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data[@"bank_account_no"]]] isEqualToString:@""]) {
        
    }else{
        self.bank_account_no.text = [NSString stringWithFormat:@"%@",Data[@"bank_account_no"]];
    }
    
    /*金额*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data[@"withdraw_amount"]]] isEqualToString:@""]) {
        
    }else{
        self.withdraw_amount.text = [NSString stringWithFormat:@"%@",Data[@"withdraw_amount"]];

    }
    

}
#pragma mark - 去全部填写
-(void)SetUpAction{
    if (self.SetupBlock) {
        self.SetupBlock();
    }
}
-(void)detailsAction{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showErrorWithStatus:@"暂时无法查看"];
}
#pragma mark - 懒加载
-(UIView *)CellBase{
    if (!_CellBase) {
        _CellBase = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 334)];
        _CellBase.backgroundColor = [UIColor whiteColor];
        _CellBase.layer.cornerRadius = 5;
    }
    return _CellBase;
}
-(UIView *)line_1{
    if (!_line_1) {
        _line_1 = [[UIView alloc] init];
        _line_1.frame = CGRectMake(10,66,self.CellBase.width-20,0.5);
        _line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    }
    return _line_1;
}
-(UIView *)line_2{
    if (!_line_2) {
        _line_2 = [[UIView alloc] init];
        _line_2.frame = CGRectMake(10,115,self.CellBase.width-20,0.5);
        _line_2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    }
    return _line_2;
}
-(UIImageView *)icon_1{
    if (!_icon_1) {
        _icon_1 = [[UIImageView alloc]init];
        _icon_1.frame = CGRectMake(10, 10, 24, 24);
        _icon_1.image = [UIImage imageNamed:@"ico_authentication_user"];
    }
    return _icon_1;
}
-(UIImageView *)icon_2{
    if (!_icon_2) {
        _icon_2 = [[UIImageView alloc]init];
        _icon_2.frame = CGRectMake(10, _line_1.bottom+10, 24, 19);
        _icon_2.image = [UIImage imageNamed:@"ico_idcard_blue"];
    }
    return _icon_2;
}
-(UIImageView *)icon_3{
    if (!_icon_3) {
        _icon_3 = [[UIImageView alloc]init];
        _icon_3.frame = CGRectMake(10, _line_2.bottom+15, self.CellBase.width-20, 150);
        _icon_3.image = [UIImage imageNamed:@"bg_authentication_account"];
    }
    return _icon_3;
}
-(UILabel *)legal_name{
    if (!_legal_name) {
        _legal_name = [[UILabel alloc]init];
        _legal_name.frame = CGRectMake(self.icon_1.right+19, 15, 120, 15);
        _legal_name.numberOfLines = 0;
        _legal_name.font = [UIFont systemFontOfSize:15];
        _legal_name.textColor = UIColorFromRGB(0x222222);
    }
    return _legal_name;
}
-(UILabel *)cust_type{
    if (!_cust_type) {
        _cust_type = [[UILabel alloc]init];
        _cust_type.frame = CGRectMake(self.legal_name.right+10, 15, 100, 16);
        _cust_type.numberOfLines = 0;
        _cust_type.font = [UIFont systemFontOfSize:11];
        _cust_type.textColor = UIColorFromRGB(0xFFFFFF);
        _cust_type.backgroundColor = UIColorFromRGB(0x3D8AFF);
        _cust_type.textAlignment = 1;
        _cust_type.layer.cornerRadius = 2;
    }
    return _cust_type;
}
-(UILabel *)legal_tel{
    if (!_legal_tel) {
        _legal_tel = [[UILabel alloc]init];
        _legal_tel.frame = CGRectMake(self.icon_1.right+19, self.legal_name.bottom, 100, 40);
        _legal_tel.numberOfLines = 0;
        _legal_tel.font = [UIFont systemFontOfSize:12];
        _legal_tel.textColor = UIColorFromRGB(0x999999);
    }
    return _legal_tel;
}
-(UILabel *)cell_card{
    if (!_cell_card) {
        _cell_card = [[UILabel alloc]init];
        _cell_card.frame = CGRectMake(self.icon_2.right+19, self.line_1.bottom, self.CellBase.width-20, 50);
        _cell_card.numberOfLines = 0;
        _cell_card.font = [UIFont systemFontOfSize:15];
        _cell_card.textColor = UIColorFromRGB(0x222222);
    }
    return _cell_card;
}
-(UILabel *)cell_text{
    if (!_cell_text) {
        _cell_text = [[UILabel alloc]init];
        _cell_text.frame = CGRectMake(10, self.CellBase.bottom-50, self.CellBase.width-80, 30);
        _cell_text.numberOfLines = 0;
        _cell_text.font = [UIFont systemFontOfSize:12];
        _cell_text.textColor = UIColorFromRGB(0x999999);
    }
    return _cell_text;
}
-(UIButton *)cell_setup{
    if (!_cell_setup) {
        _cell_setup = [UIButton buttonWithType:UIButtonTypeCustom];
        _cell_setup.frame = CGRectMake(self.CellBase.width-50, 0, 50, 50);
        [_cell_setup setImage:[UIImage imageNamed:@"ico_set_blue"] forState:UIControlStateNormal];
        [_cell_setup addTarget:self action:@selector(SetUpAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cell_setup;
}
-(FL_Button *)cell_details{
    if (!_cell_details) {
        _cell_details = [FL_Button buttonWithType:UIButtonTypeCustom];
        _cell_details.frame = CGRectMake(self.CellBase.width-90, self.CellBase.bottom-50, 80, 22);
        [_cell_details setImage:[UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
        [_cell_details setTitle:@"查看明细" forState:UIControlStateNormal];
        [_cell_details setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_cell_details.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _cell_details.status = FLAlignmentStatusCenter;
        _cell_details.fl_padding = 5;
        _cell_details.layer.cornerRadius = 11;
        _cell_details.layer.borderWidth=1;
        _cell_details.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        _cell_details.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
        
        [_cell_details addTarget:self action:@selector(detailsAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _cell_details;
}


-(UILabel *)bank_type{
    if (!_bank_type) {
        _bank_type = [[UILabel alloc]init];
        _bank_type.frame = CGRectMake(44, 21, 150, 13);
        _bank_type.numberOfLines = 0;
        _bank_type.font = [UIFont systemFontOfSize:15];
        _bank_type.textColor = UIColorFromRGB(0xFFFFFF);
    }
    return _bank_type;
}
-(UILabel *)bank_card_type{
    if (!_bank_card_type) {
        _bank_card_type = [[UILabel alloc]init];
        _bank_card_type.frame = CGRectMake(self.bank_type.right +5, 21, 80, 13);
        _bank_card_type.numberOfLines = 0;
        _bank_card_type.font = [UIFont systemFontOfSize:12];
        _bank_card_type.textColor = UIColorFromRGB(0xFFFFFF);
    }
    return _bank_card_type;
}
-(UILabel *)cell_bank1{
    if (!_cell_bank1) {
        _cell_bank1 = [[UILabel alloc]init];
        _cell_bank1.frame = CGRectMake(10, self.bank_type.bottom+15, 80, 13);
        _cell_bank1.numberOfLines = 0;
        _cell_bank1.font = [UIFont systemFontOfSize:10];
        _cell_bank1.textColor = UIColorFromRGB(0xFFFFFF);
    }
    return _cell_bank1;
}
-(UILabel *)bank_account_no{
    if (!_bank_account_no) {
        _bank_account_no = [[UILabel alloc]init];
        _bank_account_no.frame = CGRectMake(10, self.cell_bank1.bottom+5, self.icon_3.width-20, 13);
        _bank_account_no.numberOfLines = 0;
        _bank_account_no.font = [UIFont systemFontOfSize:18];
        _bank_account_no.textColor = UIColorFromRGB(0xFFFFFF);
    }
    return _bank_account_no;
}

-(UILabel *)cell_amount1{
    if (!_cell_amount1) {
        _cell_amount1 = [[UILabel alloc]init];
        _cell_amount1.frame = CGRectMake(10, self.bank_account_no.bottom+15, 80, 13);
        _cell_amount1.numberOfLines = 0;
        _cell_amount1.font = [UIFont systemFontOfSize:10];
        _cell_amount1.textColor = UIColorFromRGB(0xFFFFFF);
    }
    return _cell_amount1;
}
-(UILabel *)withdraw_amount{
    if (!_withdraw_amount) {
        _withdraw_amount = [[UILabel alloc]init];
        _withdraw_amount.frame = CGRectMake(10, self.cell_amount1.bottom+5, self.icon_3.width-20, 13);
        _withdraw_amount.numberOfLines = 0;
        _withdraw_amount.font = [UIFont systemFontOfSize:18];
        _withdraw_amount.textColor = UIColorFromRGB(0xFFFFFF);
    }
    return _withdraw_amount;
}
@end
