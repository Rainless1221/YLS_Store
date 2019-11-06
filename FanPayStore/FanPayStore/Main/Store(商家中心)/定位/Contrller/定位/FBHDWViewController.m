//
//  FBHDWViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/21.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHDWViewController.h"

@interface FBHDWViewController ()<MapControllerDelegate>

@property (strong,nonatomic)UIView * SaveMapView;//View
@property (strong, nonatomic) UIButton *saveButton;//保存按钮
@property (strong,nonatomic)UITextField * MapAdderField;//地址
@property (strong,nonatomic)UITextField * MapField;//门牌

@property (strong,nonatomic)UIButton * MapButton;
@property (copy, nonatomic) NSString *lon;
@property (copy, nonatomic) NSString *lat;

@end

@implementation FBHDWViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"定位";
    /**
     * UI
     */
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    self.backgrounView.backgroundColor = [UIColor whiteColor];
    [self.XButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    self.DZField.textColor = UIColorFromRGB(0x3D8AFF);
    if ([[MethodCommon judgeStringIsNull:self.store_address] isEqualToString:@""]) {
        
    }else{
        NSArray *array = [self.store_address componentsSeparatedByString:@" "];
        NSString *addresM = [NSString stringWithFormat:@"%@",array[array.count-1]];
        NSLog(@"%@",addresM);
        NSString *addres = [self.store_address stringByReplacingOccurrencesOfString:addresM withString:@""];
        self.MapAdderField.text = addres;
        self.MapField.text = addresM;
    }
    
    /**/

    [self.view addSubview:self.SaveMapView];
    [self.SaveMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 101));
    }];
    
    /*保存按钮*/
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW-30,44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    [self.saveButton.layer addSublayer:gl];
    
    self.saveButton.layer.shadowColor = UIColorFromRGBA(0x3D8AFF,0.5).CGColor;
    self.saveButton.layer.shadowOffset = CGSizeMake(0,4);
    self.saveButton.layer.shadowOpacity = 1;
    self.saveButton.layer.shadowRadius = 9;
    
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(SaveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SaveMapView.mas_bottom).offset(25);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 44));
    }];
    
    
    /*店铺地址*/
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 65, 50)];
    label1.text = @"店铺地址";
    label1.textColor = UIColorFromRGBA(0x222222, 1);
    label1.font = [UIFont systemFontOfSize:15];
    [self.SaveMapView addSubview:label1];
    
    UIView  *line1  = [[UIView alloc]initWithFrame:CGRectMake(10, 50, self.SaveMapView.width-20, 1)];
    line1.backgroundColor = UIColorFromRGBA(0xEAEAEA, 1);
    [self.SaveMapView addSubview:line1];
    /*门牌号*/
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 51, 65, 50)];
    label2.text = @"门牌号";
    label2.textColor = UIColorFromRGBA(0x222222, 1);
    label2.font = [UIFont systemFontOfSize:15];
    [self.SaveMapView addSubview:label2];

    //icn_blueline_location
    
    UIImageView *icon1 = [[UIImageView alloc]initWithFrame:CGRectMake(label1.right+10, 16, 17, 19)];
    icon1.image= [UIImage imageNamed:@"icn_blueline_location"];
    [self.SaveMapView addSubview:icon1];
    [icon1 mas_makeConstraints:(^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY).offset(0);
        make.left.equalTo(label1.mas_right).offset(10);
        make.size.mas_offset(CGSizeMake(17, 19));
    })];
    //input_arrow_right_blue
    UIImageView *icon2 = [[UIImageView alloc]initWithFrame:CGRectMake(label1.right+10, 16, 6, 10)];
    icon2.image= [UIImage imageNamed:@"input_arrow_right_blue"];
    [self.SaveMapView addSubview:icon2];
    [icon2 mas_makeConstraints:(^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY).offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(6, 10));
    })];
    
    
    [self.SaveMapView addSubview:self.MapAdderField];
    [self.MapAdderField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(icon1.mas_right).offset(9);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    
    [self.SaveMapView addSubview:self.MapField];
    [self.MapField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(51);
        make.left.equalTo(label1.mas_right).offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
#pragma mark - 地图选择地址
    [self.SaveMapView addSubview:self.MapButton];
    [self.MapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(label1.mas_right).offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    
}
//去定位选择地址
-(void)MapAction{
    MapViewController *VC = [MapViewController new];
    VC.delagate = self;
    [self.navigationController pushViewController:VC animated:NO];
}

- (IBAction)XBtnAction:(UIButton *)sender {
    MapViewController *VC = [MapViewController new];
//    FBHDWDTViewController *VC = [FBHDWDTViewController new];
    VC.delagate = self;
    [self.navigationController pushViewController:VC animated:NO];
}

//保存地址
- (void)SaveAction:(UIButton *)sender {
    
    /**
     * 保存定位的地址
     */
/**
 * 1、保存提示成功
 * 2、保存后返回
 */
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    NSMutableDictionary *Dict = [NSMutableDictionary dictionary];
    if (self.lon) {
        [Dict setObject:self.lon forKey:@"lon"];
    }
    if (self.lat){
        [Dict setObject:self.lat forKey:@"lat"];
    }
    if ([NSString stringWithFormat:@"%@",self.MapAdderField.text]){
        [Dict setObject:[NSString stringWithFormat:@"%@",self.MapAdderField.text] forKey:@"store_address"];
    }
    if ([NSString stringWithFormat:@" %@",self.MapField.text]) {
        [Dict setObject:[NSString stringWithFormat:@"%@",self.MapField.text] forKey:@"specific_location"];

    }
    
    
    NSDictionary *dict = @{
                           @"store_address":[NSString stringWithFormat:@"%@",self.MapAdderField.text],
                           @"lon":[NSString stringWithFormat:@"%@",self.lon],
                           @"lat":[NSString stringWithFormat:@"%@",self.lat],
                           @"specific_location":[NSString stringWithFormat:@" %@",self.MapField.text],

                           };
    
    [[FBHAppViewModel shareViewModel]insert_store_application:model.merchant_id andMerchantDict:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            //步骤1
            [SVProgressHUD showSuccessWithStatus:@"等待信息审核中"];
            //步骤2
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
//    [PublicMethods writeToUserD:self.DZField.text andKey:@"addresM"];
//    [PublicMethods writeToUserD:self.XButton.titleLabel.text andKey:@"addres"];

    
}

#pragma mark - 实现协议方法
//-(void)pushViewcontroler:(NSString *)ddres andlot:(NSString *)lon andlat:(NSString *)lat{
//    /** 地址 */
//    [self.XButton setTitle:ddres forState:UIControlStateNormal];
//
//}
-(void)Mapaddres:(NSString *)ddres andlot:(NSString *)lon andlat:(NSString *)lat{
    /** 地址 */
//    [self.XButton setTitle:ddres forState:UIControlStateNormal];
    self.MapAdderField.text = ddres;
    self.lat = lat;
    self.lon = lon;
}




#pragma mark - 懒加载

-(UIView *)SaveMapView{
    if (!_SaveMapView) {
        _SaveMapView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 101)];
        _SaveMapView.backgroundColor = [UIColor whiteColor];
        _SaveMapView.layer.cornerRadius = 5;
    }
    return _SaveMapView;
}
-(UITextField *)MapField{
    if (!_MapField) {
        _MapField = [[UITextField alloc]initWithFrame:CGRectMake(94, 51, ScreenW-30-94-10, 50)];
        _MapField.placeholder = @"请输入门牌号";
        _MapField.textColor = UIColorFromRGBA(0x3D8AFF, 1);
        _MapField.font = [UIFont systemFontOfSize:15];
        
    }
    return _MapField;
}
-(UITextField *)MapAdderField{
    if (!_MapAdderField) {
        _MapAdderField = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, ScreenW-30-94-10, 50)];
        _MapAdderField.placeholder = @"";
        _MapAdderField.textColor = UIColorFromRGBA(0x3D8AFF, 1);
        _MapAdderField.font = [UIFont systemFontOfSize:15];
    }
    return _MapAdderField;
}
-(UIButton *)MapButton{
    if (!_MapButton) {
        _MapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _MapButton.frame = CGRectMake(0, 0, ScreenW-60, 50);
        [_MapButton addTarget:self action:@selector(MapAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MapButton;
}
@end
