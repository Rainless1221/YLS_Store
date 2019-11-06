//
//  YLSLogInController.m
//  FanPayStore
//
//  Created by 苹果笔记本 on 04/10/2019.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSLogInController.h"

@interface YLSLogInController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton * PhonelogType;
@property (nonatomic, strong) UIButton * PasslogType;
@property (nonatomic, strong) UIView * TypeLine;
@property (nonatomic, strong) UIView * TypeLine_1;
//标记登陆方式
@property (assign,nonatomic)BOOL isMVM;
@property (nonatomic, strong) UITextField *PhoneTF_1;
@property (nonatomic, strong) UITextField *MSMTF;
@property (nonatomic, strong) UITextField *PassTF;
//验证码按钮
@property (nonatomic, strong) UIButton * MSMButton;
//
@property (nonatomic, strong) UIView * PhoneLine;
@property (nonatomic, strong) UIView * MSMLine;

@end

@implementation YLSLogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self createUI];

}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    [self.view addSubview:NavView];

    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(NavView.width-88, STATUS_BAR_HEIGHT, 80, 40)];
    [leftbutton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:IPHONEWIDTH(14)]];
    [leftbutton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:leftbutton];
    
}
#pragma mark - 注册
-(void)RighAction{
    FBHregisteredViewController *VC = [FBHregisteredViewController new];
    BaseNavigationController *Nav = [[BaseNavigationController alloc]initWithRootViewController:VC];
     Nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:Nav animated:YES completion:nil];
}
#pragma mark - UI
-(void)createUI{
    //Hello,
    UILabel *label_hello = [[UILabel alloc] init];
    label_hello.numberOfLines = 0;
    label_hello.text = @"Hello,";
    label_hello.textColor = [UIColor blackColor];
    label_hello.font = [UIFont systemFontOfSize:IPHONEWIDTH(15)];
    [self.view addSubview:label_hello];
    [label_hello mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(IPHONEHIGHT(85));
        make.left.mas_offset(IPHONEWIDTH(49));

    }];
    //欢迎回来！
    UILabel *label_HY = [[UILabel alloc] init];
    label_HY.numberOfLines = 0;
    label_HY.text = @"欢迎回来！";
    label_HY.textColor = UIColorFromRGB(0x282828);
    label_HY.font = [UIFont systemFontOfSize:IPHONEWIDTH(22)];
    [self.view addSubview:label_HY];
    [label_HY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(IPHONEHIGHT(103));
        make.left.mas_offset(IPHONEWIDTH(47));

    }];
    
    //切换选择
    [self.view addSubview:self.PhonelogType];
    [self.view addSubview:self.PasslogType];
    [self.view addSubview:self.TypeLine];
    [self.view addSubview:self.TypeLine_1];
    [self.PhonelogType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_HY.mas_bottom).offset(IPHONEHIGHT(65));
        make.left.mas_offset(IPHONEWIDTH(48));
        make.size.mas_offset(CGSizeMake(70, 15));
    }];
    [self.PasslogType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_HY.mas_bottom).offset(IPHONEHIGHT(65));
        make.left.equalTo(self.PhonelogType.mas_right).offset(IPHONEWIDTH(33));
        make.size.mas_offset(CGSizeMake(70, 15));

    }];
    [self.TypeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.PhonelogType.mas_bottom).offset(3);
        make.size.mas_offset(CGSizeMake(20, 1.5));
        make.centerX.equalTo(self.PhonelogType.mas_centerX).offset(0);
    }];
    [self.TypeLine_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.PhonelogType.mas_bottom).offset(3);
        make.size.mas_offset(CGSizeMake(20, 1.5));
        make.centerX.equalTo(self.PasslogType.mas_centerX).offset(0);
    }];
#pragma mark - 输入部分
    [self.view addSubview:self.PhoneTF_1];
    [self.view addSubview:self.PhoneLine];
    [self.view addSubview:self.MSMTF];
    [self.view addSubview:self.PassTF];
    [self.view addSubview:self.MSMLine];
    
    [self.PhoneTF_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONEWIDTH(58));
        make.right.mas_offset(-IPHONEWIDTH(80));
        make.top.mas_offset(IPHONEHIGHT(235));
        make.height.mas_offset(50);

    }];
    [self.PhoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONEWIDTH(48));
        make.right.mas_offset(-IPHONEWIDTH(48));
        make.top.equalTo(self.PhoneTF_1.mas_bottom).offset(0);
        make.height.mas_offset(1);
    }];
    
    
    [self.MSMTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONEWIDTH(58));
        make.right.mas_offset(IPHONEWIDTH(-80));
        make.top.equalTo(self.PhoneTF_1.mas_bottom).offset(IPHONEHIGHT(2));
        make.height.mas_offset(50);
    }];
    [self.PassTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONEWIDTH(58));
        make.right.mas_offset(IPHONEWIDTH(-80));
        make.top.equalTo(self.PhoneTF_1.mas_bottom).offset(IPHONEHIGHT(2));
        make.height.mas_offset(50);
    }];
    [self.MSMLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONEWIDTH(48));
        make.right.mas_offset(IPHONEWIDTH(-48));
        make.top.equalTo(self.MSMTF.mas_bottom).offset(IPHONEHIGHT(1));
        make.height.mas_offset(1);
    }];
    
