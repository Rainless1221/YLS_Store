//
//  MoneyCertificationController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "MoneyCertificationController.h"

@interface MoneyCertificationController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * MoneyTableView;
@property (strong,nonatomic)NSMutableArray * Data;
@property (assign,nonatomic)BOOL info_merchant;
@property (assign,nonatomic)NSInteger cust_type;

@property (strong,nonatomic)NSDictionary * dict1;
@property (strong,nonatomic)NSDictionary * dict2;
@property (strong,nonatomic)NSDictionary * dict3;

@property (strong,nonatomic)UIView * NavView;
@property (strong,nonatomic)UILabel * NavLabl;

@end

@implementation MoneyCertificationController
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
    self.navigationItem.title = @"提现认证";
    
    
    self.dict1 = @{@"icon":@"ico_merchant_person",
                            @"label":@"小微商户",@"cust_type":@"1"};
    self.dict2 = @{@"icon":@"ico_merchant_retailers",
                            @"label":@"个体商户",@"cust_type":@"2"};
   self.dict3 = @{@"icon":@"ico_merchant_enterprise",
                            @"label":@"企业商户",@"cust_type":@"3"};
    
    
    NSArray *marArr = @[@{@"icon":@"ico_merchant_person",
                          @"label":@"小微商户",@"cust_type":@"1"},
                        @{@"icon":@"ico_merchant_retailers",
                          @"label":@"个体商户",@"cust_type":@"2"},
                        @{@"icon":@"ico_merchant_enterprise",
                          @"label":@"企业商户",@"cust_type":@"3"},
                        ];
    
    for (NSDictionary *dict in marArr) {
        [self.Data addObject:dict];
    }
    self.info_merchant = YES;
    self.cust_type = 4;
    [self merchant_center];
    [self get_ysepay_merchant_info];
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
            
            if (DIC.count == 0) {
                self.info_merchant = YES;
            }else{
                [self.Data removeAllObjects];

                self.info_merchant = NO;
                NSString *sting = [NSString stringWithFormat:@"%@",DIC[@"cust_type"]];
                self.cust_type = [sting integerValue];
                switch (self.cust_type) {
                    case 1:
                        [self.Data addObject:self.dict1];
                        [self.Data addObject:self.dict2];
                        [self.Data addObject:self.dict3];
                        break;
                    case 2:
                        [self.Data addObject:self.dict2];
                        [self.Data addObject:self.dict1];
                        [self.Data addObject:self.dict3];
                        break;
                    case 3:
                        [self.Data addObject:self.dict3];
                        [self.Data addObject:self.dict1];
                        [self.Data addObject:self.dict2];
                        break;
                    default:
                        break;
                }
                
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
#pragma mark - 导航栏
-(void)setupNav{
    self.NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    self.NavView.backgroundColor = [UIColor whiteColor];
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT, ScreenW-20, 44)];
    navLabel.text = self.navigationTitle;
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
    
    switch (self.cust_type) {
        case 1:
            [self.navigationController pushViewController:[Wei_StoreController new] animated:NO];

            break;
        case 2:
    
            [self.navigationController pushViewController:[Geti_StoreController new] animated:NO];

            break;
        case 3:
            [self.navigationController pushViewController:[Qiye_StoreController new] animated:NO];

            break;
        default:
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }

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
    [self get_ysepay_merchant_info];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.Data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xF6F6F6);
    cell.Data = self.Data[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(cell.cellIcon_jt.left-10,cell.cellIcon_jt.top-5,32,16);
        label.numberOfLines = 0;
        label.textAlignment =1;
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor whiteColor];
        label.text = @"当前";
        label.backgroundColor = UIColorFromRGB(0x3D8AFF);
        if (self.info_merchant == NO) {
            [cell addSubview:label];

        }
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (self.info_merchant == NO) {
        if (section == 0) {
            return 107;
        }else if (section == 1){
            return 50.01;
        }else{
            return 0.01;
        }
    }else{
        if (section == 0) {
            return 70;
        }else{
            return 0.01;
        }
    }
    
    return  0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 70)];
    /**/
    UIImageView *header_icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 6, 6)];
    header_icon.image = [UIImage imageNamed:@"icn_list_styletype_dot_blue"];
    
    [header_View addSubview:header_icon];
    /*用户可以根据真实情况，选择自己对应的商户类型
     认证成功，可用于查看账户的提现金额*/
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(29,20,263,30);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = UIColorFromRGB(0x999999);
    label.text = @"用户可以根据真实情况，选择自己对应的商户类型认证成功，可用于查看账户的提现金额";
    [header_View addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(29);
        make.right.mas_offset(-20);
        make.top.mas_offset(20);
    }];
    
    header_View.backgroundColor = [UIColor clearColor];
    if (self.info_merchant == NO) {
        if (section == 0) {
            header_View.height = 107;
            label.textColor = UIColorFromRGB(0x3D8AFF);
            NSString *string = [[NSString alloc]init];
            switch (self.cust_type) {
                case 1:
                    string = @"小微商户";
                    break;
                case 2:
                    string = @"个体商户";
                    break;
                case 3:
                    string = @"企业商户";
                    break;
                default:
                    break;
            }
            
            NSString *text = [NSString stringWithFormat:@"您当前认证的商户类型为——%@。\n重新认证需调教另外的认证资料，1-2个工作日确认。重新认证 不影响账户提现功能。 \n认证过程中出现疑问，可联系客服400-1819-111。",string];

            NSMutableAttributedString* lab_string = [[NSMutableAttributedString alloc] initWithString:text];
            [lab_string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x999999) range:NSMakeRange(0,13)];
            [lab_string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x999999) range:NSMakeRange(17,72)];
            label.attributedText = lab_string;
            [label sizeToFit];
            return header_View;
        }else if (section ==1){
            label.textColor = UIColorFromRGB(0x3D8AFF);
            label.text = @"请选择";
            return header_View;

        }else{
        }
    }else{
        if (section == 0) {
            return header_View;
        }
    }
    return nil;
    
}

