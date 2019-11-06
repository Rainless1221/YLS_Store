//
//  SetupView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/6.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "SetupView.h"

@implementation SetupView
/**
 退出登录
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

        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if (iResCode == 0) {

            }
        } seq:1];
    }];
    
    
}

//账号与安全
- (IBAction)accountAction:(id)sender {
    if (self.accountblock) {
        self.accountblock();
    }
}
//  经营类型
- (IBAction)RunAction:(id)sender {
    if (self.Runblock) {
        self.Runblock();
    }
}
//关于翻倍花
- (IBAction)GuanyuAction:(id)sender {
    if (self.Guanyublock) {
        self.Guanyublock();
    }
}
//常见问题or 用户协议 or 隐私 or清除缓存
- (IBAction)HelpAction:(UIButton *)sender {
    if (self.HelpBlock) {
        self.HelpBlock(sender);
    }
}
//打印机管理
- (IBAction)PAction:(UIButton *)sender {
    
    if (self.PBlock) {
        self.PBlock(sender);
    }
}

/*声音*/
- (IBAction)sound:(UISwitch *)sender {
    if (self.soundText) {
        self.soundText(sender);
    }
}
/*震动*/
- (IBAction)shake:(UISwitch *)sender {
    if (self.shakeText) {
        self.shakeText(sender);
    }
}

@end
