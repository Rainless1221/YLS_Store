//
//  StoreStatusViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "StoreStatusViewController.h"
#import "StoreStatus_View.h"
#import "Store_Menu_View.h"

@interface StoreStatusViewController ()<UIScrollViewDelegate,editorActionDelegate>
{
    NSInteger _TypeView;
}
@property (strong,nonatomic)UIScrollView * ScrollView;
@property (strong,nonatomic)StoreStatusView * StatusView;
@property (strong,nonatomic)StoreStatus_View * Store_View;
@property (strong,nonatomic)Store_Menu_View * Store_Menu_View;

/**
 导航栏
 */
@property (strong,nonatomic)UIView      * NavView;
@property (strong,nonatomic)UIImageView * NavImg;
@property (strong,nonatomic)UIImageView * NavigationImage;
@property (strong,nonatomic)UILabel     * navLabel;
@property (nonatomic) CGFloat halfHeight;

@property (strong,nonatomic)NSDictionary * StoreData;
@property (strong,nonatomic)NSMutableDictionary * StoreData1;
@property (strong,nonatomic)NSMutableDictionary * StoreData2;
@property (strong,nonatomic)NSMutableDictionary * StoreData3;
@end

@implementation StoreStatusViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self merchant_center];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.ScrollView];
//YBWeakSelf
//    /*商家基本信息*/
//    self.Store_View = [[StoreStatus_View alloc]initWithFrame:CGRectMake(15, 75, self.view.width - 30, 202)];
//    self.Store_View.backgroundColor = [UIColor whiteColor];
//    [self.ScrollView addSubview:self.Store_View];
//    self.Store_View.StoreNameBlock = ^{
//        StoreNameViewController *NameVC = [StoreNameViewController new];
//        NameVC.Data_dict = weakSelf.StoreData1;
//        [weakSelf.navigationController pushViewController:NameVC animated:NO];
//    };
//    /*菜单*/
//    self.Store_Menu_View = [[Store_Menu_View alloc]initWithFrame:CGRectMake(15, self.Store_View.bottom +20, self.view.width - 30, 100)];
//    self.Store_Menu_View.backgroundColor = [UIColor whiteColor];
//    self.Store_Menu_View.delagate = self;
//    _TypeView = self.Store_Menu_View.TypeView;
//    [self.ScrollView addSubview:self.Store_Menu_View];
//
//    self.Store_Menu_View.height = self.Store_Menu_View.SizeHeight;
//    self.ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH,  self.Store_Menu_View.SizeHeight);
//
//
//    self.Store_Menu_View.SizeHejightBlock = ^(CGFloat Height) {
//        weakSelf.Store_Menu_View.height = weakSelf.Store_Menu_View.SizeHeight;
//        weakSelf.ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH,  weakSelf.Store_Menu_View.SizeHeight+330);
//    };

    
    [self.ScrollView addSubview:self.NavigationImage];
    [self.ScrollView addSubview:self.StatusView];

    _halfHeight = (CGRectGetHeight([UIScreen mainScreen].bounds)) * 0.5 - 64;

    [self setupNavigationView];

    //conversion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"Store_Menu_View" object:nil];
}

