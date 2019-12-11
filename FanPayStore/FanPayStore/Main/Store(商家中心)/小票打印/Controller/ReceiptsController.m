//
//  ReceiptsController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/11.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "ReceiptsController.h"
#import "ReceiptsTableViewCell.h"

@interface ReceiptsController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * ReceiptstableView;
@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic, strong) NSMutableArray * rssisArray; //信号强度 可选择性使用
@property (strong,nonatomic)MySwitch *Sound;

@end

@implementation ReceiptsController
//-(void)viewWillAppear:(BOOL)animated{
//    YBWeakSelf
//    [super viewWillAppear:animated];
//    [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
//        if (!error) {
//            [ProgressShow alertView:self.view Message:@"连接成功！" cb:nil];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.ReceiptstableView reloadData];
//            });
//        }else{
//            [ProgressShow alertView:weakSelf.view Message:error.domain cb:nil];
//        }
//    }];
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"蓝牙打印";

    self.dataSource = @[].mutableCopy;
    self.rssisArray = @[].mutableCopy;
    [self _createTableView];
    
    
    self.manage = [JWBluetoothManage sharedInstance];
    YBWeakSelf
    [self.manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        weakSelf.dataSource = [NSMutableArray arrayWithArray:peripherals];
        weakSelf.rssisArray = [NSMutableArray arrayWithArray:rssis];
        [weakSelf.ReceiptstableView reloadData];
    } failure:^(CBManagerState status) {
        [ProgressShow alertView:self.view Message:[ProgressShow getBluetoothErrorInfo:status] cb:nil];
    }];
    self.manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        NSLog(@"设备已经断开连接！");
