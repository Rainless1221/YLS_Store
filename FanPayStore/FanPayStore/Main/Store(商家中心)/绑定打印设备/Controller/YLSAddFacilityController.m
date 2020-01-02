//
//  YLSAddFacilityController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/21.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSAddFacilityController.h"
#import "YLSAddScanController.h"

@interface YLSAddFacilityController ()<StarSLiderDelegate,UITextFieldDelegate>
@property (strong,nonatomic) MySwitch *Sound ;

@end

@implementation YLSAddFacilityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"云打印设备";
    
    [self setupNav];
    
    [self createUI];
    self.setsound = @"1";
    self.PT = 26;
    
    
   
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
    UIScrollView *BaseScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    BaseScroll.backgroundColor = UIColorFromRGB(0xF6F6F6);
    BaseScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 815);
    [self.view addSubview:BaseScroll];
    /** 头部说明*/
    UIView *TopView = [[UIView alloc] init];
    TopView.frame = CGRectMake(15,15,SCREEN_WIDTH-30,85.5);
    TopView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    TopView.layer.cornerRadius = 5;
    [BaseScroll addSubview:TopView];
//    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(85.5);
//    }];
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
    AddView.frame = CGRectMake(15,TopView.bottom+15,SCREEN_WIDTH-30,202+50);
    AddView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    AddView.layer.cornerRadius = 5;
    [BaseScroll addSubview:AddView];