- (void)conversionAction: (NSNotification *) notification {
    UIButton *but = (UIButton *)[self.Store_Menu_View viewWithTag:0+10];
//    but.tag = _TypeView+10;
    [self.Store_Menu_View ButtonAction:but];

}
#pragma mark --- navigationView ---
-(void)setupNavigationView{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    [self.view addSubview:NavView];
    self.NavView = NavView;
    //背景图片
    UIImageView *NavImg = [[UIImageView alloc]initWithFrame:NavView.frame];
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
    [NavView addSubview:NavImg];
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT, ScreenW-20, 44)];
    navLabel.text = @"商家信息";
    navLabel.font = NavTitleFont;
    navLabel.textColor = [UIColor whiteColor];
    navLabel.textAlignment = NSTextAlignmentCenter;
    [NavView addSubview:navLabel];
    //按钮
    UIButton *thirdBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn1.frame = CGRectMake(10, STATUS_BAR_HEIGHT, 44, 44);
    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    [thirdBtn1 addTarget:self action:@selector(LethAction) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:thirdBtn1];
    
    [self.view addSubview:NavView];
}
-(void)LethAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 去编辑
-(void)editorAction:(NSInteger)Typeinteger{
    
   YLSinStoreController *VC  = [YLSinStoreController new];
    VC.Data = self.StoreData;
    
    if (Typeinteger == 0) {
        VC.NavString = @"店铺信息";
        VC.Typeyint = 0;

        [self.navigationController pushViewController:VC animated:NO];


    }else if (Typeinteger == 1){
        VC.NavString = @"温馨提示";
        VC.Typeyint = 1;

        [self.navigationController pushViewController:VC animated:NO];

    }else if (Typeinteger == 2){
        VC.NavString = @"店铺图片";
        VC.Typeyint = 2;

        [self.navigationController pushViewController:VC animated:NO];

    }else if (Typeinteger == 3){
        VC.NavString = @"证件图片";
        VC.Typeyint = 3;

        [self.navigationController pushViewController:VC animated:NO];

    }else{

        [self.navigationController pushViewController:VC animated:NO];

    }
    
}
#pragma mark - Status请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel] get_store_application_pass_info:model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
            
            NSDictionary *DIC = resDic[@"data"][@"application_info"];
            insert_storeM *model = [insert_storeM mj_objectWithKeyValues:DIC];
            //保存
            [model saveUserData];
            
            self.StoreData = DIC;
          
            
            self.StatusView.StoreArray = DIC;

            self.Store_View.Data = DIC;
            self.Store_Menu_View.Data = DIC;

#pragma mark - 保存数据1
            [self.StoreData1 setObject:[NSString stringWithFormat:@"%@",DIC[@"store_logo"]] forKey:@"store_logo"];
            [self.StoreData1 setObject:[NSString stringWithFormat:@"  %@ ",DIC[@"category_name"]] forKey:@"category_name"];
            [self.StoreData1 setObject:[NSString stringWithFormat:@"%@",DIC[@"category_pic"]] forKey:@"category_pic"];
            [self.StoreData1 setObject:[NSString stringWithFormat:@"%@",DIC[@"category_id"]] forKey:@"category_id"];
            [self.StoreData1 setObject:self.StatusView.store_name.text forKey:@"store_name"];
            [self.StoreData1 setObject:self.StatusView.fans_number.text forKey:@"fans_num"];
            [self.StoreData1 setObject:self.StatusView.goods_number.text forKey:@"goods_num"];
            
            
            
            
            
            
            /** 温馨提示 **/
//            NSMutableArray *reminderArr = [NSMutableArray array];
//            NSString *reminderString = [NSString new];

            

            /** 门脸照片 */
            NSString *store_pic = [NSString stringWithFormat:@"%@",DIC[@"door_face_pic"]];
            // 用指定字符串分割字符串，返回一个数组
            NSArray *array = [store_pic componentsSeparatedByString:@","];
            
            for (int i = 0; i<array.count; i++) {

                NSString *picRrl = [NSString stringWithFormat:@"%@",array[i]];
                if ([PublicMethods isUrl:picRrl]) {

                }else{
                    picRrl = [NSString stringWithFormat:@"%@%@",FBHApi_Url,picRrl];
                }

                if (i<3) {
                    UIImageView *pics = [[UIImageView alloc]init];
                    pics.layer.cornerRadius = 10;
                    pics.layer.masksToBounds = YES;
                    [self.StatusView.View_Image addSubview:pics];
                    [pics mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_offset(75);
                        make.left.mas_offset(10+i*autoScaleW(110));
                        make.size.mas_offset(CGSizeMake(autoScaleW(103), autoScaleW(103)));
                    }];

                    [pics setImageWithURL:[NSURL URLWithString:picRrl] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
                }


            }
            
            
            
            
            
            /** 店里环境 */
            NSString *store_environment_pics = [NSString stringWithFormat:@"%@",DIC[@"store_environment_pics"]];
            // 用指定字符串分割字符串，返回一个数组
            NSArray *picsarray = [store_environment_pics componentsSeparatedByString:@","];
            
            /**
             还需要变化视图高度
             */
            
            for (int i = 0; i<picsarray.count; i++) {

                NSString *picRrl = [NSString stringWithFormat:@"%@",picsarray[i]];
                if ([PublicMethods isUrl:picRrl]) {

                }else{
                    picRrl = [NSString stringWithFormat:@"%@%@",FBHApi_Url,picRrl];
                }

                if (i<3) {
                    UIImageView *pics = [[UIImageView alloc]init];
                    pics.layer.cornerRadius = 10;
                    pics.layer.masksToBounds = YES;
                    [self.StatusView.View_Image addSubview:pics];
                    [pics mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_offset(274);
                        make.left.mas_offset(10+i*autoScaleW(110));
                        make.size.mas_offset(CGSizeMake(autoScaleW(103), autoScaleW(103)));
                    }];

                    [pics setImageWithURL:[NSURL URLWithString:picRrl] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
                }


            }
            
            
