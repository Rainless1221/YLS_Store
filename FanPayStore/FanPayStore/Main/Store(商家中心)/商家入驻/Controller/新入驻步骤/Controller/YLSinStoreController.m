//
//  YLSinStoreController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/18.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSinStoreController.h"
#import "YLSinStoreView.h"

@interface YLSinStoreController ()<QieHuActionDelegate,MapControllerDelegate>
@property (strong,nonatomic)UIScrollView * ScrollView;
@property (strong,nonatomic)YLSinStoreView * InStoreView;
@property (strong,nonatomic)NSMutableDictionary * StoreDataDict;

@end

@implementation YLSinStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.NavString;
    [self get_store_tips];

    /**
     *  UI
     */
    [self createUI];
}
#pragma mark - 获取店铺温馨提示信息
-(void)get_store_tips{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_store_tips:model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSArray *DIC = resDic[@"data"][@"store_tips"];
            if (self.Data.count == 0) {
                self.InStoreView.ReminData = DIC;
            }
        }else{
            
        }
        
    } andfailure:^{
        
    }];
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.ScrollView];
    self.InStoreView.isSelete = self.Typeyint;
    [self.ScrollView addSubview:self.InStoreView];
    self.InStoreView.height = self.InStoreView.SizeHeight;
    self.ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH,  self.InStoreView.SizeHeight+100);
    