//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && self.info_merchant == NO) {
        return;
    }
    NSString *type =[NSString stringWithFormat:@"%@",self.Data[indexPath.section][@"cust_type"]];
    
    FillInViewController *VC = [FillInViewController new];

    
    NSInteger typeVC = [type integerValue];
    
    switch (typeVC) {
        case 1:
        
            if (self.cust_type == 1 && self.info_merchant == NO) {
                [self.navigationController pushViewController:[Wei_StoreController new] animated:NO];

            }else{
                VC.NavString = [NSString stringWithFormat:@"%@",self.Data[indexPath.section][@"label"]];
                VC.cust_type  = [type integerValue];
                [self.navigationController pushViewController:VC animated:NO];
            }

            break;
        case 2:
   
            if (self.cust_type == 2 && self.info_merchant == NO) {
                [self.navigationController pushViewController:[Geti_StoreController new] animated:NO];

            }else{
                VC.NavString = [NSString stringWithFormat:@"%@",self.Data[indexPath.section][@"label"]];
                VC.cust_type  = [type integerValue];
                [self.navigationController pushViewController:VC animated:NO];
            }
            
            break;
        case 3:
        
            if (self.cust_type == 3 && self.info_merchant == NO) {
                [self.navigationController pushViewController:[Qiye_StoreController new] animated:NO];
                
            }else{
                VC.NavString = [NSString stringWithFormat:@"%@",self.Data[indexPath.section][@"label"]];
                VC.cust_type  = [type integerValue];
                [self.navigationController pushViewController:VC animated:NO];
            }
            break;
        default:
            break;
    }
    
    return;
    
    
    
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
        
        [_MoneyTableView registerClass:[MoneyTableViewCell class] forCellReuseIdentifier:@"MoneyTableViewCell"];
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
-(NSInteger)cust_type{
    if (!_cust_type) {
        _cust_type = [NSIndexPath new];
    }
    return _cust_type;
}
@end
