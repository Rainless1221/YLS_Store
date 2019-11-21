//
//  FBHCashierController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHCashierController.h"

@interface FBHCashierController ()<UIScrollViewDelegate,CashierDelegate,RefundDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)FBHCashierBaseView * FBHCashierView;
/**
 */
@property (strong,nonatomic)UIView * NoDataView;
@property (strong,nonatomic)UIView * NavView;
@property (strong,nonatomic)UIImageView * NavImg;
@property (strong,nonatomic)UIImageView * userImg;
@property (strong,nonatomic)UILabel * navLabel;
@property (strong,nonatomic)FL_Button *Navbutton;

@property (strong,nonatomic)UIImageView * backgrounImg;
@property (nonatomic) CGFloat halfHeight;



@property (strong,nonatomic)CashierModel * model;
@property(nonatomic,assign) BOOL IsStore;
/*收支*/
@property (strong,nonatomic)NSString * begin_date;
@property (strong,nonatomic)NSString * end_date;
/*退单数据*/
@property (strong,nonatomic)NSMutableArray * RefundData;
@end

@implementation FBHCashierController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = YES;
    /**
     获取店铺的ID
     */
    [self get_store_id];
    [self get_store_application_info];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收银台";
//    [self refund_order_num];

    /** 获取收银台基本信息 */
    [self merchant_center];
    /** 某天收支列表 */
    [self list_checkstand:self.begin_date andEnd:self.end_date];

    /** 是否可见 */
    [self isSetLook];
    /** 没有入驻商铺的界面 **/
    [self setnodataView];
    _halfHeight = (CGRectGetHeight([UIScreen mainScreen].bounds)) * 0.5 - 64;
    /**
     * UI
     **/
    [self createUI];
    /**
     * 导航栏
     **/
    [self setupNav];

    UserModel *model = [UserModel getUseData];
    NSString *store_id = [NSString stringWithFormat:@"%@",model.store_id];
    if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]) {
        self.SJScrollView.hidden = YES;
        self.NavView.hidden = YES;
        self.NoDataView.hidden = NO;
        
    }else{
        self.NoDataView.hidden = YES;
        self.SJScrollView.hidden = NO;
        self.NavView.hidden = NO;
        
    }
    
}
#pragma mark - 获取收银台基本信息
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    NSString *store_id = [NSString stringWithFormat:@"%@",model.store_id];
    if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]) {
        [MBProgressHUD hideHUD];
        return;
    }
    
    [[FBHAppViewModel shareViewModel]get_checkstand_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
            if ([resDic[@"status"] integerValue]==1) {
                
                NSDictionary *DIC=resDic[@"data"];
                self.FBHCashierView.Data = DIC;
                self.model = [CashierModel mj_objectWithKeyValues:DIC];
                //赋值
//                self.navLabel.text = [NSString stringWithFormat:@"%@",self.model.store_name];
                [self.Navbutton setTitle:[NSString stringWithFormat:@"%@",self.model.store_name] forState:UIControlStateNormal];
                NSString *url = [NSString stringWithFormat:@"%@",self.model.store_logo];
                [self.userImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"]];
                
                /*待支付*/
                NSString *num = [NSString stringWithFormat:@"%@",DIC[@"order_num_to_be_paid"]];
                NSInteger order_num = [num integerValue];
                if (order_num >0) {
                    [self.tabBarController.tabBar  showBadgeOnItmIndex:0 tabbarNum:4];
                }else if (order_num == 0){
                    [self.tabBarController.tabBar  hideBadgeOnItemIndex:0];

                }

                /*已支付订单数量*/
                NSString *num1 = [NSString stringWithFormat:@"%@",DIC[@"order_num_have_paid"]];
                NSInteger order_num1 = [num1 integerValue];
                if (order_num1 >0) {
                    [self.tabBarController.tabBar  showBadgeOnItmIndex:0 tabbarNum:4];
                }else if (order_num1 == 0){
                    [self.tabBarController.tabBar  hideBadgeOnItemIndex:0];

                }
                /*待退款和待退单订单数量*/
                NSString *num2 = [NSString stringWithFormat:@"%@",DIC[@"order_num_wait_to_refund"]];
                NSInteger order_num2 = [num2 integerValue];
                if (order_num2 >0) {
                    [self.tabBarController.tabBar  showBadgeOnItmIndex:0 tabbarNum:4];
                }else if (order_num2 == 0){
                    [self.tabBarController.tabBar  hideBadgeOnItemIndex:0];

                }
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
                NSString *message = [NSString stringWithFormat:@"%@",resDic[@"message"]];
                if ([message isEqualToString:@"请重新登录"] || [message isEqualToString:@"您的账号已在其他设备上登录"]) {
                    //                [self Exit_log];
                }
            }
            [MBProgressHUD hideHUD];
       
    } andfailure:^{
            [MBProgressHUD hideHUD];
    }];
    
