//
//  BingYuanViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/14.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "BingYuanViewController.h"
#import "BingpromptView.h"

@interface BingYuanViewController ()
@property (strong, nonatomic) UITextField *Phone;
@property (strong, nonatomic) UITextField *MSMfield;
@property (strong, nonatomic) UIButton *MSMButton;
@property (strong,nonatomic)BingpromptView * promptView;
@end

@implementation BingYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"验证手机号";
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.promptView];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,15,ScreenW-30,152);
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.view addSubview:view];
    
    
    UIView *line_1 = [[UIView alloc] init];
    line_1.frame = CGRectMake(10,50,view.width-20,0.5);
    line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    
    [view addSubview:line_1];
    
    UIView *line_11 = [[UIView alloc] init];
    line_11.frame = CGRectMake(10,line_1.bottom+50,view.width-20,0.5);
    line_11.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    
    [view addSubview:line_11];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,0,150,50);
    label.numberOfLines = 0;
    label.text = @"国家和地区";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    [view addSubview:label];
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(10,50,50,50);
    label_1.numberOfLines = 0;
    label_1.text = @"+86";
    label_1.font = [UIFont systemFontOfSize:16];
    label_1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    [view addSubview:label_1];
    
    UILabel *label_11 = [[UILabel alloc] init];
    label_11.frame = CGRectMake(10,0,150,50);
    label_11.numberOfLines = 0;
    label_11.text = @"中国";
    label_11.font = [UIFont systemFontOfSize:15];
    label_11.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    label_11.textAlignment = 2;
    [view addSubview:label_11];
    [label_11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(70, 50));
    }];
    
    
    [view addSubview:self.Phone];
    UserModel *userM = [UserModel getUseData];
    NSString*phon = [NSString stringWithFormat:@"%@",userM.mobile];
    if ([[MethodCommon judgeStringIsNull:phon] isEqualToString:@""]) {
       
    }else{
        self.Phone.text = [phon stringByReplacingOccurrencesOfString:[phon substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    }
    
    [view addSubview:self.MSMfield];
    [view addSubview:self.MSMButton];
    [self.MSMButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    
#pragma mark - 确认验证
    UIButton *AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW-30,44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    [AddButton.layer addSublayer:gl];
    
    AddButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    AddButton.layer.shadowOffset = CGSizeMake(0,4);
    AddButton.layer.shadowOpacity = 1;
    AddButton.layer.shadowRadius = 9;
    
    [AddButton setTitle:@"确认验证" forState:UIControlStateNormal];
    [AddButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [AddButton addTarget:self action:@selector(AddAction) forControlEvents:UIControlEventTouchUpInside];
    [AddButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:AddButton];
    [AddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(40);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 44));
    }];
    
    
    
    
}
-(void)AddAction{

    
    
    if (self.Phone.text==nil||self.Phone.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    if (self.MSMfield.text==nil||self.MSMfield.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return ;
    }
    UserModel *model = [UserModel getUseData];
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    NSDictionary *dict = @{
                           @"existing_mobile":[NSString stringWithFormat:@"%@",model.mobile],
                           @"existing_code":[NSString stringWithFormat:@"%@",self.MSMfield.text],
                           @"type":@"1",
                           };
    
    [[FBHAppViewModel shareViewModel]change_binded_mobile:model.merchant_id andcode:dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            
            BingbangViewController *VC=[BingbangViewController new];
            VC.existing_mobile =[NSString stringWithFormat:@"%@",self.Phone.text];
            VC.existing_code =[NSString stringWithFormat:@"%@",self.MSMfield.text];

            [self.navigationController pushViewController:VC animated:NO];

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
-(void)MSMAction{
    
    if (self.Phone.text==nil||self.Phone.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    
    
    UserModel *model = [UserModel getUseData];
    [MBProgressHUD MBProgress:@"数据加载中..."];

    //
    [[FBHAppViewModel shareViewModel]geTcaptchaWithphone:model.mobile andtype:@"7" Success:^(NSDictionary *resDic) {
        NSLog(@"当前获取到的数据是%@",resDic);
        if ([resDic[@"status"] integerValue]==1) {
            [self countDownWithTime];
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

/**
 倒计时
 
 */
- (void)countDownWithTime{
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
                [self.MSMButton setTitle:@"重获验证码" forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.MSMButton setBackgroundColor:UIColorFromRGB(0x3D89FF)];
                self.MSMButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];;
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                //                NSLog(@"____%@",strTime);
                
                [self.MSMButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.MSMButton setBackgroundColor:UIColorFromRGB(0xD4E5FF)];
                self.MSMButton.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}


#pragma mark - 懒加载

-(BingpromptView *)promptView{
    if (!_promptView) {
        _promptView = [[NSBundle mainBundle] loadNibNamed:@"BingpromptView" owner:self options:nil].lastObject;
        _promptView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        YBWeakSelf
        _promptView.QueBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _promptView;
}
-(UITextField *)Phone{
    if (!_Phone) {
        _Phone = [[UITextField alloc]initWithFrame:CGRectMake(60, 50, 150, 50)];
        _Phone.font = [UIFont systemFontOfSize:16];
        _Phone.placeholder = @"请输入手机号码";
//        _Phone.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Phone.keyboardType = UIKeyboardTypeDecimalPad;

    }
    return _Phone;
}
-(UITextField *)MSMfield{
    if (!_MSMfield) {
        _MSMfield = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, 150, 50)];
        _MSMfield.font = [UIFont systemFontOfSize:16];
        _MSMfield.placeholder = @"请输入验证码";
        _MSMfield.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];

        _MSMfield.keyboardType = UIKeyboardTypeDecimalPad;
        
    }
    return _MSMfield;
}
-(UIButton *)MSMButton{
    if (!_MSMButton) {
        _MSMButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MSMButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _MSMButton.titleLabel.font= [UIFont systemFontOfSize:15];
        _MSMButton.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _MSMButton.layer.cornerRadius = 5;
        [_MSMButton addTarget:self action:@selector(MSMAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _MSMButton;
}
@end
