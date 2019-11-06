//
//  FBHWithdrawJLViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/26.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHWithdrawJLViewController.h"
#import "WithdrawJLCell.h"

@interface FBHWithdrawJLViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * WithdrawTableview;
/** 记录数据 **/
@property (strong,nonatomic)NSMutableArray * Data;
/** 分页 */
@property (assign,nonatomic)NSInteger page;
@end

@implementation FBHWithdrawJLViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.page = 1;
    [self merchant_center];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_withdrawals_log:model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            [self.Data removeAllObjects];
            for (NSDictionary *dict in DIC[@"withdrawals_log"]) {
                [self.Data addObject:dict];
            }
            [self.WithdrawTableview reloadData];
            [MBProgressHUD hideHUD];

        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            [MBProgressHUD hideHUD];
        }
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现记录";
    /**
     * UI
     */
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    self.WithdrawTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-44) style:UITableViewStyleGrouped];
    [self.WithdrawTableview registerNib:[UINib nibWithNibName:@"WithdrawJLCell" bundle:nil] forCellReuseIdentifier:@"WithdrawJLCell"];
    self.WithdrawTableview.delegate =  self;
    self.WithdrawTableview.dataSource = self;
    self.WithdrawTableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.WithdrawTableview];
    [self.WithdrawTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    self.WithdrawTableview.separatorStyle = NO;
    
    self.WithdrawTableview.defaultNoDataText = @"";
    self.WithdrawTableview.defaultNoDataImage = [UIImage imageNamed:@"no_order_tip"];
    self.WithdrawTableview.backgroundView = [UIView new];
    self.WithdrawTableview.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
//        [self merchant_center:1];
    };
    /** 底部刷新 **/
    self.WithdrawTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    self.WithdrawTableview.mj_footer.ignoredScrollViewContentInsetBottom = 30;

}
-(void)footerRereshing{
    
    [self merchant_center];
    [self.WithdrawTableview.mj_footer endRefreshing];
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WithdrawJLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WithdrawJLCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.Data = self.Data[indexPath.row];
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]init];
    return headerV;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *footer = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 52)];
    footer.text = @"如有疑问，可与客服微信号 @fanbeihua 联系或者留言";
    footer.textColor = UIColorFromRGB(0x999999);
    footer.textAlignment = 1;
    footer.font = [UIFont systemFontOfSize:12];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 52;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - GET
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
@end
