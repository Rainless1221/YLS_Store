//
//  FBHaccomplishController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHaccomplishController.h"

@interface FBHaccomplishController ()
@property (weak, nonatomic) IBOutlet UIView *AccomView;
/* 查看订单详情 按钮*/
@property (strong,nonatomic)UIButton * IDOKButton;
@end

@implementation FBHaccomplishController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"验证成功";
    [self createUI];
    
    
}

#pragma mark - UI
-(void)createUI{
    
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    NavView.backgroundColor = UIColorFromRGB(0xFFFFFF);

    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 160, 44)];
    navLabel.text = @"验证成功";
    navLabel.textColor = UIColorFromRGB(0x222222);
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.font = NavTitleFont;
    navLabel.centerX = NavView.centerX;
    [NavView addSubview:navLabel];
    
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenW-85, STATUS_BAR_HEIGHT, 80, 44)];
    [leftbutton setTitle:@"完成" forState:UIControlStateNormal];
    [leftbutton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *righbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 60, 44)];
    //    [righbutton setTitle:@"返回" forState:UIControlStateNormal];
    [righbutton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [righbutton setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    righbutton.layer.cornerRadius = 14;
    [righbutton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    [NavView addSubview:righbutton];
    [NavView addSubview:leftbutton];
    [self.view addSubview:NavView];
    
#pragma mark - 验证成功，用户订单消费完成 可到收银台查看收入
    UIView *BaseView = [[UIView alloc]initWithFrame:CGRectMake(15, 15+(kIs_iPhoneX? 84:64), ScreenW-30, 314)];
    BaseView.backgroundColor = [UIColor whiteColor];
    BaseView.layer.cornerRadius = 5;
    [self.view addSubview:BaseView];
    [BaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15+(kIs_iPhoneX? 84:64));
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(314);
    }];
    
    /*order_validation_success*/
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 196, 187)];
    imageView.image = [UIImage imageNamed:@"order_validation_success"];
    [BaseView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(25);
        make.size.mas_offset(CGSizeMake(196, 187));
    }];
    
    /*文本提示*/
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, BaseView.height-66, 200, 20)];
    label.text = @"验证成功，用户订单消费完成 ";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = UIColorFromRGB(0x222222);
    label.textAlignment = 1;
    label.numberOfLines = 0;
    label.centerX =BaseView.centerX;
    [BaseView addSubview:label];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottom+5, 195, 20)];
    label1.text = @"可到收银台查看收入";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = UIColorFromRGB(0x222222);
    label1.textAlignment = 1;
    label1.numberOfLines = 0;
    label1.centerX =BaseView.centerX;
    [BaseView addSubview:label1];
    
#pragma mark - 查看订单详情
    self.IDOKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.IDOKButton.frame = CGRectMake(15,  BaseView.bottom+40, ScreenW-30, 44);
    
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
    
    [self.IDOKButton setTitle:@"查看订单详情" forState:UIControlStateNormal];
    [self.IDOKButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [self.IDOKButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.IDOKButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.IDOKButton];
    
}

-(void)RighAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)leftAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 查看订单详情
- (void)ButtonAction:(UIButton *)sender {

    FBHDdetailsController*VC = [FBHDdetailsController new];
    VC.status = 0;
    VC.order_id = [NSString stringWithFormat:@"%@",self.order_id];
    VC.navigationTitle = @"订单已完成";
    [self.navigationController pushViewController:VC animated:NO];

}


@end
