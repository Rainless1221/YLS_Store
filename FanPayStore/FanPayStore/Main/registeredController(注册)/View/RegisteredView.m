//
//  RegisteredView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/30.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "RegisteredView.h"

@implementation RegisteredView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    [self addSubview:self.RegisLabel];
    [self addSubview:self.line_phone];
    [self addSubview:self.line_msm];
    [self addSubview:self.line_pawss];
    [self addSubview:self.Field_phone];
    [self addSubview:self.Field_msm];
    [self addSubview:self.Field_pawss];
    [self addSubview:self.Phoneicon];
    
    [self.line_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.RegisLabel.mas_bottom).offset(IPHONEHIGHT(104));
        make.left.mas_offset(IPHONEWIDTH(47.5));
        make.right.mas_offset(IPHONEWIDTH(-47.5));
        make.height.mas_offset(0.5);
    }];
    [self.line_msm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line_phone.mas_bottom).offset(IPHONEHIGHT(50));
        make.left.mas_offset(IPHONEWIDTH(47.5));
        make.right.mas_offset(IPHONEWIDTH(-137.5));
        make.height.mas_offset(0.5);
    }];
    [self.line_pawss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line_msm.mas_bottom).offset(IPHONEHIGHT(50));
        make.left.mas_offset(IPHONEWIDTH(47.5));
        make.right.mas_offset(IPHONEWIDTH(-47.5));
        make.height.mas_offset(0.5);
    }];
    
    [self.Field_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.line_phone.mas_top).offset(1);
        make.left.mas_offset(IPHONEWIDTH(47.5));
        make.right.mas_offset(IPHONEWIDTH(-85.5));
        make.height.mas_offset(IPHONEHIGHT(50));
    }];
    [self.Field_msm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.line_msm.mas_top).offset(1);
        make.left.mas_offset(IPHONEWIDTH(47.5));
        make.right.mas_offset(IPHONEWIDTH(-157.5));
        make.height.mas_offset(IPHONEHIGHT(50));
    }];
    [self.Field_pawss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.line_pawss.mas_top).offset(1);
        make.left.mas_offset(IPHONEWIDTH(47.5));
        make.right.mas_offset(IPHONEWIDTH(-85.5));
        make.height.mas_offset(IPHONEHIGHT(50));
    }];
    [self.Phoneicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.Field_phone.mas_centerY).offset(0);
        make.right.mas_offset(IPHONEWIDTH(-47.5));
        make.height.mas_offset(IPHONEHIGHT(16));
        make.width.mas_offset(IPHONEWIDTH(16));
    }];
    
    /**注册按钮*/
    [self addSubview:self.Button_Regis];
    [self.Button_Regis mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line_pawss.mas_bottom).offset(IPHONEHIGHT(46));
        make.left.mas_offset(IPHONEWIDTH(47.5));
        make.right.mas_offset(IPHONEWIDTH(-47.5));
        make.height.mas_offset(IPHONEHIGHT(44));
    }];
    /**短信验证按钮*/
    [self addSubview:self.Button_MSM];
    [self.Button_MSM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.Field_msm.mas_centerY).offset(0);
        make.right.mas_offset(IPHONEWIDTH(-47.5));
        make.height.mas_offset(IPHONEHIGHT(28));
        make.width.mas_offset(IPHONEWIDTH(80));
    }];
    
    /**去登陆按钮*/
    [self addSubview:self.Button_Login];
    [self.Button_Login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Button_Regis.mas_bottom).offset(IPHONEHIGHT(5));
        make.right.mas_offset(IPHONEWIDTH(-47.5));
        make.height.mas_offset(IPHONEHIGHT(28));
        make.width.mas_offset(IPHONEWIDTH(120));
    }];
    /**密码可见按钮*/
    [self addSubview:self.Pawss_Look];
    [self.Pawss_Look mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.Field_pawss.mas_centerY).offset(0);
        make.right.mas_offset(IPHONEWIDTH(-47.5));
        make.height.mas_offset(IPHONEHIGHT(28));
        make.width.mas_offset(IPHONEWIDTH(30));
    }];
    
    /*协议*/
    YYLabel *xieyi = [[YYLabel alloc]init];
    NSString *protocol = @"注册，请阅读并同意《一鹿省商家入驻协议》";
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:12]];
    attri_str.color= [UIColor blackColor];
    NSRange ProRange = [protocol rangeOfString:@"《一鹿省商家入驻协议》"];
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"3D8AFF"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    xieyi.attributedText = attri_str;
    xieyi.textAlignment = 1;
    xieyi.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [xieyi addGestureRecognizer:labelTapGestureRecognizer];
    [self addSubview:xieyi];

    [xieyi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.bottom.mas_offset(-IPHONEHIGHT(43+(kIs_iPhoneX ? 22:0)));
        make.size.mas_offset(CGSizeMake(ScreenW-20, 35));
    }];
    
    /*添加监听事件*/
    [self.Field_phone addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    [self.Field_msm addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    [self.Field_pawss addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    
}
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    UILabel *label=(UILabel*)recognizer.view;
    NSLog(@"%@被点击了",label.text);
    if (_delegate && [_delegate respondsToSelector:@selector(XieDelegateAction)]) {
        [_delegate XieDelegateAction];
    }
}
#pragma mark - 监听输入框
- (void)myNameStarAction:(UITextField *)textField{
    if (textField == self.Field_phone) {
        self.line_phone.backgroundColor = UIColorFromRGB(0xF7AE2B);
        self.Phoneicon.hidden = NO;
    }else if (textField == self.Field_msm){
        self.line_msm.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }else{
        self.line_pawss.backgroundColor = UIColorFromRGB(0xF7AE2B);
        self.Pawss_Look.hidden = NO;
    }
}
// 失去焦点
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.line_phone.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.line_msm.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.line_pawss.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.Pawss_Look.hidden = YES;
    self.Phoneicon.hidden = YES;

}
#pragma mark - 注册
-(void)RegisAction{
    if (self.Field_phone.text==nil||self.Field_phone.text.length==0 ) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }else if (self.Field_msm.text==nil||self.Field_msm.text.length==0){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }else if (self.Field_pawss.text==nil||self.Field_pawss.text.length==0){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }else if (self.Field_pawss.text.length<6){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码不能少于6位"];
        return ;
        
    }else if (self.Field_pawss.text.length>16){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码不能多于16位"];
        return ;
        
    }
