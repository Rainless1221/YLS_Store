//
//  FBHbankcardController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/4.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHbankcardController.h"
#import "bankcardYanViewController.h"

@interface FBHbankcardController ()<UITableViewDelegate,UITableViewDataSource>
//左按钮
@property(nonatomic,weak) UIButton *leftBtn;
//右按钮
@property(nonatomic,weak) UIButton *rightBtn;
//按钮横线
@property(nonatomic,weak) UIView *leftBottomLine;
/** 添加银行卡 **/
@property (weak, nonatomic) IBOutlet UIButton *AllCardButton;
/** 标示对公 Or 个人 **/
@property (assign,nonatomic)BOOL  isPublic;

@property (strong,nonatomic)NSMutableArray * Data;

@property (assign,nonatomic)NSInteger page;
@end

@implementation FBHbankcardController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self merchant_center];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的银行卡";
    [self createUI];
    [self setupSelectView];
    self.isPublic = NO;
    
    self.page = 1;
    [self merchant_center];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    NSString *Page = [NSString stringWithFormat:@"%ld",(long)self.page];
    //银行卡信息
    [[FBHAppViewModel shareViewModel]list_merchant_bank_card:model.merchant_id andpage:Page andlimit:@"50" Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"][@"bank_card_info"];
            Bank_infoModel *model=[Bank_infoModel mj_objectWithKeyValues:DIC];
            NSLog(@"银行卡信息 ：%@ ",model);
            
            [self.Data removeAllObjects];
            for (NSDictionary *dict in DIC) {
                [self.Data addObject:dict];
            }
            
            [self.tableView reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
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
    [leftBtn setTitle:@"个人" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [selectBgView addSubview:leftBtn];
    leftBtn.frame = CGRectMake(0, 0, Bwidth, 33);
    leftBtn.tag = 1;
    self.leftBtn = leftBtn;
    [self.leftBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    
    
    //右边按钮
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"对公账户" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [rightBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [selectBgView addSubview:rightBtn];
    rightBtn.frame =CGRectMake(leftBtn.right, 0, Bwidth, 33);
    rightBtn.tag = 2;
//    self.rightBtn = rightBtn;
    
    //左边底部横线
    UIView *leftBottomLine = [[UIView alloc]initWithFrame:CGRectMake(leftBtn.left+20, leftBtn.bottom, 20, 2)];
    leftBottomLine.centerX = leftBtn.centerX;
    leftBottomLine.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [leftBtn addSubview:leftBottomLine];
    
    self.leftBottomLine = leftBottomLine;
}
/**
 * 个人 or 对公账户
 */
-(void)clickLeftBtn:(UIButton *)sender{
    for (int i = 0; i<2; i++) {
        if (sender.tag == i+1) {
            self.leftBottomLine.centerX = sender.centerX;
            sender.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(18)];
            [sender setTitleColor:UIColorFromRGB(0x3d8aff) forState:UIControlStateNormal];
            continue;
        }
        UIButton *but = (UIButton *)[self.view viewWithTag:i+1];
        but.selected = NO;
        but.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(15)];
        [but setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
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
    self.AllCardButton.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
    self.tableView.frame  = CGRectMake(0, 50, ScreenW, ScreenH -50);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.allowsSelectionDuringEditing = YES;

    [self.tableView registerNib:[UINib nibWithNibName:@"bankcardTableViewCell" bundle:nil] forCellReuseIdentifier:@"bankcardTableViewCell"];

    
    [self.view addSubview:self.tableView];
    
    self.tableView.defaultNoDataText = @"";
    self.tableView.defaultNoDataImage = [UIImage imageNamed:@"no_order_tip"];
    self.tableView.backgroundView = [UIView new];
    self.tableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
        //        [self merchant_center:1];
    };

}
/** 上拉刷新 */
-(void)footerRereshing{
    self.page ++;
    [self merchant_center];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.Data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    bankcardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bankcardTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
//    cell.BankIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"Icon"]]];
//
//    cell.BankName.text = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"Name"]];
//
//    cell.BankInt.text = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"Int"]];
//
//    cell.Bankcard.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"card"]]];
    
    cell.Data = self.Data[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 110)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setImage:[UIImage imageNamed:@"ico_add_bankcard"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth =1;
    button.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    [button addTarget:self action:@selector(AllcardAction:) forControlEvents:UIControlEventTouchUpInside];
    [foooter addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(30);
        make.size.mas_offset(CGSizeMake(ScreenW-80, 44));
    }];
    return foooter;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /** 点击删除银行卡  **/
    NSString *cardid = self.Data[indexPath.row][@"card_id"];
    NSLog(@"银行卡ID %@",cardid);
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section) {

        }
        // 删除数据源的数据,self.cellData是你自己的数据
        NSString *cardid = self.Data[indexPath.row][@"card_id"];
        DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
        samView.deleteLabel.text = @"删除提醒";
        NSString *card_number = [NSString stringWithFormat:@"您是否对  %@  尾号%@的 储蓄卡 进行删除操作。",self.Data[indexPath.row][@"affiliated_bank_name"],self.Data[indexPath.row][@"card_number"]];
        samView.deleteText.text = card_number;

        samView.DeleteCardBlock = ^{
            [self DeleteAction:cardid];
            [self.Data removeObjectAtIndex:indexPath.row];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:samView];


    }

}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";//默认文字为 Delete
}
#pragma mark - 删除银行卡
-(void)DeleteAction:(NSString *)cardid{
    
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]delete_bank_card:model.merchant_id andcard_id:cardid Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {

            [self.tableView reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
}
#pragma mark - 添加银行卡
//- (IBAction)AllcardAction:(id)sender {
- (void)AllcardAction:(UIButton*)sender {

    if (self.isPublic == YES) {
        /** 对公 */
//        [self.navigationController pushViewController:[FBHAllpubliccardController new] animated:NO];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"此功能暂未开发"];
    }else{
        /** 个人 */
        [self.navigationController pushViewController:[bankcardYanViewController new] animated:NO];
    }
    
}

#pragma mark - Get
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
@end