//    [[FBHAppViewModel shareViewModel] list_business_center:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
//
//        if ([resDic[@"status"] integerValue]==1) {
//            NSDictionary *DIC=resDic[@"data"];
//            /** 保存商家中心信息 */
//            storeBaseModel *model = [storeBaseModel mj_objectWithKeyValues:DIC];
//            [model saveUserData];
//            /*待支付*/
//            NSString *num = [NSString stringWithFormat:@"%@",model.order_num_to_be_paid];
//            NSInteger order_num = [num integerValue];
//
//            if (order_num >0) {
//                self.FBHCashierView.badgeLable.text = [NSString stringWithFormat:@"%ld",order_num];
//                self.FBHCashierView.badgeLable.hidden = NO;
//                [self.tabBarController.tabBar  showBadgeOnItmIndex:0 tabbarNum:4];
//            }else if (order_num == 0){
//                self.FBHCashierView.badgeLable.hidden = YES;
//                [self.tabBarController.tabBar  hideBadgeOnItemIndex:0];
//
//            }
//
//        }else{
//
//        }
//        [MBProgressHUD hideHUD];
//    } andfailure:^{
//        [MBProgressHUD hideHUD];
//    }];
    
}
#pragma mark - 获取店铺ID
-(void)get_store_id{
    
    UserModel *model = [UserModel getUseData];
    //获取店铺ID
    [[FBHAppViewModel shareViewModel]get_store_id:model.merchant_id Success:^(NSDictionary *resDic) {

            if ([resDic[@"status"] integerValue]==1) {
                NSDictionary *DIC=resDic[@"data"];
                NSString *storeString = [NSString stringWithFormat:@"%@",DIC[@"store_id"]];

                UserModel *model1=[UserModel mj_objectWithKeyValues:DIC];
                model1.merchant_id = model.merchant_id;
                model1.mobile = model.mobile;
                model1.store_id = storeString;
                model1.token = model.token;
                
                [model1 saveUserData];
                
                if ([storeString isEqualToString:@""]) {
                    self.SJScrollView.hidden = YES;
                    self.NavView.hidden = YES;
                    self.NoDataView.hidden = NO;
                    
                }else{
                    self.NoDataView.hidden = YES;
                    self.SJScrollView.hidden = NO;
                    self.NavView.hidden = NO;
                }
                
            }else{
                NSString *message = [NSString stringWithFormat:@"%@",resDic[@"message"]];
                if ([message isEqualToString:@"请重新登录"] || [message isEqualToString:@"您的账号已在其他设备上登录"]) {
                    
                }
                
            }
            
       
        
    } andfailure:^{
        
    }];
    
    
}
#pragma mark - 某天收支列表
-(void)list_checkstand:(NSString *)begin_date andEnd:(NSString *)end_date{
    self.begin_date = begin_date;
    self.end_date = end_date;
    
    UserModel *model = [UserModel getUseData];
    NSDictionary *dict =@{
//                          @"begin_date":[NSString stringWithFormat:@"%@",begin_date],
//                          @"end_date":[NSString stringWithFormat:@"%@",end_date],
//                          @"type":@"1",
//                          @"consumption_date":[NSString stringWithFormat:@"%@",begin_date],
                          @"page":@"1",
                          @"limit":@"100",
                          };
    
    [[FBHAppViewModel shareViewModel]list_checkstand_consumption:model.merchant_id andstore_id:model.store_id andlistDict:dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            /** 总营收 **/
//            self.FBHCashierView.total_income.text = [NSString stringWithFormat:@"+%@",DIC[@"total_income"]];
//            self.FBHCashierView.total_expense.text = [NSString stringWithFormat:@"%@",DIC[@"total_expense"]];
            [self.FBHCashierView.IncomeArray removeAllObjects];
            NSDictionary *consumption_info = DIC[@"consumption_info"];
            for (NSDictionary *dict in consumption_info) {
                [self.FBHCashierView.IncomeArray addObject:dict];
            }
            NSInteger TabCount = self.FBHCashierView.IncomeArray.count >5 ? 5: self.FBHCashierView.IncomeArray.count;
            [self.FBHCashierView.View3 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(TabCount*45+100);
            }];
            [self.FBHCashierView.IncomeTableview reloadData];
            
            self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 750+TabCount*45);

        }else{

        }
    } andfailure:^{
        
    }];
}
#pragma mark - 退款数量单独请求
-(void)refund_order_num{
    UserModel *model = [UserModel getUseData];
    
    NSDictionary *Dict = @{
                           @"order_status":@"6",
                           @"begin_date":@"",//[NSString stringWithFormat:@"%@",self.begin_date],
                           @"end_date":@"",//[NSString stringWithFormat:@"%@",self.end_date],
                           @"page":@"1",
                           @"limit":@"50",
                           };
    
    [[FBHAppViewModel shareViewModel]list_merchant_orders:model.merchant_id andstore_id:model.store_id andorders:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC = resDic[@"data"];
            
            /*退款数量*/
            NSString *num = [NSString stringWithFormat:@"%@",DIC[@"pending_refund_order_num"]];
            NSInteger order_num = [num integerValue];
            if (order_num >0) {
                for (NSDictionary *dict in DIC[@"order_info"]) {
                    NSString *order_status = [NSString stringWithFormat:@"%@",dict[@"order_status"]];
                    if ([order_status integerValue] == 6) {
                        [self.RefundData addObject:dict];
                    }
                }
                if (self.RefundData.count>0) {
                    [self RefundApp:self.RefundData];
                }
                
            }else if (order_num == 0){
                
            }
            
            
        }else{
            
        }
    } andfailure:^{
        
    }];
    
}
#pragma mark - 店铺申请信息
-(void)get_store_application_info{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_store_application_info:model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
            
            NSString *message = [NSString stringWithFormat:@"%@",resDic[@"message"]];
            if ([message isEqualToString:@"没有申请信息，请先入驻"]) {
                [PublicMethods writeToUserD:@"2" andKey:@"get_store_application_info"];
                return ;
            }
            [PublicMethods writeToUserD:@"1" andKey:@"get_store_application_info"];
            
            NSDictionary *DIC = resDic[@"data"][@"application_info"];
            insert_storeM *model = [insert_storeM mj_objectWithKeyValues:DIC];
            //保存
            [model saveUserData];
            
            
        }
    } andfailure:^{
        
    }];
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    NavView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:NavView];
    self.NavView = NavView;
    /** 背景图片 **/
    UIImageView *NavImg = [[UIImageView alloc]initWithFrame:NavView.frame];
    //    NavImg.image = [UIImage imageNamed:@"bg_index_top_scene"];
    /**
     *  1.通过CAGradientLayer 设置渐变的背景。
     */
    CAGradientLayer *layer = [CAGradientLayer new];
    //colors存放渐变的颜色的数组
    layer.colors=@[(__bridge id)UIColorFromRGB(0x4EC3FF).CGColor,(__bridge id)UIColorFromRGB(0x45A6FF).CGColor,(__bridge id)UIColorFromRGB(0x3D8AFF).CGColor];
    /**
     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
     */
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.frame = NavImg.bounds;
//    [NavImg.layer addSublayer:layer];
//    self.NavImg = NavImg;
//    [NavView addSubview:NavImg];
    /** 头像 */
    UIImageView *userImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, STATUS_BAR_HEIGHT+5, 34, 34)];
    userImg.backgroundColor = [UIColor clearColor];
    userImg.image = [UIImage imageNamed:@"register_empty_avatar"];
    userImg.layer.cornerRadius = 34/2;
    userImg.layer.masksToBounds = YES;
    userImg.layer.borderWidth = 2;
    userImg.layer.borderColor = UIColorFromRGB(0xFFFFFF).CGColor;
    [NavView addSubview:userImg];
    self.userImg=userImg;
    /** 店铺名称 */
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(userImg.right + 12, STATUS_BAR_HEIGHT, 200, 44)];
    navLabel.text = @"";
    navLabel.textColor = UIColorFromRGBA(0x222222, 1);
    navLabel.font = [UIFont systemFontOfSize:16];