//        weakSelf.title = @"蓝牙列表";
    };
    
    if (self.ReceiptsData.count>0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(printe)];

    }
    
    
}
#pragma mark - 打印
- (void)printe{
    if (self.manage.stage != JWScanStageCharacteristics) {
        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        return;
    }
    
    [self JWPrinter_Printer:self.ReceiptsData];
    
#pragma mark - 打印小票的样式排版
//    JWPrinter *printer = [[JWPrinter alloc] init];
//    UIImage *YLSimage = [UIImage imageNamed:@"xiaoPrinter"];
//    [printer appendImage:YLSimage alignment:HLTextAlignmentLeft maxWidth:300];
////    [printer appendQRCodeWithInfo:@"" centerImage:YLSimage alignment:HLTextAlignmentLeft maxWidth:120];
//
//
//    [printer appendText:@"商家订单小票" alignment:HLTextAlignmentLeft];
//
//    [printer appendSeperatorLine];
//    [printer appendNewLine];
//    [printer appendText:[NSString stringWithFormat:@"桌号：%@",self.ReceiptsData[@"order_status"]] alignment:HLTextAlignmentCenter fontSize:31];
//    [printer appendText:@"*大房子创意菜*" alignment:HLTextAlignmentCenter];
//    [printer appendSeperatorLine];
//    [printer appendText:[NSString stringWithFormat:@"序号：#%@   人数：%@",self.ReceiptsData[@"people_count"],self.ReceiptsData[@"people_count"]] alignment:HLTextAlignmentCenter fontSize:15];
//    //    [printer appendText:@"--------------------------------" alignment:HLTextAlignmentCenter];
//    [printer appendText:[NSString stringWithFormat:@"下单时间：%@",self.ReceiptsData[@"add_time"]] alignment:HLTextAlignmentCenter];
//    [printer appendText:@"*******************************" alignment:HLTextAlignmentCenter];
//
//    [printer appendText:@"-----------订单信息-----------" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
//
//    [printer appendLeftText:@"名称" middleText:@"单价" rightText:@"数量" isTitle:YES];
//    NSArray *goodsArr = self.ReceiptsData[@"goods_info"];
//    for (int i =0; i<goodsArr.count; i++) {
//
//        NSString *name = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
//        NSString *price = [NSString stringWithFormat:@"%@ ",goodsArr[i][@"goods_price"]];
//        NSString *num =  [NSString stringWithFormat:@" *%@",goodsArr[i][@"goods_num"]];
//        //        [printer appendTitle:name value:price];
//        //        [printer appendLeftText:name middleText:price rightText: [NSString stringWithFormat:@" *%@",goodsArr[i][@"goods_num"]] isTitle:NO];
//
//        [printer YLSappendLeftText:name  alignment:HLTextAlignmentLeft fontSize:20 isTitle:NO];        [printer setOffset:180];
//        [printer YLSappendLeftText:price  alignment:HLTextAlignmentLeft fontSize:8 isTitle:NO];          [printer setOffset:320 ];
//        [printer YLSappendLeftText:num alignment:HLTextAlignmentLeft  fontSize:8 isTitle:YES];
//    }
//
//    [printer appendNewLine];
//    //    [printer appendText:@"------------------------------------------" alignment:HLTextAlignmentCenter];
//    [printer appendSeperatorLine];
//    [printer appendTitle:@"服务费用：" value:self.ReceiptsData[@"service_money"]];
//    [printer appendTitle:@"本单节省：" value:self.ReceiptsData[@"save_money"]];
//    [printer appendTitle:@"用户实付：" value:[NSString stringWithFormat:@"%@元",self.ReceiptsData[@"actual_money"]]];
//    [printer appendSeperatorLine];
//    //    [printer appendText:@"------------------------------------------" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
//
//    double i = [self.ReceiptsData[@"actual_money"] doubleValue];
//    double j = [self.ReceiptsData[@"service_money"] doubleValue];
//    double qian = i - j;
////    [printer appendTitle:@"商家实收：" value:[NSString stringWithFormat:@"%.2f元",qian]];
//    [printer YLSappendLeftText:@"商家实收："  alignment:HLTextAlignmentLeft fontSize:10 isTitle:NO]; [printer setOffset:300 ];
//    [printer YLSappendLeftText:[NSString stringWithFormat:@"%.2f元",qian]  alignment:HLTextAlignmentRight fontSize:20 isTitle:YES];
//
//    //    [printer appendText:@"------------------------------------------" alignment:HLTextAlignmentCenter];
//    [printer appendSeperatorLine];
//    [printer appendText:[NSString stringWithFormat:@"备注：%@",self.ReceiptsData[@"remark"]] alignment:HLTextAlignmentLeft fontSize:15];
//    [printer appendText:@"*******************************" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
//    [printer appendText:@"-----------其他信息-----------" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
//
//
//
//    //    [printer appendTitle:@"消费地址：" value:dict[@"store_address"]];
//    [printer appendText:[NSString stringWithFormat:@"消费地址：%@",self.ReceiptsData[@"store_address"]] alignment:HLTextAlignmentLeft];
//
//    NSString *phon = [NSString stringWithFormat:@"%@",self.ReceiptsData[@"user_info"][@"mobile"]];
//    NSString *string =[phon stringByReplacingOccurrencesOfString:[phon substringWithRange:NSMakeRange(3,4)]withString:@"****"];
////    NSString *UserString = [NSString stringWithFormat:@"%@(%@)%@",self.ReceiptsData[@"user_info"][@"user_name"],self.ReceiptsData[@"user_info"][@"sex"],string];
//    //    [printer appendTitle:@"用户信息：" value:UserString];
//    [printer appendText:[NSString stringWithFormat:@"用户信息：%@(%@)",self.ReceiptsData[@"user_info"][@"user_name"],self.ReceiptsData[@"user_info"][@"sex"]] alignment:HLTextAlignmentLeft];
//    [printer appendText:[NSString stringWithFormat:@"用户号码：%@",string] alignment:HLTextAlignmentLeft];
//
//    //    [printer appendTitle:@"订单编号：" value:dict[@"order_sn"]];
//    [printer appendText:[NSString stringWithFormat:@"订单编号：%@",self.ReceiptsData[@"order_sn"]] alignment:HLTextAlignmentLeft];
//
//    NSString *paid = [NSString new];
//    NSString *pid = [NSString stringWithFormat:@"%@",self.ReceiptsData[@"paid_type"]];
//
//    if ([pid isEqualToString:@"4"]) {
//        paid = @"余额支付";
//
//    }else if ([pid isEqualToString:@"1"]){
//        paid = @"支付宝支付";
//
//    }else if ([pid isEqualToString:@"2"]){
//        paid = @"微信支付";
//
//    }else{
//        paid = @"银行卡快捷支付";
//
//    }
//    //    [printer appendTitle:@"交易类型：" value:paid];
//    [printer appendText:[NSString stringWithFormat:@"交易类型：%@",paid] alignment:HLTextAlignmentLeft];
//
//    //    [printer appendTitle:@"交易时间：" value:dict[@"add_time"]];
//    //    [printer appendText:[NSString stringWithFormat:@"交易时间：%@",dict[@"add_time"]] alignment:HLTextAlignmentLeft];
//
//
//    [printer appendSeperatorLine];
//    [printer appendNewLine];
//    [printer appendText:@"感谢使用一鹿省，祝您生活愉快!\n下载一鹿省app全国走到哪省到哪" alignment:HLTextAlignmentCenter fontSize:5];
////    [printer appendText:@"下载一鹿省app全国走到哪省到哪" alignment:HLTextAlignmentCenter fontSize:8];
//    [printer appendNewLine];
//
//
//
//
//    NSData *mainData = [printer getFinalData];
//    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
//        if (completion) {
//            NSLog(@"打印成功");
//        }else{
//            NSLog(@"写入错误---:%@",error);
//        }
//    }];
}
#pragma mark tableview medthod
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    ReceiptsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ReceiptsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

