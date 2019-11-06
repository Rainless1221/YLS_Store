//
//  YLSAddFacilityController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/21.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSAddFacilityController.h"
#import "YLSAddScanController.h"

@interface YLSAddFacilityController ()

@end

@implementation YLSAddFacilityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加打印设备";
    
    [self setupNav];
    
    [self createUI];
}
#pragma mark - 导航栏
-(void)setupNav{
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60, 28)];
    [leftbutton setImage:[UIImage imageNamed:@"icn_titlebar_menu_flicking"] forState:(UIControlState)UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.rightBarButtonItem=rightitem;
}
-(void)RighAction{
    SWQRCodeConfig *config = [[SWQRCodeConfig alloc]init];
    config.scannerType = SWScannerTypeBoth;
    /** 棱角颜色 */
    config.scannerCornerColor = UIColorFromRGB(0x3D8AFF);
    /** 边框颜色 */
    config.scannerBorderColor = UIColorFromRGB(0xFFFFFF);
    
    YLSAddScanController *qrcodeVC = [[YLSAddScanController alloc]init];
    qrcodeVC.codeConfig = config;
    [self.navigationController pushViewController:qrcodeVC animated:YES];
}
#pragma mark - UI
-(void)createUI{
    /** 头部说明*/
    UIView *TopView = [[UIView alloc] init];
    TopView.frame = CGRectMake(15,15,345,85.5);
    TopView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    TopView.layer.cornerRadius = 5;
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(85.5);
    }];
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(9.5,15,100,13.5);
    label1.numberOfLines = 0;
    label1.text = @"扫描填写";
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:15];
    [TopView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(9.5,38.5,TopView.width-20,40);
    label2.numberOfLines = 0;
    label2.text = @"点击右上角扫描按钮，扫描打印机底部二维码，可快速识别设备终端号与密钥。";
    label2.textColor = UIColorFromRGB(0x999999);
    label2.font = [UIFont systemFontOfSize:13];
    [TopView addSubview:label2];
    
    /**填写资料*/
    UIView *AddView = [[UIView alloc] init];
    AddView.frame = CGRectMake(15,183.5,345,201.5);
    AddView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    AddView.layer.cornerRadius = 5;
    [self.view addSubview:AddView];
    [AddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopView.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(202);
    }];
    NSArray *Array = @[@"设备名称",@"终端号",@"密钥",@"类型"];
    for (int i = 0; i<4; i++) {
        UIView *LineView = [[UIView alloc] init];
        LineView.frame = CGRectMake(10,50+i*51,AddView.width-20,0.5);
        LineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [AddView addSubview:LineView];
        
        UILabel *AddLabel = [[UILabel alloc] init];
        AddLabel.frame = CGRectMake(10,i*51,80,50);
        AddLabel.numberOfLines = 0;
        AddLabel.textColor = UIColorFromRGB(0x222222);
        AddLabel.font = [UIFont systemFontOfSize:15];
        AddLabel.text = [NSString stringWithFormat:@"%@",Array[i]];
        [AddView addSubview:AddLabel];
        
    }
    
    /** 确认添加按钮*/
    UIButton *AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [AddButton setTitle:@"确认添加" forState:UIControlStateNormal];
    [AddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    AddButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    AddButton.layer.cornerRadius = 10;
    [AddButton addTarget:self action:@selector(BindingPinterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:AddButton];
    [AddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AddView.mas_bottom).offset(20);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(44);
    }];
    
    
    [AddView addSubview:self.NameTF];
    [AddView addSubview:self.FacilityTF];
    [AddView addSubview:self.TheKeyTF];
    
    [self.NameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(90);
        make.right.mas_offset(-10);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    [self.FacilityTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(90);
        make.right.mas_offset(-10);
        make.top.mas_offset(51);
        make.height.mas_offset(50);
    }];
    [self.TheKeyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(90);
        make.right.mas_offset(-10);
        make.top.mas_offset(102);
        make.height.mas_offset(50);
    }];
    
    
    /*选择类型*/
    [AddView addSubview:self.TypeButton1];
    [AddView addSubview:self.TypeButton2];
    [self.TypeButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(90);
        make.top.mas_offset(162);
        make.size.mas_offset(CGSizeMake(60, 32));
    }];
    [self.TypeButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TypeButton1.mas_right).offset(10);
        make.top.mas_offset(162);
        make.size.mas_offset(CGSizeMake(60, 32));
    }];
    UIButton *jiantou = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiantou setImage:[UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
    [AddView addSubview:jiantou];
    [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.TypeButton1.mas_centerY).offset(0);
        make.right.mas_offset(-10);
    }];
    //conversion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"AddScanData" object:nil];
    
    //设备类型
    UIButton *but = (UIButton *)[self.view viewWithTag:1];
    [self TypeAction:but];
    
}
#pragma mark - 扫描返回的结果
- (void)conversionAction: (NSNotification *) notification {
    NSDictionary *dict =  [self dictionaryWithJsonString:notification.object];
    self.FacilityTF.text = [NSString stringWithFormat:@"%@",dict[@"machineCode"]];
    self.TheKeyTF.text = [NSString stringWithFormat:@"%@",dict[@"msign"]];
    
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
#pragma mark - 类别
-(void)TypeAction:(UIButton *)sender{
    for (int i = 1; i<3; i++) {
        if (sender.tag == i) {
            sender.selected = YES;
            sender.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
            self.PrinType = [NSString stringWithFormat:@"%d",i];
            continue;
        }
        UIButton *but = (UIButton *)[self.view viewWithTag:i];
        but.selected = NO;
        but.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;

    }
    
}
#pragma mark - 绑定
-(void)BindingPinterAction{
    
    //http://103.27.7.20/h5/other/back.html
    
    if (self.NameTF.text==nil||self.NameTF.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入设备名称"];
        return ;
    }
    if (self.FacilityTF.text==nil||self.FacilityTF.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入设备终端号"];
        return ;
    }
    if (self.TheKeyTF.text==nil||self.TheKeyTF.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入设备秘钥"];
        return ;
    }
    if (self.PrinType==nil||self.PrinType.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请选择类别"];
        return ;
    }
    [MBProgressHUD MBProgress:@"绑定中..."];

    UserModel *Model = [UserModel getUseData];
    NSDictionary *Dict = @{
                           @"machine_secret":[NSString stringWithFormat:@"%@",self.TheKeyTF.text],//设备秘钥
                           @"machine_code":[NSString stringWithFormat:@"%@",self.FacilityTF.text],//设备编号
                           @"printer_type":self.PrinType,//应用场景：1吧台2后厨
                           @"machine_name":[NSString stringWithFormat:@"%@",self.NameTF.text]//自定义设备名称
                           };
    
    [[FBHAppViewModel shareViewModel]binding_pinter:Model.merchant_id andstore_id:Model.store_id andjoinDict:Dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipmentList" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    
    //设备名称
    NSString *machine_name = [NSString stringWithFormat:@"%@",Data[@"machine_name"]];
    if ([[MethodCommon judgeStringIsNull:machine_name] isEqualToString:@""]) {
        machine_name = @"";
    }else{
        self.NameTF.text = machine_name;

    }
    
    //设备终端号
    NSString *machine_code = [NSString stringWithFormat:@"%@",Data[@"machine_code"]];
    if ([[MethodCommon judgeStringIsNull:machine_code] isEqualToString:@""]) {
        machine_code = @"";
    }else{
        self.FacilityTF.text = machine_code;

    }

    //设备密钥
    NSString *machine_secret = [NSString stringWithFormat:@"%@",Data[@"machine_secret"]];
    if ([[MethodCommon judgeStringIsNull:machine_secret] isEqualToString:@""]) {
        machine_secret = @"";
    }else{
        self.TheKeyTF.text = machine_secret;
    }
    

    //设备类型
    NSString *printer_type = [NSString stringWithFormat:@"%@",Data[@"printer_type"]];
    if ([[MethodCommon judgeStringIsNull:printer_type] isEqualToString:@""]) {
        printer_type = @"";
    }else{
        UIButton *but = (UIButton *)[self.view viewWithTag:[printer_type integerValue]];
        [self TypeAction:but];
    }
    
    
    
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddScanData" object:nil];
    
}
#pragma mark - 懒加载
-(UITextField *)NameTF{
    if (!_NameTF) {
        _NameTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _NameTF.font = [UIFont systemFontOfSize:15];
        _NameTF.textColor = UIColorFromRGB(0x222222);
        _NameTF.placeholder = @"请输入自定义设备名称";
    }
    return _NameTF;
}
-(UITextField *)FacilityTF{
    if (!_FacilityTF) {
        _FacilityTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _FacilityTF.font = [UIFont systemFontOfSize:15];
        _FacilityTF.textColor = UIColorFromRGB(0x222222);
        _FacilityTF.placeholder = @"请输入设备终端号";
        _FacilityTF.keyboardType = UIKeyboardTypePhonePad;

    }
    return _FacilityTF;
}
-(UITextField *)TheKeyTF{
    if (!_TheKeyTF) {
        _TheKeyTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _TheKeyTF.font = [UIFont systemFontOfSize:15];
        _TheKeyTF.textColor = UIColorFromRGB(0x222222);
        _TheKeyTF.placeholder = @"请输入设备密钥";
        _TheKeyTF.keyboardType = UIKeyboardTypePhonePad;

    }
    return _TheKeyTF;
}
-(UIButton *)TypeButton1{
    if (!_TypeButton1) {
        _TypeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TypeButton1 setTitle:@"吧台" forState:UIControlStateNormal];
        [_TypeButton1 setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_TypeButton1 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        _TypeButton1.titleLabel.font = [UIFont systemFontOfSize:15];
       _TypeButton1. layer.cornerRadius = 16;
        _TypeButton1.layer.borderWidth = 1;
        _TypeButton1.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        _TypeButton1.backgroundColor = UIColorFromRGBA(0xDCDCDC, 0.4);
        _TypeButton1.tag = 1;
        [_TypeButton1 addTarget:self action:@selector(TypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TypeButton1;
}
-(UIButton *)TypeButton2{
    if (!_TypeButton2) {
        _TypeButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TypeButton2 setTitle:@"后厨" forState:UIControlStateNormal];
        [_TypeButton2 setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_TypeButton2 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        _TypeButton2.titleLabel.font = [UIFont systemFontOfSize:15];
        _TypeButton2. layer.cornerRadius = 16;
        _TypeButton2.layer.borderWidth = 1;
        _TypeButton2.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        _TypeButton2.backgroundColor = UIColorFromRGBA(0xDCDCDC, 0.4);
        _TypeButton2.tag = 2;
        [_TypeButton2 addTarget:self action:@selector(TypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TypeButton2;
}
@end
