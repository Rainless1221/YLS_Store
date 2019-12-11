//
//  BindingPayController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//绑定支付宝

#import "BindingPayController.h"
#import "YLSAddPayViewController.h"
#import "PayTableViewCell.h"

@interface BindingPayController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * PayTableView;
@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表

@end

@implementation BindingPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付宝账号";
    [self list_merchant_alipay_account];
    [self createUI];

}
-(void)list_merchant_alipay_account{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]list_merchant_alipay_account:model.merchant_id  Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            
             NSDictionary *DIC = resDic[@"data"];
            [self.dataSource removeAllObjects];
           
            for (NSString *key in DIC) {
                 [self.dataSource addObject:DIC[key]];
            }
            [self.PayTableView reloadData];
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
    [self.view addSubview:self.PayTableView];
    [self.PayTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"alipay_account" object:nil];

}
- (void)conversionAction: (NSNotification *) notification {
    [self list_merchant_alipay_account];
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
//    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.Data = self.dataSource[indexPath.row];
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 92;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 90;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    header_View.backgroundColor = UIColorFromRGB(0xF6F6F6);
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,15,header_View.width-30,86);
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [header_View addSubview:view];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(9.5,14.5,view.width-20,14);
    label.numberOfLines = 0;
    label.text = @"绑定支付宝提现账号";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(10,38,view.width-10,35);
    label1.numberOfLines = 0;
    label1.text = @"添加支付宝账号用于提现通道，只有绑定过银行卡的用户才能绑定支付宝帐号。";
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
    [Footer_Button setTitle:@"  绑定支付宝账号" forState:UIControlStateNormal];
    [Footer_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Footer_Button setImage:[UIImage imageNamed:@"icn_add_table_code_item"] forState:UIControlStateNormal];
    [Footer_Button addTarget:self action:@selector(AddFacilityAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.dataSource.count>0) {
//        [Footer_View addSubview:Footer_Button];
    }else{
        [Footer_View addSubview:Footer_Button];
    }
    return Footer_View;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark -绑定支付宝账号
-(void)AddFacilityAction{
    [self.navigationController pushViewController:[YLSAddPayViewController new] animated:NO];

}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alipay_account" object:nil];
    
}
#pragma mark - 懒加载
-(UITableView *)PayTableView{
    if (!_PayTableView) {
        _PayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _PayTableView.delegate = self;
        _PayTableView.dataSource = self;
        _PayTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _PayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_PayTableView registerClass:[PayTableViewCell class] forCellReuseIdentifier:@"PayTableViewCell"];

        _PayTableView.customNoDataView = [UIView new];
        _PayTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _PayTableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
