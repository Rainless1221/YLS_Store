//
//  JHCoverView.m
//  支付
//
//  Created by zhou on 16/10/14.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHCoverView.h"


@interface JHCoverView ()<UITextFieldDelegate>
/** 白色view */
@property (nonatomic, strong) UIView *bottomView;
/** 显示密码的数量 */
@property (nonatomic,assign) int pwCount;
/** 存放背景颜色是 黑色点 的UIImageView */
@property (nonatomic, strong) NSMutableArray *pwArray;
/** 键盘的高度 */
@property (nonatomic,assign) CGFloat keyBoardHeight;
/** 忘记密码 */
@property (nonatomic, strong) UIButton *forgetPWBtn;
/** 表示在弹出键盘的时候只设置bottomView的高度一次 */
@property (nonatomic,assign) BOOL isFirst;


@end

@implementation JHCoverView

- (NSMutableArray *)pwArray
{
    if (_pwArray == nil) {
        _pwArray = [NSMutableArray array];
    }
    return _pwArray;
}
- (NSMutableString *)pwStr
{
    if (_pwStr == nil) {
        _pwStr = [NSMutableString string];
    }
    return _pwStr;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 监听键盘的位置改变
        // 监听键盘的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        //监听重新输入密码的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(againInputPW) name:@"againInputPassWord" object:nil];
        //监听忘记密码的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPassWord) name:@"forgetInputPassWord" object:nil];
        //默认yes
        self.isFirst = YES;
        //默认是0，就是密码没有输入
        self.pwCount = 0;
    
        //创建UI
        [self createUI];
        
    }
    
    return self;
}

/**
 键盘通知方法
 */
