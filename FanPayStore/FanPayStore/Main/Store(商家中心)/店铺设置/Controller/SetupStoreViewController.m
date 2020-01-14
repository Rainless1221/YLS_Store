//
//  SetupStoreViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/12/18.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "SetupStoreViewController.h"
#import "CanWeiView.h"

@interface SetupStoreViewController ()<UITableViewDelegate,UITableViewDataSource,CanViewDelegate>
@property (strong,nonatomic)UITableView * SetUptable;
@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)MySwitch *YYSound;
/*餐位费金额*/
@property (strong,nonatomic)NSString * CanWei;
@end

@implementation SetupStoreViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self merchant_center];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title = @"店铺设置";
    
    NSArray *marArr = @[@[
                            @{@"icon":@"icn_msg_cnenter_system",
                              @"label":@"接收预约订单",@"cellid":@"1"
                              },
                            ],
                        
                        @[
                            @{@"icon":@"icn_msg_cnenter_system",
                              @"label":@"餐位收费",@"cellid":@"2"
                              },
                            ],
                        
                        ];
    
    for (NSDictionary *dict in marArr) {
        [self.Data addObject:dict];
        
    }
    self.CanWei = @"0.00";
//    [self merchant_center];
    [self createUI];
    
}
#pragma mark - 请求数据
-(void)merchant_center{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    
    if ([model.store_id isEqualToString:@""]) {
        [MBProgressHUD hideHUD];
        
        return;
    }
    /**
     获取商家中心的信息（商家中心显示的信息）
     */
    [[FBHAppViewModel shareViewModel] yls_list_business_center:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            /** 保存商家中心信息 */
            storeBaseModel *model = [storeBaseModel mj_objectWithKeyValues:DIC];
            [model saveUserData];
            [self.SetUptable reloadData];
        }else{
            //            [SVProgressHUD setMinimumDismissTimeInterval:2];
            //            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SetUptable];
    [self.SetUptable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.Data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,0,cell.width-30,cell.height);
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [cell addSubview:view];
    NSString *celltext = [NSString stringWithFormat:@"%@",self.Data[indexPath.section][indexPath.row][@"label"]];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,0,200,50);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    label.text = celltext;
    [view addSubview:label];
    
    ///
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenW-50 , 0, 10, 50);
    [button setImage:[UIImage imageNamed:@"input_arrow_right_deepgray"] forState:UIControlStateNormal];
    [view addSubview:button];
