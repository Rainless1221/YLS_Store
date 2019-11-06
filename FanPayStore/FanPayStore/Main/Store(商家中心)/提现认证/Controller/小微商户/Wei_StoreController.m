//
//  Wei_StoreController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "Wei_StoreController.h"

@interface Wei_StoreController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * MoneyTableView;
@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)NSMutableArray * Data1;
@property (strong,nonatomic)NSDictionary * Dict;

@property (strong,nonatomic)UIView * NavView;
@property (strong,nonatomic)UILabel * NavLabl;

@end

@implementation Wei_StoreController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现账户信息";
    
    NSArray *marArr = @[@{@"icon":@"icn_shop_type_cycle_blue",
                          @"label":@"法人信息"
                          },
                        @{@"icon":@"icn_shop_type_cycle_blue",
                          @"label":@"身份证信息"},
                        @{@"icon":@"icn_shop_type_cycle_blue",
                          @"label":@"银行卡信息"},
                        @{@"icon":@"icn_shop_type_cycle_blue",
                          @"label":@"客户协议书"},
                        ];
    
    for (NSDictionary *dict in marArr) {
        [self.Data addObject:dict];
        [self.Data1 addObject:dict];
    }
    
    [self merchant_center];
    
    [self createUI];
    [self setupNav];
}
#pragma mark - 请求数据
-(void)merchant_center{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    
    
    [[FBHAppViewModel shareViewModel]get_completion_ysepay_mer_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            
            self.Dict = DIC;
            if (DIC.count==0) {
                
            }else{
                NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
                NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
                NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
                NSMutableDictionary *dict4 = [NSMutableDictionary dictionary];
                
                
                [dict1 setObject:DIC[@"is_complete_legal_info"] forKey:@"celltype"];
                [dict1 setObject:DIC[@"legal_name"] forKey:@"cellText1"];
                [dict1 setObject:DIC[@"legal_tel"] forKey:@"cellText2"];
                
                
                
                
                [dict2 setObject:DIC[@"is_complete_ID_info"] forKey:@"celltype"];
                [dict2 setObject:DIC[@"cert_no"] forKey:@"cellText1"];
                [dict2 setObject:@"" forKey:@"cellText2"];
                
                
                
                
                
                [dict3 setObject:DIC[@"is_complete_bank_card_info"] forKey:@"celltype"];
                [dict3 setObject:DIC[@"bank_account_no"] forKey:@"cellText1"];
                [dict3 setObject:@"" forKey:@"cellText2"];
                
                
                
                [dict4 setObject:DIC[@"is_complete_customer_agreement_info"] forKey:@"celltype"];
                [dict4 setObject:@"" forKey:@"cellText1"];
                [dict4 setObject:@"" forKey:@"cellText2"];
                
                [self.Data1 removeAllObjects];
                [self.Data1 addObject:dict1];
                [self.Data1 addObject:dict2];
                [self.Data1 addObject:dict3];
                [self.Data1 addObject:dict4];
                
                [self.MoneyTableView reloadData];
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
#pragma mark - 导航栏
-(void)setupNav{
    self.NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    self.NavView.backgroundColor = [UIColor whiteColor];
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT, ScreenW-20, 44)];
    navLabel.text = @"提现账户信息";
    navLabel.font = NavTitleFont;
    navLabel.textAlignment = NSTextAlignmentCenter;
    [self.NavView addSubview:navLabel];
    self.NavLabl = navLabel;
    //按钮
    UIButton *thirdBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn1.frame = CGRectMake(10, STATUS_BAR_HEIGHT, 44, 44);
    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    [thirdBtn1 addTarget:self action:@selector(LethAction) forControlEvents:UIControlEventTouchUpInside];
    [self.NavView addSubview:thirdBtn1];
    
    [self.view addSubview:self.NavView];
    
    
    
    
    
}
-(void)LethAction{
    
//    if (self.navigationController.viewControllers.count >= 2) {
//        UIViewController *vc = [self.navigationController.viewControllers objectOrNilAtIndex:1];
//        [self.navigationController popToViewController:vc animated:YES];
//    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.MoneyTableView];
    [self.MoneyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(44+STATUS_BAR_HEIGHT);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"MoneyCer" object:nil];

}
- (void)conversionAction: (NSNotification *) notification {
    [self merchant_center];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Account_TXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Account_TXTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xF6F6F6);
    cell.Data = self.Data[indexPath.row];
    cell.TableData = self.Data1[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(25,520.5,325,0.5);
    view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    if (indexPath.row==self.Data.count-1) {
        
    }else{
        [cell.CellBase addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(0);
            make.height.mas_offset(1);
        }];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  397;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MoneyHeaderView *header_View = [[MoneyHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 70)];
    /**/
    ysepayModel *model = [ysepayModel getUseData];
    header_View.SetupBlock = ^{
//        FillInViewController *VC = [FillInViewController new];
//        VC.NavString = @"小微商户";
//        VC.cust_type  = 1;
//        VC.Data = model;
//        [self.navigationController pushViewController:VC animated:NO];
        
        MoneyCertificationController *VC = [MoneyCertificationController new];
        VC.navigationTitle = @"认证类型-修改";
        [self.navigationController pushViewController:VC animated:NO];
    };
    header_View.Data = self.Dict;
    header_View.backgroundColor = [UIColor clearColor];
    return header_View;
    
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ModifyController *VC = [ModifyController new];
    VC.NavString = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"label"]];
    [self.navigationController pushViewController:VC animated:NO];
    
    
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MoneyCer" object:nil];
    
}
#pragma mark - 懒加载
-(UITableView *)MoneyTableView{
    if (!_MoneyTableView) {
        _MoneyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStyleGrouped];
        _MoneyTableView.delegate = self;
        _MoneyTableView.dataSource = self;
        _MoneyTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        
        [_MoneyTableView registerClass:[Account_TXTableViewCell class] forCellReuseIdentifier:@"Account_TXTableViewCell"];
        
        [_MoneyTableView registerClass:[MoneyHeaderView class] forHeaderFooterViewReuseIdentifier:@"MoneyHeaderView"];
        _MoneyTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    return _MoneyTableView;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
-(NSMutableArray *)Data1{
    if (!_Data1) {
        _Data1 = [NSMutableArray array];
    }
    return _Data1;
}
- (NSDictionary *)Dict{
    if (!_Dict) {
        _Dict = [NSDictionary dictionary];
    }
    return _Dict;
}

@end
