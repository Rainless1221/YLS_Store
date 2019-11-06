//
//  FBHaccountController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/4.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//  账户的安全

#import "FBHaccountController.h"
#import "FBHupPassViewController.h"
#import "BingbangViewController.h"

@interface FBHaccountController ()
@property (weak, nonatomic) IBOutlet UILabel *discount_account;
@property (weak, nonatomic) IBOutlet UILabel *mobile;

@end

@implementation FBHaccountController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];

    [[FBHAppViewModel shareViewModel]get_merchant_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            self.discount_account.text = [NSString stringWithFormat:@"%@",DIC[@"discount_account"]];
            
            self.mobile.text = [NSString stringWithFormat:@"%@",DIC[@"mobile"]];
//            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户";
    [self merchant_center];

}
/**
 *  重置密码
 */
- (IBAction)ResetAction:(UIButton *)sender {
    FBHResetViewController *VC = [FBHResetViewController new];
    VC.isTonav = @"YES";
    [self.navigationController pushViewController:VC animated:NO];
}
/**
 *  提现密码
 */
- (IBAction)withdrawalAction:(UIButton *)sender {
    [self.navigationController pushViewController:[FBHupPassViewController new] animated:NO];

}
/**
 * 退出登录
 */
- (IBAction)NOLoginAciton:(UIButton *)sender {
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
                NSLog(@"删除别名成功");
            }
        } seq:1];
    }];
    
}
/**
 * 绑定手机
 */
- (IBAction)BingbangAction:(UIButton *)sender {
    [self.navigationController pushViewController:[BingYuanViewController new] animated:NO];

}




@end
