//
//  YLSEquipmentController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/19.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSEquipmentController.h"
#import "EquipmentCell.h"

@interface YLSEquipmentController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * EquipmentTableView;
@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (strong,nonatomic)UIView * unbindingView;
@property (strong,nonatomic)UILabel * unbindingLabel;
@property (strong,nonatomic)NSString    *unbindingID;
@property (strong,nonatomic)NSString    * machine_code;
@property (strong,nonatomic)MySwitch *Sound;

@end

@implementation YLSEquipmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"打印设备";
    
    [self PinterList];
    
    [self createUI];
    
}
#pragma mark - 获取列表
-(void)PinterList{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *Model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]pinter_list:Model.merchant_id andstore_id:Model.store_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
            NSDictionary *DIC = resDic[@"data"];
            [self.dataSource removeAllObjects];
            for (NSDictionary *dict in DIC) {
                [self.dataSource addObject:dict];
            }
            [self.EquipmentTableView reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.EquipmentTableView];
    [self.EquipmentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    
   
#pragma mark - 解绑提示
    UIView *unbindingView = [[UIView alloc] init];
    unbindingView.frame = CGRectMake(15,219.5,345,228);
    unbindingView.backgroundColor = [UIColor whiteColor];
    unbindingView.layer.cornerRadius = 6;
    [self.unbindingView addSubview:unbindingView];
    [unbindingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 228));
    }];
    
    UIView *LineView = [[UIView alloc] init];
    LineView.frame = CGRectMake(0,50,unbindingView.width,0.5);
    LineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [unbindingView addSubview:LineView];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(50,0,150,50);
    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"提示";
    [unbindingView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.size.mas_offset(CGSizeMake(150, 50));
        make.centerX.mas_offset(0);
    }];
    
    //叉号
    UIButton *queButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queButton.frame = CGRectMake(0, 0, 50, 50);
    [queButton setImage:[UIImage imageNamed:@"suspension_layer_btn_close_pressed"] forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(queAction) forControlEvents:UIControlEventTouchUpInside];
    [unbindingView addSubview:queButton];
   
    self.unbindingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 89, unbindingView.width-20, 60)];
    self.unbindingLabel.textColor = [UIColor blackColor];
    self.unbindingLabel.font = [UIFont systemFontOfSize:16];
    self.unbindingLabel.numberOfLines = 2;
    [unbindingView addSubview:self.unbindingLabel];
    [self.unbindingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(89);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
    }];
    
    UIButton *unbindingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [unbindingButton setTitle:@"确认" forState:UIControlStateNormal];
    [unbindingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    unbindingButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    unbindingButton.layer.cornerRadius = 10;
    [unbindingButton addTarget:self action:@selector(unbindingAction) forControlEvents:UIControlEventTouchUpInside];
    [unbindingView addSubview:unbindingButton];
    [unbindingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-40);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_offset(44);
    }];
    
    //conversion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"EquipmentList" object:nil];
}
#pragma mark - 添加成功返回
- (void)conversionAction: (NSNotification *) notification {
    [self PinterList];
    
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EquipmentCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.Data = self.dataSource[indexPath.row];
    YBWeakSelf
    cell.unbindingBlock = ^{
        self.unbindingLabel.text = [NSString stringWithFormat:@"确定要将“%@”从打印设备中解绑？",weakSelf.dataSource[indexPath.row][@"machine_name"]];
        self.unbindingID = [NSString stringWithFormat:@"%@",weakSelf.dataSource[indexPath.row][@"printer_id"]];
        self.machine_code = [NSString stringWithFormat:@"%@",weakSelf.dataSource[indexPath.row][@"machine_code"]];
        [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.unbindingView];
        
    };
    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 190;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 90;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    header_View.backgroundColor = UIColorFromRGB(0xF6F6F6);
    
    UIView *view_OFF = [[UIView alloc] init];
    view_OFF.frame = CGRectMake(15,15,ScreenW-30,50);
    view_OFF.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view_OFF.layer.cornerRadius = 5;
    [header_View addSubview:view_OFF];
    
    UILabel *label_OFF = [[UILabel alloc] init];
    label_OFF.frame = CGRectMake(10,0,150,50);
    label_OFF.numberOfLines = 0;
    label_OFF.text = @"设置为默认打印";
    label_OFF.font = [UIFont systemFontOfSize:15];
    [view_OFF addSubview:label_OFF];
    
    self.Sound = [[MySwitch alloc] initWithFrame:CGRectMake(view_OFF.width - 74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
        if(OnStatus){
            NSLog(@"打开");
            [PublicMethods writeToUserD:@"1" andKey:@"YunLanSound"];
        }else{
            NSLog(@"关闭");
            [PublicMethods writeToUserD:@"0" andKey:@"YunLanSound"];
        }
        [self OFF];
    }];
    
    /*判读开关滑动展示*/
    storeBaseModel *model = [storeBaseModel getUseData];

    NSString * isbluetooth = [PublicMethods readFromUserD:@"YunLanSound"];
    if ([model.choice_printer isEqualToString:@"1"]) {
        self.Sound.OnStatus = YES;
    }else if([model.choice_printer isEqualToString:@"0"]) {
        self.Sound.OnStatus = NO;
    }else{
        self.Sound.OnStatus = NO;
    }
    //设置背景图片
    [self.Sound setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
    [self.Sound setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
    [self.Sound setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
    [view_OFF addSubview:self.Sound];

    
    
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,view_OFF.bottom+15,header_View.width-30,86);
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [header_View addSubview:view];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(9.5,14.5,100,14);
    label.numberOfLines = 0;
    label.text = @"云打印设备";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];

    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(10,38,view.width,35);
    label1.numberOfLines = 0;
    label1.text = @"本页用于管理，通过网络连接用于打印订单小票的打印机设备。";
    label1.textColor = UIColorFromRGB(0x999999);
    label1.font = [UIFont systemFontOfSize:13];
    [view addSubview:label1];
    
    return header_View;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *Footer_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    Footer_View.backgroundColor = [UIColor clearColor];
    UIButton *Footer_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Footer_Button.frame = CGRectMake(15, 15, Footer_View.width-30, 60);
    Footer_Button.backgroundColor = [UIColor whiteColor];
    Footer_Button.layer.cornerRadius = 5;
    [Footer_Button setTitle:@"添加打印设备" forState:UIControlStateNormal];
    [Footer_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Footer_Button setImage:[UIImage imageNamed:@"icn_add_table_code_item"] forState:UIControlStateNormal];
    [Footer_Button addTarget:self action:@selector(AddFacilityAction) forControlEvents:UIControlEventTouchUpInside];
    [Footer_View addSubview:Footer_Button];
    return Footer_View;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLSAddFacilityController *VC = [YLSAddFacilityController new];
    VC.Data = self.dataSource[indexPath.row];
    VC.IsSwitch = YES;
    [self.navigationController pushViewController:VC animated:NO];

    
}
#pragma mark -添加打印设备
-(void)AddFacilityAction{
    YLSAddFacilityController *VC = [YLSAddFacilityController new];
    VC.IsSwitch = NO;
    [self.navigationController pushViewController:VC animated:NO];

}
#pragma mark - 解绑部分
-(void)queAction{
    [self.unbindingView removeFromSuperview];

}
-(void)unbindingAction{
    [self.unbindingView removeFromSuperview];

    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *Model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]unbinding_pinter:Model.merchant_id andstore_id:Model.store_id andprinter_id:self.unbindingID  andmachine_code:self.machine_code Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            [self PinterList];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
   
}
#pragma mark - 控制开关
-(void)OFF{
    /*判读外面打印开关*/
//    NSString * isbluetooth = [PublicMethods readFromUserD:@"isbluetooth"];
//    if ([isbluetooth isEqualToString:@"NO"]) {
//        /*关闭接口*/
//        [self shutdownRestart:@"0"];
//        return;
//    }
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
        [self shutdownRestart:@"0"];
    }else{
        /*关闭接口*/
        [self shutdownRestart:@"0"];
    }
    
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
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EquipmentList" object:nil];
    
}
#pragma mark - 懒加载
-(UITableView *)EquipmentTableView{
    if (!_EquipmentTableView) {
        _EquipmentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _EquipmentTableView.delegate = self;
        _EquipmentTableView.dataSource = self;
        _EquipmentTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _EquipmentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_EquipmentTableView registerClass:[EquipmentCell class] forCellReuseIdentifier:@"EquipmentCell"];
//
//        [_EquipmentTableView registerClass:[HotelOrderCell class] forCellReuseIdentifier:@"HotelOrderCell"];
//        [_EquipmentTableView registerClass:[TheHotelCell class] forCellReuseIdentifier:@"TheHotelCell"];
        _EquipmentTableView.customNoDataView = [UIView new];
        _EquipmentTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _EquipmentTableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(UIView *)unbindingView{
    if (!_unbindingView) {
        _unbindingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _unbindingView.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    }
    return _unbindingView;
}
@end
