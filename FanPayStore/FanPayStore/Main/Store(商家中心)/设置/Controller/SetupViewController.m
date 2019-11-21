//
//  SetupViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//  设置中心

#import "SetupViewController.h"
#import "SetupView.h"
#import "SDImageCache.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SetupViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *cacheString;
}
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)SetupView * scrollView;
@property (strong,nonatomic)UITableView * SetUptable;
@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)MySwitch *bluetooth;
@property (strong,nonatomic)MySwitch *Sound;
@property (strong,nonatomic)MySwitch *HeSwitch;
@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    //获取缓存图片的大小(字节)
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
    
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    float MBCache = bytesCache/1000/1000;
    cacheString = [NSString stringWithFormat:@"%.2lfM",MBCache];
    
    NSArray *marArr = @[@[
                            @{@"icon":@"icn_msg_cnenter_system",
                              @"label":@"账户与安全",@"cellid":@"1"
                              },
                            ],
                        @[@{@"icon":@"icn_msg_cnenter_service",
                            @"label":@"经营类型",@"cellid":@"2"},
                          ],
                        @[@{@"icon":@"icn_msg_cnenter_service",
                            @"label":@"打印设备",@"cellid":@"22"},
                          ],
                        @[@{@"icon":@"icn_msg_cnenter_notice",
                            @"label":@"语音播报",@"cellid":@"3"},],
                        
                        @[@{@"icon":@"icn_msg_cnenter_notice",
                            @"label":@"打印开关",@"cellid":@"4"},],
                        @[@{@"icon":@"icn_msg_cnenter_notice",
                            @"label":@"自动核销",@"cellid":@"44"},],
                        @[
                            @{@"icon":@"icn_msg_cnenter_system",
                              @"label":@"常见问题与反馈",@"cellid":@"5"
                              },
                            @{@"icon":@"icn_msg_cnenter_service",
                              @"label":@"一鹿省用户协议",@"cellid":@"6"},
                            @{@"icon":@"icn_msg_cnenter_notice",
                              @"label":@"一鹿省隐私政策",@"cellid":@"7"},
                            @{@"icon":@"icn_msg_cnenter_notice",
                              @"label":@"关于一鹿省",@"cellid":@"8"},
                            @{@"icon":@"icn_msg_cnenter_notice",
                              @"label":@"清除缓存",@"cellid":@"9"},
                            ],
            
                        
                        ];
    
    for (NSDictionary *dict in marArr) {
        [self.Data addObject:dict];
        
    }
    
    [self get_store_auto_confirm_info];
    
    [self createUI];
    
    [self OFF];

}
#pragma mark - UI
-(void)createUI{
    
    
//    [self.view addSubview:self.SJScrollView];
//    [self.SJScrollView addSubview:self.scrollView];
//    [self.scrollView.cacheButton setTitle:cacheString forState:UIControlStateNormal];
    
    
    
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
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        case 5:
            return 1;
            break;
        case 6:
            return 5;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,0,cell.width-30,50);
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
    