//    [NavView addSubview:navLabel];
    self.navLabel =navLabel;
    
    self.Navbutton = [FL_Button buttonWithType:UIButtonTypeCustom];
    self.Navbutton.frame = CGRectMake(userImg.right + 12, STATUS_BAR_HEIGHT, 200, 44);
    [self.Navbutton setImage:[UIImage imageNamed:@"icn_branch_exchange_black"] forState:UIControlStateNormal];
    [self.Navbutton setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
    [self.Navbutton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    //样式
    self.Navbutton.status = FLAlignmentStatusLeft;
    self.Navbutton.fl_padding = 10;
    self.Navbutton.titleLabel.font = [UIFont systemFontOfSize:20];
    [NavView addSubview:self.Navbutton];
    
    /** 收银细则 **/
    UIButton *thirdBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn1.frame = CGRectMake(ScreenW-16-80, STATUS_BAR_HEIGHT, 80, 44);
    [thirdBtn1 addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn1 setTitle:@"收银细则" forState:UIControlStateNormal];
    [thirdBtn1 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [thirdBtn1.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [NavView addSubview:thirdBtn1];
    
    
//    UserModel *model = [UserModel getUseData];
//    if ([model.store_id isEqualToString:@""]) {
//        self.NavView.hidden = YES;
//
//    }else{
//        self.NavView.hidden = NO;
//    }
    
}
-(void)rightAction{
    /* Html(收银细则) */
    FBHinformationViewController *VC = [FBHinformationViewController new];
    VC.Navtitle = @"收银细则";
    VC.agreeUrl = FBHApi_HTML_shouyi;
    [self.navigationController pushViewController:VC animated:NO];
    
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
//    [self.SJScrollView addSubview:self.backgrounImg];
    [self.SJScrollView addSubview:self.FBHCashierView];
//    [self.FBHCashierView TimeAction:self.FBHCashierView.TimeButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"conversion" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OrdAction:) name:@"OrderConversino" object:nil];
    /** 版本更新 **/
//    [self lookup];
   
}
//店铺转换
- (void)conversionAction: (NSNotification *) notification {
    [self merchant_center];
    [self list_checkstand:self.begin_date andEnd:self.end_date];
}
- (void)OrdAction: (NSNotification *) notification {
    [self merchant_center];
}
/**/
-(void)labelTouchUpInside{
//    [self.navigationController pushViewController:[GuestRoomsController new] animated:YES];

//    RefundView *samView = [[RefundView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:samView];
}

#pragma mark - 无入驻界面
-(void)setnodataView{
    self.NoDataView = [[UIView alloc]init];
    [self.view addSubview:self.NoDataView];
    [self.NoDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    UIImageView *backImage = [[UIImageView alloc]init];
    backImage.image = [UIImage imageNamed:@"no_fill_business_info_tip"];
    [self.NoDataView addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-autoScaleW(45));
        make.height.mas_offset(autoScaleW(217));
    }];
    
    UIButton *nobutton = [UIButton buttonWithType:UIButtonTypeCustom];
    nobutton.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    nobutton.layer.cornerRadius = 10;
    [nobutton setTitle:@"申请入驻" forState:UIControlStateNormal];
    [nobutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nobutton addTarget:self action:@selector(InstoreAction) forControlEvents:UIControlEventTouchUpInside];
    [nobutton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(18)]];
    [self.NoDataView addSubview:nobutton];
    [nobutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.size.mas_offset(CGSizeMake(150, 44));
        make.bottom.equalTo(backImage.mas_top).offset(-autoScaleW(88));
    }];
    
    UILabel *nolabel = [[UILabel alloc]init];
    nolabel.text =@"入驻成功后可查看收银台，工作台数据";
    nolabel.textColor = UIColorFromRGB(0x999999);
    nolabel.textAlignment = NSTextAlignmentCenter;
    nolabel.font = [UIFont systemFontOfSize:autoScaleW(14)];
    [self.NoDataView addSubview:nolabel];
    [nolabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.size.mas_offset(CGSizeMake(300, 15));
        make.bottom.equalTo(nobutton.mas_top).offset(-autoScaleW(24));
    }];
    
    UILabel *noText = [[UILabel alloc]init];
    noText.text =@"立即申请入驻";
    noText.textColor = UIColorFromRGB(0xF7AE2B);
    noText.textAlignment = NSTextAlignmentCenter;
    noText.font = [UIFont systemFontOfSize:autoScaleW(22)];
    [self.NoDataView addSubview:noText];
    [noText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.size.mas_offset(CGSizeMake(300, 15));
        make.bottom.equalTo(nolabel.mas_top).offset(-autoScaleW(18));
    }];
    
}
/**
 * 无入驻时，去申请入驻
 */