#pragma mark - 保存数据2
            [self.StoreData2 setObject:[NSString stringWithFormat:@"%@",DIC[@"store_address"]] forKey:@"store_address"];
            [self.StoreData2 setObject:self.StatusView.merchant_name.text forKey:@"merchant_name"];
            [self.StoreData2 setObject:self.StatusView.merchant_mobile.text forKey:@"merchant_mobile"];
            [self.StoreData2 setObject:self.StatusView.merchant_telephone.text forKey:@"merchant_telephone"];
            
            
            
            /** 身份证照片 */
            NSString *card_pic = [NSString stringWithFormat:@"%@",DIC[@"hand_held_ID_card_pic"]];
            // 用指定字符串分割字符串，返回一个数组
            NSArray *CardArray = [card_pic componentsSeparatedByString:@","];
     
            for (int i = 0; i<CardArray.count; i++) {

                NSString *picRrl = [NSString stringWithFormat:@"%@",CardArray[i]];
                if ([PublicMethods isUrl:picRrl]) {

                }else{
                    picRrl = [NSString stringWithFormat:@"%@%@",FBHApi_Url,picRrl];
                }

                if (i<3) {
                    UIImageView *pics = [[UIImageView alloc]init];
                    pics.layer.cornerRadius = 10;
                    pics.layer.masksToBounds = YES;
                    [self.StatusView.View_P addSubview:pics];
                    [pics mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_offset(126);
                        make.left.mas_offset(10+i*autoScaleW(110));
                        make.size.mas_offset(CGSizeMake(autoScaleW(103), autoScaleW(103)));
                    }];

                    [pics setImageWithURL:[NSURL URLWithString:picRrl] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
                }


            }

            
            
            /** 营业执照图片 */
            NSString *license_pic = [NSString stringWithFormat:@"%@",DIC[@"business_license_pic"]];

            
            NSArray *license_picArr = [license_pic componentsSeparatedByString:@","];
            
            
            for (int i = 0; i<license_picArr.count; i++) {

                NSString *picRrl = [NSString stringWithFormat:@"%@",license_picArr[i]];
                if ([PublicMethods isUrl:picRrl]) {

                }else{
                    picRrl = [NSString stringWithFormat:@"%@%@",FBHApi_Url,picRrl];
                }

                if (i<3) {
                    UIImageView *pics = [[UIImageView alloc]init];
                    pics.layer.cornerRadius = 10;
                    pics.layer.masksToBounds = YES;
                    [self.StatusView.View_P addSubview:pics];
                    [pics mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_offset(325);
                        make.left.mas_offset(10+i*autoScaleW(110));
                        make.size.mas_offset(CGSizeMake(autoScaleW(103), autoScaleW(103)));
                    }];

                    [pics setImageWithURL:[NSURL URLWithString:picRrl] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
                }


            }
            
            
            
            
            
            
            
            /** 经营许可证图片 */
            NSString *permit_pic = [NSString stringWithFormat:@"%@",DIC[@"business_permit_pic"]];

            
            
            NSArray *permit_picArr = [permit_pic componentsSeparatedByString:@","];
            
            
            for (int i = 0; i<permit_picArr.count; i++) {

                NSString *picRrl = [NSString stringWithFormat:@"%@",permit_picArr[i]];
                if ([PublicMethods isUrl:picRrl]) {

                }else{
                    picRrl = [NSString stringWithFormat:@"%@%@",FBHApi_Url,picRrl];
                }

                if (i<3) {
                    UIImageView *pics = [[UIImageView alloc]init];
                    pics.layer.cornerRadius = 10;
                    pics.layer.masksToBounds = YES;
                    [self.StatusView.View_P addSubview:pics];
                    [pics mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_offset(523);
                        make.left.mas_offset(10+i*autoScaleW(110));
                        make.size.mas_offset(CGSizeMake(autoScaleW(103), autoScaleW(103)));
                    }];

                    [pics setImageWithURL:[NSURL URLWithString:picRrl] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
                }


            }
            
            
            
