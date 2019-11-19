//
//  FBHDdetailsController.m
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHDdetailsController.h"

@interface FBHDdetailsController ()<UIScrollViewDelegate,StarEvaluatorDelegate,DetaiOrderDelegate,AmountDelegate,JHCoverViewDelegate>
{
    double actual_money;
}
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)UIImageView * backgrounImg;
@property (nonatomic) CGFloat halfHeight;
@property (strong,nonatomic)UIView * NavView;
@property (strong,nonatomic)UILabel * NavLabl;
@property (strong,nonatomic)UIButton * DayinButton;
@property (strong,nonatomic)NSDictionary  * DictData;

@property (strong,nonatomic)DetailsYSView * YSView;
@property (strong,nonatomic)DetailsJDView * JDView;
@property (strong,nonatomic)DetailsQTView * QTView;
@property (strong,nonatomic)DetailsPLView * PLView;
@property (strong,nonatomic)DetailsTKView * TKView;
@property (strong,nonatomic)UIButton * TKButton;
@property (strong,nonatomic)DetailsAmountView * AmountView;
/** 提现密码输入 */
@property (nonatomic, strong) JHCoverView *coverView;
@end

@implementation FBHDdetailsController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    //    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
//            weakSelf.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        }else{
            
        }
    }];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark - 请求
-(void)merchant_center{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]detail_merchant_orders:model.merchant_id andorder_id:self.order_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            
            //            self.scrollView.actual_money.text = [NSString stringWithFormat:@"%@",DIC[@"actual_money"]];
            //            self.scrollView.store_address.text = [NSString stringWithFormat:@"%@",DIC[@"store_address"]];
            //            self.scrollView.add_time.text = [NSString stringWithFormat:@"%@",DIC[@"add_time"]];
            //            self.scrollView.save_money.text = [NSString stringWithFormat:@"%@",DIC[@"save_money"]];
            NSString *money = [NSString stringWithFormat:@"%@",DIC[@"actual_money"]];
            actual_money = [money doubleValue];
            
            self.DictData = DIC;
            self.QTView.Data = DIC;
            self.YSView.Data = DIC;
            self.PLView.Data = DIC;
            [self createUI];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self merchant_center];
    
    self.navigationItem.title = @"订单详情";
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.backgrounImg];
    
//    [self.SJScrollView addSubview:self.JDView];
    
    _halfHeight = (CGRectGetHeight([UIScreen mainScreen].bounds)) * 0.5 - 64;
    
    [self setupNav];
//    [self createUI];
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT, ScreenW-20, 44)];
    navLabel.text = self.navigationTitle;
    navLabel.font = NavTitleFont;
    navLabel.textAlignment = NSTextAlignmentCenter;
    [NavView addSubview:navLabel];
    self.NavLabl = navLabel;
    //按钮
    UIButton *thirdBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn1.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 44, 44);
    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    [thirdBtn1 addTarget:self action:@selector(LethAction) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:thirdBtn1];
    
    [self.view addSubview:NavView];
    
    //打印按钮
    UIButton *DayinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    DayinButton.frame = CGRectMake(NavView.width-50, STATUS_BAR_HEIGHT, 50, 44);
    [DayinButton setImage:[UIImage imageNamed:@"icn_printer_black"] forState:UIControlStateNormal];
    [DayinButton addTarget:self action:@selector(printe) forControlEvents:UIControlEventTouchUpInside];
    [DayinButton setTitleColor:UIColorFromRGBA(0x222222, 1) forState:UIControlStateNormal];
    [NavView addSubview:DayinButton];
    self.DayinButton = DayinButton;
    
    self.NavView = NavView;
    
    
}
-(void)LethAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UI
-(void)createUI{
    
    UILabel *navLabel = [[UILabel alloc]init];
    navLabel.text = self.navigationTitle;
    navLabel.font = [UIFont systemFontOfSize:26];
    navLabel.textColor = [UIColor blackColor];
    navLabel.textAlignment = NSTextAlignmentCenter;
    [self.SJScrollView addSubview:navLabel];
    [navLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(25+STATUS_BAR_HEIGHT);
        make.left.mas_offset(15);
        make.height.mas_offset(24);
    }];
    
    
    UILabel *navLabel1 = [[UILabel alloc]init];
    navLabel1.text = @"感谢使用一鹿省，祝您生活愉快。";
    navLabel1.font = [UIFont systemFontOfSize:12];
    navLabel1.textColor = [UIColor blackColor];
    navLabel1.textAlignment = NSTextAlignmentCenter;
    [self.SJScrollView addSubview:navLabel1];
    [navLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.equalTo(navLabel.mas_bottom).offset(10);
    }];
    
    NSArray *goodsArr = self.DictData[@"goods_info"];
    /**
     本次订单已评价信息
     */
    NSDictionary *evaluate_info = self.DictData[@"evaluate_info"];
    //图片的数组
    NSString *evaluate_pics = [NSString stringWithFormat:@"%@",evaluate_info[@"evaluate_pics"]];
    NSArray *array = [NSArray array];
    if ([[MethodCommon judgeStringIsNull:evaluate_pics] isEqualToString:@""]) {
        
    }else{
        // 用指定字符串分割字符串，返回一个数组
        array = [evaluate_pics componentsSeparatedByString:@","];
    }
    NSInteger imageMun = array.count;
    int d = ceil(imageMun / 3.0);
    //商品的数组
    NSInteger goodMun  = goodsArr.count;
    //标签的数组
    NSString *evaluate_tags = [NSString stringWithFormat:@"%@",evaluate_info[@"evaluate_tags"]];
    NSArray *tagsarray = [NSArray array];
    if ([[MethodCommon judgeStringIsNull:evaluate_tags] isEqualToString:@""]) {
        
    }else{
        // 用指定字符串分割字符串，返回一个数组
        tagsarray = [evaluate_tags componentsSeparatedByString:@","];
    }
    
    NSInteger tagMun = tagsarray.count;
    int f = ceil(tagMun / 3.0);
    
    [self.SJScrollView addSubview:self.TKView];
    [self.SJScrollView addSubview:self.YSView];
    [self.SJScrollView addSubview:self.QTView];
    [self.SJScrollView addSubview:self.PLView];
    [self.SJScrollView addSubview:self.TKButton];

