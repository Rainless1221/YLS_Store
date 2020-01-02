//
//  FBHStoreViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHStoreViewController.h"
#import "YLSHelpViewController.h"

@interface FBHStoreViewController ()<UIScrollViewDelegate,HQBannerViewDelegate,storeMerchantDelegate>
/**
 自定义导航栏
 */
@property (strong,nonatomic)UIView * NavView;
@property (strong,nonatomic)UIButton * unreadButton;
/**
 导航栏标题
 */
@property (strong,nonatomic)UILabel *navLabel;
@property (strong,nonatomic)FL_Button *Navbutton;
/**
 导航栏背景图
 */
@property (strong,nonatomic)UIImageView * NavImg;
@property (strong,nonatomic)UIImageView * backgrounImg;
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)storeCenterView * scrollView;
/** 滚动高度 */
@property (nonatomic) CGFloat halfHeight;

@property (strong,nonatomic)NSString * store_address;

@property (assign,nonatomic)NSInteger cust_type;

/*分店标示*/
@property (strong,nonatomic)UIButton * branch_typeButton;
@end

@implementation FBHStoreViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.SJScrollView];
//    [self.SJScrollView addSubview:self.backgrounImg];
//    [self.view addSubview:self.NavView];
    _halfHeight = (CGRectGetHeight([UIScreen mainScreen].bounds)) * 0.5 - 64;
    /**
     请求数据
     */
    self.cust_type = 4;
    // 并发队列的创建方法
    dispatch_queue_t queue_B = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    // 异步执行任务创建方法
    dispatch_async(queue_B, ^{
        [self merchant_center];
        [self get_completion_ysepay_mer_info];
        [self get_store_application_info];
        NSLog(@"中心线程---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
//    [self discount_goods];
//     [self get_completion_ysepay_mer_info];
    
    
    /**
     *  导航栏
     */
    [self setupNav];
    /**
     *  UI
     */
    [self createUI];


}

#pragma mark - 请求数据
-(void)merchant_center{
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // 回到主线程
    dispatch_async(mainQueue, ^{
        
        
    });
    UserModel *model = [UserModel getUseData];

    /**
     获取商家中心的信息（商家中心显示的信息）
     */
    [[FBHAppViewModel shareViewModel] yls_list_business_center:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            /** 保存商家中心信息 */
            storeBaseModel *model = [storeBaseModel mj_objectWithKeyValues:DIC];
            [model saveUserData];
            self.store_address = model.store_address;
            self.scrollView.Data = model;
            
            if ([model.have_unread_news isEqualToString:@"1"]) {
                self.unreadButton.selected = YES;
            }else{
                self.unreadButton.selected = NO;
                
            }
            
            /*是否主店*/
            NSString *branch_type = [NSString stringWithFormat:@"%@",DIC[@"branch_type"]];
            if ([branch_type isEqualToString:@"2"]) {
                [PublicMethods writeToUserD:branch_type andKey:@"branch_type"];
                self.branch_typeButton.hidden = YES;
            }else if ([branch_type isEqualToString:@"3"]){
                [PublicMethods writeToUserD:branch_type andKey:@"branch_type"];
                self.branch_typeButton.hidden = YES;
            }else{
                self.branch_typeButton.hidden = NO;
//                [PublicMethods writeToUserD:branch_type andKey:@"branch_type"];
            }
            /** 商家名称 */
            NSString *store_name = [NSString stringWithFormat:@"%@",DIC[@"store_name"]];
//            self.navLabel.text = store_name;
            [self.Navbutton setTitle:store_name forState:UIControlStateNormal];

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
    
//    [MBProgressHUD MBProgress:@"数据加载中..."];

//    [[FBHAppViewModel shareViewModel]get_store_application_info:model.merchant_id Success:^(NSDictionary *resDic) {
//        if ([resDic[@"status"] integerValue]==1){
//            NSDictionary *DIC = resDic[@"data"][@"application_info"];
//            insert_storeM *model = [insert_storeM mj_objectWithKeyValues:DIC];
//            //保存
//            [model saveUserData];
//
//
//        }else{
//            [SVProgressHUD setMinimumDismissTimeInterval:2];
//            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
//        }
//
//        [MBProgressHUD hideHUD];
//
//    } andfailure:^{
//        [MBProgressHUD hideHUD];
//
//    }];
    
//    [[FBHAppViewModel shareViewModel]yls_list_business_center:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
//
//        if ([resDic[@"status"] integerValue]==1) {
//            NSDictionary *DIC=resDic[@"data"];
//
//
//        }
//    } andfailure:^{
//
//    }];
    
}
-(void)discount_goods{
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]tips_for_merchant_about_discount_goods:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            //            1表是 0表否
            //            NSLog(@"%@",DIC[@"hint_for_discount"])
            NSString *string = [NSString stringWithFormat:@"%@",DIC[@"hint_for_discount"]];
            if ([string isEqualToString:@"1"]) {
                [SureguideView sureGuideViewWithImageName:@"remind_fill_business_marketing" imageCount:3];
            }else{
                NSString *string1 = [NSString stringWithFormat:@"%@",DIC[@"hint_for_goods"]];
                if ([string1 isEqualToString:@"1"]) {
                    [SureguideView sureGuideViewWithImageName:@"remind_fill_business_products" imageCount:2];
                }
            }
            
            
        }
    } andfailure:^{
        
    }];
}
-(void)get_completion_ysepay_mer_info{
    
    
    UserModel *model = [UserModel getUseData];
    
    if ([model.store_id isEqualToString:@""]) {

        return;
    }
    
    [[FBHAppViewModel shareViewModel]get_completion_ysepay_mer_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            
            NSString *sting = [NSString stringWithFormat:@"%@",DIC[@"cust_type"]];
            if ([[MethodCommon judgeStringIsNull:sting] isEqualToString:@""]) {
                self.cust_type = 4;
            }else{
                self.cust_type = [sting integerValue];
            }

                
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            
        }

    } andfailure:^{

        
    }];
    

    
}
-(void)get_ysepay_merchant_info{
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_ysepay_merchant_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"][@"ys_mer_info"];
            /** 保存信息 */
            ysepayModel *model = [ysepayModel mj_objectWithKeyValues:DIC];
            [model saveUserData];
            
            
        }
    } andfailure:^{
        
    }];
}
#pragma mark - 店铺申请信息
-(void)get_store_application_info{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_store_application_info:model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
            NSDictionary *DIC=resDic[@"data"];
            //1为未审核，2为审核通过，3为审核驳回
            NSString *status = [NSString stringWithFormat:@"%@",DIC[@"status"]];
            if ([[MethodCommon judgeStringIsNull:status] isEqualToString:@""]) {
                status=@"";
            }
            if ([status isEqualToString:@"1"]) {
//                [SVProgressHUD setMinimumDismissTimeInterval:2];
//                [SVProgressHUD showErrorWithStatus:@"您的资料已提交审核，请勿重复提交!"];
            }else if([status isEqualToString:@"3"]){
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:@"您的资料审核未通过，请检查资料重新提交！"];
            }else{
               
            }
            
        }
    } andfailure:^{
        
    }];
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    NavView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:NavView];
    //背景图片
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
    [NavImg.layer addSublayer:layer];
    
    self.NavImg = NavImg;
