//
//  Payment_passwordViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/4.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "Payment_passwordViewController.h"
#import "NewTextField.h"
#import "FBHupPassViewController.h"

@interface Payment_passwordViewController ()<UITextFieldDelegate>
/** 白色view */
@property (nonatomic, strong) UIView *bottomView;
/** 显示密码的数量 */
@property (nonatomic,assign) int pwCount;
/** 存放背景颜色是 黑色点 的UIImageView */
@property (nonatomic, strong) NSMutableArray *pwArray;
/** 键盘的高度 */
@property (nonatomic,assign) CGFloat keyBoardHeight;

/** 表示在弹出键盘的时候只设置bottomView的高度一次 */
@property (nonatomic,assign) BOOL isFirst;
/** 存储密码 */
@property (nonatomic,copy) NSMutableString *pwStr;

@property (nonatomic, strong) NewTextField *payTextField;

@property (strong,nonatomic)UILabel *promptLabel;
@property (strong,nonatomic)UILabel *promptLabel1;

@end

@implementation Payment_passwordViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.Navtitle;//@"设置提现密码";

    // 监听键盘的位置改变
    // 监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //监听重新输入密码的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(againInputPW) name:@"againInputPassWord" object:nil];
    //默认yes
    self.isFirst = YES;
    //默认是0，就是密码没有输入
    self.pwCount = 0;
    
    //创建UI
    [self createUI];
    [self.payTextField becomeFirstResponder];

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
//        CGRect bottomFrame = self.bottomView.frame;
//        bottomFrame.size.height = self.keyBoardHeight + CGRectGetMaxY(self.forgetPWBtn.frame);
//        bottomFrame.origin.y = self.view.bounds.size.height - bottomFrame.size.height;
//        self.bottomView.frame = bottomFrame;
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
 创建UI
 */
- (void)createUI
{
    //创建白色view
    UIView *bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    CGFloat bottomH = 100;
    CGFloat bottomY = self.view.bounds.size.height - bottomH;
    bottomView.frame = CGRectMake(0, 0, ScreenW, 250);
    bottomView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    [self.view addSubview:bottomView];
    
    //创建白色头上的提示view
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    headerView.frame = CGRectMake(0, 0, bottomView.bounds.size.width, 60);
    [bottomView addSubview:headerView];
    //灰色的横线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lineView.frame = CGRectMake(0, headerView.bounds.size.height-1, headerView.bounds.size.width, 1);
//    [headerView addSubview:lineView];

    //输入密码提示
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, headerView.bounds.size.height)];
    promptLabel.text = self.prompt;//@"请输入提现密码";
    promptLabel.textAlignment = 1;
    promptLabel.textColor = [UIColor blackColor];
    promptLabel.font = [UIFont systemFontOfSize:17];
//    [promptLabel sizeToFit];
    promptLabel.center = CGPointMake(headerView.bounds.size.width/2, headerView.bounds.size.height/2);
    [headerView addSubview:promptLabel];
    self.promptLabel = promptLabel;
    
    //UITextField
    NewTextField *payTextField = [[NewTextField alloc] init];
    self.payTextField = payTextField;
    //payTextField的高度为6等份的宽度
    payTextField.frame = CGRectMake(10, CGRectGetMaxY(headerView.frame) + 40, bottomView.bounds.size.width - 20, (bottomView.bounds.size.width - 20) / 6);
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

    //输入密码提示
    UILabel *promptLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, headerView.bounds.size.height)];
    promptLabel1.text = self.prompt1;//@"";
    promptLabel1.textAlignment = 1;
    promptLabel1.textColor = [UIColor blackColor];
    promptLabel1.font = [UIFont systemFontOfSize:12];
//    [promptLabel1 sizeToFit];
    promptLabel1.center = CGPointMake(headerView.bounds.size.width/2, payTextField.bounds.size.height+120);
    [bottomView addSubview:promptLabel1];
    self.promptLabel1 = promptLabel1;
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
    
//    NSLog(@" 输入的密码 textChange ==%@",self.pwStr);
    
    if (self.pwStr.length == 6) {
        
        if ( self.Passpage == 0){
            /** 首次设置密码 */
            self.navigationItem.title = @"设置提现密码";
            self.promptLabel.text = @"请再次输入，以确认密码";
            self.promptLabel1.text = @"不能是登录密码或连续数字";
            self.Passpage  = 10;
            [self againInputPW];
            
            
        }else if (self.Passpage == 1){
            /** 验证密码 */
            [self verify_old_password];
            

        }else if (self.Passpage == 2) {
            self.navigationItem.title = @"新提现密码";
            self.promptLabel.text =@"请再次输入，以确认密码";
            self.promptLabel1.text = @"不能是登录密码或连续数字";
            self.Passpage  ++;

            [self againInputPW];
            
        }else if (self.Passpage == 3){
            
            
//            self.Passpage  ++;

            /** 修改提现密码 请求 */
            [self payment_password:self.pwStr];

            /** 返回 **/
            
        }else if (self.Passpage == 4){
            
            self.navigationItem.title = @"重置提现密码";
            self.promptLabel.text = @"请再次输入，以确认密码";
            self.promptLabel1.text = @"不能是登录密码或连续数字";
            self.Passpage  ++;
            
            
            [self againInputPW];

        }else if (self.Passpage == 5){

//            self.Passpage  ++;
            /** 重置提现密码 请求 */
            [self payment_password:self.pwStr];
            /** 返回 **/
            
        }else{
            
            /** 首次设置 请求 */
            [self payment_password:self.pwStr];
            /** 返回 **/
        }
        
        
//        if ([self.pwStr isEqualToString:@"199103"]) {//如果输入的密码是199103表示输入密码正确
//
//            NSLog(@"密码正确==%@",self.pwStr);
//
//            if ([self.delegate respondsToSelector:@selector(inputCorrectCoverView:)]) {
//                [self deleteClick:nil];
//                [self.delegate inputCorrectCoverView:self];
//            }
//        }else{
//
//            NSLog(@"密码错误＝＝%@",self.pwStr);
//
//            if ([self.delegate respondsToSelector:@selector(coverView:)]) {
//                [self.delegate coverView:self];
//            }
//        }
        
    }
}
#pragma mark - 验证密码
-(void)verify_old_password{
    [MBProgressHUD MBProgress:@"验证中...."];
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]verify_old_pwd_or_code_before_set_payment_password:model.merchant_id andkey:@"old_pwd" andsiring:[MD5Sign MD5:self.pwStr] Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1){
            self.navigationItem.title = @"新提现密码";
            self.promptLabel.text = @"请设置新提现密码，用于提现验证";
            self.promptLabel1.text = @"不能是登录密码或连续数字";
            self.Passpage  ++;
            [self againInputPW];

        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
}
#pragma mark -- 设置密码
-(void)payment_password:(NSString *)pass{
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[FBHupPassViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//
//        }
//
//    }
    [MBProgressHUD MBProgress:@"设置中...."];

    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]set_payment_password:model.merchant_id andcode:nil andpassword:pass Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1){
            if (self.Passpage == 2 || self.Passpage  == 10){
                [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];

                [self.navigationController popViewControllerAnimated:YES];
            }else{
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[FBHupPassViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    
                    }
                    
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
    
    
}

@end
