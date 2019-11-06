//
//  FBHbondViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//  券码验证

#import "FBHbondViewController.h"
#import "bondPromptView.h"
#import "GTVerifyCodeView.h"

@interface FBHbondViewController ()
@property (nonatomic, weak) GTVerifyCodeView *codeView;
/** 输入的券码 */
@property (strong,nonatomic)NSString * Code;
/*确定输入按钮*/
@property (strong,nonatomic)UIButton * IDOKButton;
@end

@implementation FBHbondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"券码验证";
    [self createUI];
}

#pragma mark - UI
-(void)createUI{
    
    GTVerifyCodeView *codeView = [[GTVerifyCodeView alloc] initWithFrame:CGRectMake(0, 50,ScreenW, 180) onFinishedEnterCode:^(NSString *code) {
        NSLog(@"%@",code);
        //        if (arc4random()%2) {
        //            [self reset];
        //        }
        self.Code = code;
        
    }];
    codeView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:codeView];
    _codeView = codeView;
    
    
    
    self.IDOKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.IDOKButton.frame = CGRectMake(15, codeView.bottom + 20, ScreenW-30, 44);
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, ScreenW-30, 44);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.cornerRadius = 10;
    gradientLayer.locations = @[@(0.0),@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[UIColorFromRGB(0x43C1FF) CGColor],(id)[UIColorFromRGB(0x3D89FF) CGColor],(id)[UIColorFromRGB(0x3D89FF) CGColor]]];//渐变数组
    [self.IDOKButton.layer addSublayer:gradientLayer];
    
    self.IDOKButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    self.IDOKButton.layer.shadowOffset = CGSizeMake(0,4);
    self.IDOKButton.layer.shadowOpacity = 1;
    self.IDOKButton.layer.shadowRadius = 9;
    
    [self.IDOKButton setTitle:@"确认输入" forState:UIControlStateNormal];
    [self.IDOKButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [self.IDOKButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.IDOKButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.IDOKButton];
    
}
- (void)ButtonAction:(UIButton *)sender {
    
    if (self.Code.length ==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入完整"];
        return;
    }
    [self.view endEditing:YES];
    
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]input_order_code:model.merchant_id andstore_id:model.store_id andorder_code:self.Code Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1){
            
            NSString *order_idString = [NSString stringWithFormat:@"%@",resDic[@"data"][@"order_id"]];
            
            bondPromptView *tipView = [[NSBundle mainBundle] loadNibNamed:@"bondPromptView" owner:self options:nil].lastObject;
            tipView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            //    tipView.promptImage.image = [UIImage imageNamed:@"icn_failure"];
            //    tipView.proptLabel.text = @"验证失败";
            [self.view.window addSubview:tipView];
            tipView.bondBlock = ^{
                
                FBHaccomplishController *VC = [FBHaccomplishController new];
                VC.order_id = order_idString;
                [self.navigationController pushViewController:VC animated:NO];
                
            };
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            
            bondPromptView *tipView = [[NSBundle mainBundle] loadNibNamed:@"bondPromptView" owner:self options:nil].lastObject;
            tipView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            tipView.promptImage.image = [UIImage imageNamed:@"icn_failure"];
            tipView.proptLabel.text = @"验证失败";
            tipView.promptText.text = @"请核对券码，再重新输入。";
            [self.view.window addSubview:tipView];
            
        }
        
    } andfailure:^{
        
        
    }];
    
    
     
}



@end