//    [NavView addSubview:NavImg];
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT, 220, 44)];
    navLabel.text = @"";
    navLabel.textColor = [UIColor blackColor];
//    [NavView addSubview:navLabel];
    self.navLabel = navLabel;

    self.Navbutton = [FL_Button buttonWithType:UIButtonTypeCustom];
    self.Navbutton.frame = CGRectMake(10, STATUS_BAR_HEIGHT, 220, 44);
    [self.Navbutton setImage:[UIImage imageNamed:@"icn_branch_exchange_black"] forState:UIControlStateNormal];
    [self.Navbutton setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
    [self.Navbutton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    //样式
    self.Navbutton.status = FLAlignmentStatusLeft;
    self.Navbutton.fl_padding = 10;
    self.Navbutton.titleLabel.font = [UIFont systemFontOfSize:20];
    [NavView addSubview:self.Navbutton];
    
    //信息中心
    self.unreadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.unreadButton.frame = CGRectMake(ScreenW-10-40, STATUS_BAR_HEIGHT, 40, 44);
    [self.unreadButton setImage:[UIImage imageNamed:@"icn_nav_message_normal"] forState:UIControlStateNormal];
    [self.unreadButton setImage:[UIImage imageNamed:@"icn_nav_set_black_reddot_normal"] forState:UIControlStateSelected];
    [self.unreadButton addTarget:self action:@selector(WordAction) forControlEvents:UIControlEventTouchUpInside];
//    [NavView addSubview:self.unreadButton];
    
    //设置
    UIButton *thirdBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn2.frame = CGRectMake(ScreenW-9-40, STATUS_BAR_HEIGHT, 40, 44);
    [thirdBtn2 setImage:[UIImage imageNamed:@"icn_nav_set_black_normal"] forState:UIControlStateNormal];
    [thirdBtn2 setImage:[UIImage imageNamed:@"icn_nav_set_black_reddot_normal"] forState:UIControlStateSelected];
    [NavView addSubview:thirdBtn2];
    [thirdBtn2 addTarget:self action:@selector(SetupAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //    thirdBtn1.selected = YES;
//        thirdBtn2.selected = YES;
    
    self.NavView = NavView;
    
}
/**
 * 设置中心
 */
-(void)SetupAction:(UIButton *)Btn{
    Btn.selected = NO;
    [self.tabBarController.tabBar  hideBadgeOnItemIndex:3];

    [self.navigationController pushViewController:[SetupViewController new] animated:YES];
}
/**
 * 信息中心
 */
-(void)WordAction{
    [self.navigationController pushViewController:[WordViewController new] animated:YES];
}
#pragma mark - 定位
-(void)LatViewcontroler{
    FBHDWViewController *VC = [FBHDWViewController new];
    VC.store_address = self.store_address;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - UI
-(void)createUI{
    
    [self.SJScrollView addSubview:self.scrollView];
    self.scrollView.height = self.SJScrollView.contentSize.height;
    
    //conversion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"conversion" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction1:) name:@"business_center" object:nil];

    [self.view addSubview:self.branch_typeButton];
    [self.branch_typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.top.mas_offset(350);
        make.size.mas_offset(CGSizeMake(49, 49));
    }];
    
    

    
}
//店铺转换
- (void)conversionAction: (NSNotification *) notification {
    [self.SJScrollView setContentOffset:CGPointMake(0, -22) animated:YES];
    [self ViewheaderRereshing];
    [self get_ysepay_merchant_info];
}
- (void)conversionAction1: (NSNotification *) notification {
    [self merchant_center];
}
#pragma mark - 模块事件
-(void)pushViewcontroler:(NSInteger )Btntag{
    UserModel *model = [UserModel getUseData];
    NSString *store_id = [NSString stringWithFormat:@"%@",model.store_id];
    
    FBHOrderViewController*VC = [FBHOrderViewController new];
    NSString *branch_type =[PublicMethods  readFromUserD:@"branch_type"];

    /*认证*/
    MoneyCertificationController *VC1 = [MoneyCertificationController new];

    switch (Btntag) {
        case 10:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]) {
                /** 未入驻店铺 **/
                [self.navigationController pushViewController:[StepsViewController new] animated:YES];
            }else{
                /** 已入驻店铺 **/
                [self.navigationController pushViewController:[StoreStatusViewController new] animated:YES];
                
            }
            break;
            
        case 11:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            
            /** 商家分类 **/
            [self.navigationController pushViewController:[TheLabelController new] animated:YES];
            break;
            
        case 12:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            /** 商家产品 **/
            [self.navigationController pushViewController:[FBHCPViewController new] animated:YES];
            break;
        case 13:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            /** 翻呗设置 **/
            [self.navigationController pushViewController:[MarketingController new] animated:YES];
            break;
        
        case 20:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            /**
             *  订单
             **/
            VC.status = @"0";VC.isDzhuang = 1;
            [self.navigationController pushViewController:VC animated:YES];
            break;
        case 21:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            VC.status = @"1";VC.isDzhuang = 1;
            [self.navigationController pushViewController:VC animated:YES];
            break;
        case 22:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            VC.status = @"2";VC.isDzhuang = 1;
            [self.navigationController pushViewController:VC animated:YES];
            break;
        case 23:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            VC.status = @"4";VC.isDzhuang = 1;
            [self.navigationController pushViewController:VC animated:YES];
            break;
            
        case 30:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            /** 账号安全 **/
            [self.navigationController pushViewController:[FBHaccountController new] animated:YES];
            break;
        case 31:
             /** 分店切换 **/
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            if ([branch_type isEqualToString:@"2"]){
                /** 2表主店  **/
                [self.navigationController pushViewController:[StoreBranchController new] animated:YES];
            }else if ([branch_type isEqualToString:@"3"]){
                /** 3表既不是主店也不是分店 **/
                [self.navigationController pushViewController:[StoreBranchController new] animated:YES];
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:@"无权限查看分店信息"];
            }
            
            
            break;
            
        case 322:
            
            /** 提现认证 **/
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            switch (self.cust_type) {
                case 1:
                    [self.navigationController pushViewController:[Wei_StoreController new] animated:YES];

                    break;
                case 2:
                    [self.navigationController pushViewController:[Geti_StoreController new] animated:YES];

                    break;
                case 3:
                    [self.navigationController pushViewController:[Qiye_StoreController new] animated:YES];

                    break;
                case 4:
                    VC1.navigationTitle= @"提现认证";
                    [self.navigationController pushViewController:VC1 animated:NO];

                    break;
                    
                default:
                    break;
            }
            
            break;
        case 32:
            
            /** 银行卡 **/
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            [self.navigationController pushViewController:[FBHbankcardController new] animated:YES];
//            [self.navigationController pushViewController:[YLSCertificationController new] animated:NO];

            break;
        case 33:
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            /** 我的粉丝 **/
            [self.navigationController pushViewController:[FansViewController new] animated:YES];
            break;
        case 34:
            /** 加盟代理 **/
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            [self.navigationController pushViewController:[FBHJoinInViewController new] animated:YES];
            break;

        case 35:
            /** 关于一鹿省 **/
            [self.navigationController pushViewController:[FBHGYViewController new] animated:YES];
            break;
        case 36:
            /** 帮助与客服 **/
            [self.navigationController pushViewController:[YLSHelpViewController new] animated:YES];
            break;
        case 37:
            /** 版本更新 **/
            [self lookup];
            break;
        case 38:
            /** 绑定支付宝 **/
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            [self.navigationController pushViewController:[BindingPayController new] animated:YES];
            break;
        case 39:
            /** 店铺设置 **/
            if ([[MethodCommon judgeStringIsNull:store_id] isEqualToString:@""]){
                [self store];
                return;
            }
            [self.navigationController pushViewController:[SetupStoreViewController new] animated:YES];
            break;
        case 40:
            /** 反馈 **/
            [self.navigationController pushViewController:[FeedbackViewController new] animated:YES];
            break;
            
        case 399:
            /** 打印机 **/
            [self.navigationController pushViewController:[ReceiptsController new] animated:YES];
            break;
            
            
        default:
            break;
    }
}

