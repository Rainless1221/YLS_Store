//
//  FBHOrderViewController.m
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHOrderViewController.h"

@interface FBHOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderCellDelegate,BrandNewDelegate,OrderDelegate,HotelOrderDelegate,OrderCellDelegate1,OrderCellDelegate2>
/** 列表 **/
@property (strong,nonatomic)UITableView * orderTableView;
/** 菜单栏 */
@property (strong,nonatomic)DDMenuView * MenuView;
/** 列表信息 */
@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)NSMutableArray * DataC;
@property (strong,nonatomic)NSMutableArray * DataS;
/** 分页 */
@property (assign,nonatomic)NSInteger page;
@property (assign,nonatomic)NSInteger ZSint;

@end

@implementation FBHOrderViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self refund_order_num];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

#pragma mark - 请求
-(void)merchant_center:(NSString *)status{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    
    NSDictionary *Dict = @{
                           @"order_status":[NSString stringWithFormat:@"%@",status],
                           @"begin_date":[NSString stringWithFormat:@"%@",self.begin_date],//[NSString stringWithFormat:@"%@",self.begin_date],
                           @"end_date":[NSString stringWithFormat:@"%@",self.end_date],//[NSString stringWithFormat:@"%@",self.end_date],
                           @"page":[NSString stringWithFormat:@"%ld",self.page],
                           @"limit":@"50",
                           };
    
    [[FBHAppViewModel shareViewModel]list_merchant_orders:model.merchant_id andstore_id:model.store_id andorders:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            
            NSDictionary *DIC = resDic[@"data"];
            if (self.page ==1) {
                [self.Data removeAllObjects];
                [self.DataC removeAllObjects];
                [self.DataS removeAllObjects];

            }
            
            if ([status integerValue] == 6) {
                for (NSDictionary *dict in DIC[@"order_info"]) {
                    NSString *order_status = [NSString stringWithFormat:@"%@",dict[@"order_status"]];
                    if ([order_status integerValue] == 6) {
                        [self.Data addObject:dict];
                    }else if([order_status integerValue] == 7){
                        [self.DataC addObject:dict];
                    }else{
                        [self.DataS addObject:dict];

                    }
                    
                }
                
                [self refund_order_num];
            }else{
                for (NSDictionary *dict in DIC[@"order_info"]) {
                    [self.Data addObject:dict];
                }
            }
            
            [self.orderTableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"OrderConversino" object:nil];

            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark - 退款数量单独请求
-(void)refund_order_num{
    UserModel *model = [UserModel getUseData];
    
    NSDictionary *Dict = @{
                           @"order_status":@"6",
                           @"begin_date":[NSString stringWithFormat:@"%@",self.begin_date],//[NSString stringWithFormat:@"%@",self.begin_date],
                           @"end_date":[NSString stringWithFormat:@"%@",self.end_date],//[NSString stringWithFormat:@"%@",self.end_date],
                           @"page":[NSString stringWithFormat:@"%ld",self.page],
                           @"limit":@"50",
                           };
    
    [[FBHAppViewModel shareViewModel]list_merchant_orders:model.merchant_id andstore_id:model.store_id andorders:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC = resDic[@"data"];

                /*退款数量*/
                NSString *num = [NSString stringWithFormat:@"%@",DIC[@"pending_refund_order_num"]];
                NSInteger order_num = [num integerValue];
                if (order_num >0) {
                    [self.MenuView.badgeLable setHidden:NO];
                    self.MenuView.badgeLable.width = order_num>9 ? 18: 13;
                    [self.MenuView.badgeLable  setText:num];

                }else if (order_num == 0){
                    [self.MenuView.badgeLable setHidden:YES];
                    
                }
            
            
        }else{
           
        }
    } andfailure:^{

    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商家订单";
    self.page = 1;
    [self merchant_center:self.status];
    /**
     * 导航栏
     */
    [self setupNav];
    /**
     * UI
     */
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"adeOrendTime" object:nil];
}
- (void)refreshTableView: (NSNotification *) notification {
    //处理消息
    NSArray *info = [notification object];
    self.begin_date = [NSString stringWithFormat:@"%@",info[0]];
    self.end_date = [NSString stringWithFormat:@"%@",info[1]];
    self.page = 1;
    [self merchant_center:self.status];
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    NavView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 160, 44)];
    navLabel.text = @"商家订单";
    navLabel.textColor = UIColorFromRGB(0x222222);
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.font = NavTitleFont;
    navLabel.centerX = NavView.centerX;
    [NavView addSubview:navLabel];
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenW-48, STATUS_BAR_HEIGHT, 48, 44)];
    [leftbutton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    [leftbutton setImage:[UIImage imageNamed:@"icn_calendar_black"] forState:UIControlStateNormal];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *righbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 40, 44)];
    //    [righbutton setTitle:@"返回" forState:UIControlStateNormal];
    [righbutton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [righbutton setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    righbutton.layer.cornerRadius = 14;
    [righbutton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    [NavView addSubview:righbutton];
    [NavView addSubview:leftbutton];
    
    [self.view addSubview:NavView];
}
/**
 * 选择历史
 */
-(void)RighAction{
    [self.navigationController pushViewController:[FBHDLSViewController new] animated:NO];
}
-(void)leftAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - UI
-(void)createUI{
    /**
     * 菜单栏
     */
    YBWeakSelf
    self.MenuView = [[DDMenuView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+44, ScreenW, 70)];
    self.MenuView.backgroundColor = [UIColor clearColor];
    self.MenuView.isSelete = [self.status integerValue];
    self.MenuView.Menublock = ^(NSString *btntag) {
        weakSelf.page = 1;
        weakSelf.status = btntag;
        [weakSelf merchant_center:btntag];
        [weakSelf.orderTableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        
    };
    
    //        replyView *tipView = [[NSBundle mainBundle] loadNibNamed:@"replyView" owner:self options:nil].lastObject;
    //        tipView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //        [self.view.window addSubview:tipView];
    
    
    [self.view addSubview:self.MenuView];
    
    /** 列表 **/
    
    self.orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.MenuView.bottom, ScreenW, ScreenH - self.MenuView.height - 44-20) style:UITableViewStylePlain];
    self.orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.orderTableView.estimatedRowHeight = 0;
    self.orderTableView.estimatedSectionHeaderHeight = 0;
    self.orderTableView.estimatedSectionFooterHeight = 0;
    self.orderTableView.backgroundColor = [UIColor clearColor];
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource =self;
    [self.view addSubview:self.orderTableView];
    self.orderTableView.defaultNoDataText = @"您暂时没有相关的订单哦～";
    self.orderTableView.defaultNoDataImage = [UIImage imageNamed:@"no_order_tip"];
    self.orderTableView.backgroundView = [UIView new];
    self.orderTableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
        //        [self merchant_center];
    };
//    self.orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
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
     self.orderTableView.mj_header = header;
    
    /** 底部刷新 **/
    self.orderTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}