#pragma mark - 判断是否可以退款 1表是 0表否
    if (self.status == 2) {
        NSString *can_refund = [NSString stringWithFormat:@"%@",self.DictData[@"can_refund"]];
        if ([can_refund  isEqualToString:@"0"]) {
            self.TKButton.userInteractionEnabled = NO;//交互关闭
            self.TKButton.alpha=0.5;//透明度
//            self.TKView.hidden = YES;
//            self.TKView.height = IPHONEHIGHT(10);
//            self.YSView.status = DetailsVieWStatus_1;
//            self.YSView.height = goodsArr.count*55+230;

        }else if ([can_refund  isEqualToString:@"1"]){
            self.TKButton.userInteractionEnabled = YES;//交互开启
//            self.TKView.hidden = YES;
//            self.TKView.height = IPHONEHIGHT(10);
//            self.YSView.status = DetailsVieWStatus_1;
//            self.YSView.height = goodsArr.count*55+230;
            
        }else{
            self.TKButton.userInteractionEnabled = NO;//交互关闭
            self.TKButton.alpha=0.5;//透明度
//            self.TKView.hidden = YES;
//            self.TKView.height = IPHONEHIGHT(10);
//            self.YSView.status = DetailsVieWStatus_1;
//            self.YSView.height = goodsArr.count*55+230;
            
        }
    }else{
        self.TKButton.userInteractionEnabled = NO;//交互关闭
        self.TKButton.alpha=0.5;//透明度
        
//        self.TKView.hidden = YES;
//        self.TKView.height = IPHONEHIGHT(10);
//        self.YSView.status = DetailsVieWStatus_1;
//        self.YSView.height = goodsArr.count*55+230;
        
    }
    
    /*本版本不是上退款、先隐藏*/
//    self.TKButton.height = 0.01;
//    self.TKButton.hidden = YES;

    self.PLView.height = goodsArr.count*50+(d)*110 +(f)*35 +220;
#pragma mark - 判断
    //0全部、1待付款、2待使用、3待评价、4已评价、5已取消、6待退单、7退单完成、8退单失败、9待退款、10退款完成、11退款失败） 传入2，获取2,3的订单信息； 传入6，获取6,7,8的订单信息 传入9
    if (self.status == 4) {

        self.TKView.hidden = YES;
        self.TKView.height = IPHONEHIGHT(10);
        self.YSView.status = DetailsVieWStatus_1;
        self.YSView.height = goodsArr.count*55+230;
        
        self.YSView.top = self.TKView.bottom -10;
        self.TKButton.top = self.YSView.bottom +20;
        self.QTView.top = self.TKButton.bottom +20;
        self.PLView.top = self.QTView.bottom +20;
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.YSView.height+self.QTView.height+self.PLView.height+340);
        
    }else if (self.status == 2){
        self.TKView.hidden = YES;
        self.TKView.height = IPHONEHIGHT(10);
        self.YSView.status = DetailsVieWStatus_1;
        self.YSView.height = goodsArr.count*55+230;
        
        self.PLView.hidden = YES;
        self.YSView.top = self.TKView.bottom -10;
        self.TKButton.top = self.YSView.bottom +20;
        self.QTView.top = self.TKButton.bottom +20;
        self.PLView.top = self.QTView.bottom +20;
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.TKView.height+self.YSView.height+self.QTView.height+240);
        
    }else if (self.status == 8 || self.status == 6 || self.status == 7 ){
        self.TKView.hidden = YES;
        self.TKView.height = IPHONEHIGHT(10);
        self.YSView.status = DetailsVieWStatus_1;
        self.YSView.height = goodsArr.count*55+230;
        
        self.PLView.hidden = YES;
        self.YSView.top = self.TKView.bottom -10;
        self.TKButton.top = self.YSView.bottom +20;
        self.QTView.top = self.TKButton.bottom +20;
        self.PLView.top = self.QTView.bottom +20;
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.TKView.height+self.YSView.height+self.QTView.height+240);
        
    }else if (self.status == 9 || self.status == 10 || self.status == 11 ){
        self.TKView.hidden = NO;
        self.TKView.height = IPHONEHIGHT(122);
        self.YSView.status = DetailsVieWStatus_2;
        self.YSView.height = goodsArr.count*55+310;
        if (self.status == 10) {
            [self.TKView.Button2 setTitle:@"到账成功" forState:UIControlStateSelected];
            self.TKView.Button2.selected = YES;

        }else{
             [self.TKView.Button2 setTitle:@"到账失败" forState:UIControlStateSelected];
            self.TKView.Button2.selected = YES;

        }
        
        self.PLView.hidden = YES;
    
        self.YSView.top = self.TKView.bottom -10;
        self.TKButton.top = self.YSView.bottom +20;
        self.QTView.top = self.TKButton.bottom +20;
        self.PLView.top = self.QTView.bottom +20;
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.TKView.height+self.YSView.height+self.QTView.height+240);
        
        
    }else{
        self.TKView.hidden = YES;
        self.TKView.height = IPHONEHIGHT(10);
        self.YSView.status = DetailsVieWStatus_1;
        self.YSView.height = goodsArr.count*55+230;
        
        self.PLView.hidden = YES;
        self.YSView.top = self.TKView.bottom -10;
        self.TKButton.top = self.YSView.bottom +20;
        self.QTView.top = self.TKButton.bottom +20;
        self.PLView.top = self.QTView.bottom +20;
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.TKView.height+self.YSView.height+self.QTView.height+240);
        
    }
    
//    self.TKButton.userInteractionEnabled = YES;//交互关闭
//    self.TKButton.alpha=1;//透明度
    return;
    
