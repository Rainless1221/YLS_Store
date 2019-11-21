//
//  FBHWorkbenchController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHWorkbenchController.h"
#import "Suspended_View.h"// 暂停合作

@interface FBHWorkbenchController ()<UIScrollViewDelegate,zyyyDelegate,WorkbenchDelegate,FSCalendarDataSource, FSCalendarDelegate,DDDBManagerDelegate>

@property (strong,nonatomic)UIScrollView * FBHScrollView;
@property (strong,nonatomic)UIImageView * backgrounImg;
@property (strong,nonatomic)WorkbenchBaseView * WorkbenchView;
/**  */
@property (strong,nonatomic)UIView * NoDataView;
@property (strong,nonatomic)UIView * NavView;
@property (strong,nonatomic)UIImageView * NavImg;
@property (strong,nonatomic)UILabel * NavLabl;
@property (strong,nonatomic)FL_Button *Navbutton;

@property (nonatomic) CGFloat halfHeight;
@property (strong,nonatomic)NSMutableDictionary * storeData;
@property(nonatomic,assign) BOOL IsStore;
//曲线图数据
@property (strong,nonatomic)NSMutableArray * orderData;
@property (strong,nonatomic)NSMutableArray * visitorData;
@property (strong,nonatomic)NSMutableArray * orderDay;
@property (strong,nonatomic)NSMutableArray * visitorDay;
@property (nonatomic,strong) LRSChartView * incomeChartLineView;
/** 日历 **/
@property (weak, nonatomic) FSCalendar *calendar;

/*抽屉*/
@property (strong,nonatomic)UIView * ChoutiView;
@end

@implementation FBHWorkbenchController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = YES;
    //    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    [self get_store_application_info];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工作台";
    [self merchant_center];
    
    [self setnodataView];
    
    _halfHeight = (CGRectGetHeight([UIScreen mainScreen].bounds)) * 0.5 - 60;
    [self createUI];
    
    [self setupNav];
    
    UserModel *model = [UserModel getUseData];
    NSString *store_id = [NSString stringWithFormat:@"%@",model.store_id];
    if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]) {
        self.FBHScrollView.hidden = YES;
        self.NavView.hidden = YES;
        self.NoDataView.hidden = NO;
        self.backgrounImg.hidden = YES;
    }else{
        self.NoDataView.hidden = YES;
        self.FBHScrollView.hidden = NO;
        self.NavView.hidden = NO;
        self.backgrounImg.hidden = NO;

    }

    
//    if ([model.store_id isEqualToString:@""]) {
//        [SureguideView sureGuideViewWithImageName:@"remind_fill_business_info" imageCount:1];
//
//    }

}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.backgrounImg];
    [self.view addSubview:self.FBHScrollView];
    [self.FBHScrollView addSubview:self.WorkbenchView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"StatusView" object:nil];
    //conversion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"conversion" object:nil];

   
}
//店铺转换
- (void)conversionAction: (NSNotification *) notification {

    [self get_store_application_info];
    [self merchant_center];

}
#pragma mark - 请求
-(void)merchant_center{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
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
            if ([[MethodCommon judgeStringIsNull:storeString] isEqualToString:@""]){
                self.FBHScrollView.hidden = YES;
                self.NavView.hidden = YES;
                self.NoDataView.hidden = NO;
                self.backgrounImg.hidden = YES;

            }else{
                self.NoDataView.hidden = YES;
                self.FBHScrollView.hidden = NO;
                self.NavView.hidden = NO;
                self.backgrounImg.hidden = NO;

            }
            
            [self shang];
        }else{
            
            NSString *message = [NSString stringWithFormat:@"%@",resDic[@"message"]];
            if ([message isEqualToString:@"请重新登录"] || [message isEqualToString:@"您的账号已在其他设备上登录"]) {
//                [self Exit_log];
            }
        }
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
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