#pragma mark - 提交审核按钮
    UIView *AuditView = [[UIView alloc] init];
    AuditView.frame = CGRectMake(0,684.5,369.5,59);
    AuditView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [self.view addSubview:AuditView];
    [AuditView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(60);
    }];
    UIButton *AuditButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [AuditButton setTitle:@"提交审核" forState:UIControlStateNormal];
    [AuditButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    AuditButton.titleLabel.font = [UIFont systemFontOfSize:16];
    AuditButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    AuditButton.layer.cornerRadius = 20;
    [AuditButton addTarget:self action:@selector(AuditAction) forControlEvents:UIControlEventTouchUpInside];
    [AuditView addSubview:AuditButton];
    [AuditButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.size.mas_offset(CGSizeMake(AuditView.width-82, 40));
    }];
}
#pragma mark - 提交审核事件
-(void)AuditAction{

    UserModel *model = [UserModel getUseData];
    NSString *addres = [NSString stringWithFormat:@"%@",self.InStoreView.AView_address.text];

    NSDictionary *dict = @{
                           @"store_address":[NSString stringWithFormat:@"%@",addres],
                           @"lon":[NSString stringWithFormat:@"%@",self.StoreDataDict[@"lon"]],
                           @"lat":[NSString stringWithFormat:@"%@",self.StoreDataDict[@"lat"]],
                           @"specific_location":[NSString stringWithFormat:@"%@",self.InStoreView.AView_MenP.text],
                           @"business_hours":[NSString stringWithFormat:@"%@",self.StoreDataDict[@"business_hours"]],
                           @"business_times":[NSString stringWithFormat:@"%@",self.StoreDataDict[@"business_times"]],
                           @"merchant_name":[NSString stringWithFormat:@"%@",self.InStoreView.AView_Name.text],
                           @"merchant_mobile":[NSString stringWithFormat:@"%@",self.InStoreView.AView_Phone.text],
                           @"merchant_telephone":[NSString stringWithFormat:@"%@",self.InStoreView.AView_GPhone.text],

                           
                           @"reminder":[NSString stringWithFormat:@"%@",self.StoreDataDict[@"reminder"]],
                           @"reminder2":[NSString stringWithFormat:@"%@",self.InStoreView.ReminTF.text],
//                           @"door_face_pic":[NSString stringWithFormat:@"%@",self.door_face_pic],
//                           @"store_environment_pics":[NSString stringWithFormat:@"%@",self.storePics],
//
                           
                           };
    
    NSLog(@"数据  = %@",dict)
    
    return;
    
    [[FBHAppViewModel shareViewModel]insert_store_application:model.merchant_id andMerchantDict:dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
            
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
    
}


#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    _Data = Data;
    self.InStoreView.Data = Data;
    for (NSString *key in Data) {
        
        [self.StoreDataDict setObject:Data[key] forKey:key];
        
    }

}
#pragma mark - QieHuActionDelegate(切换)
-(void)QieHuAction:(NSInteger)Typeinteger{
    NSArray *menuArray = @[@"店铺信息",@"温馨提醒",@"店铺图片",@"证件图片"];
    self.navigationItem.title = [NSString stringWithFormat:@"%@",menuArray[Typeinteger]];
    self.InStoreView.height = self.InStoreView.SizeHeight;
    self.ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH,  self.InStoreView.SizeHeight+100);
}
#pragma mark - 去选择地址事件
-(void)SetAddress:(UILabel *)addressLabel{
    MapViewController * last = [[MapViewController alloc]init];
    //设置代理
    last.delagate = self;
    [self.navigationController pushViewController:last animated:YES];
}
-(void)Mapaddres:(NSString *)ddres andlot:(NSString *)lon andlat:(NSString *)lat{
    /** 地址 */
    self.InStoreView.AView_address.text = ddres;
    self.InStoreView.AView_address.textColor = UIColorFromRGB(0x222222);
    
    [self.StoreDataDict setObject:ddres forKey:@"store_address"];
    [self.StoreDataDict setObject:lon forKey:@"lon"];
    [self.StoreDataDict setObject:lat forKey:@"lat"];

//    self.addres = [NSString stringWithFormat:@"%@",ddres];
//    self.lon = [NSString stringWithFormat:@"%@",lon];
//    self.lat = [NSString stringWithFormat:@"%@",lat];
    
}
#pragma mark - 选择周期事件
-(void)SetCycle:(UITextField *)Cycle{
    PeriodView *periodV = [[PeriodView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    periodV.PeriodBlock = ^(NSString *PeriodString) {
        if ([PeriodString isEqualToString:@""]) {
            return ;
        }
        Cycle.text = PeriodString;
        Cycle.textColor = UIColorFromRGB(0x222222);
        [self.StoreDataDict setObject:PeriodString forKey:@"business_times"];

    };
    [[UIApplication sharedApplication].keyWindow addSubview:periodV];
}
#pragma mark - 选择营业时间事件
-(void)SetTime:(UITextField *)Time{
    hoursView *hoursV = [[hoursView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    hoursV.HoursBlock = ^(NSString *HoursString) {
        if ([HoursString isEqualToString:@""]) {
            return ;
        }
        Time.text = HoursString;
        Time.textColor = UIColorFromRGB(0x222222);
        [self.StoreDataDict setObject:HoursString forKey:@"business_hours"];

    };
    [[UIApplication sharedApplication].keyWindow addSubview:hoursV];
    
}
#pragma mark - 选择温馨提示事件
-(void)SetReminder:(NSMutableArray *)Array{
    NSString *Reminsting = [NSString new];
    for (NSString *reminID in Array) {
        if ([[MethodCommon judgeStringIsNull:Reminsting] isEqualToString:@""]) {
            Reminsting  = [NSString stringWithFormat:@"%@",reminID];
        }else{
            Reminsting  = [NSString stringWithFormat:@"%@,%@",Reminsting,reminID];
        }
        
    }
    
    [self.StoreDataDict setObject:Reminsting forKey:@"reminder"];

}
#pragma mark - 懒加载
-(UIScrollView *)ScrollView{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ScrollView.backgroundColor = MainbackgroundColor;
        _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, autoScaleW(2083));
    }
    return _ScrollView;
}
-(YLSinStoreView *)InStoreView{
    if (!_InStoreView) {
        _InStoreView = [[YLSinStoreView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 750)];
        _InStoreView.delagate = self;
    }
    return _InStoreView;
}
-(NSMutableDictionary *)StoreDataDict{
    if (!_StoreDataDict) {
        _StoreDataDict = [NSMutableDictionary dictionary];
    }
    return _StoreDataDict;
}
@end
