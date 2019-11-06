//
//  FBHRevenuedetailsController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHRevenuedetailsController.h"

@interface FBHRevenuedetailsController ()
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)RevenuedetailsView * scrollView;
@end

@implementation FBHRevenuedetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"营收记录";
    [self createUI];
    [self merchant_center];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    //1为收入 如用户消费付款 2为支出 如提现
    UserModel *model = [UserModel getUseData];
    NSDictionary *Dict = @{
                           @"log_id":[NSString stringWithFormat:@"%@",self.log_id],
                           @"type":[NSString stringWithFormat:@"%@",self.log_type],
                           };
    
    [[FBHAppViewModel shareViewModel]get_checkstand_revenue:model.merchant_id andstore_id:model.store_id andlistDict:Dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            self.scrollView.Data =DIC[@"consumption_info"];
        }else{
            
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
    
    
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
//    self.scrollView.Data = @{@"isor":@"1"};
}

#pragma mark - GET
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 700);
    }
    return _SJScrollView;
}
-(RevenuedetailsView *)scrollView{
    if (!_scrollView) {
        _scrollView =[[ RevenuedetailsView alloc]initWithFrame:CGRectMake(15, 10, ScreenW-30, 350)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.layer.cornerRadius = 5;
        
    }
    return _scrollView;
}

@end