-(void)shang{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    
    //上半部分
//    [[FBHAppViewModel shareViewModel] get_workbench_upper_part_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
//
//        if ([resDic[@"status"] integerValue] == 1) {
//            NSDictionary *DIC = resDic[@"data"];
//            if (DIC.count==0) {
//
//            }else{
//                self.WorkbenchView.Data = DIC;
//
//            }
//            self.NavLabl.text = DIC[@"store_name"];
//
//        }else{
//
//        }
//        [MBProgressHUD hideHUD];
//
//    } andfailure:^{
//        [MBProgressHUD hideHUD];
//    }];
    
    [[FBHAppViewModel shareViewModel]yls_get_workbench_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC = resDic[@"data"];
            if (DIC.count==0) {
                
            }else{
                self.WorkbenchView.Data = DIC;
                NSString *num = [NSString stringWithFormat:@"%@",DIC[@"have_red_point"]];
                NSInteger order_num = [num integerValue];
                if (order_num ==1) {
                    [self.tabBarController.tabBar  showBadgeOnItmIndex:1 tabbarNum:4];
                }else if (order_num == 2){
                    [self.tabBarController.tabBar  hideBadgeOnItemIndex:1];
                }
            }
            /*店铺名称*/
            NSString *store_name = [NSString stringWithFormat:@"%@",DIC[@"store_name"]];
            self.NavLabl.text = store_name;
            [self.Navbutton setTitle:store_name forState:UIControlStateNormal];
            
        }else{
            
        }
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
    
    //下半部分
    [[FBHAppViewModel shareViewModel]get_workbench_lower_part_info:model.merchant_id andstore_id:model.store_id andsearch_date:nil Success:^(NSDictionary *resDic) {

        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            if (DIC.count==0) {

            }else{
                self.WorkbenchView.Current_Data = DIC;

            }
            [self.orderData removeAllObjects];
            [self.orderDay removeAllObjects];
            [self.visitorData removeAllObjects];
            [self.visitorDay removeAllObjects];
            //订单
            for (NSDictionary *dict in DIC[@"current_month_order_num_trend"]) {
                NSString *num = [NSString stringWithFormat:@"%@",dict[@"order_num"]];
                [self.orderData addObject:num];
                NSString * time = [NSString stringWithFormat:@"%@",dict[@"order_date"]];
                // 用指定字符串分割字符串，返回一个数组
                NSArray *picsarray = [time componentsSeparatedByString:@"-"];
                NSString *ordert = [NSString stringWithFormat:@"%@-%@",picsarray[1],picsarray[2]];
                [self.orderDay addObject:ordert];
            }

            //访客
            for (NSDictionary *dict in DIC[@"current_month_visitor_num_trend"]) {
                NSString *num = [NSString stringWithFormat:@"%@",dict[@"visitor_num"]];
                [self.visitorData addObject:num];
                NSString * time = [NSString stringWithFormat:@"%@",dict[@"visit_date"]];
                // 用指定字符串分割字符串，返回一个数组
                NSArray *picsarray = [time componentsSeparatedByString:@"-"];
                NSString *visit = [NSString stringWithFormat:@"%@-%@",picsarray[1],picsarray[2]];
                [self.visitorDay addObject:visit];

            }
            [self.incomeChartLineView removeFromSuperview];
            NSArray *arr = @[self.orderData];
            [self setincomeChartLine:arr anddataArrOfX:self.orderDay];


            [MBProgressHUD hideHUD];


        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }

    } andfailure:^{

    }];
    
    
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
 *///
-(void)InstoreAction{
    [self.navigationController pushViewController:[StepsViewController new] animated:NO];
    //测试
    //    [self.navigationController pushViewController:[FBHStoreDataController new] animated:NO];
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
//    NavView.backgroundColor = [UIColor whiteColor];
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
    layer.colors=@[(__bridge id)UIColorFromRGB(0xffffff).CGColor,(__bridge id)UIColorFromRGB(0xffffff).CGColor,(__bridge id)UIColorFromRGB(0xffffff).CGColor];
    /**
     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
     */
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.frame = NavImg.bounds;
//    [NavImg.layer addSublayer:layer];
//
//    self.NavImg = NavImg;
//    [NavView addSubview:NavImg];
    /** 标题 */
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, STATUS_BAR_HEIGHT, 160, 44)];
    navLabel.text = @"";
    navLabel.textColor = UIColorFromRGB(0x222222);
    navLabel.font = [UIFont systemFontOfSize:20];
