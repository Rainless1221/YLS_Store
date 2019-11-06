//
//  MoneyWinViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/4.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "MoneyWinViewController.h"

@interface MoneyWinViewController ()

@end

@implementation MoneyWinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加成功";

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,15,ScreenW-30,autoScaleW(314));
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    
    [self.view addSubview:view];
    
    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"account_authenticate_success"];
    [view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(10);
        make.size.mas_offset(CGSizeMake(autoScaleW(206), autoScaleW(170)));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,0,view.width-20,37);
    label.numberOfLines = 0;
    label.textAlignment = 1;
    label.font= [UIFont systemFontOfSize:15];
    label.text = @"提现账户认证成功\n可返回账户管理界面，查看提现";

    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-20);
        make.left.right.mas_offset(0);
        make.height.mas_offset(40);
    }];

    
    UIButton *StepsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    StepsButton.frame = CGRectMake(autoScaleW(15), view.bottom + autoScaleW(40), ScreenW - autoScaleW(30), 44);
    
    StepsButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    StepsButton.layer.shadowOffset = CGSizeMake(0,4);
    StepsButton.layer.shadowOpacity = 1;
    StepsButton.layer.shadowRadius = 9;
    
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW - autoScaleW(30),44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    
    [StepsButton.layer addSublayer:gl];
    
    
    
    [StepsButton setTitle:@"返回分账管理" forState:UIControlStateNormal];
    [StepsButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(18)]];
    [StepsButton addTarget:self action:@selector(StepsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:StepsButton];
    
}
#pragma mark - 返回
-(void)StepsAction{
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MoneyCertificationController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