#pragma mark - 商品信息
    
    
//    UIView *GoodsView = [[UIView alloc]initWithFrame:CGRectMake(15, self.backgrounImg.bottom-50, ScreenW-30, 220+goodsArr.count*45)];
//    GoodsView.backgroundColor = [UIColor whiteColor];
//    GoodsView.layer.cornerRadius =  5;
//    GoodsView.layer.shadowOpacity = 0.2;
//    GoodsView.layer.shadowOffset = CGSizeMake(0, 0.5);
//    [self.SJScrollView addSubview:GoodsView];
//    self.GoodsView = GoodsView;
//
//    UILabel *goodTitle = [[UILabel alloc]init];
//    goodTitle.text = @"订单信息";
//    goodTitle.font = [UIFont systemFontOfSize:18];
//    goodTitle.textColor = UIColorFromRGB(0x222222);
//    [GoodsView addSubview:goodTitle];
//    [goodTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(11);
//        make.top.mas_offset(5);
//        make.height.mas_offset(45);
//    }];
//    UIImageView *goodicon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 6, 10)];
//    goodicon.image = [UIImage imageNamed:@"input_arrow_right_blue"];
//    [GoodsView addSubview:goodicon];
//    [goodicon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-11);
//        make.centerY.equalTo(goodTitle.mas_centerY).offset(0);
//        make.size.mas_offset(CGSizeMake(6, 10));
//    }];
//
//    UIView *line1 = [[UIView alloc]init];
//    line1.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    [GoodsView addSubview:line1];
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.top.mas_offset(60);
//        make.height.mas_offset(1);
//    }];
//
//    /** 两个圆圈 **/
//    UIView *yuan1 = [[UIView alloc]init];
//    yuan1.backgroundColor = UIColorFromRGB(0x999999);
//    yuan1.layer.cornerRadius = 5;
//    //    [GoodsView addSubview:yuan1];
//    //    [yuan1 mas_makeConstraints:^(MASConstraintMaker *make) {
//    //        make.size.mas_offset(CGSizeMake(10, 10));
//    //        make.left.mas_offset(-5);
//    //        make.top.mas_offset(55);
//    //    }];
//    /***
//     商品
//     ***/
//
//    for (int i =0; i<goodsArr.count; i++) {
//
//        UILabel *goodsName = [[UILabel alloc]init];
//        goodsName.text = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
//        goodsName.textColor = UIColorFromRGB(0x222222);
//        goodsName.font = [UIFont systemFontOfSize:15];
//        [GoodsView addSubview:goodsName];
//        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(line1.mas_bottom).offset(12+35*i);
//            make.left.mas_offset(10);
//            make.size.mas_offset(CGSizeMake(GoodsView.width/2, 25));
//        }];
//
//
//        UILabel *goods_price = [[UILabel alloc]init];
//        goods_price.text = [NSString stringWithFormat:@"¥ %@",goodsArr[i][@"goods_price"]];
//        goods_price.textColor = UIColorFromRGB(0x222222);
//        goods_price.font = [UIFont systemFontOfSize:14];
//        [GoodsView addSubview:goods_price];
//        [goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(line1.mas_bottom).offset(12+35*i);
//            make.left.equalTo(goodsName.mas_right).offset(10);
//            make.size.mas_offset(CGSizeMake(GoodsView.width/4, 25));
//        }];
//
//        UILabel *goods_num = [[UILabel alloc]init];
//        goods_num.text = [NSString stringWithFormat:@"x%@",goodsArr[i][@"goods_num"]];
//        goods_num.textColor = UIColorFromRGB(0x999999);
//        goods_num.font = [UIFont systemFontOfSize:12];
//        goods_num.textAlignment = 2;
//        [GoodsView addSubview:goods_num];
//        [goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(line1.mas_bottom).offset(12+35*i);
//            make.right.mas_offset(-10);
//            make.size.mas_offset(CGSizeMake(GoodsView.width/4, 25));
//        }];
//    }
//
//
//
//
//    UIView *line2 = [[UIView alloc]init];
//    line2.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    [GoodsView addSubview:line2];
//    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.bottom.mas_offset(-150);
//        make.height.mas_offset(1);
//    }];
//
//    UILabel *fuwu = [[UILabel alloc]init];
//    fuwu.text= @"服务费用";
//    fuwu.textColor=UIColorFromRGB(0x999999);
//    fuwu.font = [UIFont systemFontOfSize:14];
//    [GoodsView addSubview:fuwu];
//    [fuwu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(line2.mas_bottom).offset(18);
//    }];
//
//    UILabel *fuwuText = [[UILabel alloc]init];
//    fuwuText.text= [NSString stringWithFormat:@"¥%@",self.DictData[@"service_money"]];
//    fuwuText.textColor=UIColorFromRGB(0x222222);
//    fuwuText.font = [UIFont systemFontOfSize:14];
//    [GoodsView addSubview:fuwuText];
//    [fuwuText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.top.equalTo(line2.mas_bottom).offset(18);
//    }];
//
//    UILabel *youhui = [[UILabel alloc]init];
//    youhui.text= @"翻呗优惠";
//    youhui.textColor=UIColorFromRGB(0x999999);
//    youhui.font = [UIFont systemFontOfSize:14];
//    [GoodsView addSubview:youhui];
//    [youhui mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(fuwu.mas_bottom).offset(18);
//    }];
//
//    self.save_money = [[UILabel alloc]init];
//    self.save_money.text= [NSString stringWithFormat:@"-¥%@",self.DictData[@"save_money"]];//@"-¥60";
//    self.save_money.textAlignment = NSTextAlignmentRight;
//    self.save_money.textColor=UIColorFromRGB(0x3D8AFF);
//    self.save_money.font = [UIFont systemFontOfSize:14];
//    [GoodsView addSubview:self.save_money];
//    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.top.equalTo(fuwu.mas_bottom).offset(18);
//    }];
//
//    UIView *line3 = [[UIView alloc]init];
//    line3.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    [GoodsView addSubview:line3];
//    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.top.equalTo(youhui.mas_bottom).offset(20);
//        make.height.mas_offset(1);
//    }];
//
//    UILabel *shifu = [[UILabel alloc]init];
//    shifu.text= @"实付";
//    shifu.textColor=UIColorFromRGB(0x999999);
//    shifu.font = [UIFont systemFontOfSize:14];
//    [GoodsView addSubview:shifu];
//    [shifu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.bottom.mas_offset(-26);
//    }];
//
//    self.actual_money = [[UILabel alloc]init];
//    self.actual_money.text= [NSString stringWithFormat:@"¥%@",self.DictData[@"actual_money"]];// @"¥325";
//    self.actual_money.textAlignment = NSTextAlignmentRight;
//    self.actual_money.textColor=UIColorFromRGB(0x222222);
//    self.actual_money.font = [UIFont systemFontOfSize:24];
//    [GoodsView addSubview:self.actual_money];
//    [self.actual_money mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.bottom.mas_offset(-22);
//    }];
//
//
//
//
//
//    /**
//     其他信息
//     */
//    UIView *OtherView = [[UIView alloc]initWithFrame:CGRectMake(15, self.GoodsView.bottom+20, ScreenW-30, 334)];
//    OtherView.backgroundColor = [UIColor whiteColor];
//    OtherView.layer.cornerRadius =  5;
//    OtherView.layer.shadowOpacity = 0.2;
//    OtherView.layer.shadowOffset = CGSizeMake(0, 0.5);
//    [self.SJScrollView addSubview:OtherView];
//    self.OtherView = OtherView;
//
//    UILabel *OtherTitle = [[UILabel alloc]init];
//    OtherTitle.text = @"其他信息";
//    OtherTitle.font = [UIFont systemFontOfSize:18];
//    OtherTitle.textColor = UIColorFromRGB(0x222222);
//    [OtherView addSubview:OtherTitle];
//    [OtherTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(11);
//        make.top.mas_offset(5);
//        make.height.mas_offset(45);
//    }];
//
//    UIView *line4 = [[UIView alloc]init];
//    line4.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    [OtherView addSubview:line4];
//    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.top.mas_offset(60);
//        make.height.mas_offset(1);
//    }];
//    UILabel *OtherTitle1 = [[UILabel alloc]init];
//    OtherTitle1.text = @"消费地址";
//    OtherTitle1.font = [UIFont systemFontOfSize:14];
//    OtherTitle1.textColor = UIColorFromRGB(0x999999);
//    [OtherView addSubview:OtherTitle1];
//    [OtherTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(line4.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//        make.width.mas_offset(80);
//    }];
//
//    UILabel *OtherLabel1 = [[UILabel alloc]init];
//    OtherLabel1.text = [NSString stringWithFormat:@"%@",self.DictData[@"store_address"]];//@"思明区中华城南区5楼";
//    OtherLabel1.font = [UIFont systemFontOfSize:14];
//    OtherLabel1.textColor = UIColorFromRGB(0x222222);
//    OtherLabel1.textAlignment = 0;
//    [OtherView addSubview:OtherLabel1];
//    [OtherLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(OtherTitle1.mas_right).offset(5);
//        make.right.mas_offset(-10);
//        make.top.equalTo(line4.mas_bottom).offset(20);
//        make.height.mas_offset(15);
//    }];
//
//    UILabel *OtherTitle2 = [[UILabel alloc]init];
//    OtherTitle2.text = @"用户信息";
//    OtherTitle2.font = [UIFont systemFontOfSize:14];
//    OtherTitle2.textColor = UIColorFromRGB(0x999999);
//    [OtherView addSubview:OtherTitle2];
//    [OtherTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(OtherTitle1.mas_bottom).offset(15);
//        make.height.mas_offset(13);
//    }];
//
//    UILabel *OtherLabel2 = [[UILabel alloc]init];
//    NSString *phon = [NSString stringWithFormat:@"%@",self.DictData[@"user_info"][@"mobile"]];
//    NSString *string =[phon stringByReplacingOccurrencesOfString:[phon substringWithRange:NSMakeRange(3,4)]withString:@"****"];
//
//    OtherLabel2.text = [NSString stringWithFormat:@"%@(%@)%@",self.DictData[@"user_info"][@"user_name"],self.DictData[@"user_info"][@"sex"],string];//@"黄几言（先生）";
//    OtherLabel2.font = [UIFont systemFontOfSize:14];
//    OtherLabel2.textColor = UIColorFromRGB(0x222222);
//    [OtherView addSubview:OtherLabel2];
//    [OtherLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(OtherTitle2.mas_right).offset(26);
//        make.right.mas_offset(-10);
//        make.top.equalTo(OtherTitle1.mas_bottom).offset(15);
//        make.height.mas_offset(13);
//    }];
//
//#pragma mark - 联系按钮
//
//    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
////        [phoneButton setTitle:@" 联系" forState:UIControlStateNormal];
//    [phoneButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
//    //    [phoneButton setImage:[UIImage imageNamed:@"icn_contact_customer_blue"] forState:UIControlStateNormal];
////        [phoneButton addTarget:self action:@selector(printe) forControlEvents:UIControlEventTouchUpInside];
//    phoneButton.layer.cornerRadius = 5;
//    //    phoneButton.layer.borderWidth = 1;
//    phoneButton.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
//
//    [OtherView addSubview:phoneButton];
//    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(OtherTitle2.mas_right).offset(26);
//        make.top.equalTo(OtherLabel2.mas_bottom).offset(15);
//        make.size.mas_offset(CGSizeMake(80, 32));
//    }];
//
//    UILabel *OtherTitle_bei = [[UILabel alloc]init];
//    OtherTitle_bei.text = @"订单备注";
//    OtherTitle_bei.font = [UIFont systemFontOfSize:14];
//    OtherTitle_bei.textColor = UIColorFromRGB(0x999999);
//    [OtherView addSubview:OtherTitle_bei];
//    [OtherTitle_bei mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(phoneButton.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//        //        make.width.mas_offset(100);
//    }];
//    UILabel *OtherLabel_bei = [[UILabel alloc]init];
//    OtherLabel_bei.text = [NSString stringWithFormat:@"%@",self.DictData[@"remark"]];//self.DictData[@"remark"];//@"345678904";
//    OtherLabel_bei.font = [UIFont systemFontOfSize:14];
//    OtherLabel_bei.textColor = UIColorFromRGB(0x222222);
//    OtherLabel_bei.numberOfLines = 2;
//    [OtherView addSubview:OtherLabel_bei];
//    [OtherLabel_bei mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(OtherLabel1.mas_left).offset(0);
//        make.right.mas_offset(-10);
//        make.top.equalTo(phoneButton.mas_bottom).offset(20);
//        //        make.height.mas_offset(13);
//    }];
//
//    UIView *line5 = [[UIView alloc]init];
//    line5.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    [OtherView addSubview:line5];
//    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.top.equalTo(OtherLabel_bei.mas_bottom).offset(15);
//        make.height.mas_offset(1);
//    }];
//    UILabel *OtherTitle3 = [[UILabel alloc]init];
//    OtherTitle3.text = @"订单编号";
//    OtherTitle3.font = [UIFont systemFontOfSize:14];
//    OtherTitle3.textColor = UIColorFromRGB(0x999999);
//    [OtherView addSubview:OtherTitle3];
//    [OtherTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(line5.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//    }];
//
//    UILabel *OtherLabel3 = [[UILabel alloc]init];
//    OtherLabel3.text = self.DictData[@"order_sn"];//@"345678904";
//    OtherLabel3.font = [UIFont systemFontOfSize:14];
//    OtherLabel3.textColor = UIColorFromRGB(0x222222);
//    [OtherView addSubview:OtherLabel3];
//    [OtherLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(OtherTitle3.mas_right).offset(26);
//        make.right.mas_offset(-10);
//        make.top.equalTo(line5.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//    }];
//
//    UILabel *OtherTitle4 = [[UILabel alloc]init];
//    OtherTitle4.text = @"订单时间";
//    OtherTitle4.font = [UIFont systemFontOfSize:14];
//    OtherTitle4.textColor = UIColorFromRGB(0x999999);
//    [OtherView addSubview:OtherTitle4];
//    [OtherTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(OtherTitle3.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//    }];
//    UILabel *OtherLabel4 = [[UILabel alloc]init];
//    OtherLabel4.text = self.DictData[@"add_time"];//@"345678904";
//    OtherLabel4.font = [UIFont systemFontOfSize:14];
//    OtherLabel4.textColor = UIColorFromRGB(0x222222);
//    [OtherView addSubview:OtherLabel4];
//    [OtherLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(OtherTitle4.mas_right).offset(26);
//        make.right.mas_offset(-10);
//        make.top.equalTo(OtherTitle3.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//    }];
//
//
//    UILabel *OtherTitle5 = [[UILabel alloc]init];
//    OtherTitle5.text = @"支付时间";
//    OtherTitle5.font = [UIFont systemFontOfSize:14];
//    OtherTitle5.textColor = UIColorFromRGB(0x999999);
//    [OtherView addSubview:OtherTitle5];
//    [OtherTitle5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(OtherTitle4.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//    }];
//    UILabel *OtherLabel5 = [[UILabel alloc]init];
//    OtherLabel5.text = self.DictData[@"paid_time"];//@"2018-12-12 ";
//    OtherLabel5.font = [UIFont systemFontOfSize:14];
//    OtherLabel5.textColor = UIColorFromRGB(0x222222);
//    [OtherView addSubview:OtherLabel5];
//    [OtherLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(OtherTitle5.mas_right).offset(26);
//        make.right.mas_offset(-10);
//        make.top.equalTo(OtherTitle4.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//    }];
//
//    UILabel *OtherTitle6 = [[UILabel alloc]init];
//    OtherTitle6.text = @"支付方式";
//    OtherTitle6.font = [UIFont systemFontOfSize:14];
//    OtherTitle6.textColor = UIColorFromRGB(0x999999);
//    [OtherView addSubview:OtherTitle6];
//    [OtherTitle6 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(OtherTitle5.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//    }];
//
//
//
//
//
//
//    UILabel *OtherLabel6 = [[UILabel alloc]init];
//    NSString *pid = [NSString stringWithFormat:@"%@",self.DictData[@"paid_type"]];
//    if ([pid isEqualToString:@"4"]) {
//        OtherLabel6.text = @"余额支付";
//
//    }else if ([pid isEqualToString:@"1"]){
//        OtherLabel6.text = @"支付宝支付";
//
//    }else if ([pid isEqualToString:@"2"]){
//        OtherLabel6.text = @"微信支付";
//
//    }else{
//        OtherLabel6.text = @"银行卡快捷支付";
//
//    }
//    OtherLabel6.font = [UIFont systemFontOfSize:14];
//    OtherLabel6.textColor = UIColorFromRGB(0x222222);
//    [OtherView addSubview:OtherLabel6];
//    [OtherLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(OtherTitle6.mas_right).offset(26);
//        make.right.mas_offset(-10);
//        make.top.equalTo(OtherTitle5.mas_bottom).offset(20);
//        make.height.mas_offset(13);
//    }];
//
//
//    OtherView.height  = 334+50;
//#pragma mark - 评价信息
//
//
//
//    UIView *ScoreView = [[UIView alloc]initWithFrame:CGRectMake(15, self.OtherView.bottom+20, ScreenW-30, goodMun*50+(d)*110 +(f)*35 +290 )];
//    ScoreView.backgroundColor = [UIColor whiteColor];
//    ScoreView.layer.cornerRadius =  5;
//    ScoreView.layer.shadowOpacity = 0.2;
//    ScoreView.layer.shadowOffset = CGSizeMake(0, 0.5);
//    [self.SJScrollView addSubview:ScoreView];
//    self.ScoreView = ScoreView;
//
//    UILabel *ScoreTitle = [[UILabel alloc]init];
//    ScoreTitle.text = @"本次订单已评价";
//    ScoreTitle.font = [UIFont systemFontOfSize:18];
//    ScoreTitle.textColor = UIColorFromRGB(0x222222);
//    [ScoreView addSubview:ScoreTitle];
//    [ScoreTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(11);
//        make.top.mas_offset(5);
//        make.height.mas_offset(45);
//    }];
//
//    /*评分 evaluate_score*/
//    NSString *score = [NSString stringWithFormat:@"%@",evaluate_info[@"evaluate_score"]];
//    //星星
//    StarEvaluator *starEvaluator = [[StarEvaluator alloc] initWithFrame:CGRectMake(25, 76, 120, 30)];
//    starEvaluator.delegate= self;
//    [ScoreView addSubview:starEvaluator];
//    //    self.starEvaluator = starEvaluator;
//    [starEvaluator mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(ScoreTitle.mas_bottom).offset(10);
//        make.size.mas_offset(CGSizeMake(120, 25));
//    }];
//    starEvaluator.userInteractionEnabled = NO;
//    starEvaluator.currentValue = [score integerValue];
//
//    UILabel *star = [[UILabel alloc]init];
//    if ([[MethodCommon judgeStringIsNull:score] isEqualToString:@""]) {
//        star.text = @"0分";
//    }else{
//        star.text = [NSString stringWithFormat:@"%@分",score];
//    }
//    star.textColor = UIColorFromRGB(0x3D8AFF);
//    star.font = [UIFont systemFontOfSize:15];
//    [ScoreView addSubview:star];
//    [star mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.top.equalTo(ScoreTitle.mas_bottom).offset(10);
//
//    }];
//
//    /** 评论文本 */
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 111, ScoreView.width-20, 100)];
//    view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
//    view.layer.cornerRadius = 5;
//    [ScoreView addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(starEvaluator.mas_bottom).offset(10);
//        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.height.mas_offset(100);
//    }];
//
//    UILabel *label = [[UILabel alloc] init];
//    //evaluate_content
//    NSString *evaluate_content = [NSString stringWithFormat:@"%@",evaluate_info[@"evaluate_content"]];
//
//    if ([[MethodCommon judgeStringIsNull:evaluate_content] isEqualToString:@""]) {
//
//    }else{
//        NSString *str = [NSString stringWithFormat:@"%@",evaluate_info[@"evaluate_content"]];
//
////        //编码
////        NSString *uniStr = [NSString stringWithUTF8String:[str UTF8String]];
////        NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
////        NSString *goodStr = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding] ;
////        NSLog(@"---编码--->[%@]",goodStr);
////
////        //解码
////        const char *jsonString = [goodStr UTF8String];   // goodStr 服务器返回的 json
////        NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
////        NSString *goodMsg1 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
////        NSLog(@"---解码--->[%@]",goodMsg1);
//
//
////        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
////
////        label.attributedText = attributedString;
//
//        label.text = str;
//        //@"环小清新，看着服干净，位置也容易找，中华城南区五楼电梯。他们家味还算比较道，如果喜欢口味重或者偏爱辣不建议了。";
//
//    }
//    label.numberOfLines = 0;
//    [view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.mas_offset(0);
//    }];
//
//
//
//
//
//
//
//
//
//
//    /** 标签 */
//    UIView *evaluateView = [[UIView alloc]initWithFrame:CGRectMake(0, view.bottom, ScoreView.width, tagMun*30)];
//    [ScoreView addSubview:evaluateView];
//    [evaluateView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.mas_bottom).offset(0);
//        make.right.left.mas_offset(0);
//        make.height.mas_offset(tagMun*30);
//    }];
//
//    for (int i =0; i<tagMun; i++) {
//        NSInteger  y = i/3 ;
//        NSInteger  x = i%3;
//        UILabel *evaluate_tags = [[UILabel alloc]init];
//
//        NSString *tabstring = [NSString stringWithFormat:@"%@",tagsarray[i]];
//
//        if ([[MethodCommon judgeStringIsNull:tabstring] isEqualToString:@""]) {
//
//        }else{
//            tabstring = [NSString stringWithFormat:@"#%@",tagsarray[i]];
//            evaluate_tags.text = [NSString stringWithFormat:@"%@",tabstring];
//        }
//        evaluate_tags.textColor = UIColorFromRGB(0xF7AE2B);
//        evaluate_tags.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
//        evaluate_tags.font = [UIFont systemFontOfSize:autoScaleW(14)];
//        evaluate_tags.layer.borderWidth = 1;
//        evaluate_tags.layer.cornerRadius = 14;
//        evaluate_tags.textAlignment = 1;
//        //        [ScoreView addSubview:evaluate_tags];
//        //        [evaluate_tags mas_makeConstraints:^(MASConstraintMaker *make) {
//        //            make.top.equalTo(huifu.mas_top).offset(autoScaleW(30)*y-(d*autoScaleW(100)) -(f*35)-(goodMun*42));
//        //            make.left.mas_offset(autoScaleW(105)*x+10);
//        //            make.size.mas_offset(CGSizeMake(autoScaleW(100), 28));
//        //        }];
//
//
//        static UIButton *recordBtn =nil;
//
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//        CGRect rect = [tabstring boundingRectWithSize:CGSizeMake(evaluateView.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
//
//        CGFloat BtnW = rect.size.width + 20;
//        CGFloat BtnH = rect.size.height + 10;
//        btn.layer.masksToBounds = YES;
//        btn.layer.cornerRadius = BtnH/2;
//        btn.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
//        btn.layer.borderWidth = 1;
//
//        if (i == 0){
//            btn.frame = CGRectMake(10, 10, BtnW, BtnH);
//        }else{
//
//            CGFloat yuWidth = ScoreView.width - 20 -recordBtn.frame.origin.x -recordBtn.frame.size.width;
//
//            if (yuWidth >= rect.size.width) {
//
//                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 10, recordBtn.frame.origin.y, BtnW, BtnH);
//            }else{
//
//                btn.frame =CGRectMake(10, recordBtn.frame.origin.y+recordBtn.frame.size.height+10, BtnW, BtnH);
//            }
//
//        }
//        [btn setTitle:tabstring forState:UIControlStateNormal];
//        [evaluateView addSubview:btn];
//        recordBtn = btn;
//
//        [evaluateView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_offset(CGRectGetMaxY(btn.frame)+10);
//        }];
//    }
//
//    UIView *picView = [[UIView alloc]initWithFrame:CGRectMake(0, view.bottom, ScoreView.width, autoScaleW(110)*d)];
//    picView.backgroundColor = [UIColor whiteColor];
//    [ScoreView addSubview:picView];
//    [picView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(evaluateView.mas_bottom).offset(0);
//        make.right.left.mas_offset(0);
//        make.height.mas_offset(autoScaleW(110)*d);
//    }];
//    /** 评论图片 **/
//    for (int i=0 ; i<imageMun; i++) {
//        NSInteger  y = i/3 ;
//        NSInteger  x = i%3;
//        UIImageView *iamge = [[UIImageView alloc]init];
//        NSString *url = [NSString stringWithFormat:@"%@",array[i]];
//        [iamge sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
//        iamge.backgroundColor = [UIColor redColor];
//        iamge.layer.cornerRadius = 5;
//        [picView addSubview:iamge];
//        [iamge mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_offset(10);
//            make.left.mas_offset(x*autoScaleW(110)+10);
//            make.size.mas_offset(CGSizeMake(autoScaleW(103), autoScaleW(103)));
//        }];
//        //        [picView mas_updateConstraints:^(MASConstraintMaker *make) {
//        //            make.height.mas_offset(iamge.height+10);
//        //        }];
//    }
//    /** 回复按钮 */
//    UIButton *huifu = [UIButton buttonWithType:UIButtonTypeCustom];
//    [huifu setTitle:@" 回复用户" forState:UIControlStateNormal];
//    [huifu setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
//    [huifu.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [huifu setImage:[UIImage imageNamed:@"icn_reply_customer_blue"] forState:UIControlStateNormal];
//    huifu.layer.cornerRadius = 6;
//    huifu.layer.borderWidth = 1;
//    huifu.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
//    [huifu addTarget:self action:@selector(huifuAction) forControlEvents:UIControlEventTouchUpInside];
//    [ScoreView addSubview:huifu];
//    [huifu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_offset(-30);
//        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.height.mas_offset(40);
//    }];
//
//    /** 评价的商品 */
//    for (int i = 0; i<goodMun; i++) {
//
//        UILabel *goodsName = [[UILabel alloc]init];
//        goodsName.text = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
//        goodsName.textColor = UIColorFromRGB(0x222222);
//        [ScoreView addSubview:goodsName];
//        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(picView.mas_bottom).offset(40*i+10);
//            make.left.mas_offset(10);
//            make.size.mas_offset(CGSizeMake(GoodsView.width/2, 25));
//        }];
//
//
//        UIButton *zan = [UIButton buttonWithType:UIButtonTypeCustom];
//        [zan setImage:[UIImage imageNamed:@"icn_product_like_normal"] forState:UIControlStateNormal];
//        [zan setImage:[UIImage imageNamed:@"icn_product_like_active"] forState:UIControlStateSelected];
//        [ScoreView addSubview:zan];
//        [zan mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(picView.mas_bottom).offset(40*i+10);
//            make.right.mas_offset(-52);
//            make.size.mas_offset(CGSizeMake(32, 32));
//        }];
//
//
//        UIButton *cai = [UIButton buttonWithType:UIButtonTypeCustom];
//        [cai setImage:[UIImage imageNamed:@"icn_product_dislike_normal"] forState:UIControlStateNormal];
//        [cai setImage:[UIImage imageNamed:@"icn_product_dislike_active"] forState:UIControlStateSelected];
//        [ScoreView addSubview:cai];
//        [cai mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(picView.mas_bottom).offset(40*i+10);
//            make.right.mas_offset(-10);
//            make.size.mas_offset(CGSizeMake(32, 32));
//        }];
//        NSString *evaluate = [NSString stringWithFormat:@"%@",goodsArr[i][@"evaluate"]];
//        // 1为赞 0为踩（现都为赞）
//        if ( [evaluate isEqualToString: @"1"]) {
//            zan.selected = YES;
//            cai.selected = NO;
//        }else{
//            zan.selected = NO;
//            cai.selected = YES;
//        }
//
//
//    }
//
//
//#pragma mark - 判断
//    if ([self.navigationTitle isEqualToString:@"订单已评价"]) {
//
//        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, GoodsView.height+ScoreView.height+OtherView.height+250);
//
//    }else if ([self.navigationTitle isEqualToString:@"订单已支付"]){
//        ScoreView.hidden = YES;
//        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, GoodsView.height+OtherView.height+200);
//
//    }else{
//        ScoreView.hidden = YES;
//        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, GoodsView.height+OtherView.height+200);
//
//    }
}
/** 拨打电话 */
-(void)PhoneAction{

    NSString *telephoneNumber = self.DictData[@"user_info"][@"mobile"];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:str];
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
            NSLog(@"OpenSuccess=%d",success);
            
        }];
    } else {
        // Fallback on earlier versions
    }
}
/** 回复评论 **/
-(void)huifuAction{
    
    FBHevaluateViewController *VC = [FBHevaluateViewController new];
    VC.order_id = self.order_id;
    [self.navigationController pushViewController:VC animated:NO];
}
- (void)Huifu_order{
    FBHevaluateViewController *VC = [FBHevaluateViewController new];
    VC.order_id = self.order_id;
    [self.navigationController pushViewController:VC animated:NO];
    
}
#pragma mark - 打印
- (void)printe{
    
    if (self.manage.stage != JWScanStageCharacteristics) {
//        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        ReceiptsController *VC = [ReceiptsController new];
        VC.ReceiptsData = self.DictData;
        [self.navigationController pushViewController:VC animated:NO];
        return;
    }
    
    [self JWPrinter_Printer:self.DictData];
    

}
#pragma mark - 提交退款
-(void)AmountAction{
    _AmountView.AmountTF.text = @"¥";
    [self.view.window addSubview:self.AmountView];
//     [[UIApplication sharedApplication].keyWindow addSubview:self.AmountView];
}
#pragma mark - 确认退款
-(void)AmountConfirm{
    NSString *number = [self.AmountView.AmountTF.text stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    if (number==nil || number.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入退款金额"];
        return;
    }
    if ([number doubleValue]<=0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入大于0的金额"];
        return;
    }
    if ([number doubleValue]>actual_money) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入小于订单金额"];
        return;
    }
    [self.AmountView removeFromSuperview];
    [self setJHCover];

}
#pragma mark - 弹出密码验证
-(void)setJHCover{
    JHCoverView *coverView = [[JHCoverView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    coverView.delegate = self;
    /** 提示 **/
    coverView.tisi.text =@"";
   
    coverView.tisitext.text = @"";
    
    self.coverView = coverView;
    [self.coverView.payTextField becomeFirstResponder];
    
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view.window addSubview:coverView];
}
/**
 忘记密码
 */
- (void)forgetPassWordCoverView:(JHCoverView *)control
{
    //    JHForgetPWViewController *forgetControl = [[JHForgetPWViewController alloc] init];
    [self.navigationController pushViewController:[PaymentViewController new] animated:YES];
}
/**
 JHCoverViewDelegate的代理方法,密码输入错误
 */
- (void)coverView:(JHCoverView *)control error:(NSString *)errorString
{
    UIAlertController *altertConl = [UIAlertController alertControllerWithTitle:@"" message:errorString  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *againInputAction = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //通知重新输入密码的时候，以前输入的密码清空
        [[NSNotificationCenter defaultCenter] postNotificationName:@"againInputPassWord" object:nil];
        [self setJHCover];
        
    }];
    UIAlertAction *forgetPWAction = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //        JHForgetPWViewController *forgetControl = [[JHForgetPWViewController alloc] init];
        //跳转忘记密码界面的时候，通知 输入密码关闭
        [[NSNotificationCenter defaultCenter] postNotificationName:@"forgetInputPassWord" object:nil];
        
        [self.navigationController pushViewController:[PaymentViewController new] animated:YES];
        
    }];
    [altertConl addAction:againInputAction];
    [altertConl addAction:forgetPWAction];
    [self presentViewController:altertConl animated:YES completion:nil];
    
}
/**
 JHCoverViewDelegate的代理方法，密码输入正确
 */