#pragma mark -   /*预约订单开关*/
    if (indexPath.section == 0) {
        
        storeBaseModel *model = [storeBaseModel getUseData];
//        NSString * appointment_switch = [PublicMethods readFromUserD:@"appointment_switch"];
        self.YYSound = [[MySwitch alloc] initWithFrame:CGRectMake(view.width - 74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
            if(OnStatus){
                NSLog(@"打开");
              
                [self set_appointment:@"1"];
                
            }else{
                NSLog(@"关闭");
                
                [self set_appointment:@"2"];
            }
        }];
        
        if ([model.appointment_switch isEqualToString:@"2"]) {
            self.YYSound.OnStatus = NO;
        }else if([model.appointment_switch isEqualToString:@"1"]) {
            self.YYSound.OnStatus = YES;
        }else{
            self.YYSound.OnStatus = NO;
        }
        
        //设置背景图片
        [self.YYSound setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
        [self.YYSound setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.YYSound setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        
        [view addSubview:self.YYSound];
        
    }else if (indexPath.section == 1){
        #pragma mark -   /*餐位收费开关*/
        storeBaseModel *model = [storeBaseModel getUseData];
        //        NSString * appointment_switch = [PublicMethods readFromUserD:@"appointment_switch"];
        self.YYSound = [[MySwitch alloc] initWithFrame:CGRectMake(view.width - 74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
            if(OnStatus){
                NSLog(@"打开");
                if ([self.CanWei doubleValue] <=0) {
                    [self CanAction];
                }else{
                     [self set_meel_fee:@"1"];
                }

                
            }else{
                NSLog(@"关闭");
                
                [self set_meel_fee:@"2"];
            }
        }];
        
        if ([model.meel_fee_switch isEqualToString:@"2"]) {
            self.YYSound.OnStatus = NO;
        }else if([model.meel_fee_switch isEqualToString:@"1"]) {
            self.YYSound.OnStatus = YES;
        }else{
            self.YYSound.OnStatus = NO;
        }
        
        //设置背景图片
        [self.YYSound setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
        [self.YYSound setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.YYSound setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        
        [view addSubview:self.YYSound];
        
        /*横线*/
        UIView *view_line = [[UIView alloc] init];
        view_line.frame = CGRectMake(10,50,view.width-20,0.5);
        view_line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [view addSubview:view_line];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10,50,50,40);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"餐位费";
        [view addSubview:label];
        //
        self.CanWei  = model.meel_fee;
        [self CanWeiUI:view];
        
    }

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
         return 50;
    }else if (indexPath.section ==1){
        return 90;
    }else{
        return 50;
    }
         
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }else if (section == 1){
        return 40;
    }else if (section == 5){
        return 84;
    }else{
        return 5;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    header_View.backgroundColor = [UIColor clearColor];
    return header_View;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *header_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 54)];
    header_View.backgroundColor = [UIColor clearColor];
    if (section == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(24,0,ScreenW-48,45);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"开启接收预约订单，将会自动接收用户提交的预约订单";
        [header_View addSubview:label];
        return header_View;
    }else if (section == 1){
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(24,0,ScreenW-48,45);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"开启后，餐位费用会根据用餐人数自动计算";
        [header_View addSubview:label];
        return header_View;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    
    
    
}
#pragma mark -餐位收费相关
-(void)CanWeiUI:(UIView*)BaseView{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(64,50,15,40);
    label.numberOfLines = 0;
    label.text = @"每";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = UIColorFromRGB(0x999999);
    [BaseView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(label.right,50,15,40);
    label1.numberOfLines = 0;
    label1.textAlignment = 1;
    label1.text = @"1";
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = UIColorFromRGB(0x222222);
    [BaseView addSubview:label1];
    
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(label1.right,50,70,40);
    label2.numberOfLines = 0;
    label2.text = @"位客人收取";
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = UIColorFromRGB(0x999999);
    [BaseView addSubview:label2];
    
    
   
    
    UILabel *CanWei = [[UILabel alloc] init];
    CanWei.frame = CGRectMake(label2.right,60,35,20);
    CanWei.numberOfLines = 0;
    CanWei.textAlignment = 1;
    CanWei.text = self.CanWei;
    CanWei.font = [UIFont systemFontOfSize:12];
    CanWei.layer.borderWidth = 0.7;
    CanWei.layer.cornerRadius = 4;
    CanWei.layer.borderColor =UIColorFromRGB(0xEAEAEA).CGColor;
    CanWei.textColor = UIColorFromRGB(0x222222);
    [BaseView addSubview:CanWei];
    
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(CanWei.right+10,50,70,40);
    label3.numberOfLines = 0;
    label3.text = @"元";
    label3.font = [UIFont systemFontOfSize:12];
    label3.textColor = UIColorFromRGB(0x999999);
    [BaseView addSubview:label3];
    
    /*隐藏的按钮*/
    UIButton *canweiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    canweiButton.frame = CGRectMake(64, 50, BaseView.width-70, 40);
    [canweiButton addTarget:self action:@selector(CanAction) forControlEvents:UIControlEventTouchUpInside];
    [BaseView addSubview:canweiButton];
}
/*弹出填写视图*/
-(void)CanAction{
    CanWeiView *view = [[CanWeiView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.delagate = self;
    view.CanField.text = self.CanWei;
     [[UIApplication sharedApplication].keyWindow addSubview:view];
}
-(void)Can_card:(NSString *)Canlabel{
    self.CanWei= Canlabel;
    [self set_meel_fee:@"1"];
    [self.SetUptable reloadData];
}
#pragma mark - 设置店铺预约功能开关
-(void)set_appointment:(NSString *)status{
    UserModel *Model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]set_appointment:Model.merchant_id andstore_id:Model.store_id andstatus:status Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            
        }else{
            
        }
    } andfailure:^{
        
    }];
    
}
#pragma mark -设置店铺餐位费开关
-(void)set_meel_fee:(NSString *)status{
    if ([self.CanWei doubleValue] <=0) {
        return;
    }
     [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *Model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]set_meel_fee:Model.merchant_id andstore_id:Model.store_id andstatus:status andmeel_fee:self.CanWei  Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            [self merchant_center];
        }else{
            
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark -懒加载
-(UITableView *)SetUptable{
    if (!_SetUptable) {
        _SetUptable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStyleGrouped];
        _SetUptable.delegate = self;
        _SetUptable.dataSource = self;
        _SetUptable.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SetUptable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_SetUptable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
//        [_SetUptable registerClass:[HotelOrderCell class] forCellReuseIdentifier:@"HotelOrderCell"];
//        [_SetUptable registerClass:[TheHotelCell class] forCellReuseIdentifier:@"TheHotelCell"];
        
        _SetUptable.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _SetUptable;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
@end