-(void)InstoreAction{
    [self.navigationController pushViewController:[StepsViewController new] animated:NO];
}
#pragma mark - 去提现
-(void)getWithdraw{
    [self.navigationController pushViewController:[FBHWithdrawViewController new] animated:YES];
}
#pragma mark - 统计
-(void)StatisticalAction{
//    [SVProgressHUD setMinimumDismissTimeInterval:2];
//    [SVProgressHUD showErrorWithStatus:@"功能正在开发完善中"];
//    [self.navigationController pushViewController:[StatisticalController new] animated:YES];
    
    [self.navigationController pushViewController:[FBHRevenueController new] animated:YES];

}
#pragma mark -查看更多
-(void)getincomeMore{
    [self.navigationController pushViewController:[FBHRevenueController new] animated:YES];
}

#pragma mark - 余额是否可见
- (void)isSetLook{
    NSString *islook = [PublicMethods readFromUserD:@"islook"];
    if ([islook isEqualToString:@"YES"]) {
        self.FBHCashierView.lookButton.selected = YES;
        self.FBHCashierView.current_balance.text = @"****";
        self.FBHCashierView.today_income.text = @"****";
        self.FBHCashierView.cumulative_income.text = @"****";
        self.FBHCashierView.current_balance_String1 = @"****";

    }else{
        self.FBHCashierView.lookButton.selected = NO;
        NSString *balan = [[NSString alloc]init];
        if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",self.model.current_balance]] isEqualToString:@""]) {
            balan = [NSString stringWithFormat:@"¥ 00.00"];
        }else{
           balan = [NSString stringWithFormat:@"¥ %@",self.model.current_balance];
        }
        self.FBHCashierView.current_balance.text = balan;
        
       NSString * today_income=[NSString stringWithFormat:@"%@",self.model.today_income];
        if ([[MethodCommon judgeStringIsNull:today_income] isEqualToString:@""]) {
             self.FBHCashierView.today_income.text =  [NSString stringWithFormat:@"+ 00.00"];
        }else{
            self.FBHCashierView.today_income.text =  [NSString stringWithFormat:@"+ %@",today_income];
        }
        
        NSString * cumulative_income=[NSString stringWithFormat:@"%@",self.model.cumulative_income];
        if ([[MethodCommon judgeStringIsNull:cumulative_income] isEqualToString:@""]) {
            self.FBHCashierView.cumulative_income.text =  [NSString stringWithFormat:@"+ 00.00"];
        }else{
            self.FBHCashierView.cumulative_income.text =  [NSString stringWithFormat:@"+ %@",cumulative_income];
        }
        
        NSString *protocol = [NSString stringWithFormat:@"%@ 折 [ 平均优惠力度 ]",self.FBHCashierView.current_balance_String1];
        NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
        //设置字体颜色
        [attri_str setFont:[UIFont systemFontOfSize:12]];
        attri_str.color = [UIColor colorWithHexString:@"EE4E3E"];
        NSRange ProRange = [protocol rangeOfString:@"[ 平均优惠力度 ]"];
        
        [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"999999"] backgroundColor:[UIColor colorWithHexString:@"EE4E3E"] userInfo:nil];