- (void)keyboardWillChangeFrame:(NSNotification *)noty
{
    CGRect keyboardFrame = [noty.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyBoardHeight = keyboardFrame.size.height;
    
    if (self.isFirst) {
        self.isFirst = NO;
        //设置bottomView的高度为所有控件的高度和空隙之和
        CGRect bottomFrame = self.bottomView.frame;
        bottomFrame.size.height = self.keyBoardHeight + CGRectGetMaxY(self.forgetPWBtn.frame);
        bottomFrame.origin.y = self.bounds.size.height - bottomFrame.size.height;
        self.bottomView.frame = bottomFrame;
    }
    
}

/**
 重新输入密码的通知
 */
- (void)againInputPW
{
    //所有的代表密码的黑色圆点隐藏
    for (int i = 0; i < 6; i++) {
        UIImageView *pwImageView = self.pwArray[i];
        pwImageView.hidden = YES;
    }
    //存储密码的字符串置为空
    self.pwStr = nil;
    //payTextField置为空
    self.payTextField.text = nil;
    //输入密码个数置为0
    self.pwCount = 0;

}

/**
 忘记密码的通知
 */
- (void)forgetPassWord
{
    [self deleteClick:nil];
}
/**
 创建UI
 */
- (void)createUI
{
    //创建白色view
    UIView *bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    CGFloat bottomH = 100;
    CGFloat bottomY = self.bounds.size.height - bottomH;
    bottomView.frame = CGRectMake(0, bottomY, self.bounds.size.width, bottomH);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    //创建白色头上的提示view
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake(0, 0, bottomView.bounds.size.width, 60);
    [bottomView addSubview:headerView];
    //灰色的横线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lineView.frame = CGRectMake(0, headerView.bounds.size.height-1, headerView.bounds.size.width, 1);
    [headerView addSubview:lineView];
    
    UILabel *tisi = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.bottom+5, headerView.width, 20)];
    tisi.text = @"提现金额，8000.00元。服务费8.00元";
    tisi.textColor = [UIColor blackColor];
    tisi.font = [UIFont systemFontOfSize:15];
    tisi.textAlignment = 1;
    [headerView addSubview:tisi];
    self.tisi = tisi;
    
    UILabel *tisitext = [[UILabel alloc]initWithFrame:CGRectMake(0, tisi.bottom+5, headerView.width, 20)];
    tisitext.text = @"实际到帐 8000.00";
    tisitext.textColor = UIColorFromRGB(0xF7AE2B);
    tisitext.font = [UIFont systemFontOfSize:15];
    tisitext.textAlignment = 1;
    [headerView addSubview:tisitext];
    self.tisitext =tisitext;
    
    //删除(左上角的叉号)
    UIButton *deleteBtn = [[UIButton alloc] init];
    deleteBtn.bounds = CGRectMake(0, 0, 40, 40);
    deleteBtn.center = CGPointMake(deleteBtn.bounds.size.width/2 + 10, headerView.bounds.size.height/2);
    [deleteBtn setImage:[UIImage imageNamed:@"suspension_layer_btn_back_normal"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:deleteBtn];
    deleteBtn.tag = 44;
    //输入密码提示
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"输入密码";
    promptLabel.textColor = [UIColor blackColor];
    promptLabel.font = [UIFont systemFontOfSize:17];
    [promptLabel sizeToFit];
    promptLabel.center = CGPointMake(headerView.bounds.size.width/2, headerView.bounds.size.height/2);
    [headerView addSubview:promptLabel];
    
    //UITextField
    NewTextField *payTextField = [[NewTextField alloc] init];
    self.payTextField = payTextField;
    //payTextField的高度为6等份的宽度
    payTextField.frame = CGRectMake(10, CGRectGetMaxY(headerView.frame) + 50, bottomView.bounds.size.width - 20, (bottomView.bounds.size.width - 20) / 6-5);
    //设置样式
    payTextField.borderStyle = UITextBorderStyleRoundedRect;
    //设置payTextField的键盘
    payTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    payTextField.keyboardType = UIKeyboardTypeDecimalPad;
    //取消payTextField的光标
    payTextField.tintColor = [UIColor clearColor];
    //    [payTextField becomeFirstResponder];
    payTextField.delegate = self;
    
    //UIControlEventEditingChanged的方法
    [payTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [bottomView addSubview:payTextField];
    
    //创建5条竖线来分割payTextField
    for (int i = 0; i < 5; i++) {
        UIImageView *lineImageView = [[UIImageView alloc] init];
        CGFloat lineX = self.payTextField.bounds.size.width / 6;
        lineImageView.frame = CGRectMake(lineX * (i + 1) + 10, self.payTextField.frame.origin.y, 1, self.payTextField.bounds.size.height);
        lineImageView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [bottomView addSubview:lineImageView];
    }
    //在分割好的6个框中间都放入一个 黑色的圆点 来代表输入的密码
    for (int i = 0; i < 6; i++) {
        UIImageView *passWordImageView = [[UIImageView alloc] init];
        CGFloat pwX = self.payTextField.bounds.size.width / 6;
        passWordImageView.bounds = CGRectMake(0, 0, 10, 10);
        passWordImageView.center = CGPointMake(pwX/2 + pwX * i + 10, self.payTextField.frame.origin.y + self.payTextField.bounds.size.height/2);
        passWordImageView.backgroundColor = [UIColor blackColor];
        passWordImageView.layer.cornerRadius = 10/2;
        passWordImageView.clipsToBounds = YES;
        passWordImageView.hidden = YES;
        [bottomView addSubview:passWordImageView];
        [self.pwArray addObject:passWordImageView];
    }
    //忘记密码
    UIButton *forgetPWBtn = [[UIButton alloc] init];
    self.forgetPWBtn = forgetPWBtn;
    [forgetPWBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPWBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    forgetPWBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [forgetPWBtn sizeToFit];
    forgetPWBtn.frame = CGRectMake(bottomView.bounds.size.width - forgetPWBtn.bounds.size.width - 10, CGRectGetMaxY(payTextField.frame) + 10, forgetPWBtn.bounds.size.width, forgetPWBtn.bounds.size.height);
    [forgetPWBtn addTarget:self action:@selector(forgetPWclick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:forgetPWBtn];
    
}

/**
 删除方法，即是左上角的叉号的方法
 */
- (void)deleteClick:(UIButton *)sender
{
    if (sender.tag == 44) {
        if ([self.delegate respondsToSelector:@selector(removeCoverView:)]) {
            [self.delegate removeCoverView:self];
        }
    }
   
    //    [self.coverView removeFromSuperview];
    //隐藏
    self.hidden = YES;
    //退出键盘
    [self.payTextField endEditing:YES];
    //所有的代表密码的黑色圆点隐藏
    for (int i = 0; i < 6; i++) {
        UIImageView *pwImageView = self.pwArray[i];
        pwImageView.hidden = YES;
    }
    //存储密码的字符串置为空
    self.pwStr = nil;
    //payTextField置为空
    self.payTextField.text = nil;
    //输入密码个数置为0
    self.pwCount = 0;
    
}

/**
 忘记密码
 */
- (void)forgetPWclick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(forgetPassWordCoverView:)]) {
        [self deleteClick:nil];
        [self.delegate forgetPassWordCoverView:self];
    }
}
/**
 UITextFieldDelegate代理方法
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {//点击的是键盘的删除按钮
        //输入密码的个数－1
        self.pwCount--;
        //deleteCharactersInRange: 删除存储密码的字符串pwStr的最后一位
        [self.pwStr deleteCharactersInRange:NSMakeRange(self.pwStr.length-1, 1)];
        return YES;
    }else if (self.pwCount == 6)//输入的密码个数最多是6个
    {
        return NO;//返回no，不能够在输入
    }
    else
    {
        //在存储密码的字符串的后面假如一位输入的数字
        [self.pwStr appendString:string];
        //输入密码的个数＋1
        self.pwCount = self.pwCount + 1;
    }
    
    
    return YES;
}

/**
 UIControlEventEditingChanged的方法
 */
