//
//  YLSSheBeiController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/22.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSSheBeiController.h"

@interface YLSSheBeiController ()
@property (strong,nonatomic)UIButton * YunisButton;
@property (strong,nonatomic)UIButton * LanisButton;
@end

@implementation YLSSheBeiController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"打印设备选择";

    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,0,ScreenW,50);
    label.numberOfLines = 0;
    label.textAlignment = 1;
    label.text = @"点击选择，您店铺的打印设备接入类型";
    label.font = [UIFont systemFontOfSize: 12];
    [self.view addSubview:label];
    
    
    /**
     */
    
    UIView *view_1 = [[UIView alloc] init];
    view_1.frame = CGRectMake(32.5,50,140,140);
    view_1.backgroundColor = [UIColor whiteColor];
    view_1.layer.cornerRadius = 5;
    view_1.layer.shadowOffset = CGSizeMake(0,2);
    view_1.layer.shadowOpacity = 1;
    view_1.layer.shadowRadius = 10;
    view_1.layer.shadowColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:0.5].CGColor;
    [self.view addSubview:view_1];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(view_1.left,view_1.bottom,view_1.width,35);
    label1.numberOfLines = 0;
    label1.textAlignment = 1;
    label1.text = @"云打印设备";
    label1.font = [UIFont systemFontOfSize: 15];
    [self.view addSubview:label1];
    
    UIButton *Butoon1 = [UIButton buttonWithType:UIButtonTypeCustom];
    Butoon1.frame = CGRectMake(0, 0, view_1.width, view_1.height);
    [Butoon1 setImage:[UIImage imageNamed:@"icn_printer_black-1"] forState:UIControlStateNormal];
    [Butoon1 addTarget:self action:@selector(YunAction) forControlEvents:UIControlEventTouchUpInside];
    [view_1 addSubview:Butoon1];
    
    self.YunisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.YunisButton.backgroundColor = UIColorFromRGB(0x45A6FF);
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,40,16);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 8;
    gl.shadowOffset = CGSizeMake(0,2);
    gl.shadowOpacity = 1;
    gl.shadowRadius = 10;
    gl.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    [self.YunisButton.layer addSublayer:gl];
    
    [self.YunisButton setTitle:@"当前" forState:UIControlStateNormal];
    self.YunisButton.titleLabel.font = [UIFont systemFontOfSize:10];
    self.YunisButton.layer.cornerRadius = 8;
    [self.YunisButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view_1 addSubview:self.YunisButton];
    [self.YunisButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.right.mas_offset(-8);
        make.size.mas_offset(CGSizeMake(40, 16));
    }];
    self.YunisButton.hidden = YES;

    
  
    
    
    
    
    /**
     */
    
    UIView *view_2 = [[UIView alloc] init];
    view_2.frame = CGRectMake(202,50,140,140);
    view_2.backgroundColor = [UIColor whiteColor];
    view_2.layer.cornerRadius = 5;
    view_2.layer.shadowOffset = CGSizeMake(0,2);
    view_2.layer.shadowOpacity = 1;
    view_2.layer.shadowRadius = 10;
    view_2.layer.shadowColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:0.5].CGColor;
    [self.view addSubview:view_2];
    
    UILabel *label2= [[UILabel alloc] init];
    label2.frame = CGRectMake(view_2.left,view_2.bottom,view_2.width,35);
    label2.numberOfLines = 0;
    label2.textAlignment = 1;
    label2.text = @"蓝牙打印设备";
    label2.font = [UIFont systemFontOfSize: 15];
    [self.view addSubview:label2];
    
    UIButton *Butoon2 = [UIButton buttonWithType:UIButtonTypeCustom];
    Butoon2.frame = CGRectMake(0, 0, view_2.width, view_2.height);
    [Butoon2 setImage:[UIImage imageNamed:@"icn_blueteeth_black"] forState:UIControlStateNormal];
    [Butoon2 addTarget:self action:@selector(LanAction) forControlEvents:UIControlEventTouchUpInside];
    [view_2 addSubview:Butoon2];
    
    
    self.LanisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer *gl1 = [CAGradientLayer layer];
    gl1.frame = CGRectMake(0,0,40,16);
    gl1.startPoint = CGPointMake(0, 0);
    gl1.endPoint = CGPointMake(1, 1);
    gl1.colors = @[(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl1.locations = @[@(0.0),@(0.5),@(1.0)];
    gl1.cornerRadius = 8;
    gl1.shadowOffset = CGSizeMake(0,2);
    gl1.shadowOpacity = 1;
    gl1.shadowRadius = 10;
    gl1.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    [self.LanisButton.layer addSublayer:gl1];

    [self.LanisButton setTitle:@"当前" forState:UIControlStateNormal];
    self.LanisButton.titleLabel.font = [UIFont systemFontOfSize:10];
    self.LanisButton.layer.cornerRadius = 8;
    self.LanisButton.backgroundColor = UIColorFromRGB(0x45A6FF);
    [self.LanisButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view_2 addSubview:self.LanisButton];
    [self.LanisButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.right.mas_offset(-8);
        make.size.mas_offset(CGSizeMake(40, 16));
    }];
    self.LanisButton.hidden = YES;

    /*判读开关滑动展示
     0 ：为关闭打印
     1 ：云打印
     2 :   蓝牙打印
     */
    NSString * isbluetooth1 = [PublicMethods readFromUserD:@"YunLanSound"];
    if ([isbluetooth1 isEqualToString:@"1"]) {
        self.LanisButton.hidden = YES;
        self.YunisButton.hidden = NO;

    }else if([isbluetooth1 isEqualToString:@"2"]) {
        self.LanisButton.hidden = NO;
        self.YunisButton.hidden = YES;

    }else{
        self.LanisButton.hidden = YES;
        self.YunisButton.hidden = YES;

    }
    
    
    //conversion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"YunLanSound" object:nil];
    
}
#pragma mark - 添加成功返回
- (void)conversionAction: (NSNotification *) notification {
    NSString * isbluetooth1 = [PublicMethods readFromUserD:@"YunLanSound"];
    if ([isbluetooth1 isEqualToString:@"1"]) {
        self.LanisButton.hidden = YES;
        self.YunisButton.hidden = NO;
        
    }else if([isbluetooth1 isEqualToString:@"2"]) {
        self.LanisButton.hidden = NO;
        self.YunisButton.hidden = YES;
        
    }else{
        self.LanisButton.hidden = YES;
        self.YunisButton.hidden = YES;
        
    }
    
}
#pragma mark - 云打印
-(void)YunAction{
    [self.navigationController pushViewController:[YLSEquipmentController new] animated:NO];

}
#pragma mark - 蓝牙打印
-(void)LanAction{
     [self.navigationController pushViewController:[ReceiptsController new] animated:NO];
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"YunLanSound" object:nil];
    
}
@end