#pragma mark - 密码复杂程度判断
    BOOL Passcheck = [self judgePassWordLegal:self.Field_pawss.text];
    if (!Passcheck) {
        
        return;
    }
    
    /*注册字典*/
    NSDictionary *Dict = @{
                           @"phone":[NSString stringWithFormat:@"%@",self.Field_phone.text],
                           @"msm":[NSString stringWithFormat:@"%@",self.Field_msm.text],
                           @"pawss":[NSString stringWithFormat:@"%@",self.Field_pawss.text]
                           };
    if (_delegate && [_delegate respondsToSelector:@selector(RegisDelegateAction:)]) {
        [_delegate RegisDelegateAction:Dict];
    }
    
}
#pragma mark - 获取验证码
-(void)MSMAction:(UIButton *)sender{
    if (self.Field_phone.text==nil||self.Field_phone.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(MSMDelegateAction:MSMButton:)]) {
        [_delegate MSMDelegateAction:self.Field_phone.text MSMButton:sender];
    }
}
#pragma mark - 密码是否看见
-(void)LookAction:(UIButton *)sender{
    if (sender.selected == NO) {
        sender.selected = YES;
       self.Field_pawss.secureTextEntry = NO;
    }else{
        sender.selected = NO;
        self.Field_pawss.secureTextEntry = YES;
    }
    
}
#pragma mark - 已有账号，去登录
-(void)LoginAction{
    if (_delegate && [_delegate respondsToSelector:@selector(LoginDelegateAction)]) {
        [_delegate LoginDelegateAction];
    }
}
#pragma mark - 密码的  大小写数字判断
- (BOOL)judgePassWordLegal:(NSString *)pass {
    
    // 验证密码长度
    if(pass.length < 6 || pass.length > 16) {
        NSLog(@"请输入6-16的密码");
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入6-16的密码"];
        return NO;
    }
    
    // 验证密码是否包含数字
    NSString *numPattern = @".*\\d+.*";
    NSPredicate *numPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numPattern];
    if (![numPred evaluateWithObject:pass]) {
        NSLog(@"密码必须包含数字");
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码必须包含数字"];
        return NO;
    }
    
    // 验证密码是否包含小写字母
    NSString *lowerPattern = @".*[a-z]+.*";
    NSPredicate *lowerPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lowerPattern];
    if (![lowerPred evaluateWithObject:pass]) {
        NSLog(@"密码必须包含小写字母");
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码必须包含小写字母"];
        return NO;
    }
    
    // 验证密码是否包含大写字母
    NSString *upperPattern = @".*[A-Z]+.*";
    NSPredicate *upperPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", upperPattern];
    if (![upperPred evaluateWithObject:pass]) {
        NSLog(@"密码必须包含大写字母");
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"密码必须包含大写字母"];
        return NO;
    }
    return YES;
}

#pragma mark --- 懒加载
-(UILabel *)RegisLabel{
    if (!_RegisLabel) {
        _RegisLabel = [[UILabel alloc]init];
        _RegisLabel.frame = CGRectMake(autoScaleW(47),autoScaleW(59),autoScaleW(200),20.5);
        _RegisLabel.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _RegisLabel.font = [UIFont systemFontOfSize:autoScaleW(22)];
        _RegisLabel.text = @"欢迎加入一鹿省！";
    }
    return _RegisLabel;
}