#pragma mark -   /*语音播报*/
    if (indexPath.section == 3) {
       NSString * Sound = [PublicMethods readFromUserD:@"isShakeOpen"];
        
       self.Sound = [[MySwitch alloc] initWithFrame:CGRectMake(view.width - 74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
            if(OnStatus){
                NSLog(@"打开");
                [PublicMethods writeToUserD:@"YES" andKey:@"isShakeOpen"];
                self.isShakeOpen = YES;
//                [PublicMethods writeToUserD:@"YES" andKey:@"isSoundOpen"];
//                self.isSoundOpen = YES;
                NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.StoreAV"];
                [userDefault setObject:@"YES" forKey:@"isShakeOpen"];
                [userDefault synchronize];
                //震动下
                [self shakeText:nil];

            }else{
                NSLog(@"关闭");
                [PublicMethods writeToUserD:@"NO" andKey:@"isShakeOpen"];
                self.isShakeOpen = NO;
//                [PublicMethods writeToUserD:@"NO" andKey:@"isSoundOpen"];
//                self.isSoundOpen = NO;
                NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.StoreAV"];
                [userDefault setObject:@"NO" forKey:@"isShakeOpen"];
                [userDefault synchronize];
                
            }
        }];
        
        if ([Sound isEqualToString:@"NO"]) {
            self.Sound.OnStatus = NO;
        }else if([Sound isEqualToString:@"YES"]) {
            self.Sound.OnStatus = YES;
        }else{
            self.Sound.OnStatus = NO;
        }
        
        //设置背景图片
        [self.Sound setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
        [self.Sound setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.Sound setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        
        [view addSubview:self.Sound];
        
    }
  #pragma mark -/*打印开关*/
    if (indexPath.section == 4) {
        
        self.bluetooth = [[MySwitch alloc] initWithFrame:CGRectMake(view.width - 74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
            if(OnStatus){
                NSLog(@"开关 打开");

                [PublicMethods writeToUserD:@"YES" andKey:@"isbluetooth"];
                NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.StoreAV"];
                [userDefault setObject:@"YES" forKey:@"isbluetooth"];
                [userDefault synchronize];
                [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {

                    if (!error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                        });
                    }else{
                        
                    }
                    
                }];
                if (self.manage.stage != JWScanStageCharacteristics) {
                    //        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
//                    ReceiptsController *VC = [ReceiptsController new];
//                    VC.ReceiptsData = dict;
//                    [self.navigationController pushViewController:VC animated:NO];
//                    return;
                }
            }else{
                NSLog(@"开关  关闭");

                [PublicMethods writeToUserD:@"NO" andKey:@"isbluetooth"];
                NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.StoreAV"];
                [userDefault setObject:@"NO" forKey:@"isbluetooth"];
                [userDefault synchronize];
                [self.manage cancelPeripheralConnection:self.manage.connectedPerpheral];
                
            }
            
            /**
             控制开关
             */
            [self OFF];
        }];
        /*判读开关滑动展示*/
        NSString * isbluetooth = [PublicMethods readFromUserD:@"isbluetooth"];
        if ([isbluetooth isEqualToString:@"NO"]) {
            self.bluetooth.OnStatus = NO;
        }else if([isbluetooth isEqualToString:@"YES"]) {
            self.bluetooth.OnStatus = YES;

        }else{
            self.bluetooth.OnStatus = NO;
            [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
                
                if (!error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    });
                }else{
                    
                }
            }];
            
        }


        //设置背景图片
        [self.bluetooth setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
        [self.bluetooth setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.bluetooth setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        
        [view addSubview:self.bluetooth];
        
    }
#pragma mark - / *核销*/
    if (indexPath.section == 5) {
        self.HeSwitch = [[MySwitch alloc] initWithFrame:CGRectMake(view.width - 74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
            if(OnStatus){
                NSLog(@"打开");
                [self goodVerification:@"1"];
            }else{
                NSLog(@"关闭");
                [self goodVerification:@"0"];
            }
            
        }];
        /*判读开关滑动展示*/
        NSString * auto_confirm = [PublicMethods readFromUserD:@"auto_confirm"];
        if ([auto_confirm isEqualToString:@"NO"]) {
            self.HeSwitch.OnStatus = NO;
        }else if([auto_confirm isEqualToString:@"YES"]) {
            self.HeSwitch.OnStatus = YES;
            
        }else{
            self.HeSwitch.OnStatus = NO;
        }
        
        //设置背景图片
        [self.HeSwitch setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
        [self.HeSwitch setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.HeSwitch setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [view addSubview:self.HeSwitch];
        
    }
    /*缓存*/
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.numberOfLines = 0;
    label_1.font = [UIFont systemFontOfSize:16];
    label_1.textColor = UIColorFromRGB(0x222222);
    label_1.backgroundColor = [UIColor whiteColor];
    label_1.text = cacheString;
    if (indexPath.section == 6 && indexPath.row == 4) {
        [view addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_offset(0);
            make.right.mas_offset(-10);
        }];
    }
    
    /*横线*/
    if (indexPath.section == 6) {
        view.height = 55;
        if (indexPath.row == 4) {
            
        }else{
            UIView *line = [[UIView alloc] init];
            line.frame = CGRectMake(10,50,view.width-20,0.5);
            line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
            [view addSubview:line];
        }
    }
    
    return cell;
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 54;
    }else if (section == 4){
        return 54;
    }else if (section == 5){
        return 36;
    }else if (section == 6){
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
    if (section == 3) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(24,10,ScreenW-48,45);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"请保持手机音量开启，APP运行中或者后台运行中，否则可能 收不到语音提醒";
        [header_View addSubview:label];
        return header_View;
    }else if (section == 4){
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(24,10,ScreenW-48,54);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"请保持手机蓝牙开启，并连接订单的打印机，否则无法打印平 台订单";
        [header_View addSubview:label];
        return header_View;
    }else if (section == 5){
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(24,0,ScreenW-48,36);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"开启自动核销，订单会在6个小时后自动核销";
        [header_View addSubview:label];
        return header_View;
    }else if (section == 6){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 20, ScreenW-30, 44);
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
        button.backgroundColor = [UIColor colorWithRed:255/255.0 green:105/255.0 blue:105/255.0 alpha:1.0];
        button.layer.cornerRadius = 10;
        [button addTarget:self action:@selector(NOLoginAciton:) forControlEvents:UIControlEventTouchUpInside];
        [header_View addSubview:button];
        return header_View;;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[FBHaccountController new] animated:NO];
    }else if (indexPath.section == 1){
        [self.navigationController pushViewController:[ManagementTypesController new] animated:NO];
    }else if (indexPath.section == 2){
        [self.navigationController pushViewController:[YLSSheBeiController new] animated:NO];

    }else if (indexPath.section == 4){
//        ReceiptsController *VC = [ReceiptsController new];
//        [self.navigationController pushViewController:VC animated:NO];
        [self KAP];
    }else if (indexPath.section == 5){
     
    }else if (indexPath.section == 6 && indexPath.row == 0){
        [self.navigationController pushViewController:[FBHHelpViewController new] animated:NO];
    }else if (indexPath.section == 6 && indexPath.row == 1){
        /** Html 页面(用户协议) **/
        FBHinformationViewController *VC = [FBHinformationViewController new];
        VC.Navtitle = @"用户协议";
        VC.agreeUrl = FBHApi_HTML_yonghu;
        [self.navigationController pushViewController:VC animated:NO];
    }else if (indexPath.section == 6 && indexPath.row == 2){
        //隐私协议
        FBHinformationViewController *VC = [FBHinformationViewController new];
        VC.Navtitle = @"隐私协议";
        VC.agreeUrl = FBHApi_HTML_Yinsi;
        [self.navigationController pushViewController:VC animated:NO];
    }else if (indexPath.section == 6 && indexPath.row == 3){
        [self.navigationController pushViewController:[FBHGYViewController new] animated:NO];
    }else if (indexPath.section == 6 && indexPath.row == 4){
        [[WMZAlert shareInstance]showAlertWithType:AlertTypeSystemPush headTitle:@"清除缓存" textTitle:@"确定清除缓存?" leftHandle:^(id anyID) {
            //        取消按钮点击回调
        } rightHandle:^(id anyID) {
            //        确定按钮点击回调
            //清除缓存
            [self clearDiskOnCompletion];
        }];
    }
    
    
    
}
#pragma mark - 控制开关
-(void)OFF{
    /*判读外面打印开关*/
    NSString * isbluetooth = [PublicMethods readFromUserD:@"isbluetooth"];
    if ([isbluetooth isEqualToString:@"NO"]) {
        /*关闭接口*/
        [self shutdownRestart:@"2"];
        return;
    }
    /*判读开关滑动展示
     0 ：为关闭打印
     1 ：云打印
     2 :   蓝牙打印
     */
    NSString * YunLanSound = [PublicMethods readFromUserD:@"YunLanSound"];
    if ([YunLanSound isEqualToString:@"1"]) {
      /*打开接口*/
        [self shutdownRestart:@"1"];
    }else if([YunLanSound isEqualToString:@"2"]) {
         /*关闭接口*/
        [self shutdownRestart:@"2"];
    }else{
        /*打开接口*/
        [self shutdownRestart:@"1"];
    }
    
}
-(void)shutdownRestart:(NSString *)type{
    UserModel *Model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]shutdownRestart:Model.merchant_id andstore_id:Model.store_id andresponse_type:type Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