//    CBPeripheral *peripherral = [self.dataSource objectAtIndex:indexPath.row];
//    if (peripherral.state == CBPeripheralStateConnected) {
//        //链接
////        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        //未链接
////        cell.accessoryType = UITableViewCellAccessoryNone;
//
//    }
    cell.receData = [self.dataSource objectAtIndex:indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"名称:%@",peripherral.name];
//    NSNumber * rssis = self.rssisArray[indexPath.row];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"强度:%@",rssis];
//    cell.ReceName.text = [NSString stringWithFormat:@"%@",peripherral.name];
//    cell.ReceType.text = [NSString stringWithFormat:@"强度:%@",rssis];
    [MBProgressHUD hideHUD];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 186;
}
#pragma mark -  列表头部
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 111)];
    HeaderView.backgroundColor = [UIColor clearColor];
    
    
    UIView *view_OFF = [[UIView alloc] init];
    view_OFF.frame = CGRectMake(0,15,HeaderView.width-30,50);
    view_OFF.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view_OFF.layer.cornerRadius = 5;
    [HeaderView addSubview:view_OFF];
    [view_OFF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_offset(0);
        make.top.mas_offset(15);
        make.height.mas_offset(50);
    }];
    
    UILabel *label_OFF = [[UILabel alloc] init];
    label_OFF.frame = CGRectMake(10,0,150,50);
    label_OFF.numberOfLines = 0;
    label_OFF.text = @"设置为默认打印";
    label_OFF.font = [UIFont systemFontOfSize:15];
    [view_OFF addSubview:label_OFF];
    
    self.Sound = [[MySwitch alloc] initWithFrame:CGRectMake(view_OFF.width - 74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
        if(OnStatus){
            NSLog(@"打开");
            [PublicMethods writeToUserD:@"2" andKey:@"YunLanSound"];
            /*打开接口*/
            [self shutdownRestart:@"2"];
        }else{
            NSLog(@"关闭");
            [PublicMethods writeToUserD:@"0" andKey:@"YunLanSound"];
            [self shutdownRestart:@"0"];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YunLanSound" object:nil];

    }];
    /*判读开关滑动展示*/
//    NSString * isbluetooth = [PublicMethods readFromUserD:@"YunLanSound"];
//    if ([isbluetooth isEqualToString:@"2"]) {
//        self.Sound.OnStatus = YES;
//    }else if([isbluetooth isEqualToString:@"0"]) {
//        self.Sound.OnStatus = NO;
//    }else{
//        self.Sound.OnStatus = NO;
//
//    }
    
     storeBaseModel *model = [storeBaseModel getUseData];
    if ([model.choice_printer isEqualToString:@"2"]) {
        self.Sound.OnStatus = YES;
    }else if([model.choice_printer isEqualToString:@"1"]) {
        self.Sound.OnStatus = NO;
    }else{
        self.Sound.OnStatus = NO;
    }
    //设置背景图片
    [self.Sound setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
    [self.Sound setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
    [self.Sound setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
    [view_OFF addSubview:self.Sound];

    
    UILabel *label_rece = [[UILabel alloc] init];
    label_rece.numberOfLines = 0;
    label_rece.text = @"蓝牙设备";
    label_rece.font = [UIFont systemFontOfSize:12];
    label_rece.textColor = UIColorFromRGB(0x333333);
    [HeaderView addSubview:label_rece];
    [label_rece mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(46);
    }];
    
    //搜索蓝牙按钮
    UIButton *view_button = [UIButton buttonWithType:UIButtonTypeCustom];
    view_button.frame = CGRectMake(15,view_OFF.bottom+15,345,50);
    view_button.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view_button.layer.cornerRadius = 5;
    [view_button setTitle:@"搜索蓝牙设备" forState:UIControlStateNormal];
    [view_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    view_button.titleLabel.font = [UIFont systemFontOfSize:15];
    [view_button addTarget:self action:@selector(ReceActuion) forControlEvents:UIControlEventTouchUpInside];
    [HeaderView addSubview:view_button];
    [view_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_offset(0);
        make.top.equalTo(view_OFF.mas_bottom).offset(15);
        make.height.mas_offset(50);
    }];
    return HeaderView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    CBPeripheral *peripheral = [self.dataSource objectAtIndex:indexPath.row];
    [MBProgressHUD MBProgress:@"连接蓝牙中..."];

    [self.manage connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
        
        if (!error) {
            [ProgressShow alertView:self.view Message:@"连接成功！" cb:nil];
//            self.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView reloadData];
            });

        }else{

            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
        [MBProgressHUD hideHUD];

    }];
//    [MBProgressHUD hideHUD];

}

