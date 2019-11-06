//
//  FBHHelpViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/11.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//  

#import "FBHHelpViewController.h"
#import "QYSDK.h"

@interface FBHHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *OnlineButton;
@property (weak, nonatomic) IBOutlet UIButton *PhoneButton;
@property (weak, nonatomic) IBOutlet UIView *HelpView;

@property (strong,nonatomic)NSMutableArray  * Data;
@property (assign,nonatomic)NSInteger page;
@end

@implementation FBHHelpViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助与客服";
    self.HelpView.height = autoScaleW(328);
    [self createUI];
    self.page = 1;
    [self merchant_center];

}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    NSDictionary *Dict = @{
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                           @"limit":@"50"
                           };
    
    [[FBHAppViewModel shareViewModel]list_common_problem:model.merchant_id andproblem:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"][@"problem_info"];
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
#pragma mark - 问题详情
-(void)HelpDetail:(NSString *)problemID{
    UserModel *model = [UserModel getUseData];
    //问题详情
    [[FBHAppViewModel shareViewModel]detail_common_problem:model.merchant_id andproblem_id:problemID Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
//            NSDictionary *DIC=resDic[@"data"];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}
#pragma mark - UI
-(void)createUI{
    self.OnlineButton.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    self.PhoneButton.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;

    /** 列表 **/
    self.tableView.frame = CGRectMake(0, 50, self.HelpView.width, self.HelpView.height - 90);
    [self.tableView registerNib:[UINib nibWithNibName:@"HelpTableViewCell" bundle:nil] forCellReuseIdentifier:@"HelpTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    [self.HelpView addSubview:self.tableView];
    
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
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HelpTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    cell.helpLabel.text = [NSString stringWithFormat:@"@%@",self.Data[indexPath.row][@"question"]];
    //
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *idString = [NSString stringWithFormat:@"@%@",self.Data[indexPath.row][@"problem_id"]];
    /**
     * 点击跳转到详情界面
     * 1、传问题ID过去
     * 2、到公共的web界面
     * 3、或者是请求后展示文本
     **/
    [self HelpDetail:idString];
}

/** 在线客服 **/
- (IBAction)onlineAction:(id)sender {
//    FBHinformationViewController *VC = [FBHinformationViewController new];
//    VC.Navtitle = @"在线客服";
//    VC.agreeUrl = FBHApi_HTML_kefu;
//    [self.navigationController pushViewController:VC animated:NO];
    
    QYSource *source = [[QYSource alloc] init];
    source.title = @"一鹿省客服";
    source.urlString = @"https://qiyukf.com/";
    storeBaseModel *model = [storeBaseModel getUseData];
    [QYCustomUIConfig sharedInstance].customerHeadImageUrl =  [NSString stringWithFormat:@"%@",model.store_logo];
    
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"一鹿省客服";
    sessionViewController.source = source;
    sessionViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sessionViewController animated:YES];
}
/** 拨打电话  */
- (IBAction)phoneAction:(id)sender {
    /** 弹出选择是否确定要拨打电话 */
    NSString *telephoneNumber=@"400-181-9111";
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:str];
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
            NSLog(@"OpenSuccess=%d",success);
            
        }];
    } else {
        // Fallback on earlier versions
    }
    
}
/** 换一换（刷新下） **/
- (IBAction)refreshAction:(id)sender {
    [self footerRereshing];
}

#pragma mark - GET
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
@end