- (void)inputCorrectCoverView:(JHCoverView *)control andPass:(NSString *)pass{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *Model = [UserModel getUseData];
    
    NSString *number = [self.AmountView.AmountTF.text stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    NSString *fee = [NSString stringWithFormat:@"%@",number];//退款金额
    NSString *reply = [NSString stringWithFormat:@"%@",self.AmountView.BeiZhu.text];//商家备注
    NSString *payment_pwd = [MD5Sign MD5:pass];

    NSDictionary *Dict = @{
                           @"order_id":self.order_id,
                           @"refund_fee":fee,
                           @"pay_password":payment_pwd,
                           @"merchant_reply":reply,
                           };
    
    [[FBHAppViewModel shareViewModel]merchant_refund:Model.merchant_id andstore_id:Model.store_id andjoinDict:Dict  Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
//            NSDictionary *DIC=resDic[@"data"];
            [self merchant_center];
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
#pragma mark - ScrollViewDelegate
// 滑动时要执行的代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    UIColor *color = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = MIN(1, (_halfHeight + 64 + offsetY)/_halfHeight);
    if (offsetY >= - _halfHeight - 64) {
        //        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        //替换这种方式
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        self.NavView.backgroundColor = UIColorFromRGBA(0xffffff, offsetY);
        self.NavLabl.alpha = offsetY;

    } else {
        //        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
        //替换这种方式
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        self.NavView.backgroundColor = UIColorFromRGBA(0xffffff, 1);

        self.NavLabl.alpha = 1;
    }
    
    
    if (offsetY >=15) {
        [self.DayinButton setImage:[UIImage imageNamed:@"icn_printer_black"] forState:UIControlStateNormal];

    }else{
        [self.DayinButton setImage:[UIImage imageNamed:@"icn_printer_white"] forState:UIControlStateNormal];

    }
}
#pragma mark - Get
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1790);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}