//    [NavView addSubview:navLabel];
    self.NavLabl = navLabel;
    
    self.Navbutton = [FL_Button buttonWithType:UIButtonTypeCustom];
    self.Navbutton.frame = CGRectMake(12, STATUS_BAR_HEIGHT, 160, 44);
    [self.Navbutton setImage:[UIImage imageNamed:@"icn_branch_exchange_black"] forState:UIControlStateNormal];
    [self.Navbutton setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
    [self.Navbutton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    //样式
    self.Navbutton.status = FLAlignmentStatusLeft;
    self.Navbutton.fl_padding = 10;
    self.Navbutton.titleLabel.font = [UIFont systemFontOfSize:20];
    [NavView addSubview:self.Navbutton];
    
    UIButton *RighBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    RighBtn.frame = CGRectMake(ScreenW-16-57, STATUS_BAR_HEIGHT, 57, 44);
    [RighBtn setTitle:@" 更多" forState:UIControlStateNormal];
    [RighBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [RighBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [RighBtn setImage:[UIImage imageNamed:@"icn_nav_plus_black_normal"] forState:UIControlStateNormal];
    [RighBtn addTarget:self action:@selector(ChoutiAction) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:RighBtn];
    
    /** 二维码 */
//    UIButton *thirdBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    thirdBtn1.frame = CGRectMake(ScreenW-16-120, STATUS_BAR_HEIGHT, 120, 44);
//    [thirdBtn1 setTitle:@"  店铺二维码" forState:UIControlStateNormal];
//    [thirdBtn1.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_nav_qrcode_normal"] forState:UIControlStateNormal];
//    [thirdBtn1 addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
//    [NavView addSubview:thirdBtn1];
    /** 扫一扫 */
    UIButton *thirdBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn2.frame = CGRectMake(RighBtn.left-65, STATUS_BAR_HEIGHT, 60, 44);
    [thirdBtn2 setTitle:@" 验劵" forState:UIControlStateNormal];
    [thirdBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn2.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [thirdBtn2 setImage:[UIImage imageNamed:@"icn_titlebar_menu_flicking"] forState:UIControlStateNormal];
    [thirdBtn2 addTarget:self action:@selector(Righ2Action) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:thirdBtn2];
    
    
    
}
#pragma mark - 抽屉
-(void)ChoutiAction{
    [self.view.window addSubview:self.ChoutiView];
}
-(void)tapAction:(id)tap{
    [self.ChoutiView removeFromSuperview];
}
#pragma mark --- 选择 ---
- (void)ChoutiButtonAction:(UIButton *)sender {
    
    for (int i = 1; i<4; i++) {
        if (sender.tag == i) {
            sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self.view viewWithTag:i];
        but.selected = NO;
    }
    
    [self.ChoutiView removeFromSuperview];
    
}
/**
 *二维码
 */
-(void)RighAction{
    [self.ChoutiView removeFromSuperview];

    [self.navigationController pushViewController:[FBHQRCodeController new] animated:YES];
}
/**
 * 扫一扫
 */
-(void)Righ2Action{

    SWQRCodeConfig *config = [[SWQRCodeConfig alloc]init];
    config.scannerType = SWScannerTypeBoth;
    /** 棱角颜色 */
    config.scannerCornerColor = UIColorFromRGB(0x3D8AFF);
    /** 边框颜色 */
    config.scannerBorderColor = UIColorFromRGB(0xFFFFFF);

    FBHRichScanController *qrcodeVC = [[FBHRichScanController alloc]init];
    qrcodeVC.codeConfig = config;
    [self.navigationController pushViewController:qrcodeVC animated:YES];
    
}
-(void)Righ3Action{
    [self.ChoutiView removeFromSuperview];
    [self.navigationController pushViewController:[ConsumptionViewController new] animated:YES];

}
-(void)zhuoAction{
    [self.ChoutiView removeFromSuperview];
    [self.navigationController pushViewController:[ZhuoCodeViewController new] animated:YES];
    
}
#pragma mark -设置店铺状态
- (void)Setstatus:(NSInteger)statusType{
    
//    Suspended_View *suspen = [[Suspended_View alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    suspen.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.56];
//
//     [[UIApplication sharedApplication].keyWindow addSubview:suspen];
//    return;
    
    StatusViewController *VC = [StatusViewController new];
    VC.statusType = [NSString stringWithFormat:@"%ld",(long)statusType];
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (void)refreshTableView: (NSNotification *) notification {
    //处理消息
    NSString *info = [notification object];
    if ([info isEqualToString:@"1"]) {
        self.WorkbenchView.status.text = @"营业中";
        self.WorkbenchView.status.textColor = UIColorFromRGB(0x3D8AFF);
        self.WorkbenchView.status.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        self.WorkbenchView.status.backgroundColor = UIColorFromRGB(0xE5F4FF);
        self.WorkbenchView.statusBtn2.hidden = YES;
        self.WorkbenchView.statusBtn1.hidden = NO;
        
        
        
    }else if ([info isEqualToString:@"2"]){
        self.WorkbenchView.status.text = @"打烊中";
        self.WorkbenchView.status.textColor = UIColorFromRGB(0xFF6969);
        self.WorkbenchView.status.layer.borderColor = UIColorFromRGB(0xFF6969).CGColor;
        self.WorkbenchView.status.backgroundColor = UIColorFromRGB(0xFFE7E4);
        self.WorkbenchView.statusBtn1.hidden = YES;
        self.WorkbenchView.statusBtn2.hidden = NO;
        [self.WorkbenchView.statusBtn2 setUserInteractionEnabled:YES];

    }else {
        self.WorkbenchView.status.text = @"暂停合作";
        self.WorkbenchView.status.textColor = UIColorFromRGB(0x666666);
        self.WorkbenchView.status.layer.borderColor = UIColorFromRGB(0xDADADA).CGColor;
        self.WorkbenchView.status.backgroundColor = UIColorFromRGB(0xEDEDED);
        self.WorkbenchView.statusBtn1.hidden = YES;
        self.WorkbenchView.statusBtn2.hidden = NO;
        [self.WorkbenchView.statusBtn2 setUserInteractionEnabled:NO];
        self.WorkbenchView.statusBtn2.backgroundColor = UIColorFromRGB(0xB2B2B2);
        self.WorkbenchView.statusBtn2.layer.borderColor = UIColorFromRGB(0x929292).CGColor;
        
    }
    
}

#pragma mark - zyyyDelegate (选择的时间)
-(void)moveImageBtnClick:(zyyy_DateListView *)Zview andData:(NSDictionary *)Dict{
 
    
}

#pragma mark - 订单Or访客
-(void)OrderOrFang:(NSInteger)btnTag{
    if (btnTag == 1) {
        [self.incomeChartLineView removeFromSuperview];
        
        NSArray *arr = @[self.orderData];
        [self setincomeChartLine:arr anddataArrOfX:self.orderDay];
    }else{
        [self.incomeChartLineView removeFromSuperview];
        
        NSArray *arr = @[self.visitorData];
        [self setincomeChartLine:arr anddataArrOfX:self.visitorDay];
    }
}
#pragma mark - 折线图
-(void)setincomeChartLine:(NSArray *)tempDataArrOfY anddataArrOfX:(NSArray *)dataArrOfX
{
    //    _incomeChartLineView = [[LRSChartView alloc]initWithFrame:CGRectMake(13, self.scrollView.TJlabelText.bottom+30, self.scrollView.WorkView3.width - 26, self.scrollView.WorkView3.height-(self.scrollView.TJlabelText.bottom+30+15))];
    _incomeChartLineView = [[LRSChartView alloc]initWithFrame:CGRectMake(13, self.WorkbenchView.current_month.bottom+30, self.WorkbenchView.currentView.width - 26, self.WorkbenchView.currentView.height-(self.WorkbenchView.current_month.bottom+30+10))];
    
    //是否默认显示第一个点
    _incomeChartLineView.isShowFirstPaoPao = YES;
    //是否可以浮动
    _incomeChartLineView.isFloating = YES;
    //设置X轴坐标字体大小
    _incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
    //设置X轴坐标字体颜色
    _incomeChartLineView.x_Color = UIColorFromRGB(0x999999);
    //设置Y轴坐标字体大小
    _incomeChartLineView.y_Font = [UIFont systemFontOfSize:10];
    //设置Y轴坐标字体颜色
    _incomeChartLineView.y_Color = UIColorFromRGB(0x999999);
    //设置X轴数据间隔
    _incomeChartLineView.Xmargin = 10;
    _incomeChartLineView.xRow = 7;
    //设置背景颜色
    //    _incomeChartLineView.backgroundColor = [UIColor yellowColor];
    //是否根据折线数据浮动泡泡
    _incomeChartLineView.isFloating = YES;
    //折线图数据
    _incomeChartLineView.leftDataArr = tempDataArrOfY;
    //折线图所有颜色
    _incomeChartLineView.leftColorStrArr = @[@"#3D8AFF",@"#febf83",@"#53d2f8",@"#7211df"];
    //设置折线样式
    _incomeChartLineView.chartViewStyle = LRSChartViewMoreClickLine;
    //设置图层效果
    _incomeChartLineView.chartLayerStyle = LRSChartGradient;
    //设置折现效果
    _incomeChartLineView.lineLayerStyle = LRSLineLayerNone;
    //泡泡背景颜色
    _incomeChartLineView.paopaoBackGroundColor = UIColorFromRGB(0x3D8AFF);//[self colorWithHexString:@"00b6b0"];
    
    //设置标线颜色
    _incomeChartLineView.markColor = UIColorFromRGB(0x3D8AFF);
    //渐变效果的颜色组
    _incomeChartLineView.colors = @[@[ UIColorFromRGB(0xfebf83),[UIColor greenColor]],@[UIColorFromRGB(0x53d2f8),[UIColor blueColor]],@[UIColorFromRGB(0x7211df)],[UIColor redColor]];
    //渐变开始比例
    _incomeChartLineView.proportion = 0.6;
    //底部日期
    _incomeChartLineView.dataArrOfX =dataArrOfX;// @[@"01-13",@"01-14",@"01-15",@"01-16",@"01-17",@"01-18",@"01-19",@"01-20",@"01-21",@"01-22"];
    //开始画图
    [_incomeChartLineView show];
    [self.WorkbenchView.currentView addSubview:_incomeChartLineView];
    
}


#pragma mark - ScrollViewDelegate
// 滑动时要执行的代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = MIN(1, (_halfHeight + 64 + offsetY)/_halfHeight);
    if (offsetY >= - _halfHeight - 64) {
        //替换这种方式
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        self.NavView.backgroundColor = UIColorFromRGBA(0xffffff, offsetY);
        self.NavLabl.alpha = offsetY;
        self.Navbutton.alpha = offsetY;
        self.NavImg.alpha = offsetY;
    } else {
        //替换这种方式
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        self.NavView.backgroundColor = UIColorFromRGBA(0xffffff, 1);
        self.NavLabl.alpha = 1;
        self.Navbutton.alpha = 1;
        self.NavImg.alpha  = 1;
    }
}
#pragma mark - 去设置
-(void)SetupAction{
    //    [self.navigationController pushViewController:[FBHSZViewController new] animated:NO];
}

#pragma mark - 更多
-(void)MoreAction{
    //    [self.navigationController pushViewController:[FBHGoodsListController new] animated:YES];
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
        UserModel *model = [UserModel getUseData];

        switch (Btntag) {
            case 10:
                if ([model.store_id isEqualToString:@""]) {
                    /** 未入驻店铺 **/
                    [self store];
                }else{
                    /** 已入驻店铺 **/
                    [self.navigationController pushViewController:[StoreStatusViewController new] animated:NO];
                }
                break;
                
            case 11:
                if ([model.store_id isEqualToString:@""]){
                    [self store];
                    return;
                }
                
                /** 商家分类 **/
                [self.navigationController pushViewController:[TheLabelController new] animated:NO];
                break;
                
            case 12:
                if ([model.store_id isEqualToString:@""]){
                    [self store];
                    return;
                }
                /** 商家产品 **/
                [self.navigationController pushViewController:[FBHCPViewController new] animated:NO];
                break;
            case 13:
                if ([model.store_id isEqualToString:@""]){
                    [self store];
                    return;
                }
                /** 翻呗设置 **/
                [self.navigationController pushViewController:[MarketingController new] animated:NO];
                break;
                
            default:
                break;
        }
        
    }
    
}
/** 去申请入驻商铺 */
-(void)store{
    [self.navigationController pushViewController:[StepsViewController new] animated:NO];
}
#pragma mark - 日历
-(void)Calendar{
    CalendarView *tipview = [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[UIApplication sharedApplication].keyWindow addSubview:tipview];
}

-(void)ViewheaderRereshing{
    [self merchant_center];
    [self.FBHScrollView.mj_header endRefreshing];
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StatusView" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"conversion" object:nil];

}
#pragma mark --- 懒加载 ---
-(UIScrollView *)FBHScrollView{
    if (!_FBHScrollView) {
        _FBHScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _FBHScrollView.backgroundColor = [UIColor clearColor];
        _FBHScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 710);
        _FBHScrollView.delegate = self;
        
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
        _FBHScrollView.mj_header = header;
    }
    return _FBHScrollView;
}
-(UIImageView *)backgrounImg{
    if (!_backgrounImg) {
        _backgrounImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, -44, ScreenW, 260)];
        _backgrounImg.image = [UIImage imageNamed:@"bg_index_top_scene-1"];
    }
    return _backgrounImg;
}
-(WorkbenchBaseView *)WorkbenchView{
    if (!_WorkbenchView) {
        _WorkbenchView =[[ WorkbenchBaseView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 1030)];
        _WorkbenchView.delagate = self;
    }
    return _WorkbenchView;
}

