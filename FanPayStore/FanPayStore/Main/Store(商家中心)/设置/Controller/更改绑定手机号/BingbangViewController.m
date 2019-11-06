//
//  BingbangViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/9.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BingbangViewController.h"
#import "BingpromptView.h"

@interface BingbangViewController ()
@property (weak, nonatomic) IBOutlet UITextField *Phone;
@property (weak, nonatomic) IBOutlet UITextField *MSMfield;
@property (weak, nonatomic) IBOutlet UIButton *MSMButton;
@property (strong,nonatomic)BingpromptView * promptView;
@end

@implementation BingbangViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更改绑定手机号";
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    
//    [[UIApplication sharedApplication].keyWindow addSubview:self.promptView];

    self.Phone.keyboardType = UIKeyboardTypeDecimalPad;
    self.MSMfield.keyboardType = UIKeyboardTypeDecimalPad;
    [self.MSMButton addTarget:self action:@selector(MSMAction) forControlEvents:UIControlEventTouchUpInside];

}
- (IBAction)binded_mobile:(UIButton *)sender {
    [self binded_mobile];
}
-(void)binded_mobile{
    if (self.Phone.text==nil||self.Phone.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    if (self.MSMfield.text==nil||self.MSMfield.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return ;
    }
    
    UserModel *model = [UserModel getUseData];
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    NSDictionary *dict = @{
                           @"existing_mobile":[NSString stringWithFormat:@"%@",self.existing_mobile],
                           @"existing_code":[NSString stringWithFormat:@"%@",self.existing_code],
                           @"new_mobile":[NSString stringWithFormat:@"%@",self.Phone.text],
                           @"code":[NSString stringWithFormat:@"%@",self.MSMfield.text],
                           @"type":@"2",
                           };
    
    
    [[FBHAppViewModel shareViewModel]change_binded_mobile:model.merchant_id andcode:dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];

            if (self.navigationController.viewControllers.count >= 2) {
                UIViewController *vc = [self.navigationController.viewControllers objectOrNilAtIndex:1];
                [self.navigationController popToViewController:vc animated:YES];
            }
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
}
/**
 */

-(void)MSMAction{
    
    if (self.Phone.text==nil||self.Phone.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    
    
    UserModel *model = [UserModel getUseData];
    [MBProgressHUD MBProgress:@"数据加载中..."];

    //
    [[FBHAppViewModel shareViewModel]geTcaptchaWithphone:self.Phone.text andtype:@"5" Success:^(NSDictionary *resDic) {
        NSLog(@"当前获取到的数据是%@",resDic);
        if ([resDic[@"status"] integerValue]==1) {
            [self countDownWithTime];
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
}

/**
 倒计时
 
 */
- (void)countDownWithTime{
    __block NSInteger timeout = 59; // 倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                //设置按钮的样式
                [self.MSMButton setTitle:@"重获验证码" forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.MSMButton setBackgroundColor:UIColorFromRGB(0x3D89FF)];
                self.MSMButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];;
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                //                NSLog(@"____%@",strTime);
                
                [self.MSMButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                [self.MSMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.MSMButton setBackgroundColor:UIColorFromRGB(0xD4E5FF)];
                self.MSMButton.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}


#pragma mark - GET

-(BingpromptView *)promptView{
    if (!_promptView) {
        _promptView = [[NSBundle mainBundle] loadNibNamed:@"BingpromptView" owner:self options:nil].lastObject;
        _promptView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        YBWeakSelf
        _promptView.QueBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _promptView;
}




@end
