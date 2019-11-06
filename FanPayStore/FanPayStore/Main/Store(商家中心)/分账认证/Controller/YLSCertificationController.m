//
//  YLSCertificationController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/22.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSCertificationController.h"

@interface YLSCertificationController ()<UITableViewDelegate,UITableViewDataSource>
//按钮横线
@property(nonatomic,strong) UIView *leftBottomLine;
@property (strong,nonatomic)UITableView * CertifiTableview;
@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)NSMutableArray * Data1;
/** 标示对公 Or 个人 **/
@property (assign,nonatomic)BOOL  isPublic;
@end

@implementation YLSCertificationController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分账认证";
    [self createUI];

    [self setupSelectView];
    
    [self Get_bank_card_info];
    
}
#pragma mark - 请求
-(void)Get_bank_card_info{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
//    [[FBHAppViewModel shareViewModel]get_bank_card_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
//        if ([resDic[@"status"] integerValue]==1){
//            NSDictionary *DIC = resDic[@"data"][@"bank_card_info"];
//
//            [self.Data removeAllObjects];
////            for (NSDictionary *dict in DIC) {
////                [self.Data addObject:dict];
////            }
//            [self.Data addObject:DIC];
//            [self.CertifiTableview reloadData];
//
//        }else{
//            [SVProgressHUD setMinimumDismissTimeInterval:2];
//            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
//        }
//        [MBProgressHUD hideHUD];
//
//    } andfailure:^{
//        [MBProgressHUD hideHUD];
//
//    }];
    
    [[FBHAppViewModel shareViewModel]list_bank_card_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
             NSDictionary *DIC = resDic[@"data"][@"account_info"];
             [self.Data1 removeAllObjects];
             [self.Data1 addObject:DIC];
             [self.CertifiTableview reloadData];
        }else{
            
        }
         [MBProgressHUD hideHUD];
    } andfailure:^{
         [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark - 选择栏
-(void)setupSelectView{
    CGFloat Bwidth = ScreenW/4;
    UIView *selectBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    selectBgView.backgroundColor = [UIColor whiteColor];
    selectBgView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影偏移量
    selectBgView.layer.shadowOffset = CGSizeMake(0,0);
    // 设置阴影透明度
    selectBgView.layer.shadowOpacity = 0.8;
    // 设置阴影半径
    selectBgView.layer.shadowRadius = 5;
    selectBgView.clipsToBounds = NO;
    [self.view addSubview:selectBgView];
    
    //左边按钮
    UIButton *leftBtn = [[UIButton alloc]init];
    [leftBtn setTitle:@"私人账户" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
    [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, Bwidth, 48);
    leftBtn.tag = 1;
    [selectBgView addSubview:leftBtn];
    leftBtn.selected = YES;

    
    
    //右边按钮
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"对公账户" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [rightBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
    rightBtn.frame =CGRectMake(leftBtn.right, 0, Bwidth, 48);
    rightBtn.tag = 2;
    [selectBgView addSubview:rightBtn];
  
    
    //左边底部横线
   self.leftBottomLine = [[UIView alloc]initWithFrame:CGRectMake(leftBtn.left+20, leftBtn.bottom, 20, 2)];
    self.leftBottomLine.centerX = leftBtn.centerX;
    self.leftBottomLine.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [leftBtn addSubview:self.leftBottomLine];
    
}
/**
 * 个人 or 对公账户
 */
-(void)clickLeftBtn:(UIButton *)sender{
    for (int i = 0; i<2; i++) {
        if (sender.tag == i+1) {
            self.leftBottomLine.centerX = sender.centerX;
            sender.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(18)];
             sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self.view viewWithTag:i+1];
        but.selected = NO;
        but.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(15)];
    }
    if (sender.tag == 1) {
        /**
         * 个人
         * 1、切换列表
         * 2、标示类型，点击添加银行卡时，跳转到个人添加
         */
        
        //步骤 1
        
        
        //步骤 2
        self.isPublic = NO;
        
    }else if (sender.tag == 2){
        /**
         * 对公账户
         * 1、切换列表
         * 2、标示类型，点击添加银行卡时，跳转到对公添加
         */
        
        
        //步骤 1
        
        //步骤 2
        self.isPublic = YES;
        
    }else{
        
    }
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.CertifiTableview];
    [self.CertifiTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.right.bottom.mas_offset(0);
    }];
    
    //conversion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"CertifiList" object:nil];
    
}
#pragma mark - 添加成功返回
- (void)conversionAction: (NSNotification *) notification {
    
//    NSString *url = [NSString stringWithFormat:@"%@",notification.object];
//    FBHinformationViewController *VC = [FBHinformationViewController new];
//    VC.Navtitle = @"短信认证";
//    VC.agreeUrl = url;
//    [self.navigationController pushViewController:VC animated:NO];
    
    [self Get_bank_card_info];
    
    
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Data1.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    bankcardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bankcardTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
//    cell.RData = self.Data[indexPath.row];
    cell.BData = self.Data1[indexPath.row];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    foooter.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"注册账户" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setImage:[UIImage imageNamed:@"ico_add_bankcard"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth =1;
    button.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    [button addTarget:self action:@selector(AllcardAction:) forControlEvents:UIControlEventTouchUpInside];
    [foooter addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
//        make.top.mas_offset(30);
        make.size.mas_offset(CGSizeMake(ScreenW-80, 44));
    }];
    return foooter;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /** 点击删除银行卡  **/
//    NSString *cardid = self.Data1[indexPath.row][@"card_id"];
//    NSLog(@"银行卡ID %@",cardid);
}

#pragma mark - 注册账户
- (void)AllcardAction:(UIButton*)sender{
    
    if (self.isPublic == YES) {
        /** 对公 */
        [self.navigationController pushViewController:[YLSAddDuiGongCertification new] animated:NO];
//        [SVProgressHUD setMinimumDismissTimeInterval:1];
//        [SVProgressHUD showErrorWithStatus:@"此功能暂未开发"];
    }else{
        /** 个人 */
        [self.navigationController pushViewController:[YLSAddCertification new] animated:NO];
//        FBHinformationViewController *VC = [FBHinformationViewController new];
//        VC.Navtitle = @"短信认证";
//        VC.agreeUrl = @"http://www.baidu.com";
//        [self.navigationController pushViewController:VC animated:NO];
        
    }
    
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CertifiList" object:nil];
}
#pragma mark - 懒加载
-(UITableView *)CertifiTableview{
    if (!_CertifiTableview) {
        _CertifiTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _CertifiTableview.delegate = self;
        _CertifiTableview.dataSource = self;
        _CertifiTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _CertifiTableview.allowsSelectionDuringEditing = YES;
        
        [_CertifiTableview registerNib:[UINib nibWithNibName:@"bankcardTableViewCell" bundle:nil] forCellReuseIdentifier:@"bankcardTableViewCell"];
    }
    return _CertifiTableview;
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
@end