-(UIView *)line_phone{
    if (!_line_phone) {
        _line_phone = [[UIView alloc]init];
        _line_phone.frame = CGRectMake(0,0,autoScaleW(190),0.5);
        _line_phone.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    }
    return _line_phone;
}
-(UIView *)line_msm{
    if (!_line_msm) {
        _line_msm = [[UIView alloc]init];
        _line_msm.frame = CGRectMake(0,0,autoScaleW(190),0.5);
        _line_msm.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    }
    return _line_msm;
}
-(UIView *)line_pawss{
    if (!_line_pawss) {
        _line_pawss = [[UIView alloc]init];
        _line_pawss.frame = CGRectMake(0,0,autoScaleW(190),0.5);
        _line_pawss.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    }
    return _line_pawss;
}

-(UITextField *)Field_phone{
    if (!_Field_phone) {
        _Field_phone = [[UITextField alloc]init];
        _Field_phone.frame = CGRectMake(autoScaleW(57.5),autoScaleW(217.5),83,11.5);
        _Field_phone.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _Field_phone.font = [UIFont systemFontOfSize:autoScaleW(15)];
        _Field_phone.placeholder = @"请输入手机号";
        _Field_phone.keyboardType = UIKeyboardTypeDecimalPad;
        _Field_phone.clearButtonMode = UITextFieldViewModeWhileEditing;
        _Field_phone.delegate = self;

    }
    return _Field_phone;
}
-(UITextField *)Field_msm{
    if (!_Field_msm) {
        _Field_msm = [[UITextField alloc]init];
        _Field_msm.frame = CGRectMake(autoScaleW(57.5),autoScaleW(217.5),83,11.5);
        _Field_msm.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _Field_msm.font = [UIFont systemFontOfSize:autoScaleW(15)];
        _Field_msm.placeholder = @"请输入验证码";
        _Field_msm.keyboardType = UIKeyboardTypeDecimalPad;
        _Field_msm.clearButtonMode = UITextFieldViewModeWhileEditing;
        _Field_msm.delegate = self;

    }
    return _Field_msm;
}
-(UITextField *)Field_pawss{
    if (!_Field_pawss) {
        _Field_pawss = [[UITextField alloc]init];
        _Field_pawss.frame = CGRectMake(autoScaleW(57.5),autoScaleW(217.5),240.5,11.5);
        _Field_pawss.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _Field_pawss.font = [UIFont systemFontOfSize:autoScaleW(15)];
        _Field_pawss.placeholder = @"请设置密码（不少于6位字母，数字）";
        _Field_pawss.clearButtonMode = UITextFieldViewModeWhileEditing;
        _Field_pawss.delegate = self;


    }
    return _Field_pawss;
}
-(UIButton *)Button_Regis{
    if (!_Button_Regis) {
        _Button_Regis = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Button_Regis setTitle:@"注册" forState:UIControlStateNormal];
        [_Button_Regis setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Button_Regis.titleLabel.font = [UIFont systemFontOfSize:18];
        _Button_Regis.backgroundColor = UIColorFromRGB(0xF7AE2B);
        _Button_Regis.layer.cornerRadius = 10;
        [_Button_Regis addTarget:self action:@selector(RegisAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Button_Regis;
}
-(UIButton *)Button_MSM{
    if (!_Button_MSM) {
        _Button_MSM = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Button_MSM setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_Button_MSM setTitle:@"再次获取" forState:UIControlStateSelected];
        [_Button_MSM setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
        _Button_MSM.titleLabel.font = [UIFont systemFontOfSize:12];
        _Button_MSM.layer.borderWidth = 1;
        _Button_MSM.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
        _Button_MSM.layer.cornerRadius = 5;
        [_Button_MSM addTarget:self action:@selector(MSMAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _Button_MSM;
}
-(UIButton *)Button_Login{
    if (!_Button_Login) {
        _Button_Login = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Button_Login setTitle:@"已有账号，去登录" forState:UIControlStateNormal];
        [_Button_Login setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        _Button_Login.titleLabel.font = [UIFont systemFontOfSize:13];
        [_Button_Login addTarget:self action:@selector(LoginAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _Button_Login;
}
-(UIImageView *)Phoneicon{
    if (!_Phoneicon) {
        _Phoneicon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        _Phoneicon.image = [UIImage imageNamed:@"btn_product_label_select_yellow"];
        _Phoneicon.hidden = YES;
    }
    return _Phoneicon;
}
-(UIButton *)Pawss_Look{
    if (!_Pawss_Look) {
        _Pawss_Look = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Pawss_Look setImage:[UIImage imageNamed:@"icn_eye_close"] forState:UIControlStateNormal];
        [_Pawss_Look setImage:[UIImage imageNamed:@"icn_eye_open"] forState:UIControlStateSelected];
        [_Pawss_Look addTarget:self action:@selector(LookAction:) forControlEvents:UIControlEventTouchUpInside];
        _Pawss_Look.hidden = YES;
        _Pawss_Look.selected = YES;
    }
    return _Pawss_Look;
}
@end