#pragma mark - 搜索蓝牙
-(void)ReceActuion{
    [MBProgressHUD MBProgress:@"搜索蓝牙中..."];
     self.manage = [JWBluetoothManage sharedInstance];
    YBWeakSelf
    [self.manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        [weakSelf.dataSource removeAllObjects];
        [weakSelf.rssisArray removeAllObjects];

        weakSelf.dataSource = [NSMutableArray arrayWithArray:peripherals];
        weakSelf.rssisArray = [NSMutableArray arrayWithArray:rssis];
        [weakSelf.ReceiptstableView reloadData];
        [MBProgressHUD hideHUD];

    } failure:^(CBManagerState status) {
        [MBProgressHUD hideHUD];

        [ProgressShow alertView:self.view Message:[ProgressShow getBluetoothErrorInfo:status] cb:nil];
    }];
    
    
}
#pragma mark - 开关
-(void)shutdownRestart:(NSString *)type{
    UserModel *Model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]store_printer_choice:Model.merchant_id andstore_id:Model.store_id andchoice_printer:type Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];

        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"business_center" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YunLanSound" object:nil];

}
#pragma mark - UI
- (void) _createTableView{
    if (!_ReceiptstableView) {
        _ReceiptstableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 0, self.view.frame.size.width-30, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _ReceiptstableView.delegate = self;
        _ReceiptstableView.dataSource = self;
        _ReceiptstableView.layer.cornerRadius = 10;
        _ReceiptstableView.backgroundColor = [UIColor clearColor];
        _ReceiptstableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ReceiptstableView.tableFooterView = [UIView new];
//        if ([_ReceiptstableView respondsToSelector:@selector(setSeparatorInset:)]) {
//            [_ReceiptstableView setSeparatorInset:UIEdgeInsetsZero];
//        }
//        if ([_ReceiptstableView respondsToSelector:@selector(setLayoutMargins:)]) {
//            [_ReceiptstableView setLayoutMargins:UIEdgeInsetsZero];
//        }
    }
    if (![self.view.subviews containsObject:_ReceiptstableView]) {
        [self.view addSubview:_ReceiptstableView];
    }else{
        [_ReceiptstableView reloadData];
    }
}
@end
