//
//  BankView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo  _ios. All rights reserved.
//      银行卡信息

#import "BankView.h"

@implementation BankView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    [self addSubview:self.Thetitle_3];
    [self addSubview:self.WeiView_4];
    [self addSubview:self.WeiView_5];
    
    //结算银行卡信息信息
    UILabel *yinhang1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 50)];
    yinhang1.textColor = UIColorFromRGB(0x222222);
    yinhang1.font = [UIFont systemFontOfSize:15];
    yinhang1.text = @"银行卡号";
    [self.WeiView_4 addSubview:yinhang1];
    
    UIView *view_line1 = [[UIView alloc] init];
    view_line1.frame = CGRectMake(10,yinhang1.bottom,self.WeiView_4.width-20,0.5);
    view_line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.WeiView_4 addSubview:view_line1];
    
    UILabel *yinhang2 = [[UILabel alloc]initWithFrame:CGRectMake(10, yinhang1.bottom, 90, 50)];
    yinhang2.textColor = UIColorFromRGB(0x222222);
    yinhang2.font = [UIFont systemFontOfSize:15];
    yinhang2.text = @"卡主姓名";
    [self.WeiView_4 addSubview:yinhang2];
    
    UIView *view_line2 = [[UIView alloc] init];
    view_line2.frame = CGRectMake(10,yinhang2.bottom,self.WeiView_4.width-20,0.5);
    view_line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.WeiView_4 addSubview:view_line2];
    
    UILabel *yinhang3 = [[UILabel alloc]initWithFrame:CGRectMake(10, yinhang2.bottom, 90, 50)];
    yinhang3.textColor = UIColorFromRGB(0x222222);
    yinhang3.font = [UIFont systemFontOfSize:15];
    yinhang3.text = @"账户性质";
    [self.WeiView_4 addSubview:yinhang3];
    
    UIView *view_line3 = [[UIView alloc] init];
    view_line3.frame = CGRectMake(10,yinhang3.bottom,self.WeiView_4.width-20,0.5);
    view_line3.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.WeiView_4 addSubview:view_line3];
    
    UILabel *yinhang4 = [[UILabel alloc]initWithFrame:CGRectMake(10, yinhang3.bottom, 90, 50)];
    yinhang4.textColor = UIColorFromRGB(0x222222);
    yinhang4.font = [UIFont systemFontOfSize:15];
    yinhang4.text = @"卡类性质";
    [self.WeiView_4 addSubview:yinhang4];
    
    UIView *view_line4 = [[UIView alloc] init];
    view_line4.frame = CGRectMake(10,yinhang4.bottom,self.WeiView_4.width-20,0.5);
    view_line4.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.WeiView_4 addSubview:view_line4];
    
    
    UILabel *yinhang5 = [[UILabel alloc]initWithFrame:CGRectMake(10, yinhang4.bottom, 90, 50)];
    yinhang5.textColor = UIColorFromRGB(0x222222);
    yinhang5.font = [UIFont systemFontOfSize:15];
    yinhang5.text = @"所在城市";
    [self.WeiView_4 addSubview:yinhang5];
    
    UIView *view_line5 = [[UIView alloc] init];
    view_line5.frame = CGRectMake(10,yinhang5.bottom,self.WeiView_4.width-20,0.5);
    view_line5.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.WeiView_4 addSubview:view_line5];
    
    
    UILabel *yinhang6 = [[UILabel alloc]initWithFrame:CGRectMake(10, yinhang5.bottom, 90, 50)];
    yinhang6.textColor = UIColorFromRGB(0x222222);
    yinhang6.font = [UIFont systemFontOfSize:15];
    yinhang6.text = @"所属银行";
    [self.WeiView_4 addSubview:yinhang6];
    
    UIView *view_line6 = [[UIView alloc] init];
    view_line6.frame = CGRectMake(10,yinhang6.bottom,self.WeiView_4.width-20,0.5);
    view_line6.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.WeiView_4 addSubview:view_line6];
    
    
    UILabel *yinhang7 = [[UILabel alloc]initWithFrame:CGRectMake(10, yinhang6.bottom, 90, 50)];
    yinhang7.textColor = UIColorFromRGB(0x222222);
    yinhang7.font = [UIFont systemFontOfSize:15];
    yinhang7.text = @"开户支行";
    [self.WeiView_4 addSubview:yinhang7];
    
    UIView *view_line7 = [[UIView alloc] init];
    view_line7.frame = CGRectMake(10,yinhang7.bottom,self.WeiView_4.width-20,0.5);
    view_line7.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.WeiView_4 addSubview:view_line7];
    
    
    UILabel *yinhang8 = [[UILabel alloc]initWithFrame:CGRectMake(10, yinhang7.bottom, 90, 50)];
    yinhang8.textColor = UIColorFromRGB(0x222222);
    yinhang8.font = [UIFont systemFontOfSize:15];
    yinhang8.text = @"预留手机";
    [self.WeiView_4 addSubview:yinhang8];
    
    UILabel *yinhang = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.WeiView_5.width-20, 50)];
    yinhang.textColor = UIColorFromRGB(0x222222);
    yinhang.font = [UIFont systemFontOfSize:15];
    yinhang.text = @"请上传开户银行卡面、反面照片，建议横图";
    [self.WeiView_5 addSubview:yinhang];
    
    
    [self.WeiView_4 addSubview:self.bank_account_no];
    [self.WeiView_4 addSubview:self.bank_account_name];
    [self.WeiView_4 addSubview:self.bank_account_type];
    [self.WeiView_4 addSubview:self.bank_card_type];
    [self.WeiView_4 addSubview:self.Field_8];
    [self.WeiView_4 addSubview:self.bank_type];
    [self.WeiView_4 addSubview:self.bank_name];
    [self.WeiView_4 addSubview:self.bank_name1];
    [self.WeiView_4 addSubview:self.bank_telephone_no];

    [self.WeiView_5 addSubview:self.bank_card_front_pic];
    [self.WeiView_5 addSubview:self.bank_card_back_pic];
    
    /*Button*/
    
    self.type1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.type1.frame = CGRectMake(yinhang3.right, yinhang3.top, self.WeiView_4.width-yinhang3.right-10, 50);
    [self.type1 setImage:[UIImage imageNamed:@"ico_arrow_right_blue"] forState:UIControlStateNormal];
    self.type1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [self.type1 setTitleEdgeInsets:UIEdgeInsetsMake(0, self.type1.width, 0, -10)];

    [self.WeiView_4 addSubview:self.type1];
    
    
    self.type2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.type2.frame = CGRectMake(yinhang4.right, yinhang4.top, self.WeiView_4.width-yinhang4.right-10, 50);
    [self.type2 setImage:[UIImage imageNamed:@"ico_arrow_right_blue"] forState:UIControlStateNormal];
    self.type2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    [self.WeiView_4 addSubview:self.type2];
    
    self.type3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.type3.frame = CGRectMake(yinhang5.right, yinhang5.top, self.WeiView_4.width-yinhang5.right-10, 50);
    [self.type3 setImage:[UIImage imageNamed:@"ico_arrow_right_blue"] forState:UIControlStateNormal];
    self.type3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    [self.WeiView_4 addSubview:self.type3];
    
    
    self.type4 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.type4.frame = CGRectMake(yinhang6.right, yinhang6.top, self.WeiView_4.width-yinhang6.right-10, 50);
    [self.type4 setImage:[UIImage imageNamed:@"ico_arrow_right_blue"] forState:UIControlStateNormal];
    self.type4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    [self.WeiView_4 addSubview:self.type4];
    
    self.type5 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.type5.frame = CGRectMake(self.bank_name.right, yinhang7.top, self.WeiView_4.width-self.bank_name.right-10, 50);
    [self.type5 setImage:[UIImage imageNamed:@"ico_arrow_right_blue"] forState:UIControlStateNormal];
    self.type5.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    [self.WeiView_4 addSubview:self.type5];
    self.type1.tag = 1;
    self.type2.tag = 2;
    self.type3.tag = 3;
    self.type4.tag = 4;
    self.type5.tag = 5;
    [self.type1 addTarget:self action:@selector(TypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.type2 addTarget:self action:@selector(TypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.type3 addTarget:self action:@selector(TypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.type4 addTarget:self action:@selector(TypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.type5 addTarget:self action:@selector(TypeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(becomeMy)];
    [self.bank_name1 addGestureRecognizer:tap];

}
-(void)becomeMy
{
    self.bank_name.hidden= NO;
    self.bank_name1.hidden= YES;
    [self.bank_name becomeFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.bank_name) {
        self.bank_name1.hidden=NO;
        if ([textField.text isEqualToString:@""]) {
            self.bank_name1.textColor = UIColorFromRGB(0x999999);
            self.bank_name1.text= @"如 “厦门江头支行”";
        }
        self.bank_name.hidden=YES;
        [self.bank_name resignFirstResponder];
    }
    
}

-(void)changeLabel:(UITextField *)text
{
    self.bank_name1.hidden=YES;
    self.bank_name1.textColor = [UIColor blackColor];
    self.bank_name1.text = text.text;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"开始编辑");
    [self.bank_name addTarget:self action:@selector(changeLabel:) forControlEvents:UIControlEventEditingChanged];

}


-(void)TypeAction:(UIButton *)Btn{
    if (self.SettypeBlock) {
        self.SettypeBlock(Btn);
    }
    
}

- (void)Action:(UIButton *)sender{
    if (self.ImagePicBlock) {
        self.ImagePicBlock(sender);
    }
    
}
#pragma mark -赋值
- (void)setData:(ysepayModel *)Data{
   

    /*卡号*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.bank_account_no]] isEqualToString:@""]) {
        
    }else{
        self.bank_account_no.text = [NSString stringWithFormat:@"%@",Data.bank_account_no];

    }
    
    /*卡主姓名*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.bank_account_name]] isEqualToString:@""]) {
        
    }else{
        self.bank_account_name.text= [NSString stringWithFormat:@"%@",Data.bank_account_name];

    }
    
    /*省，市*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.bank_province]] isEqualToString:@""]) {
        
    }else{
        _Field_8.text= [NSString stringWithFormat:@"%@%@",Data.bank_province,Data.bank_city];

    }
    
    
    /*银行*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.bank_type]] isEqualToString:@""]) {
        
    }else{
        _bank_type.text= [NSString stringWithFormat:@"%@",Data.bank_type];

    }
    
    /*支行*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.bank_name]] isEqualToString:@""]) {
        
    }else{
        _bank_name1.text= [NSString stringWithFormat:@"%@",Data.bank_name];
        _bank_name1.textColor = UIColorFromRGB(0x222222);
        _bank_name.text= [NSString stringWithFormat:@"%@",Data.bank_name];
    }
    
    /*手机号*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.bank_telephone_no]] isEqualToString:@""]) {
        
    }else{
        _bank_telephone_no.text= [NSString stringWithFormat:@"%@",Data.bank_telephone_no];
        
    }
    
    /*账户性质
     ：1对私 2对公
     */
    NSString *str_type = [NSString stringWithFormat:@"%@",Data.bank_account_type];
    if ([[MethodCommon judgeStringIsNull:str_type] isEqualToString:@""]) {
        
    }else{
        if ([str_type isEqualToString:@"1"]) {
            self.bank_account_type.text = @"对私";
        }else if ([str_type isEqualToString:@"2"]){
            self.bank_account_type.text = @"对公";
        }else{
            
        }
    }
    
    /*银行卡性质
     ：1借记卡 2贷记卡 3单位结算卡
     */
    NSString *str1 = [NSString stringWithFormat:@"%@",Data.bank_card_type];
    if ([[MethodCommon judgeStringIsNull:str1] isEqualToString:@""]) {
        
    }else{
        if ([str1 isEqualToString:@"1"]) {
            self.bank_card_type.text = @"借记卡";
        }else if ([str1 isEqualToString:@"2"]){
            self.bank_card_type.text = @"贷记卡";
        }else if ([str1 isEqualToString:@"3"]){
            self.bank_card_type.text = @"单位结算卡";
            
        }else{
            self.bank_card_type.text = @"";
            
        }
    }
    
    /*图片*/
    
    NSString *url = [NSString stringWithFormat:@"%@",Data.bank_card_front_pic];
    if ([[MethodCommon judgeStringIsNull:url] isEqualToString:@""]) {
    }else{
        if ([PublicMethods isUrl:url]) {
            
        }else{
            url = [NSString stringWithFormat:@"%@%@",FBHApi_Url,url];
        }
        [self.bank_card_front_pic setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"btn_add_authentication_data_normal"]];
    }
    
    
    
    NSString *url1 = [NSString stringWithFormat:@"%@",Data.bank_card_back_pic];
    if ([[MethodCommon judgeStringIsNull:url1] isEqualToString:@""]) {
    }else{
        if ([PublicMethods isUrl:url1]) {
            
        }else{
            url1 = [NSString stringWithFormat:@"%@%@",FBHApi_Url,url1];
        }
        [self.bank_card_back_pic setImageWithURL:[NSURL URLWithString:url1] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"btn_add_authentication_data_normal"]];
    }
}
#pragma mark - 懒加载
-(UILabel *)Thetitle_3{
    if (!_Thetitle_3) {
        _Thetitle_3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 44)];
        _Thetitle_3.font = [UIFont systemFontOfSize:15];
        _Thetitle_3.textColor = UIColorFromRGB(0x222222);
        _Thetitle_3.text = @"结算银行卡信息";
    }
    return _Thetitle_3;
}
-(UIView *)WeiView_4{
    if (!_WeiView_4) {
        _WeiView_4 = [[UIView alloc]initWithFrame:CGRectMake(15, self.Thetitle_3.bottom, ScreenW-30, 403)];
        _WeiView_4.layer.cornerRadius = 5;
        _WeiView_4.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _WeiView_4;
}

-(UIView *)WeiView_5{
    if (!_WeiView_5) {
        _WeiView_5 = [[UIView alloc]initWithFrame:CGRectMake(15, self.WeiView_4.bottom+15, ScreenW-30, 148)];
        _WeiView_5.layer.cornerRadius = 5;
        _WeiView_5.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _WeiView_5;
}

-(UITextField *)bank_account_no{
    if (!_bank_account_no) {
        _bank_account_no = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, ScreenW-150, 50)];
        _bank_account_no.font = [UIFont systemFontOfSize:14];
        _bank_account_no.textColor = UIColorFromRGB(0x222222);
        _bank_account_no.placeholder=@"请输入银行卡号";
        _bank_account_no.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _bank_account_no;
}

-(UITextField *)bank_account_name{
    if (!_bank_account_name) {
        _bank_account_name = [[UITextField alloc]initWithFrame:CGRectMake(100, self.bank_account_no.bottom, ScreenW-150, 50)];
        _bank_account_name.font = [UIFont systemFontOfSize:14];
        _bank_account_name.textColor = UIColorFromRGB(0x222222);
        _bank_account_name.placeholder=@"请输入银行卡卡主姓名";
        _bank_account_name.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _bank_account_name;
}

-(UITextField *)bank_account_type{
    if (!_bank_account_type) {
        _bank_account_type = [[UITextField alloc]initWithFrame:CGRectMake(100, self.bank_account_name.bottom, ScreenW-150, 50)];
        _bank_account_type.font = [UIFont systemFontOfSize:14];
        _bank_account_type.textColor = UIColorFromRGB(0x222222);
        _bank_account_type.placeholder=@"请选择银行卡账户性质";
        _bank_account_type.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _bank_account_type;
}

-(UITextField *)bank_card_type{
    if (!_bank_card_type) {
        _bank_card_type = [[UITextField alloc]initWithFrame:CGRectMake(100, self.bank_account_type.bottom, ScreenW-150, 50)];
        _bank_card_type.font = [UIFont systemFontOfSize:14];
        _bank_card_type.textColor = UIColorFromRGB(0x222222);
        _bank_card_type.placeholder=@"请选择银行卡类型性质";
        _bank_card_type.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _bank_card_type;
}

-(UITextField *)Field_8{
    if (!_Field_8) {
        _Field_8 = [[UITextField alloc]initWithFrame:CGRectMake(100, self.bank_card_type.bottom, ScreenW-150, 50)];
        _Field_8.font = [UIFont systemFontOfSize:14];
        _Field_8.textColor = UIColorFromRGB(0x222222);
        _Field_8.placeholder=@"请选择银行卡开户所在省份、城市";
        _Field_8.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _Field_8;
}

-(UITextField *)bank_type{
    if (!_bank_type) {
        _bank_type = [[UITextField alloc]initWithFrame:CGRectMake(100, self.Field_8.bottom, ScreenW-150, 50)];
        _bank_type.font = [UIFont systemFontOfSize:14];
        _bank_type.textColor = UIColorFromRGB(0x222222);
        _bank_type.placeholder= @"请选择银行卡所属银行";
        _bank_type.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _bank_type;
}
-(UITextField *)bank_name{
    if (!_bank_name) {
        _bank_name = [[UITextField alloc]initWithFrame:CGRectMake(100, self.bank_type.bottom, ScreenW-170, 50)];
        _bank_name.font = [UIFont systemFontOfSize:14];
        _bank_name.textColor = UIColorFromRGB(0x222222);
        _bank_name.placeholder= @"如 “厦门江头支行”";
        _bank_name.clearButtonMode=UITextFieldViewModeWhileEditing;
        _bank_name.hidden = YES;
        _bank_name.delegate = self;
    }
    return _bank_name;
}
-(UILabel *)bank_name1{
    if (!_bank_name1) {
        _bank_name1 = [[UILabel alloc]initWithFrame:CGRectMake(100, self.bank_type.bottom, ScreenW-170, 50)];
        _bank_name1.font = [UIFont systemFontOfSize:14];
        _bank_name1.textColor = UIColorFromRGB(0x999999);
        _bank_name1.text= @"如 “厦门江头支行”";
        _bank_name1.numberOfLines = 0;
        _bank_name1.userInteractionEnabled=YES;

    }
    return _bank_name1;
}
-(UITextField *)bank_telephone_no{
    if (!_bank_telephone_no) {
        _bank_telephone_no = [[UITextField alloc]initWithFrame:CGRectMake(100, self.bank_name.bottom, ScreenW-150, 50)];
        _bank_telephone_no.font = [UIFont systemFontOfSize:14];
        _bank_telephone_no.textColor = UIColorFromRGB(0x222222);
        _bank_telephone_no.placeholder=@"请输入银行卡开户预留手机号码";
        _bank_telephone_no.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _bank_telephone_no;
}
-(UIButton *)bank_card_front_pic{
    if (!_bank_card_front_pic) {
        _bank_card_front_pic = [UIButton buttonWithType:UIButtonTypeCustom];
        _bank_card_front_pic.frame = CGRectMake(10, 54, 74, 74);
        [_bank_card_front_pic setImage:[UIImage imageNamed:@"btn_add_authentication_data_normal"] forState:UIControlStateNormal];
        [_bank_card_front_pic addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        _bank_card_front_pic.tag  =3;
    }
    return _bank_card_front_pic;
}
-(UIButton *)bank_card_back_pic{
    if (!_bank_card_back_pic) {
        _bank_card_back_pic = [UIButton buttonWithType:UIButtonTypeCustom];
        _bank_card_back_pic.frame = CGRectMake(self.bank_card_front_pic.right+10, 54, 74, 74);
        [_bank_card_back_pic setImage:[UIImage imageNamed:@"btn_add_authentication_data_normal"] forState:UIControlStateNormal];
        [_bank_card_back_pic addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        _bank_card_back_pic.tag  = 4;
    }
    return _bank_card_back_pic;
}
@end