#pragma mark - 登录按钮
    UIButton *LogButton = [UIButton buttonWithType:UIButtonTypeSystem];
    LogButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [LogButton setTitle:@"登录" forState:UIControlStateNormal];
    [LogButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    LogButton.titleLabel.font = [UIFont systemFontOfSize:IPHONEHIGHT(18)];
    LogButton.layer.cornerRadius = 10;
    [self.view addSubview:LogButton];
    [LogButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONEWIDTH(48));
        make.right.mas_offset(IPHONEWIDTH(-48));
        make.height.mas_offset(44);
        make.top.mas_offset(IPHONEHIGHT(376));
    }];
    
    
}
#pragma mark - 切换登陆方式
-(void)LogTypeAction:(UIButton *)sender{
    if (sender.tag == 1) {
        self.isMVM = NO;
        self.PhonelogType.titleLabel.font = [UIFont systemFontOfSize:15];
        self.PasslogType.titleLabel.font = [UIFont systemFontOfSize:13];
        self.TypeLine.hidden = NO;
        self.TypeLine_1.hidden = YES;
        self.PassTF.hidden = YES;
        self.MSMTF.hidden = NO;

    }else{
        self.isMVM = YES;
        self.PasslogType.titleLabel.font = [UIFont systemFontOfSize:15];
        self.PhonelogType.titleLabel.font = [UIFont systemFontOfSize:13];
        self.TypeLine_1.hidden = NO;
        self.TypeLine.hidden = YES;
        self.PassTF.hidden = NO;
        self.MSMTF.hidden = YES;

    }
    
  
}
#pragma mark -
// 失去焦点
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.PhoneLine.backgroundColor = UIColorFromRGB(0xEAEAEA);
    self.MSMLine.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    self.line3.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    self.line4.backgroundColor = UIColorFromRGB(0xEAEAEA);
    
}
- (void)myNameStarAction:(UITextField *)textField
{
    if (textField == self.PhoneTF_1) {
        self.PhoneLine.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }else if (textField == self.MSMTF){
        self.MSMLine.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }else if (textField == self.PassTF){
        self.MSMLine.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }else{
        self.PhoneLine.backgroundColor = UIColorFromRGB(0xF7AE2B);
    }
    
}
#pragma mark - 懒加载
-(UIButton *)PhonelogType{
    if (!_PhonelogType) {
        _PhonelogType = [UIButton buttonWithType:UIButtonTypeSystem];
        [_PhonelogType setTitle:@"快捷登录" forState:UIControlStateNormal];
        _PhonelogType.titleLabel.font = [UIFont systemFontOfSize:IPHONEHIGHT(13)];
        [_PhonelogType setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        _PhonelogType.tag = 1;
        [_PhonelogType addTarget:self action:@selector(LogTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PhonelogType;
}
-(UIButton *)PasslogType{
    if (!_PasslogType) {
        _PasslogType = [UIButton buttonWithType:UIButtonTypeSystem];
        [_PasslogType setTitle:@"账号登录" forState:UIControlStateNormal];
        _PasslogType.titleLabel.font = [UIFont systemFontOfSize:IPHONEHIGHT(13)];
        [_PasslogType setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        _PasslogType.tag = 2;
        [_PasslogType addTarget:self action:@selector(LogTypeAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _PasslogType;
}
-(UIView *)TypeLine{
    if (!_TypeLine) {
        _TypeLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 1.5)];
        _TypeLine.backgroundColor =  [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return _TypeLine;
}
-(UIView *)TypeLine_1{
    if (!_TypeLine_1) {
        _TypeLine_1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 1.5)];
        _TypeLine_1.backgroundColor =  [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _TypeLine_1.hidden = YES;
    }
    return _TypeLine_1;
}
-(UITextField *)PhoneTF_1{
    if (!_PhoneTF_1) {
        _PhoneTF_1 = [[UITextField alloc]initWithFrame:CGRectMake(58, 235, 190, 50)];
        _PhoneTF_1.keyboardType = UIKeyboardTypePhonePad;
        _PhoneTF_1.placeholder = @"请输入手机号";
        _PhoneTF_1.font = [UIFont systemFontOfSize:IPHONEHIGHT(15)];
        [_PhoneTF_1 addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
        _PhoneTF_1.delegate = self;
        _PhoneTF_1.clearButtonMode = UITextFieldViewModeWhileEditing;

    }
    return _PhoneTF_1;
}
-(UITextField *)MSMTF{
    if (!_MSMTF) {
        _MSMTF = [[UITextField alloc]initWithFrame:CGRectMake(48, self.PhoneTF_1.bottom, 190, 50)];
        _MSMTF.keyboardType = UIKeyboardTypeDecimalPad;
        _MSMTF.placeholder = @"请输入验证码";
        _MSMTF.font = [UIFont systemFontOfSize:IPHONEHIGHT(15)];
        [_MSMTF addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
        _MSMTF.delegate = self;
        _MSMTF.clearButtonMode = UITextFieldViewModeWhileEditing;

    }
    return _MSMTF;
}
-(UITextField *)PassTF{
    if (!_PassTF) {
        _PassTF = [[UITextField alloc]initWithFrame:CGRectMake(48, self.PhoneTF_1.bottom, 190, 50)];
        _PassTF.placeholder = @"请输入密码";
        _PassTF.font = [UIFont systemFontOfSize:IPHONEHIGHT(15)];
        [_PassTF addTarget:self action:@selector(myNameStarAction:) forControlEvents:(UIControlEventEditingDidBegin)];
        _PassTF.hidden = YES;
        _PassTF.delegate = self;
        _PassTF.clearButtonMode = UITextFieldViewModeWhileEditing;

    }
    return _PassTF;
}
-(UIView *)PhoneLine{
    if (!_PhoneLine) {
        _PhoneLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 1)];
        _PhoneLine.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    }
    return _PhoneLine;
}
-(UIView *)MSMLine{
    if (!_MSMLine) {
        _MSMLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 1)];
        _MSMLine.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    }
    return _MSMLine;
}
-(UIButton *)MSMButton{
    if (!_MSMButton) {
        _MSMButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MSMButton setTitle:@"" forState:UIControlStateNormal];
    }
    return _MSMButton;
}
@end