//        self.FBHCashierView.Pingju.attributedText = attri_str;
//        self.FBHCashierView.Pingju.textAlignment = NSTextAlignmentCenter;
        
    }
    
}
-(void)Revenuedetails:(NSDictionary *)Dara{
    FBHRevenuedetailsController *VC = [FBHRevenuedetailsController new];
    VC.log_id = Dara[@"log_id"];
    VC.log_type = Dara[@"type"];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 订单
-(void)OrderButtonAction:(NSInteger)Btntag{
    
    if (Btntag == 0) {
        // 获取代表公历的NSCalendar对象
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // 获取当前日期
        NSDate* dt = [NSDate date];
        // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
        unsigned unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay |
        NSCalendarUnitHour |  NSCalendarUnitMinute |
        NSCalendarUnitSecond | NSCalendarUnitWeekday;
        // 获取不同时间字段的信息
        NSDateComponents* comp = [gregorian components: unitFlags
                                              fromDate:dt];
        
        
        FBHOrderViewController *VC = [FBHOrderViewController new];
        VC.status = @"0";VC.isDzhuang = 1;
        [PublicMethods writeToUserD:[NSString stringWithFormat:@"%02ld-%02ld-%02ld",(long)comp.year,(long)comp.month,(long)comp.day] andKey:@"adeTime"];
        [PublicMethods writeToUserD:[NSString stringWithFormat:@"%02ld-%02ld-%02ld",(long)comp.year,(long)comp.month,(long)comp.day] andKey:@"endTime"]; 
        
        [self.navigationController pushViewController:VC animated:NO];
    }else{
        FBHOrderViewController *VC = [FBHOrderViewController new];
        
        switch (Btntag) {
            case 20:
                /**
                 *  订单
                 **/
                VC.status = @"0";VC.isDzhuang = 1;
                [self.navigationController pushViewController:VC animated:NO];
                break;
            case 21:
                
                VC.status = @"1";VC.isDzhuang = 1;
                [self.navigationController pushViewController:VC animated:NO];
                break;
            case 22:
                
                VC.status = @"2";VC.isDzhuang = 1;
                [self.navigationController pushViewController:VC animated:NO];
                break;
            case 23:
                
                VC.status = @"4";VC.isDzhuang = 1;
                [self.navigationController pushViewController:VC animated:NO];
                break;
            case 24:
                
                VC.status = @"6";VC.isDzhuang = 1;
                [self.navigationController pushViewController:VC animated:NO];
                break;
                
            default:
                break;
        }
        
    }
    
}
#pragma mark - 查看全都退款订单
-(void)LookOrder{
    FBHOrderViewController *VC = [FBHOrderViewController new];
    VC.status = @"6";VC.isDzhuang = 1;
    [self.navigationController pushViewController:VC animated:NO];
}
#pragma mark - 退单、首次进入app
-(void)RefundApp:(NSMutableArray *)Data{
    /*首次启动-退单提醒*/
    RefundView *samView = [[RefundView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.delagate = self;
    samView.Data = Data;
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
}
-(void)LookDetaButton:(NSInteger)order{
    FBHDdetailsController *VC = [FBHDdetailsController new];
    VC.status = 6;
    VC.order_id = self.RefundData[order][@"order_id"];
    VC.navigationTitle = [NSString stringWithFormat:@"%@",self.RefundData[order][@"order_status_txt"]];
    [self.navigationController pushViewController:VC animated:NO];
}
#pragma mark - ScrollViewDelegate
// 滑动时要执行的代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.SJScrollView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat alpha = MIN(1, (_halfHeight + 64 + offsetY)/_halfHeight);
        if (offsetY >= - _halfHeight - 64) {
            
//            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
//            self.NavImg.alpha = offsetY;
        } else {
//            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
//            self.NavImg.alpha = 1;
        }
    }
    
}
-(void)ViewheaderRereshing{
    [self merchant_center];
    [self list_checkstand:self.begin_date andEnd:self.end_date];
    [self.SJScrollView.mj_header endRefreshing];
    
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"conversion" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"OrderConversino" object:nil];

}
#pragma mark - Get
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1080);
        _SJScrollView.delegate = self;
        
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(ViewheaderRereshing)];
        NSMutableArray *refreshingImages = [NSMutableArray array];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        header.stateLabel.hidden = YES;
        NSArray *arr = @[@"MJ-1",@"MJ-2",@"MJ-3",@"MJ-4",@"MJ-5",@"MJ-6",@"MJ-7",@"MJ-8",@"MJ-9",@"MJ-10",@"MJ-11",@"MJ-12",@"MJ-13",@"MJ-14",@"MJ-15",@"MJ-16",@"MJ-17"];
        
        for (NSUInteger i = 0; i<arr.count; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", arr[i]]];
            [refreshingImages addObject:image];
        }
        
        // 设置普通状态的动画图片
        [header setImages:refreshingImages forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [header setImages:refreshingImages forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        // 设置header
        _SJScrollView.mj_header = header;
        
    }
    return _SJScrollView;
}
-(UIImageView *)backgrounImg{
    if (!_backgrounImg) {
        _backgrounImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, -44, ScreenW, 260)];
        _backgrounImg.image = [UIImage imageNamed:@"bg_index_top_scene"];
    }
    return _backgrounImg;
}

-(FBHCashierBaseView *)FBHCashierView{
    if (!_FBHCashierView) {
        _FBHCashierView =[[ FBHCashierBaseView alloc]initWithFrame:CGRectMake(0, 44, ScreenW, 935)];
        _FBHCashierView.delagate = self;
        
        
    }
    return _FBHCashierView;
}
-(NSMutableArray *)RefundData{
    if (!_RefundData) {
        _RefundData = [NSMutableArray array];
    }
    return _RefundData;
}
@end
