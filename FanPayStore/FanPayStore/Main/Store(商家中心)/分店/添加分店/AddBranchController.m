//
//  AddBranchController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/11.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "AddBranchController.h"

@interface AddBranchController ()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView * branchScroll;
@property (strong,nonatomic)UIView * AddView;
@property (strong,nonatomic)UILabel * branch_store_name;
@property (strong,nonatomic)UITextField * phone_fie;
@property (strong,nonatomic)UITextField *MSM_fie;
@property (strong,nonatomic) UITextField *pwss_fie;
@property (strong,nonatomic)UIButton * MSMButton;
@end

@implementation AddBranchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户设置";
    if (self.Data) {
        [self merchant_center];
    }
    [self createUI];
    
}
#pragma mark - 请求数据
-(void)merchant_center{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_one_branch_store:model.merchant_id andstore_id:model.store_id andbranch_mer_id:self.Data[@"merchant_id"] andbranch_store_id:self.Data[@"store_id"] Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            self.phone_fie.text = [NSString stringWithFormat:@"%@",DIC[@"branch_mer_mobile"]];
            self.branch_store_name.text = [NSString stringWithFormat:@"%@",DIC[@"branch_store_name"]];

        }else{
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
    
}

#pragma mark - 添加分店 add_branch_store
-(void)Add_store{
    
    if (self.phone_fie.text==nil||self.phone_fie.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    if (self.MSM_fie.text==nil||self.MSM_fie.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return ;
    }
    if (self.pwss_fie.text==nil||self.pwss_fie.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return ;
    }
    if (self.Data.count==0) {
        //添加
        [MBProgressHUD MBProgress:@"数据加载中..."];
        
        UserModel *model = [UserModel getUseData];
        NSString *pwd = [MD5Sign MD5:self.pwss_fie.text];
        
        NSDictionary *dict = @{@"mobile":[NSString stringWithFormat:@"%@",self.phone_fie.text],
                               @"code":[NSString stringWithFormat:@"%@",self.MSM_fie.text],
                               @"pwd":[NSString stringWithFormat:@"%@",pwd],
                               };
        
        
        [[FBHAppViewModel shareViewModel]add_branch_store:model.merchant_id andstore_id:model.store_id andbankDict:dict Success:^(NSDictionary *resDic) {
            
            
            if ([resDic[@"status"] integerValue]==1) {
//                NSDictionary *DIC = resDic[@"data"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BranchView" object:nil];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            [MBProgressHUD hideHUD];
        } andfailure:^{
            [MBProgressHUD hideHUD];
            
        }];
        
    }else{
        //修改
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"暂时无法修改"];
    }
    
    
    
}
#pragma mark - 删除分店
-(void)Dele_store{
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"删除提醒";
    NSString *card_number = [NSString stringWithFormat:@"您是否要删除当前的门店信息。"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"删除中..."];
        UserModel *model = [UserModel getUseData];
        
        NSDictionary *dict = @{@"branch_mer_id":[NSString stringWithFormat:@"%@",self.Data[@"merchant_id"]],
                               @"branch_store_id":[NSString stringWithFormat:@"%@",self.Data[@"store_id"]],
                               };
        
        
        [[FBHAppViewModel shareViewModel]delete_branch_store:model.merchant_id andstore_id:model.store_id andbankDict:dict Success:^(NSDictionary *resDic) {
            
            
            if ([resDic[@"status"] integerValue]==1) {
//                NSDictionary *DIC = resDic[@"data"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BranchView" object:nil];

                [self.navigationController popViewControllerAnimated:YES];

                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            [MBProgressHUD hideHUD];
        } andfailure:^{
            [MBProgressHUD hideHUD];
            
        }];
        
    };
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
}
#pragma mark - 获取验证码
-(void)MSM_Action{
    
    if (self.phone_fie.text==nil||self.phone_fie.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    
    [[FBHAppViewModel shareViewModel] geTcaptchaWithphone:self.phone_fie.text andtype:@"6" Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            [self countDownWithTime];
            
        }else{
            
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.branchScroll];
    
    /*设置分店管理账户*/
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenW-30, 44)];
    label.text = @"设置分店管理账户";
    label.textColor  = UIColorFromRGB(0x222222);
    label.font = [UIFont systemFontOfSize:autoScaleW(15)];
    [self.branchScroll addSubview:label];
    
    
    /**/
    self.AddView = [[UIView alloc]initWithFrame:CGRectMake(15, label.bottom, ScreenW-30, autoScaleW(253))];
    self.AddView.backgroundColor = [UIColor whiteColor];
    self.AddView.layer.cornerRadius = 5;
    [self.branchScroll addSubview:self.AddView];
    
    
    
    for (int i = 0; i<4; i++) {
        UIView *view_line = [[UIView alloc] init];
        view_line.frame = CGRectMake(10,50+i*50,self.AddView.width-20,0.5);
        view_line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [self.AddView addSubview:view_line];
    }
    
    /*店名*/
    self.branch_store_name = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.AddView.width -20, 50)];
    self.branch_store_name.textColor = UIColorFromRGB(0x222222);
    self.branch_store_name.font = [UIFont systemFontOfSize:15];
    [self.AddView addSubview:self.branch_store_name];
    if (self.Data.count==0) {
        self.branch_store_name.height = 0;
        self.AddView.height = autoScaleW(202);
    }
    
    /* 手机信息 */
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(10, self.branch_store_name.bottom, 60, 50)];
    phone.text = @"+86";
    phone.textColor = UIColorFromRGB(0x222222);
    phone.font = [UIFont systemFontOfSize:autoScaleW(16)];
    [self.AddView addSubview:phone];
    
    UITextField *phone_fie = [[UITextField alloc]initWithFrame:CGRectMake(phone.right, phone.top, self.AddView.width-70, 50)];
    phone_fie.placeholder = @"请输入手机号";
    phone_fie.keyboardType = UIKeyboardTypePhonePad;
    self.phone_fie = phone_fie;
    [self.AddView addSubview:phone_fie];
    
    
    /* 验证码信息 **/
    
    UITextField *MSM_fie = [[UITextField alloc]initWithFrame:CGRectMake(10, phone.bottom, self.AddView.width-100, 50)];
    MSM_fie.placeholder = @"请输入验证码";
    MSM_fie.textColor= UIColorFromRGB(0x3D8AFF);
    MSM_fie.font = [UIFont systemFontOfSize:autoScaleW(16)];
    MSM_fie.keyboardType = UIKeyboardTypePhonePad;
    self.MSM_fie = MSM_fie;
    [self.AddView addSubview:MSM_fie];
    
    UIButton *MSMButton = [UIButton buttonWithType:UIButtonTypeCustom];
    MSMButton.frame = CGRectMake(MSM_fie.right, MSM_fie.top, 88, 32);
    MSMButton.centerY =MSM_fie.centerY;
    [MSMButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [MSMButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(15)]];
    [MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    MSMButton.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    MSMButton.layer.cornerRadius = 5;
    [MSMButton addTarget:self action:@selector(MSM_Action) forControlEvents:UIControlEventTouchUpInside];
    self.MSMButton = MSMButton;
    [self.AddView addSubview:MSMButton];
    
    
    /* 登录密码 **/
    
    UITextField *pwss_fie = [[UITextField alloc]initWithFrame:CGRectMake(10, MSM_fie.bottom, self.AddView.width-20, 50)];
    pwss_fie.placeholder = @"请设置登录密码";
    pwss_fie.textColor = UIColorFromRGB(0x3D8AFF);
    pwss_fie.font = [UIFont systemFontOfSize:autoScaleW(16)];
    self.pwss_fie = pwss_fie;
    [self.AddView addSubview:pwss_fie];
    
    
    /* 类型信息 */
    UILabel *lable_lei = [[UILabel alloc]initWithFrame:CGRectMake(10, pwss_fie.bottom, 60, 50)];
    lable_lei.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    lable_lei.font = [UIFont systemFontOfSize:autoScaleW(15)];
    lable_lei.text = @"类型";
    [self.AddView addSubview:lable_lei];
    
    
    UIButton *button_Z = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_Z setTitle:@"主店" forState:UIControlStateNormal];
    [button_Z.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(15)]];
    [button_Z setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [button_Z setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
    button_Z.backgroundColor = UIColorFromRGB(0xF9F9F9);
    button_Z.layer.borderWidth = 1;
    button_Z.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
    button_Z.frame = CGRectMake(lable_lei.right+10, lable_lei.top, 60, 32);
    button_Z.centerY = lable_lei.centerY;
    button_Z.layer.cornerRadius = 16;
    [self.AddView addSubview:button_Z];
    
    
    UIButton *button_F = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_F setTitle:@"分店" forState:UIControlStateNormal];
    [button_F.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(15)]];
    [button_F setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [button_F setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
    button_F.backgroundColor = UIColorFromRGB(0xF9F9F9);
    button_F.layer.borderWidth = 1;
    button_F.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
    button_F.frame = CGRectMake(button_Z.right+15, lable_lei.top, 60, 32);
    button_F.centerY = lable_lei.centerY;
    button_F.layer.cornerRadius = 16;
    [self.AddView addSubview:button_F];
    
    /* 添加按钮or修改按钮 **/
    UIButton *Addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW-30,44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    [Addbutton.layer addSublayer:gl];
    
    Addbutton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    Addbutton.layer.shadowOffset = CGSizeMake(0,4);
    Addbutton.layer.shadowOpacity = 1;
    Addbutton.layer.shadowRadius = 9;
    
    if (self.Data.count==0) {
        [Addbutton setTitle:@"填写店铺信息" forState:UIControlStateNormal];
        button_F.selected = YES;
        button_F.backgroundColor = UIColorFromRGB(0xE5F4FF);
        button_F.layer.borderColor = UIColorFromRGB(0x94C3F7).CGColor;

        
    }else{
        [Addbutton setTitle:@"保存修改" forState:UIControlStateNormal];
        NSString *type = [NSString stringWithFormat:@"%@",self.Data[@"branch_type"]];
        if ([type isEqualToString:@"1"]) {
            button_F.selected = YES;
            button_F.backgroundColor = UIColorFromRGB(0xE5F4FF);
            button_F.layer.borderColor = UIColorFromRGB(0x94C3F7).CGColor;
        }else{
            button_Z.selected = YES;
            button_Z.backgroundColor = UIColorFromRGB(0xE5F4FF);
            button_Z.layer.borderColor = UIColorFromRGB(0x94C3F7).CGColor;
        }
        
    }

    [Addbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Addbutton addTarget:self action:@selector(Add_store) forControlEvents:UIControlEventTouchUpInside];
    [Addbutton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.branchScroll addSubview:Addbutton];
    [Addbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AddView.mas_bottom).offset(40);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 44));
    }];
    
    /* 删除按钮 **/
    UIButton *Delebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [Delebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Delebutton addTarget:self action:@selector(Dele_store) forControlEvents:UIControlEventTouchUpInside];
    [Delebutton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [Delebutton setTitle:@"删除" forState:UIControlStateNormal];
    [Delebutton setBackgroundColor:UIColorFromRGB(0xFF696A)];
    Delebutton.layer.cornerRadius = 10;
    [self.branchScroll addSubview:Delebutton];
    [Delebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Addbutton.mas_bottom).offset(20);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 44));
    }];
    
    if (self.Data.count==0) {
        Delebutton.hidden = YES;
        
    }else{
        Delebutton.hidden = NO;
        
    }
}

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
                [self.MSMButton setTitle:@"重新发送" forState:UIControlStateNormal];
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
                
                
                [self.MSMButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.MSMButton.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}
#pragma mark - 懒加载
-(UIScrollView *)branchScroll{
    if (!_branchScroll) {
        _branchScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _branchScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 700);
    }
    return _branchScroll;
}
@end