/** 去申请入驻商铺 */
-(void)store{
    [self.navigationController pushViewController:[StepsViewController new] animated:YES];
}

#pragma mark - ScrollViewDelegate
// 滑动时要执行的代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = MIN(1, (_halfHeight + 64 + offsetY)/_halfHeight);
//    if (offsetY >= - _halfHeight - 64) {
//        //替换这种方式
//        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
//        self.NavView.backgroundColor = UIColorFromRGBA(0x3d8aff, offsetY);
//        self.NavImg.alpha = offsetY;
//    } else {
//        //替换这种方式
//        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
//        self.NavView.backgroundColor = UIColorFromRGBA(0x3d8aff, 1);
//        self.NavImg.alpha = 1;
//    }
}

-(void)ViewheaderRereshing{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    
    if ([model.store_id isEqualToString:@""]) {
        
        [MBProgressHUD hideHUD];
        return;
    }
    // 并发队列的创建方法
    dispatch_queue_t queue_B = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    // 异步执行任务创建方法
    dispatch_async(queue_B, ^{
        [self merchant_center];
        [self get_completion_ysepay_mer_info];
        NSLog(@"中心线程---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    [self.SJScrollView.mj_header endRefreshing];
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"conversion" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"business_center" object:nil];

}
#pragma mark - Get
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 815);
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
-(storeCenterView *)scrollView{
    if (!_scrollView) {
        _scrollView =[[storeCenterView alloc]initWithFrame:CGRectMake(0, 44, ScreenW, ScreenH-20)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.layer.cornerRadius = 5;
        _scrollView.delagate = self;
        
    }
    return _scrollView;
}
-(UIButton *)branch_typeButton{
    if (!_branch_typeButton) {
        _branch_typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_branch_typeButton setImage:[UIImage imageNamed:@"icn_current_branch"] forState:UIControlStateNormal];
        _branch_typeButton.hidden = YES;

    }
    return _branch_typeButton;
}
@end