- (void)textChange:(UITextField *)textField
{
    //每一次输入密码的时候，都把payTextField设置为空
    self.payTextField.text = nil;
    
    //根据输入的密码的个数(pwCount)，来给payTextField设置@" "，这样就看不见payTextField里面的内容，也就是用@" "来代替输入的数字
    NSString *str = [NSString string];
    for (int i = 0; i < self.pwCount; i++) {
        str = [str stringByAppendingString:@" "];
        //输入多少个数字，那么pwArray中存储的UIImageView就有多少个显示
        UIImageView *pwImageView = self.pwArray[i];
        pwImageView.hidden = NO;
    }
    //其余的pwArray中存储的UIImageView就不显示
    for (int i = 5; i >= self.pwCount; i--) {
        UIImageView *pwImageView = self.pwArray[i];
        pwImageView.hidden = YES;
    }
    
    self.payTextField.text =str;
    
    NSLog(@"textChange==%@",self.pwStr);
    
    if (self.pwStr.length == 6) {
        [self verify:self.pwStr];
//        if (isVer) {//如果输入的密码是123456表示输入密码正确
//
//
//        }else{
//
//
//        }
        
    }
}
#pragma mark - 验证密码
-(void)verify:(NSString *)pass{
    [MBProgressHUD MBProgress:@""];
    
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]verify_payment_password:model.merchant_id andpassword:pass Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1){
//            NSLog(@"密码正确==%@",self.pwStr);
            
            if ([self.delegate respondsToSelector:@selector(inputCorrectCoverView:andPass:)]) {
                [self deleteClick:nil];
                [self.delegate inputCorrectCoverView:self andPass:pass];
            }
        }else{
            NSLog(@"密码错误＝＝%@",self.pwStr);
            
            if ([self.delegate respondsToSelector:@selector(coverView: error:)]) {
                [self deleteClick:nil];
                [self.delegate coverView:self error:resDic[@"message"]];
            }
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
}


@end