#pragma mark - 保存数据3
            [self.StoreData3 setObject:DIC[@"hand_held_ID_card_pic"] forKey:@"hand_held_ID_card_pic"];
            [self.StoreData3 setObject:DIC[@"business_license_pic"] forKey:@"business_license_pic"];
            [self.StoreData3 setObject:DIC[@"business_permit_pic"] forKey:@"business_permit_pic"];
            
            
            
            self.ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, autoScaleW(self.StatusView.height));
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark --- 点击编辑 ---
-(void)toStore:(NSInteger)btnTag{
    
    StoreNameViewController *NameVC = [StoreNameViewController new];
    NameVC.Data_dict = self.StoreData1;
    StoreInformationController *InformationVC = [StoreInformationController new];
    InformationVC.Data_dict = self.StoreData2;
    CertificateCardController *CardVC = [CertificateCardController new];
    CardVC.Data_dict = self.StoreData3;

//    StoreReminController *reminVC = [StoreReminController new];
//    ServiceFacilityController *EnvVC = [ServiceFacilityController new];

    switch (btnTag) {
        case 1:
            [self.navigationController pushViewController:NameVC animated:NO];

            break;
        case 2:
            [self.navigationController pushViewController:InformationVC animated:NO];
            
            break;
            
        case 3:
            [self.navigationController pushViewController:InformationVC animated:NO];
            
            break;
            
        case 4:
            [self.navigationController pushViewController:InformationVC animated:NO];
            
            break;
            
        case 5:
            [self.navigationController pushViewController:CardVC animated:NO];
            
            break;
        default:
            break;
    }

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
        self.NavView.backgroundColor = UIColorFromRGBA(0x3d8aff, offsetY);
        self.NavImg.alpha = offsetY;
    } else {
        //替换这种方式
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        self.NavView.backgroundColor = UIColorFromRGBA(0x3d8aff, 1);
        self.NavImg.alpha = 1;
    }
}
-(void)ViewheaderRereshing{
    [self merchant_center];
    [self.ScrollView.mj_header endRefreshing];
}
#pragma mark --- 懒加载 ---
-(UIScrollView *)ScrollView{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ScrollView.backgroundColor = MainbackgroundColor;
        _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, autoScaleW(2083));
        _ScrollView.delegate = self;
        _ScrollView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(ViewheaderRereshing)];
    }
    return _ScrollView;
}
-(UIImageView *)NavigationImage{
    if (!_NavigationImage) {
        _NavigationImage = [[UIImageView alloc]initWithFrame:CGRectMake(-100, -150, SCREEN_WIDTH+200, 280)];
        _NavigationImage.image = [UIImage imageNamed:@"bg_index_top_scene"];
        _NavigationImage.layer.cornerRadius = 280*0.5;
        _NavigationImage.layer.masksToBounds = YES;
        _NavigationImage.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _NavigationImage.layer.shadowOffset = CGSizeMake(0,5);
        _NavigationImage.layer.shadowOpacity = 1;
        _NavigationImage.layer.shadowRadius = 10;
    }
    return _NavigationImage;
}
-(StoreStatusView *)StatusView{
    if (!_StatusView) {
        _StatusView =[[StoreStatusView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, autoScaleW(2083))];
        _StatusView.backgroundColor = [UIColor clearColor];
        _StatusView.layer.cornerRadius = 5;
//        _StatusView.delagate = self;
        
        
        YBWeakSelf
        /** 去编辑 */
        _StatusView.TheEditorBlock = ^(NSInteger tag) {
            [weakSelf toStore:tag];
        };
        
    }
    return _StatusView;
}
- (NSDictionary *)StoreData{
    if (!_StoreData) {
        _StoreData = [NSDictionary dictionary];
    }
    return _StoreData;
}
- (NSMutableDictionary *)StoreData1{
    if (!_StoreData1) {
        _StoreData1 = [NSMutableDictionary dictionary];
    }
    return _StoreData1;
}
- (NSMutableDictionary *)StoreData2{
    if (!_StoreData2) {
        _StoreData2 = [NSMutableDictionary dictionary];
    }
    return _StoreData2;
}
- (NSMutableDictionary *)StoreData3{
    if (!_StoreData3) {
        _StoreData3= [NSMutableDictionary dictionary];
    }
    return _StoreData3;
}
@end
