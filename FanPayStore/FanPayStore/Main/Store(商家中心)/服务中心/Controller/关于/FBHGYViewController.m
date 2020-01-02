//
//  FBHGYViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/4.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHGYViewController.h"

@interface FBHGYViewController ()
/** 版本号 */
@property (weak, nonatomic) IBOutlet UILabel *banben;
/** 检查最新版本 */
@property (weak, nonatomic) IBOutlet UIButton *versionButton;
/** 用户协议 */

@end

@implementation FBHGYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于一鹿省";
    [self.versionButton setTitleColor:UIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
    
    [self lookup];
    
}

#pragma mark - 获取当前版本信息
- (IBAction)VersionAction:(UIButton *)sender {

    UserModel *model=[UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_mer_version_info:model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            
            NSDictionary *DIC=resDic[@"data"];
            NSLog(@"ios 版本号: %@",DIC[@"ios_version"]);
            NSLog(@"ios 版 下载地址: %@",DIC[@"ios_download"]);
            NSLog(@"ios 版 下载地址: %@",DIC[@"ios_content"]);

            /**
             * 本地版本
             */
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

            NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            
            NSLog(@"当前应用软件版本:%@",appCurVersion);
            
        }else{
            //            [SVProgressHUD setMinimumDismissTimeInterval:2];
            //            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
    
}
#pragma mark - 使用协议
- (IBAction)agreeUrlAction:(UIButton *)sender {
    
    FBHinformationViewController *VC = [FBHinformationViewController new];
    VC.Navtitle = @"使用协议";
    VC.agreeUrl = FBHApi_HTML_Falu;
    [self.navigationController pushViewController:VC animated:YES];
    
}


#pragma mark - 获取应用在 appStore的信息
-(void)lookup{
    
    
    
    
    NSString *urlString = @"http://itunes.apple.com/lookup?id=1465861059";
    //自己应用在App Store里的地址
    NSURL *url = [NSURL URLWithString:urlString];
    //这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。
    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    //    解析json数据
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = json[@"results"];
    for (NSDictionary *dic in array) {
        NSString *newVersion = [dic valueForKey:@"version"];// appStore 的版本号
        NSLog(@"appStore 的版本号 :%@",newVersion);
       
        /**
         * 本地版本
         */
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"当前应用软件版本:%@",appCurVersion);
        self.banben.text = [NSString stringWithFormat:@"v%@",appCurVersion];
        
        if (newVersion == appCurVersion) {
            [self.versionButton setTitle:@"目前已是最新版本" forState:UIControlStateNormal];
        }else{
            [self.versionButton setTitle:@"去下载最新版本" forState:UIControlStateNormal];
            
        }
    }
    
    
    
    
    
    
}



@end