-(UIImageView *)backgrounImg{
    if (!_backgrounImg) {
        _backgrounImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, -44, ScreenW, 260)];
        _backgrounImg.image = [UIImage imageNamed:@"bg_index_top_scene-1"];
        
        _backgrounImg.layer.shadowColor = UIColorFromRGB(0x47D2FF).CGColor;
    }
    return _backgrounImg;
}
-(DetailsTKView *)TKView{
    if (!_TKView) {
        _TKView = [[DetailsTKView alloc]initWithFrame:CGRectMake(30, 104+STATUS_BAR_HEIGHT, ScreenW-60, 120)];
        _TKView.backgroundColor = [UIColor whiteColor];
        _TKView.layer.shadowOffset = CGSizeMake(0,2);
        _TKView.layer.shadowOpacity = 1;
        _TKView.layer.shadowRadius = 8;
        _TKView.layer.cornerRadius = 5;
        _TKView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        //        _TKView.delagate = self;
    }
    return _TKView;
}
-(DetailsYSView *)YSView{
    if (!_YSView) {
        _YSView = [[DetailsYSView alloc]initWithFrame:CGRectMake(15,self.TKView.bottom-IPHONEHIGHT(10), ScreenW-30, 400)];
        _YSView.backgroundColor = [UIColor whiteColor];
        _YSView.layer.shadowOffset = CGSizeMake(0,2);
        _YSView.layer.shadowOpacity = 1;
        _YSView.layer.shadowRadius = 8;
        _YSView.layer.cornerRadius = 5;
        _YSView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    }
    return _YSView;
}
-(DetailsJDView *)JDView{
    if (!_JDView) {
        _JDView = [[DetailsJDView alloc]initWithFrame:CGRectMake(15,self.TKView.bottom-10, ScreenW-30, 657)];
        _JDView.backgroundColor = [UIColor whiteColor];
        _JDView.layer.shadowOffset = CGSizeMake(0,2);
        _JDView.layer.shadowOpacity = 1;
        _JDView.layer.shadowRadius = 8;
        _JDView.layer.cornerRadius = 5;
        _JDView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    }
    return _JDView;
}
-(DetailsQTView *)QTView{
    if (!_QTView) {
        _QTView = [[DetailsQTView alloc]initWithFrame:CGRectMake(15, self.TKButton.bottom+20, ScreenW-30, 430)];
        _QTView.backgroundColor = [UIColor whiteColor];
        _QTView.layer.shadowOffset = CGSizeMake(0,2);
        _QTView.layer.shadowOpacity = 1;
        _QTView.layer.shadowRadius = 8;
        _QTView.layer.cornerRadius = 5;
        _QTView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor;
    }
    return _QTView;
}
-(DetailsPLView *)PLView{
    if (!_PLView) {
        _PLView = [[DetailsPLView alloc]initWithFrame:CGRectMake(15, self.QTView.bottom+20, ScreenW-30, 439)];
        _PLView.backgroundColor = [UIColor whiteColor];
        _PLView.layer.shadowOffset = CGSizeMake(0,2);
        _PLView.layer.shadowOpacity = 1;
        _PLView.layer.shadowRadius = 8;
        _PLView.layer.cornerRadius = 5;
        _PLView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _PLView.delagate = self;
    }
    return _PLView;
}
-(UIButton *)TKButton{
    if (!_TKButton) {
        _TKButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _TKButton.frame = CGRectMake(15, self.YSView.bottom+0, ScreenW-30, 44);
        _TKButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
        _TKButton.layer.cornerRadius = 10;
        [_TKButton setTitle:@"提交退款" forState:UIControlStateNormal];
        [_TKButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _TKButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_TKButton addTarget:self action:@selector(AmountAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TKButton;
}
-(DetailsAmountView *)AmountView{
    if (!_AmountView) {
        _AmountView = [[DetailsAmountView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _AmountView.delagate = self;
    }
    return _AmountView;
}
@end