/**
 * 刷新
 */
-(void)headerRereshing{
    self.page = 1;
    [self merchant_center:self.status];
    [self.orderTableView.mj_header endRefreshing];
}
-(void)footerRereshing{
    self.page ++;
    [self merchant_center:self.status];
    [self.orderTableView.mj_footer endRefreshing];
}
#pragma mark - 删除订单
-(void)delete_order:(NSDictionary *)Dara{
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"删除提醒";
    NSString *card_number = [NSString stringWithFormat:@"您是否要将本订单删除。"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"删除中..."];
        UserModel *model = [UserModel getUseData];
        [[FBHAppViewModel shareViewModel]delete_order:model.merchant_id andstore_id:model.store_id andorder_id:Dara[@"order_id"] Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue] == 1) {
                [self merchant_center:self.status];
                [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
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
-(void)delete_order1:(NSDictionary *)Dara{
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"删除提醒";
    NSString *card_number = [NSString stringWithFormat:@"您是否要将本订单删除。"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"删除中..."];
        UserModel *model = [UserModel getUseData];
        [[FBHAppViewModel shareViewModel]delete_order:model.merchant_id andstore_id:model.store_id andorder_id:Dara[@"order_id"] Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue] == 1) {
                [self merchant_center:self.status];
                [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
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
-(void)delete_order2:(NSDictionary *)Dara{
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"删除提醒";
    NSString *card_number = [NSString stringWithFormat:@"您是否要将本订单删除。"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"删除中..."];
        UserModel *model = [UserModel getUseData];
        [[FBHAppViewModel shareViewModel]delete_order:model.merchant_id andstore_id:model.store_id andorder_id:Dara[@"order_id"] Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue] == 1) {
                [self merchant_center:self.status];
                [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
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
-(void)detail:(NSDictionary *)Dara{
    FBHDdetailsController *VC = [FBHDdetailsController new];
    VC.status = 1;
    VC.order_id = [NSString stringWithFormat:@"%@",Dara[@"order_id"]];
    VC.navigationTitle = @"待支付";
    [self.navigationController pushViewController:VC animated:NO];
}

#pragma mark - 打印事件
-(void)printe:(NSDictionary *)data{
    
    /*判读外面打印开关*/
    NSString * isbluetooth = [PublicMethods readFromUserD:@"isbluetooth"];
    if ([isbluetooth isEqualToString:@"YES"]) {
       
    }else{
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"未开启打印开关、请开启"];
        return;
    }
    /*判读开关滑动展示
     0 ：为关闭打印
     1 ：云打印
     2 :   蓝牙打印
     */
    NSString * YunLanSound = [PublicMethods readFromUserD:@"YunLanSound"];
    if ([YunLanSound isEqualToString:@"1"]) {
        [self dayin:data[@"order_id"]];

    }else if([YunLanSound isEqualToString:@"2"]) {
        [self merchant_center_DaYin:data[@"order_id"]];
    }else{
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"未选择打印方式、请开启选择"];
    }
    
   
   
}
#pragma mark - 云打印请求
-(void)dayin:(NSString *)order_id{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]YlyReceipts:model.merchant_id andstore_id:model.store_id andorder_id:order_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
//            NSDictionary *DIC=resDic[@"data"];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
}
#pragma mark - 订单详情
-(void)merchant_center_DaYin:(NSString *)order_id{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]detail_merchant_orders:model.merchant_id andorder_id:order_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            
            [self printe_DaYin:DIC];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
}
#pragma mark - 蓝牙打印
- (void)printe_DaYin:(NSDictionary *)dict{
    
    [MBProgressHUD MBProgress:@"打印加载中..."];

    if (self.manage.stage != JWScanStageCharacteristics) {
        //        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        ReceiptsController *VC = [ReceiptsController new];
        VC.ReceiptsData = dict;
        [self.navigationController pushViewController:VC animated:NO];
        return;
    }
    
    NSLog(@"可以打印！！！！！！！！！！！")
    [self JWPrinter_Printer:dict];

}
#pragma mark - 退单
-(void)Refund:(NSDictionary *)Dara{
    UserModel *Model = [UserModel getUseData];
    NSString *order_id = [NSString stringWithFormat:@"%@",Dara[@"order_id"]];


    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"确认退款";
    NSString *card_number = [NSString stringWithFormat:@"订单编号：%@ 金额：%@\n正在申请退款，是否确认退款。",Dara[@"order_sn"],Dara[@"actual_money"]];
    samView.deleteText.text = card_number;
    [samView.deleteButton setTitle:@"确认退款" forState:UIControlStateNormal];
    [samView.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    samView.deleteButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:105/255.0 blue:105/255.0 alpha:1.0];
    [samView.cancel setTitleColor:UIColorFromRGB(0xFF6969) forState:UIControlStateNormal];
    samView.cancel.layer.borderColor = UIColorFromRGB(0xFF6969).CGColor;
    samView.DeleteCardBlock = ^{
        //execute_refund
        [MBProgressHUD MBProgress:@"数据加载中..."];
        
        [[FBHAppViewModel shareViewModel]order_refund:Model.merchant_id andstore_id:Model.store_id andorder_id:order_id andtype:@"1" Success:^(NSDictionary *resDic) {
            if ([resDic[@"status"] integerValue] == 1) {
                [self merchant_center:self.status];
                [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
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
#pragma mark -拒绝退单
-(void)Refused:(NSDictionary *)Dara{
    UserModel *Model = [UserModel getUseData];
    NSString *order_id = [NSString stringWithFormat:@"%@",Dara[@"order_id"]];
    
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"拒绝退款";
    NSString *card_number = [NSString stringWithFormat:@" 确定拒绝，订单编号：%@ 金额：%@ 退款申请",Dara[@"order_sn"],Dara[@"actual_money"]];
    samView.deleteText.text = card_number;
    [samView.deleteButton setTitle:@"确认拒绝" forState:UIControlStateNormal];
    [samView.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    samView.deleteButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:105/255.0 blue:105/255.0 alpha:1.0];
    [samView.cancel setTitleColor:UIColorFromRGB(0xFF6969) forState:UIControlStateNormal];
    samView.cancel.layer.borderColor = UIColorFromRGB(0xFF6969).CGColor;
    samView.DeleteCardBlock = ^{
        //reject_refund
        [MBProgressHUD MBProgress:@"数据加载中..."];

         [[FBHAppViewModel shareViewModel]order_refund:Model.merchant_id andstore_id:Model.store_id andorder_id:order_id andtype:@"2" Success:^(NSDictionary *resDic) {
            if ([resDic[@"status"] integerValue] == 1) {
                [self merchant_center:self.status];
                [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
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
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.status isEqualToString:@"6"]) {
        return 3;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if ([self.status isEqualToString:@"6"]) {
        if (section == 0) {
            return self.Data.count;
        }else if(section == 1){
            return self.DataC.count;
        }else{
            return self.DataS.count;
        }
        
    }else{
        return self.Data.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BrandNewOrderCell * cell1= [tableView dequeueReusableCellWithIdentifier:@"BrandNewOrderCell"];
    cell1=[[BrandNewOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BrandNewOrderCell"];
    cell1.delagate = self;
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell1.Data = self.Data[indexPath.row];
    }else if(indexPath.section == 1){
        
        cell1.Data = self.DataC[indexPath.row];
    }else{
        
        cell1.Data = self.DataS[indexPath.row];
    }
//    cell1.order_id = 2;
//    if (indexPath.row == self.ZSint) {
//        cell1.order_id = 1;
//    }
//    cell1.TheRestBlock = ^{
//        self.ZSint = indexPath.row;
//        [self.orderTableView reloadData];
//    };
    return cell1;
    

    
//    OrderViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderViewCell"];
//    //            if (!cell) {
//    cell=[[OrderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderViewCell"];
//    //            }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor clearColor];
//    NSString *order_status = [NSString new];
//    NSString *pay_status = [NSString new];
//    NSString *trade_status = [NSString new];
//    NSString *eval_status = [NSString new];
//    NSString *refund_status = [NSString new];
//
//    if (indexPath.section == 0) {
//        order_status = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"order_status"]];
//        //支付状态 0 未支付，1 已支付
//         pay_status =  [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"pay_status"]];
//        //交易状态 0 进行中 1.已完成(未核销)，2.已结算（已核销），3.已分佣,4 已取消
//         trade_status =  [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"trade_status"]];
//        //评价状态 0 未评价，1.已评价
//         eval_status = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"eval_status"]];
//        //退款状态 0 未退款 1发起退款中 2.退款已确认，3退款已完成，4.退款已取消
//        refund_status = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"refund_status"]];
//    }else if(indexPath.section == 1){
//        order_status = [NSString stringWithFormat:@"%@",self.DataC[indexPath.row][@"order_status"]];
//        //支付状态 0 未支付，1 已支付
//         pay_status =  [NSString stringWithFormat:@"%@",self.DataC[indexPath.row][@"pay_status"]];
//        //交易状态 0 进行中 1.已完成(未核销)，2.已结算（已核销），3.已分佣,4 已取消
//         trade_status =  [NSString stringWithFormat:@"%@",self.DataC[indexPath.row][@"trade_status"]];
//        //评价状态 0 未评价，1.已评价
//         eval_status = [NSString stringWithFormat:@"%@",self.DataC[indexPath.row][@"eval_status"]];
//        //退款状态 0 未退款 1发起退款中 2.退款已确认，3退款已完成，4.退款已取消
//        refund_status = [NSString stringWithFormat:@"%@",self.DataC[indexPath.row][@"refund_status"]];
//    }else{
//        order_status = [NSString stringWithFormat:@"%@",self.DataS[indexPath.row][@"order_status"]];
//        //支付状态 0 未支付，1 已支付
//         pay_status =  [NSString stringWithFormat:@"%@",self.DataS[indexPath.row][@"pay_status"]];
//        //交易状态 0 进行中 1.已完成(未核销)，2.已结算（已核销），3.已分佣,4 已取消
//         trade_status =  [NSString stringWithFormat:@"%@",self.DataS[indexPath.row][@"trade_status"]];
//        //评价状态 0 未评价，1.已评价
//         eval_status = [NSString stringWithFormat:@"%@",self.DataS[indexPath.row][@"eval_status"]];
//        //退款状态 0 未退款 1发起退款中 2.退款已确认，3退款已完成，4.退款已取消
//        refund_status = [NSString stringWithFormat:@"%@",self.DataS[indexPath.row][@"refund_status"]];
//    }
////0全部、1待付款、2待使用、3待评价、4已评价、5已取消、6待退单、7退单完成、8退单失败、9待退款、10退款完成、11退款失败） 传入2，获取2,3的订单信息； 传入6，获取6,7,8的订单信息 传入9
//    if ([order_status isEqualToString: @"1"] ){
//        if ([refund_status isEqualToString:@"0"] || [refund_status isEqualToString:@"4"]) {
//            cell.status = OrderVieWStatus_1;
//        }else{
//            cell.status = OrderVieWStatus_8;
//        }
//
//    }else if ([order_status isEqualToString: @"2"]){
//        if ([refund_status isEqualToString:@"0"] || [refund_status isEqualToString:@"4"]) {
//            cell.status = OrderVieWStatus_2;
//        }else{
//            cell.status = OrderVieWStatus_8;
//        }
//
//    }else if ([order_status isEqualToString: @"3"]){
//        if ([refund_status isEqualToString:@"0"] || [refund_status isEqualToString:@"4"]) {
//            cell.status = OrderVieWStatus_3;
//        }else{
//            cell.status = OrderVieWStatus_8;
//        }
//
//    }else if ([order_status isEqualToString: @"4"]){
//        if ([refund_status isEqualToString:@"0"] || [refund_status isEqualToString:@"4"]) {
//            cell.status = OrderVieWStatus_4;
//        }else{
//            cell.status = OrderVieWStatus_8;
//        }
//
//    }else if ([order_status isEqualToString: @"5"]){
//        if ([refund_status isEqualToString:@"0"] || [refund_status isEqualToString:@"4"]) {
//            cell.status = OrderVieWStatus_5;
//        }else{
//            cell.status = OrderVieWStatus_8;
//        }
//
//    }else if ([order_status isEqualToString: @"6"]){
//         cell.status = OrderVieWStatus_6;
//
//    }else if ([order_status isEqualToString: @"7"]){
//        cell.status = OrderVieWStatus_7;
//
//    }else if ([order_status isEqualToString: @"8"]){
//        cell.status = OrderVieWStatus_7;
//
//    }else if ([order_status isEqualToString: @"9"]){
//        cell.status = OrderVieWStatus_8;
//
//    }else if ([order_status isEqualToString: @"10"]){
//        cell.status = OrderVieWStatus_8;
//
//    }else if ([order_status isEqualToString: @"11"]){
//        cell.status = OrderVieWStatus_8;
//
//    }else{
//        cell.status = OrderVieWStatus_8;
//
//    }
//
//
//    if (indexPath.section == 0) {
//        cell.delagate = self;
//        cell.Data = self.Data[indexPath.row];
//    }else if(indexPath.section == 1){
//
//        cell.delagate = self;
//        cell.Data = self.DataC[indexPath.row];
//    }else{
//
//        cell.delagate = self;
//        cell.Data = self.DataS[indexPath.row];
//    }
//    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *order_status = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"order_status"]];

//    OrderViewCell * cell = (OrderViewCell *)[tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    BrandNewOrderCell * cell = (BrandNewOrderCell *)[tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    //直接返回cell 高度
    return [cell getCellHeight];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.status isEqualToString:@"6"]) {
        return IPHONEWIDTH(48);
    }else{
        return 0.01;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 43)];
    headerView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(15,15,150,30);
    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = [UIColor blackColor];
    [headerView addSubview:label1];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,5,ScreenW-30,1);
    view.clipsToBounds = YES;
    [headerView addSubview:view];
    NSInteger lineW = (ScreenW-30)/9;

    if (section == 0) {
        label1.text = @"未处理";

    }else if (section == 1){
        if (self.DataC.count>0) {
            label1.text = @"处理成功";
            for (int i=0; i<=lineW; i++) {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*9, 0, 5, 0.5)];
                line.backgroundColor = UIColorFromRGBA(0x999999, 0.7);
                [view addSubview:line];
            }
        }
       
        
    }else{
        if (self.DataS.count>0) {
            label1.text = @"处理失败";
            for (int i=0; i<=lineW; i++) {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*9, 0, 5, 0.5)];
                line.backgroundColor = UIColorFromRGBA(0x999999, 0.7);
                [view addSubview:line];
            }
        }
       
    }
    if ([self.status isEqualToString:@"6"]) {
        return headerView;
    }else{
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FBHDdetailsController *VC = [FBHDdetailsController new];
    NSString *order_status = [NSString new];
    NSString *order_id = [NSString new];
    NSString *order_status_txt = [NSString new];
    if (indexPath.section == 0) {
        order_status = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"order_status"]];
        order_id = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"order_id"]];
        order_status_txt = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"order_status_txt"]];
    }else if(indexPath.section == 1){
        order_status = [NSString stringWithFormat:@"%@",self.DataC[indexPath.row][@"order_status"]];
        order_id = [NSString stringWithFormat:@"%@",self.DataC[indexPath.row][@"order_id"]];
        order_status_txt = [NSString stringWithFormat:@"%@",self.DataC[indexPath.row][@"order_status_txt"]];

    }else{
        order_status = [NSString stringWithFormat:@"%@",self.DataS[indexPath.row][@"order_status"]];
        order_id = [NSString stringWithFormat:@"%@",self.DataS[indexPath.row][@"order_id"]];
        order_status_txt = [NSString stringWithFormat:@"%@",self.DataS[indexPath.row][@"order_status_txt"]];

    }
    
    VC.order_id = order_id;
    VC.navigationTitle = order_status_txt;
    
    switch ([order_status integerValue]) {
        case 0:
            VC.status = 0;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 1:
            VC.status = 1;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 2:
            VC.status = 2;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 3:
            VC.status = 3;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 4:
            VC.status = 4;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 5:
            VC.status = 5;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 6:
            VC.status = 6;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 7:
            VC.status = 7;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 8:
            VC.status = 8;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 9:
            VC.status = 9;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 10:
            VC.status = 10;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
        case 11:
            VC.status = 11;
            [self.navigationController pushViewController:VC animated:NO];
            
            break;
            
        default:
            
            break;
    }
    
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"adeOrendTime" object:nil];
    
}
#pragma mark --- 懒加载
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
-(NSMutableArray *)DataC{
    if (!_DataC) {
        _DataC = [NSMutableArray array];
    }
    return _DataC;
}
-(NSMutableArray *)DataS{
    if (!_DataS) {
        _DataS = [NSMutableArray array];
    }
    return _DataS;
}
-(NSString *)begin_date{
    if (!_begin_date) {
        _begin_date = [[NSString alloc]init];
    }
    return _begin_date;
}
-(NSString *)end_date{
    if (!_end_date) {
        _end_date = [[NSString alloc]init];
    }
    return _end_date;
}
@end