-(UIView *)ChoutiView{
    if (!_ChoutiView) {
        _ChoutiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _ChoutiView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _ChoutiView.userInteractionEnabled = YES;
        /** 视图点击 */
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_ChoutiView addGestureRecognizer:tapGesturRecognizer];
        
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(autoScaleW(245),64+(kIs_iPhoneX ? 22:0),autoScaleW(115),110);
        view.backgroundColor = [UIColor colorWithRed:235/255.0 green:243/255.0 blue:255/255.0 alpha:1.0];
        view.layer.cornerRadius = 8;
        
        view.layer.borderWidth = 1;
        view.layer.borderColor = UIColorFromRGB(0xEAEAEA).CGColor;
        
        /*二维码*/
        FL_Button *Button2 = [FL_Button buttonWithType:UIButtonTypeCustom];
        Button2.frame = CGRectMake(10, 0, view.width, 37);
        [Button2 setImage:[UIImage imageNamed:@"icn_titlebar_menu_invite_code"] forState:UIControlStateNormal];
        [Button2 setTitle:@"邀约注册码" forState:UIControlStateNormal];
        [Button2.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(14)]];
        [Button2 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        Button2.status = FLAlignmentStatusImageLeft;
        Button2.fl_padding = 6;
        [Button2 addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
        Button2.tag = 3;
        
        [view addSubview:Button2];
        /*消费码 */
        FL_Button *Button3 = [FL_Button buttonWithType:UIButtonTypeCustom];
        Button3.frame = CGRectMake(10, Button2.bottom, view.width, 36);
        [Button3 setImage:[UIImage imageNamed:@"icn_titlebar_menu_consume_code"] forState:UIControlStateNormal];
        [Button3 setTitle:@"到店消费码" forState:UIControlStateNormal];
        [Button3.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(14)]];
        [Button3 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        Button3.status = FLAlignmentStatusImageLeft;
        Button3.fl_padding = 6;
        [Button3 addTarget:self action:@selector(Righ3Action) forControlEvents:UIControlEventTouchUpInside];
        Button3.tag = 4;
        
        [view addSubview:Button3];
        /*生成桌码 */
        FL_Button *Button1 = [FL_Button buttonWithType:UIButtonTypeCustom];
        Button1.frame = CGRectMake(10, Button3.bottom, view.width, 37);
        [Button1 setImage:[UIImage imageNamed:@"icn_titlebar_menu_table_code"] forState:UIControlStateNormal];
        [Button1 setTitle:@"生成桌码" forState:UIControlStateNormal];
        [Button1.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(14)]];
        [Button1 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        Button1.status = FLAlignmentStatusImageLeft;
        Button1.fl_padding = 6;
        [Button1 addTarget:self action:@selector(zhuoAction) forControlEvents:UIControlEventTouchUpInside];
        Button1.tag = 2;
        
        [view addSubview:Button1];
        
        /*收款码 */
        FL_Button *Button4 = [FL_Button buttonWithType:UIButtonTypeCustom];
        Button4.frame = CGRectMake(10, Button1.bottom, view.width, 37);
        [Button4 setImage:[UIImage imageNamed:@"icn_titlebar_menu_flicking"] forState:UIControlStateNormal];
        [Button4 setTitle:@"收款码" forState:UIControlStateNormal];
        [Button4.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(14)]];
        [Button4 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        Button4.status = FLAlignmentStatusImageLeft;
        Button4.fl_padding = 6;
//        [Button4 addTarget:self action:@selector(Righ2Action) forControlEvents:UIControlEventTouchUpInside];
        Button4.tag = 4;
        
//        [view addSubview:Button4];
        
        [self.ChoutiView addSubview:view];

    }
    return _ChoutiView;
}
-(NSMutableArray *)orderData{
    if (!_orderData) {
        _orderData = [NSMutableArray array];
    }
    return _orderData;
}
-(NSMutableArray *)visitorData{
    if (!_visitorData) {
        _visitorData = [NSMutableArray array];
    }
    return _visitorData;
}
-(NSMutableArray *)orderDay{
    if (!_orderDay) {
        _orderDay = [NSMutableArray array];
    }
    return _orderDay;
}
-(NSMutableArray *)visitorDay{
    if (!_visitorDay) {
        _visitorDay = [NSMutableArray array];
    }
    return _visitorDay;
}
-(NSMutableDictionary *)storeData{
    if (!_storeData) {
        _storeData = [NSMutableDictionary dictionary];
    }
    return _storeData;
}

@end
