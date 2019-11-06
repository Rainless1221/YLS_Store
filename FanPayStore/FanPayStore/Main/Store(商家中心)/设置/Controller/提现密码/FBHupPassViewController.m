//
//  FBHupPassViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//  提现密码

#import "FBHupPassViewController.h"
#import "Payment_passwordViewController.h"
#import "PaymentViewController.h"

@interface FBHupPassViewController ()

@end

@implementation FBHupPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现密码";
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    
}

#pragma mark - 修改

- (IBAction)Action:(UIButton *)sender {
    
    Payment_passwordViewController *VC =[Payment_passwordViewController new];

    /** 首次设置 */
//    VC.Passpage = 0;
//    VC.Navtitle = @"设置提现密码";
//    VC.prompt = @"请设置提现密码，用于提现验证";
//    VC.prompt1 = @"不能是登录密码或连续数字";
    
    /** 修改 */
    VC.Passpage = 1;
    VC.Navtitle = @"修改提现密码";
    VC.prompt = @"请输入提现密码";
    
    [self.navigationController pushViewController:VC animated:NO];
    
}
#pragma mark - 找回

- (IBAction)zhaoAction:(UIButton *)sender {
    PaymentViewController *VC =[PaymentViewController new];
//    VC.Passpage = 3;
//    VC.Navtitle = @"重置提现密码";
//    VC.prompt = @"请设置新提现密码，用于提现验证";
//    VC.prompt1 = @"不能是登录密码或连续数字";
    [self.navigationController pushViewController:VC animated:NO];

}















@end