//    [AddView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(TopView.mas_bottom).offset(15);
//        make.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(202+50);
//    }];
    NSArray *Array = @[@"设备名称",@"终端号",@"密钥",@"类型",@"打印联数"];
    for (int i = 0; i<5; i++) {
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
//    UIButton *jiantou = [UIButton buttonWithType:UIButtonTypeCustom];
//    [jiantou setImage:[UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
//    [AddView addSubview:jiantou];
//    [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.TypeButton1.mas_centerY).offset(0);
//        make.right.mas_offset(-10);
//    }];


    /**声音设置*/
//    self.AddVoiceView = [[UIView alloc] init];
//    self.AddVoiceView.frame = CGRectMake(15,AddView.bottom+15,SCREEN_WIDTH-30,155.5);
//    self.AddVoiceView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
//    self.AddVoiceView.layer.cornerRadius = 5;
//    [BaseScroll addSubview:self.AddVoiceView];
//    [AddVoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(AddView.mas_bottom).offset(15);
//        make.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(120);
//    }];
    
    NSArray *Array1 = @[@"静音",@"音量设置"];
    UIView *LineView = [[UIView alloc] init];
    LineView.frame = CGRectMake(10,50,self.AddVoiceView.width-20,0.5);
    LineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.AddVoiceView addSubview:LineView];
    for (int i = 0; i<2; i++) {
       
        
        UILabel *AddLabel = [[UILabel alloc] init];
        AddLabel.frame = CGRectMake(10,i*51,80,50);
        AddLabel.numberOfLines = 0;
        AddLabel.textColor = UIColorFromRGB(0x222222);
        AddLabel.font = [UIFont systemFontOfSize:12];
        AddLabel.text = [NSString stringWithFormat:@"%@",Array1[i]];
        [self.AddVoiceView addSubview:AddLabel];
        
    }
    if (self.Data.count == 0) {
        self.Sound = [[MySwitch alloc] initWithFrame:CGRectMake(self.AddVoiceView.width -74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
            if(OnStatus){
                NSLog(@"打开");
                [self.star showStarSlider:-21];
                self.IsMute = YES;
            }else{
                NSLog(@"关闭");
                [self.star showStarSlider:self.PT];
                self.IsMute = NO;
            }
        }];
        self.Sound.OnStatus = NO;

        //设置背景图片
        [self.Sound setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
        [self.Sound setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.Sound setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.AddVoiceView addSubview:self.Sound];
    }
    /**滑动声音*/
    self.view_Voice = [[UIView alloc] init];
    self.view_Voice.frame = CGRectMake(10,90.5,self.AddVoiceView.width-20,50);
    self.view_Voice.backgroundColor = [UIColor colorWithRed:223/255.0 green:236/255.0 blue:254/255.0 alpha:1.0];
    self.view_Voice.layer.cornerRadius = 10;
    self.view_Voice.layer.borderWidth = 1;
    self.view_Voice.layer.borderColor = [UIColor colorWithRed:65/255.0 green:137/255.0 blue:243/255.0 alpha:1.0].CGColor;
    [self.AddVoiceView addSubview:self.view_Voice];
    
    self.setsoundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icn_volume_blue_low"]];
    self.setsoundImage.frame = CGRectMake(18, 17, 20,  20);
    [self.view_Voice addSubview:self.setsoundImage];
    
    self.star = [[StarSliderView alloc]initWithFrame:CGRectMake(80, 0, self.view_Voice.width-80, 50) andWithCurrentStarNum:1 andUserEnabled:YES andWithDistance:1];
    self.star.delegate = self;
     [self.view_Voice addSubview:self.star];
    
    /*联数类型*/
    [AddView addSubview:self.LianButton1];
    [AddView addSubview:self.LianButton2];
    [AddView addSubview:self.LianButton3];
    [self.LianButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(90);
        make.top.mas_offset(162+50);
        make.size.mas_offset(CGSizeMake(40, 32));
    }];
    [self.LianButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LianButton1.mas_right).offset(10);
        make.top.mas_offset(162+50);
        make.size.mas_offset(CGSizeMake(40, 32));
    }];
    [self.LianButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LianButton2.mas_right).offset(10);
        make.top.mas_offset(162+50);
        make.size.mas_offset(CGSizeMake(40, 32));
    }];
    
    
    
    /** 确认添加按钮*/
    UIButton *AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    AddButton.frame = CGRectMake(15, AddView.bottom+15, ScreenW-30, 44);
    [AddButton setTitle:@"确认" forState:UIControlStateNormal];
    [AddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    AddButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    AddButton.layer.cornerRadius = 10;
    [AddButton addTarget:self action:@selector(BindingPinterAction) forControlEvents:UIControlEventTouchUpInside];
    [BaseScroll addSubview:AddButton];
//    [AddButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(AddVoiceView.mas_bottom).offset(20);
//        make.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(44);
//    }];
    
    
   
    
   
    
    
    
   
    //conversion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"AddScanData" object:nil];
    
    //设备类型
    UIButton *but = (UIButton *)[self.view viewWithTag:1];
    [self TypeAction:but];
    
    //联数类型
    UIButton *but1 = (UIButton *)[self.view viewWithTag:11];
    [self LianAction:but1];
    
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
#pragma mark - 联数
-(void)LianAction:(UIButton *)sender{
    for (int i = 1; i<4; i++) {
        if (sender.tag == i+10) {
            sender.selected = YES;
            sender.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
            self.LianType = [NSString stringWithFormat:@"%d",i];
            continue;
        }
        UIButton *but = (UIButton *)[self.view viewWithTag:i+10];
        but.selected = NO;
        but.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        
    }
    
}
#pragma mark - - 声音方法
-(void)starSliderMoveWithCurrentNum:(int)starNum Slider:(float)pt{
    NSLog(@"声量 %d^^^^^^^^^^^^^",starNum);
    if (starNum>=7) {
        self.setsoundImage.image = [UIImage imageNamed:@"icn_volume_blue_high"];
        self.view_Voice.backgroundColor = [UIColor colorWithRed:223/255.0 green:236/255.0 blue:254/255.0 alpha:1.0];
        self.view_Voice.layer.borderColor = [UIColor colorWithRed:65/255.0 green:137/255.0 blue:243/255.0 alpha:1.0].CGColor;
    }else if (starNum>=4){
        self.setsoundImage.image = [UIImage imageNamed:@"icn_volume_blue_medium"];
        self.view_Voice.backgroundColor = [UIColor colorWithRed:223/255.0 green:236/255.0 blue:254/255.0 alpha:1.0];
        self.view_Voice.layer.borderColor = [UIColor colorWithRed:65/255.0 green:137/255.0 blue:243/255.0 alpha:1.0].CGColor;
    }else if (starNum>=1){
        self.setsoundImage.image = [UIImage imageNamed:@"icn_volume_blue_low"];
        self.view_Voice.backgroundColor = [UIColor colorWithRed:223/255.0 green:236/255.0 blue:254/255.0 alpha:1.0];
        self.view_Voice.layer.borderColor = [UIColor colorWithRed:65/255.0 green:137/255.0 blue:243/255.0 alpha:1.0].CGColor;
        
    }else{
        self.setsoundImage.image = [UIImage imageNamed:@"icn_volume_gray_mute"];
        self.view_Voice.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        self.view_Voice.layer.borderColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0].CGColor;
    }
    
    
    if (starNum==0) {
       [self.Sound removeFromSuperview];
        self.Sound = [[MySwitch alloc] initWithFrame:CGRectMake(self.AddVoiceView.width -74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
            if(OnStatus){
                NSLog(@"打开");
                [self.star showStarSlider:-21];
                self.IsMute = YES;
            }else{
                NSLog(@"关闭");
                [self.star showStarSlider:self.PT];
                self.IsMute = NO;
            }
        }];
        self.Sound.OnStatus = YES;
        //设置背景图片
        [self.Sound setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
        [self.Sound setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.Sound setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.AddVoiceView addSubview:self.Sound];
    }else{
        [self.Sound removeFromSuperview];
        self.Sound = [[MySwitch alloc] initWithFrame:CGRectMake(self.AddVoiceView.width -74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
            if(OnStatus){
                NSLog(@"打开");
                [self.star showStarSlider:-21];
                self.IsMute = YES;
            }else{
                NSLog(@"关闭");
                [self.star showStarSlider:self.PT];
                self.IsMute = NO;
            }
        }];
        self.Sound.OnStatus = NO;
        //设置背景图片
        [self.Sound setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
        [self.Sound setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.Sound setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
        [self.AddVoiceView addSubview:self.Sound];
        self.PT = pt;
        self.setsound = [NSString stringWithFormat:@"%d",starNum];
    }
    
}
#pragma mark -添加按钮事件
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
    if (self.LianType==nil||self.LianType.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请选择联数"];
        return ;
    }
    
    if (self.IsSwitch == YES) {
        [self switch_pinter];

    }else{
        [self binding_pinter];
        
    }
    
    
}
#pragma mark - 编辑
-(void)switch_pinter{
   
    [MBProgressHUD MBProgress:@"绑定中..."];
    NSString * setsound = [NSString stringWithFormat:@"%@",self.setsound];
    if (self.IsMute == YES) {
        setsound = @"0";
    }
    UserModel *Model = [UserModel getUseData];
    NSDictionary *Dict = @{
                           @"machine_secret":[NSString stringWithFormat:@"%@",self.TheKeyTF.text],//设备秘钥
                           @"machine_code":[NSString stringWithFormat:@"%@",self.FacilityTF.text],//设备编号
                           @"printer_type":self.PrinType,//应用场景：1吧台2后厨
                           @"machine_name":[NSString stringWithFormat:@"%@",self.NameTF.text],//自定义设备名称
                           @"multi":self.LianType,//应用场景：默认为1，范围：1-9
//                           @"setsound":setsound,//应用场景：音量设置：默认为5，范围：1-9
                           };
    
    
    
    [[FBHAppViewModel shareViewModel]switch_pinter:Model.merchant_id andstore_id:Model.store_id andprinter_id:self.printer_id andjoinDict:Dict Success:^(NSDictionary *resDic) {
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
#pragma mark - 绑定
-(void)binding_pinter{
   
    [MBProgressHUD MBProgress:@"绑定中..."];
    NSString * setsound = [NSString stringWithFormat:@"%@",self.setsound];
    if (self.IsMute == YES) {
        setsound = @"0";
    }
    UserModel *Model = [UserModel getUseData];
    NSDictionary *Dict = @{
                           @"machine_secret":[NSString stringWithFormat:@"%@",self.TheKeyTF.text],//设备秘钥
                           @"machine_code":[NSString stringWithFormat:@"%@",self.FacilityTF.text],//设备编号
                           @"printer_type":self.PrinType,//应用场景：1吧台2后厨
                           @"machine_name":[NSString stringWithFormat:@"%@",self.NameTF.text],//自定义设备名称
                           @"multi":self.LianType,//应用场景：默认为1，范围：1-9
//                           @"setsound":setsound,//应用场景：音量设置：默认为5，范围：1-9
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
    self.printer_id = [NSString stringWithFormat:@"%@",Data[@"printer_id"]];
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
    
    //联数类型
    NSString *lian_type = [NSString stringWithFormat:@"%@",Data[@"multi"]];
    if ([[MethodCommon judgeStringIsNull:lian_type] isEqualToString:@""]) {
        lian_type = @"";
    }else{
        UIButton *but = (UIButton *)[self.view viewWithTag:[lian_type integerValue]+10];
        [self LianAction:but];
    }
    
    //声音
    self.Sound = [[MySwitch alloc] initWithFrame:CGRectMake(self.AddVoiceView.width -74, 10, 64, 32) withGap:0.3 statusChange:^(BOOL OnStatus) {
        if(OnStatus){
            NSLog(@"打开");
            [self.star showStarSlider:-21];
            self.IsMute = YES;
        }else{
            NSLog(@"关闭");
            [self.star showStarSlider:self.PT];
            self.IsMute = NO;
        }
    }];
    NSString *setsound = [NSString stringWithFormat:@"%@",Data[@"setsound"]];
    if ([setsound isEqualToString:@"0"]) {
        self.Sound.OnStatus = YES;
    }else{
        self.Sound.OnStatus = NO;
    }
    //设置背景图片
    [self.Sound setBackgroundImage:[UIImage imageNamed:@"switch_ex_frame"]];
    [self.Sound setLeftBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
    [self.Sound setRightBlockImage:[UIImage imageNamed:@"switch_ex_button"]];
    
    [self.AddVoiceView addSubview:self.Sound];

    float pt = self.PT*[setsound intValue];
    [self.star showStarSlider:pt];
    
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddScanData" object:nil];
    
}
-(void)setIsSwitch:(BOOL)IsSwitch{
    _IsSwitch = IsSwitch;
    if (IsSwitch == YES) {
         self.FacilityTF.userInteractionEnabled = NO;
         self.TheKeyTF.userInteractionEnabled = NO;
        
    }else{
        
    }
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
        _FacilityTF.delegate = self;
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
        _TheKeyTF.delegate = self;
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
-(UIButton *)LianButton1{
    if (!_LianButton1) {
        _LianButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_LianButton1 setTitle:@"1" forState:UIControlStateNormal];
        [_LianButton1 setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_LianButton1 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        _LianButton1.titleLabel.font = [UIFont systemFontOfSize:15];
        _LianButton1. layer.cornerRadius = 16;
        _LianButton1.layer.borderWidth = 1;
        _LianButton1.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        _LianButton1.backgroundColor = UIColorFromRGBA(0xDCDCDC, 0.4);
        _LianButton1.tag = 11;
        [_LianButton1 addTarget:self action:@selector(LianAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LianButton1;
}
-(UIButton *)LianButton2{
    if (!_LianButton2) {
        _LianButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_LianButton2 setTitle:@"2" forState:UIControlStateNormal];
        [_LianButton2 setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_LianButton2 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        _LianButton2.titleLabel.font = [UIFont systemFontOfSize:15];
        _LianButton2. layer.cornerRadius = 16;
        _LianButton2.layer.borderWidth = 1;
        _LianButton2.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        _LianButton2.backgroundColor = UIColorFromRGBA(0xDCDCDC, 0.4);
        _LianButton2.tag = 12;
        [_LianButton2 addTarget:self action:@selector(LianAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LianButton2;
}
-(UIButton *)LianButton3{
    if (!_LianButton3) {
        _LianButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_LianButton3 setTitle:@"3" forState:UIControlStateNormal];
        [_LianButton3 setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_LianButton3 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        _LianButton3.titleLabel.font = [UIFont systemFontOfSize:15];
        _LianButton3. layer.cornerRadius = 16;
        _LianButton3.layer.borderWidth = 1;
        _LianButton3.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        _LianButton3.backgroundColor = UIColorFromRGBA(0xDCDCDC, 0.4);
        _LianButton3.tag = 13;
        [_LianButton3 addTarget:self action:@selector(LianAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LianButton3;
}
@end