//            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];

        }else{
//            [SVProgressHUD setMinimumDismissTimeInterval:2];
//            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}
#pragma mark - 自动核销事件
-(void)goodVerification:(NSString *)auto_confirm{
    
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]set_store_auto_confirm:model.merchant_id andstore_id:model.store_id andauto_confirm:auto_confirm Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
           [self get_store_auto_confirm_info];
        }else{
            
        }
    } andfailure:^{
        
    }];
    
    
}
#pragma mark - 获取核销的状态
-(void)get_store_auto_confirm_info{
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_store_auto_confirm_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
             NSDictionary *DIC=resDic[@"data"];
            //1自动核销 0手动核销
            NSString *auto_confirm = [NSString stringWithFormat:@"%@",DIC[@"auto_confirm"]];
            if ([auto_confirm isEqualToString:@"1"]) {
                   [PublicMethods writeToUserD:@"YES" andKey:@"auto_confirm"];
            }else{
                   [PublicMethods writeToUserD:@"NO" andKey:@"auto_confirm"];
            }
            
        }else{
            
        }
    } andfailure:^{
        
    }];
    
}
#pragma mark - 清除缓存
-(void)clearDiskOnCompletion{
    //清除缓存
    //异步清除图片缓存 （磁盘中的）
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            //获取缓存图片的大小(字节)
            NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
            
            //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
            float MBCache = bytesCache/1000/1000;
            cacheString = [NSString stringWithFormat:@"%.2lfM",MBCache];
            [self.scrollView.cacheButton setTitle:cacheString forState:UIControlStateNormal];
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            
        }];
        [[SDImageCache sharedImageCache] clearMemory];
    });
    
}
#pragma mark -  退出登录
- (void)NOLoginAciton:(UIButton *)sender {
    
    [[WMZAlert shareInstance]showAlertWithType:AlertTypeSystemPush headTitle:@"退出登录" textTitle:@"确定退出登录?" leftHandle:^(id anyID) {
        //        取消按钮点击回调
        
    } rightHandle:^(id anyID) {
        //        确定按钮点击回调
        FBHLogInController *tabBarCtr = [[FBHLogInController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtr;
        [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
        [UserModel clearUserData];
        [insert_storeM clearUserData];
        [PublicMethods writeToUserD:@"" andKey:@"branch_type"];
        [[QYSDK sharedSDK] logout:^(BOOL success) {}];
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if (iResCode == 0) {
                
            }
        } seq:1];
    }];
    
    
}
#pragma mark -  切换服务器
- (void)KAP {
    
    /*判读开关滑动展示*/
    NSString * URL_addin = [PublicMethods readFromUserD:@"URL_addin"];
    NSString *tisi = [NSString new];
    NSString *isRUL = [NSString new];
    if ([URL_addin isEqualToString:@"1"]) {
        tisi = @"是否要切换正式服务器?";
        isRUL = @"0";
    }else{
        tisi = @"是否要切换测试服务器?";
        isRUL = @"1";
    }
    
    [[WMZAlert shareInstance]showAlertWithType:AlertTypeSystemPush headTitle:@"切换" textTitle:tisi leftHandle:^(id anyID) {
        //        取消按钮点击回调

    } rightHandle:^(id anyID) {
        //        确定按钮点击回调
        [PublicMethods writeToUserD:isRUL andKey:@"URL_addin"];

        FBHLogInController *tabBarCtr = [[FBHLogInController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtr;
        [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
        [UserModel clearUserData];
        [insert_storeM clearUserData];
        [PublicMethods writeToUserD:@"" andKey:@"branch_type"];
        [[QYSDK sharedSDK] logout:^(BOOL success) {}];
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if (iResCode == 0) {
                
            }
        } seq:1];
    }];
    
    
}
#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
//        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 720);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}
-(UITableView *)SetUptable{
    if (!_SetUptable) {
        _SetUptable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStyleGrouped];
        _SetUptable.delegate = self;
        _SetUptable.dataSource = self;
        _SetUptable.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SetUptable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_SetUptable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

        [_SetUptable registerClass:[HotelOrderCell class] forCellReuseIdentifier:@"HotelOrderCell"];
        [_SetUptable registerClass:[TheHotelCell class] forCellReuseIdentifier:@"TheHotelCell"];
        
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
