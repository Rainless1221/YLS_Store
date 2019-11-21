//
//  YLSinStoreView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/18.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSinStoreView.h"

@implementation YLSinStoreView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

#pragma mark -  UI
-(void)createUI{
    
    NSArray *menuArray = @[@"店铺信息",@"温馨提醒",@"店铺图片",@"证件图片"];

    for (int i = 0; i<menuArray.count; i++) {
        FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(self.width/4*i, 0, self.width/4, 75);
        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",menuArray[i]] forState:UIControlStateNormal];
        [thirdBtn setImage:[UIImage imageNamed:@"icn_business_info_record_undone"] forState:UIControlStateNormal];
        [thirdBtn setImage:[UIImage imageNamed:@"icn_business_info_record_done"] forState:UIControlStateSelected];
        [thirdBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [thirdBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateSelected];
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        thirdBtn.tag = i+10;
        thirdBtn.status = FLAlignmentStatusTop;
        thirdBtn.fl_padding = 10;
        [thirdBtn addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:thirdBtn];
    
    }
    for (int i=0; i<3; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake((self.width/8+12) +i*((self.width-160)/3+23), 24, (self.width-180)/3, 1)];
        line.backgroundColor = UIColorFromRGB(0xFAE3BB);
        [self addSubview:line];

    }
    self.SizeHeight = 800;

#pragma mark ———————— 店铺信息 ————————
    [self addSubview:self.AView];
    [self.AView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(75);
        make.bottom.mas_offset(-52);
    }];
    UIView *AView_backview = [[UIView alloc] init];
    AView_backview.frame = CGRectMake(15,139,345,353.5);
    AView_backview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    AView_backview.layer.cornerRadius = 5;
    [self.AView addSubview:AView_backview];
    [AView_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(404);
    }];
     /*分割线与标题*/
    NSArray *ArrayAtixt = @[@"店铺地址",@"门牌号",@"联系人",@"手机号",@"固定电话",@"营业周期",@"营业时间",@"人均消费"];
    for (int i = 0; i<8; i++) {
        UIView *Aline = [[UIView alloc]initWithFrame:CGRectMake(10, 50+i*51, AView_backview.width-20, 1)];
        Aline.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        if (i == 7) {
            
        }else{
            [AView_backview addSubview:Aline];
        }
        
        UILabel *AlabelTixt = [[UILabel alloc]initWithFrame:CGRectMake(10, i*51, 84, 50)];
        AlabelTixt.text = [NSString stringWithFormat:@"%@",ArrayAtixt[i]];
        AlabelTixt.textColor = UIColorFromRGB(0x222222);
        AlabelTixt.font = [UIFont systemFontOfSize:15];
        [AView_backview addSubview:AlabelTixt];
    }
    
    UILabel *Alabel_1 = [[UILabel alloc] init];
    Alabel_1.frame = CGRectMake(15.5,512.5,59,14.5);
    Alabel_1.numberOfLines = 1;
    Alabel_1.font = [UIFont systemFontOfSize:15];
    Alabel_1.textColor = UIColorFromRGB(0x222222);
    Alabel_1.text = @"商家简介";
    [self.AView addSubview:Alabel_1];
    [Alabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AView_backview.mas_bottom).offset(20);
        make.left.mas_offset(16);
    }];
    UIView *AView_jie = [[UIView alloc] init];
    AView_jie.frame = CGRectMake(15,541.5,345,50);
    AView_jie.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    AView_jie.layer.cornerRadius = 5;
    [self.AView addSubview:AView_jie];
    [AView_jie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Alabel_1.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(50);
    }];
    UILabel *Alabel_2 = [[UILabel alloc] init];
    Alabel_2.frame = CGRectMake(15.5,512.5,59,14.5);
    Alabel_2.numberOfLines = 1;
    Alabel_2.font = [UIFont systemFontOfSize:15];
    Alabel_2.textColor = UIColorFromRGB(0x222222);
    Alabel_2.text = @"商家关键字";
    [self.AView addSubview:Alabel_2];
    [Alabel_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AView_jie.mas_bottom).offset(20);
        make.left.mas_offset(16);
    }];
    
    UIView *AView_Key = [[UIView alloc] init];
    AView_Key.frame = CGRectMake(15,541.5,345,50);
    AView_Key.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    AView_Key.layer.cornerRadius = 5;
    [self.AView addSubview:AView_Key];
    [AView_Key mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Alabel_2.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(171);
    }];
    UILabel *Alabel_Key = [[UILabel alloc] init];
    Alabel_Key.numberOfLines = 0;
    Alabel_Key.font = [UIFont systemFontOfSize:13];
    Alabel_Key.textColor = UIColorFromRGB(0xCCCCCC);
    Alabel_Key.text = @"关键字可以让店铺方便被搜索到，例如”川菜”、“甜品”，“下午茶”等，最多可填3个";
    [AView_Key addSubview:Alabel_Key];
    [Alabel_Key mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(14);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
    }];
    UIView *line_Key = [[UIView alloc] init];
    line_Key.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [AView_Key addSubview:line_Key];
    [line_Key mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(108);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(0.5);
    }];
    self.AView_KeyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.AView_KeyButton setTitle:@"+ 关键字" forState:UIControlStateNormal];
    self.AView_KeyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.AView_KeyButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.AView_KeyButton.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
    self.AView_KeyButton.layer.borderWidth = 1;
    self.AView_KeyButton.layer.cornerRadius = 16;
    [self.AView_KeyButton addTarget:self action:@selector(KeyAction) forControlEvents:UIControlEventTouchUpInside];
    [AView_Key addSubview:self.AView_KeyButton];
    [self.AView_KeyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Alabel_Key.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.height.mas_offset(32);
        make.width.mas_offset(86);
    }];
    
    [AView_backview addSubview:self.AView_MenP];
    [AView_backview addSubview:self.AView_Name];
    [AView_backview addSubview:self.AView_Phone];
    [AView_backview addSubview:self.AView_GPhone];
    [AView_backview addSubview:self.AView_Cycle];
    [AView_backview addSubview:self.AView_Time];
    [AView_backview addSubview:self.AView_price];
    [AView_backview addSubview:self.AView_address];
    
    [self.AView_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(114);
        make.right.mas_offset(-10);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    [self.AView_MenP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.AView_Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(101);
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.AView_Phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(152);
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.AView_GPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(203);
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.AView_Cycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(254);
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.AView_Time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(305);
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.AView_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(356);
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    
    [AView_jie addSubview:self.AView_jie];
    [self.AView_jie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(10);
        make.right.mas_offset(-40);
        make.height.mas_offset(50);
    }];
    [AView_jie addSubview:self.AView_jieSun];
    [self.AView_jieSun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(self.AView_jie.mas_right).offset(1);
        make.right.mas_offset(0);
        make.height.mas_offset(50);
    }];
   
     /*地址图标*/
    UIButton *AaddressLogo = [UIButton buttonWithType:UIButtonTypeCustom];
    [AaddressLogo setImage: [UIImage imageNamed:@"icn_blueline_location"] forState:UIControlStateNormal];
    [AView_backview addSubview:AaddressLogo];
    [AaddressLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(94);
        make.width.mas_offset(20);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    /*选择地址*/
    UIButton *AaddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [AaddressButton setImage: [UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
    [AView_backview addSubview:AaddressButton];
    [AaddressButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [AaddressButton addTarget:self action:@selector(AddressAction) forControlEvents:UIControlEventTouchUpInside];
    [AaddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    
    /*选择营业周期*/
    UIButton *CycleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [CycleButton setImage: [UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
    [AView_backview addSubview:CycleButton];
    [CycleButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [CycleButton addTarget:self action:@selector(CycleAction) forControlEvents:UIControlEventTouchUpInside];
    [CycleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.top.mas_offset(254);
        make.height.mas_offset(50);
    }];
    
    /*选择营业时间*/
    UIButton *TimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [TimeButton setImage: [UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
    [AView_backview addSubview:TimeButton];
    [TimeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [TimeButton addTarget:self action:@selector(TimeAction) forControlEvents:UIControlEventTouchUpInside];
    [TimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(94);
        make.right.mas_offset(-10);
        make.top.mas_offset(305);
        make.height.mas_offset(50);
    }];
    
#pragma mark ———————— 温馨提醒 ————————
    [self addSubview:self.BView];
    [self.BView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(75);
        make.bottom.mas_offset(-52);
    }];
    self.BView_backview = [[UIView alloc] init];
    self.BView_backview.frame = CGRectMake(15,139,345,353.5);
    self.BView_backview.backgroundColor = [UIColor whiteColor];
    self.BView_backview.layer.cornerRadius = 5;
    [self.BView addSubview:self.BView_backview];
    [self.BView_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-10);
    }];
    UILabel *BView_text1 = [[UILabel alloc]initWithFrame:CGRectMake(10,18, 60, 13)];
    BView_text1.text = @"温馨提示";
    BView_text1.textColor = UIColorFromRGB(0x222222);
    BView_text1.font = [UIFont systemFontOfSize:15];
    [self.BView_backview addSubview:BView_text1];
    [BView_text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(18);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    
    UIView *BView_line1 = [[UIView alloc] init];
    BView_line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BView_backview addSubview:BView_line1];
    [BView_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    
    
    
 
    
#pragma mark ———————— 照片 ————————
    [self addSubview:self.CView];
    [self.CView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(75);
        make.bottom.mas_offset(-52);
    }];
    self.CView_backview = [[UIView alloc] init];
    self.CView_backview.frame = CGRectMake(15,139,345,353.5);
    self.CView_backview.backgroundColor = [UIColor whiteColor];
    self.CView_backview.layer.cornerRadius = 5;
    [self.CView addSubview:self.CView_backview];
    [self.CView_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-10);
    }];
    
    UILabel *CView_text1 = [[UILabel alloc]initWithFrame:CGRectMake(10,18, 60, 13)];
    CView_text1.text = @"店铺图片";
    CView_text1.textColor = UIColorFromRGB(0x222222);
    CView_text1.font = [UIFont systemFontOfSize:15];
    [self.CView_backview addSubview:CView_text1];
    [CView_text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(18);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    
    UIView *CView_line1 = [[UIView alloc] init];
    CView_line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.CView_backview addSubview:CView_line1];
    [CView_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    UILabel *CView_text2 = [[UILabel alloc]initWithFrame:CGRectMake(10,71, 60, 13)];
    CView_text2.text = @"门脸图片";
    CView_text2.textColor = UIColorFromRGB(0x222222);
    CView_text2.font = [UIFont systemFontOfSize:15];
    [self.CView_backview addSubview:CView_text2];
    [CView_text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(71);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    UILabel *CView_text3 = [[UILabel alloc]initWithFrame:CGRectMake(10,CView_text2.bottom, 60, 13)];
    CView_text3.text = @"必须能看见完整的门匾、门框";
    CView_text3.textColor = UIColorFromRGB(0xCCCCCC);
    CView_text3.font = [UIFont systemFontOfSize:13];
    [self.CView_backview addSubview:CView_text3];
    [CView_text3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CView_text2.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
   
    /**店铺图片*/
    self.facade = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONEWIDTH(103), IPHONEWIDTH(103))];
    self.facade.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
    self.facade. layer.cornerRadius = 5;
    self.facade.layer.masksToBounds = YES;
    self.facade.userInteractionEnabled = YES;//打开用户交互
    self.facade.tag = 31;
    //初始化一个手势
    UITapGestureRecognizer *facadeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(facadeTapAction)];
    //为图片添加手势
    [self.facade addGestureRecognizer:facadeTap];
    [self.CView_backview addSubview:self.facade];
    [self.facade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CView_text3.mas_bottom).offset(20.5);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(103), IPHONEWIDTH(103)));
    }];
    
    UIView *CView_line2 = [[UIView alloc] init];
    CView_line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.CView_backview addSubview:CView_line2];
    [CView_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CView_line1.mas_bottom).offset(194);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    UILabel *CView_text4 = [[UILabel alloc]initWithFrame:CGRectMake(10,71, 60, 13)];
    CView_text4.text = @"上传店内环境照片";
    CView_text4.textColor = UIColorFromRGB(0x222222);
    CView_text4.font = [UIFont systemFontOfSize:15];
    [self.CView_backview addSubview:CView_text4];
    [CView_text4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CView_line2.mas_bottom).offset(20);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    UILabel *CView_text5 = [[UILabel alloc]initWithFrame:CGRectMake(10,CView_text2.bottom, 60, 13)];
    CView_text5.text = @"需要包含桌椅，收银台等内容。";
    CView_text5.textColor = UIColorFromRGB(0xCCCCCC);
    CView_text5.font = [UIFont systemFontOfSize:13];
    [self.CView_backview addSubview:CView_text5];
    [CView_text5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CView_text4.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    /**环境图片*/
    self.environment = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONEWIDTH(103), IPHONEWIDTH(103))];
    self.environment.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
    self.environment.userInteractionEnabled = YES;//打开用户交互
    //初始化一个手势
    UITapGestureRecognizer *environmentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(environmentTapAction)];
    //为图片添加手势
    [self.environment addGestureRecognizer:environmentTap];
    [self.CView_backview addSubview:self.environment];
    [self.environment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CView_text5.mas_bottom).offset(20.5);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(103), IPHONEWIDTH(103)));
    }];
    
    
    
#pragma mark ———————— 证件 ————————
    [self addSubview:self.DView];
    [self.DView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(75);
        make.bottom.mas_offset(-52);
    }];
    
    UIView *DView_backview = [[UIView alloc] init];
    DView_backview.frame = CGRectMake(15,139,345,353.5);
    DView_backview.backgroundColor = [UIColor whiteColor];
    DView_backview.layer.cornerRadius = 5;
    [self.DView addSubview:DView_backview];
    [DView_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-10);
    }];
    
    UILabel *DView_label1 = [[UILabel alloc] init];
    DView_label1.frame = CGRectMake(25,157.5,58,13.5);
    DView_label1.numberOfLines = 0;
    DView_label1.text = @"证件图片";
    DView_label1.font = [UIFont systemFontOfSize:15];
    [DView_backview addSubview:DView_label1];
    [DView_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    UIView *DView_line1 = [[UIView alloc] init];
    DView_line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [DView_backview addSubview:DView_line1];
    [DView_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    UILabel *DView_label2 = [[UILabel alloc] init];
    DView_label2.frame = CGRectMake(25,157.5,58,13.5);
    DView_label2.numberOfLines = 0;
    DView_label2.text = @"上传法人身份证照片";
    DView_label2.font = [UIFont systemFontOfSize:15];
    [DView_backview addSubview:DView_label2];
    [DView_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(DView_line1.mas_bottom).offset(20);
    }];
    UILabel *DView_label3 = [[UILabel alloc]initWithFrame:CGRectMake(10,CView_text2.bottom, 60, 13)];
    DView_label3.text = @"必须上传身份证正面、反面照片。";
    DView_label3.textColor = UIColorFromRGB(0xCCCCCC);
    DView_label3.font = [UIFont systemFontOfSize:13];
    [DView_backview addSubview:DView_label3];
    [DView_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DView_label2.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    /**身份证正反*/
    self.IdCardOn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONEWIDTH(103), IPHONEWIDTH(103))];
    self.IdCardOn.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
    self.IdCardOn. layer.cornerRadius = 5;
    self.IdCardOn.layer.masksToBounds = YES;
    self.IdCardOn.userInteractionEnabled = YES;//打开用户交互
    self.IdCardOn.tag = 41;
    //初始化一个手势
    UITapGestureRecognizer *IdCardOnTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IdCardOnTapAction)];
    //为图片添加手势
    [self.IdCardOn addGestureRecognizer:IdCardOnTap];
    [DView_backview addSubview:self.IdCardOn];
    [self.IdCardOn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DView_label3.mas_bottom).offset(20.5);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(103), IPHONEWIDTH(103)));
    }];
    
    self.IdCardUnder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONEWIDTH(103), IPHONEWIDTH(103))];
    self.IdCardUnder.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
    self.IdCardUnder. layer.cornerRadius = 5;
    self.IdCardUnder.layer.masksToBounds = YES;
    self.IdCardUnder.userInteractionEnabled = YES;//打开用户交互
    self.IdCardUnder.tag = 42;
    //初始化一个手势
    UITapGestureRecognizer *IdCardUnderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IdCardUnderTapAction)];
    //为图片添加手势
    [self.IdCardUnder addGestureRecognizer:IdCardUnderTap];
    [DView_backview addSubview:self.IdCardUnder];
    [self.IdCardUnder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DView_label3.mas_bottom).offset(20.5);
        make.left.equalTo(self.IdCardOn.mas_right).offset(8);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(103), IPHONEWIDTH(103)));
    }];
    
    
    UIView *DView_line2 = [[UIView alloc] init];
    DView_line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [DView_backview addSubview:DView_line2];
    [DView_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.IdCardOn.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    UILabel *DView_label4 = [[UILabel alloc] init];
    DView_label4.frame = CGRectMake(25,157.5,58,13.5);
    DView_label4.numberOfLines = 0;
    DView_label4.text = @"上传营业执照";
    DView_label4.font = [UIFont systemFontOfSize:15];
    [DView_backview addSubview:DView_label4];
    [DView_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(DView_line2.mas_bottom).offset(20);
    }];
    UILabel *DView_label5 = [[UILabel alloc]initWithFrame:CGRectMake(10,CView_text2.bottom, 60, 13)];
    DView_label5.text = @"上传营业执照正面照片。";
    DView_label5.textColor = UIColorFromRGB(0xCCCCCC);
    DView_label5.font = [UIFont systemFontOfSize:13];
    [DView_backview addSubview:DView_label5];
    [DView_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DView_label4.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    /**营业执照*/
    self.business = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONEWIDTH(103), IPHONEWIDTH(103))];
    self.business.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
    self.business. layer.cornerRadius = 5;
    self.business.layer.masksToBounds = YES;
    self.business.userInteractionEnabled = YES;//打开用户交互
    self.business.tag = 43;
    //初始化一个手势
    UITapGestureRecognizer *businessTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(businessTapAction)];
    //为图片添加手势
    [self.business addGestureRecognizer:businessTap];
    [DView_backview addSubview:self.business];
    [self.business mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DView_label5.mas_bottom).offset(20.5);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(103), IPHONEWIDTH(103)));
    }];
    
    
    UIView *DView_line3 = [[UIView alloc] init];
    DView_line3.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [DView_backview addSubview:DView_line3];
    [DView_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.business.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    UILabel *DView_label6 = [[UILabel alloc] init];
    DView_label6.frame = CGRectMake(25,157.5,58,13.5);
    DView_label6.numberOfLines = 0;
    DView_label6.text = @"上传经营许可证";
    DView_label6.font = [UIFont systemFontOfSize:15];
    [DView_backview addSubview:DView_label6];
    [DView_label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(DView_line3.mas_bottom).offset(20);
    }];
    UILabel *DView_label7 = [[UILabel alloc]initWithFrame:CGRectMake(10,CView_text2.bottom, 60, 13)];
    DView_label7.text = @"上传营业执照正面照片。";
    DView_label7.textColor = UIColorFromRGB(0xCCCCCC);
    DView_label7.font = [UIFont systemFontOfSize:13];
    [DView_backview addSubview:DView_label7];
    [DView_label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DView_label6.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    /**上传经营许可证*/
    self.license = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONEWIDTH(103), IPHONEWIDTH(103))];
    self.license.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
    self.license. layer.cornerRadius = 5;
    self.license.layer.masksToBounds = YES;
    self.license.userInteractionEnabled = YES;//打开用户交互
    self.license.tag = 44;
    //初始化一个手势
    UITapGestureRecognizer *licenseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(licenseTapAction)];
    //为图片添加手势
    [self.license addGestureRecognizer:licenseTap];
    [DView_backview addSubview:self.license];
    [self.license mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DView_label7.mas_bottom).offset(20.5);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(103), IPHONEWIDTH(103)));
    }];
    
    

}
#pragma mark - 切换事件
-(void)ButtonAction:(UIButton *)sender{
    for (int i = 0; i<4; i++) {
        if (sender.tag == i+10) {
            sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+10];
        but.selected = NO;
    }
    
    switch (sender.tag) {
        case 10:
            self.AView.hidden = NO;
            self.BView.hidden = YES;
            self.CView.hidden = YES;
            self.DView.hidden = YES;
            self.SizeHeight = 910;
//            self.TypeView = 1;
            break;
        case 11:
            self.AView.hidden = YES;
            self.BView.hidden = NO;
            self.CView.hidden = YES;
            self.DView.hidden = YES;
            self.SizeHeight = self.ReminLabel_Y + 250;
//            self.TypeView = 2;
            break;
        case 12:
            self.AView.hidden = YES;
            self.BView.hidden = YES;
            self.CView.hidden = NO;
            self.DView.hidden = YES;
            self.SizeHeight = 750;
//            self.TypeView = 3;
            break;
        case 13:
            self.AView.hidden = YES;
            self.BView.hidden = YES;
            self.CView.hidden = YES;
            self.DView.hidden = NO;
            self.SizeHeight = 800;
//            self.TypeView = 4;
            break;
        default:
            break;
    }
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(QieHuAction:)]) {
        [self.delagate QieHuAction:sender.tag-10];

    }
}
- (void)setIsSelete:(NSInteger)isSelete{
    _isSelete = isSelete;
    for (int i = 0; i<4; i++) {
        
        if (i == isSelete) {
            UIButton *but = (UIButton *)[self viewWithTag:isSelete+10];
            [self ButtonAction:but];
            but.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+10];
        but.selected = NO;
    }
  
}
#pragma mark - 选择地址事件
-(void)AddressAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(SetAddress:)]) {
        [self.delagate SetAddress:self.AView_address];
        
    }
}
#pragma mark - 选择周期事件
-(void)CycleAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(SetCycle:)]) {
        [self.delagate SetCycle:self.AView_Cycle];
    }
}
#pragma mark - 选择营业时间事件
-(void)TimeAction{

    if (self.delagate && [self.delagate respondsToSelector:@selector(SetTime:)]) {
        [self.delagate SetTime:self.AView_Time];
        
    }
}

#pragma mark - 简介输入控制事件
- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    int length = [self convertToInt:textField.text];
    NSLog(@"个数：%d", length);
    
    //如果输入框中的文字大于15，就截取前15个作为输入框的文字
    if (length > 15) {
        textField.text = [textField.text substringToIndex:15];
    }else if(length == 15){
        self.AView_jieSun.text = [NSString stringWithFormat:@"%d/15",length];
    }else{
        self.AView_jieSun.text = [NSString stringWithFormat:@"%d/15",length];
    }
}
- (int)convertToInt:(NSString *)strtemp//判断中英混合的的字符串长度
{
    int strlength = 0;
    for (int i=0; i< [strtemp length]; i++) {
//        int a = [strtemp characterAtIndex:i];
//        if( a > 0x4e00 && a < 0x9fff) { //判断是否为中文
//            strlength += 2;
//        }else{
            strlength ++;
//        }
    }
    return strlength;
}
#pragma mark - 关键字事件
-(void)KeyAction{
   self.AView_KeyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.AView_KeyView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 6;
    [self.AView_KeyView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 280));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(50,0,ScreenW-130,50);
    label.numberOfLines = 0;
    label.text = @"输入关键字";
    label.textAlignment = 1;
    label.textColor = UIColorFromRGB(0x222222);
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UIView *lineview = [[UIView alloc] init];
    lineview.frame = CGRectMake(0,50,ScreenW-30,0.5);
    lineview.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [view addSubview:lineview];
    
    UIButton *queButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queButton.frame = CGRectMake(0, 0, 50, 50);
    [queButton setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(KeyQueAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:queButton];
    
    UIButton *KeyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [KeyButton setTitle:@"确定" forState:UIControlStateNormal];
    [KeyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    KeyButton.titleLabel.font = [UIFont systemFontOfSize:18];
    KeyButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    [KeyButton addTarget:self action:@selector(KeyTianAction) forControlEvents:UIControlEventTouchUpInside];
    KeyButton.layer.cornerRadius = 10;
    [view addSubview:KeyButton];
    [KeyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-50);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_offset(44);
    }];
    
    self.AView_KeyView_TF = [[UITextField alloc]initWithFrame:CGRectMake(30, 100, ScreenW-30, 35)];
    self.AView_KeyView_TF.font = [UIFont systemFontOfSize:15];
    self.AView_KeyView_TF.textColor = UIColorFromRGB(0x222222);
    self.AView_KeyView_TF.placeholder = @"关键字4个汉字以内";
    [view addSubview:self.AView_KeyView_TF];
    [self.AView_KeyView_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_offset(35);
        make.bottom.equalTo(KeyButton.mas_top).offset(-55);
    }];
    
    UIView *tfline = [[UIView alloc] init];
    tfline.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    [view addSubview:tfline];
    [tfline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(KeyButton.mas_top).offset(-54);
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview: self.AView_KeyView];
    
}
/**关键字取消事件*/
-(void)KeyQueAction{
     [self.AView_KeyView removeFromSuperview];
}
/**关键字添加事件*/
-(void)KeyTianAction{
    [self.AView_KeyView removeFromSuperview];
}
#pragma mark - 选择图片
/*身份证正*/
-(void)IdCardOnTapAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(SetImageDelegate:)]) {
        [self.delagate SetImageDelegate:self.IdCardOn];
    }
    
}
/*身份证反*/
-(void)IdCardUnderTapAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(SetImageDelegate:)]) {
        [self.delagate SetImageDelegate:self.IdCardUnder];
    }
    
}
/*上传营业执照*/
-(void)businessTapAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(SetImageDelegate:)]) {
        [self.delagate SetImageDelegate:self.business];
    }
    
}
/*上传经营许可证*/
-(void)licenseTapAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(SetImageDelegate:)]) {
        [self.delagate SetImageDelegate:self.license];
    }
    
}
/*上传门脸照片*/
-(void)facadeTapAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(SetImageDelegate:)]) {
        [self.delagate SetImageDelegate:self.facade];
    }
    
}
/*上传门脸照片*/
-(void)environmentTapAction{
    
    
}
#pragma mark -赋值
-(void)setData:(NSDictionary *)Data{
#pragma mark ———————— 店铺信息数据
    
    NSString *store_address = [NSString stringWithFormat:@"%@",Data[@"store_address"]];
    if ([[MethodCommon judgeStringIsNull:store_address] isEqualToString:@""]) {
        store_address = @"";
    }else{
        self.AView_address.textColor = UIColorFromRGB(0x222222);
        self.AView_address.text = store_address;
    }
    
    
    NSString *specific_location = [NSString stringWithFormat:@"%@",Data[@"specific_location"]];
    if ([[MethodCommon judgeStringIsNull:specific_location] isEqualToString:@""]) {
        specific_location = @"";
    }else{
        self.AView_MenP.text = specific_location;
    }
    
     /** 联系人 */
    NSString *merchant_name = [NSString stringWithFormat:@"%@",Data[@"merchant_name"]];
    if ([[MethodCommon judgeStringIsNull:merchant_name] isEqualToString:@""]) {
        merchant_name = @"";
    }else{
        self.AView_Name.text = merchant_name;
    }
    /** 联系手机 */
    NSString *merchant_mobile = [NSString stringWithFormat:@"%@",Data[@"merchant_mobile"]];
    if ([[MethodCommon judgeStringIsNull:merchant_mobile] isEqualToString:@""]) {
        
    }else{
        self.AView_Phone.text = merchant_mobile;
    }
    /** 固定电话 */
    NSString *merchant_telephone =[NSString stringWithFormat:@"%@",Data[@"merchant_telephone"]];
    if ([[MethodCommon judgeStringIsNull:merchant_telephone] isEqualToString:@""]) {
        
    }else{
        self.AView_GPhone.text =merchant_telephone;
    }
    /** 营业周期 */
    NSString *timeS = [NSString stringWithFormat:@"%@",Data[@"business_times"]];
    if ([[MethodCommon judgeStringIsNull:timeS] isEqualToString:@""]) {
        
    }else{
        self.AView_Cycle.text = timeS;
    }
    /** 营业时间 */
    NSString *hourS = [NSString stringWithFormat:@"%@",Data[@"business_hours"]];
    if ([[MethodCommon judgeStringIsNull:hourS] isEqualToString:@""]) {
        
    }else{
        self.AView_Time.text = hourS;
    }
    
    
 #pragma mark ———————— 温馨提醒数据
   //reminder
    //is_selected
    NSArray *Array = Data[@"reminder"];
    _ReminData = Array;
    self.ReminLabel_Y = 60;
    CGRect rect = CGRectNull;
    for (int i = 0; i<Array.count; i++) {
        NSString *lableString = [NSString stringWithFormat:@"%@",Array[i][@"info_content"]];
        rect = [lableString boundingRectWithSize:CGSizeMake(self.BView_backview.width-80, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        CGFloat infoLabelH = ceilf(rect.size.height);
        
        self.ReminV = [[SelectedRemin alloc]initWithFrame:CGRectMake(10, self.ReminLabel_Y, self.BView_backview.width-20, infoLabelH+30)];
        self.ReminV.delagate = self;
        self.ReminV.Data = Array[i];
        self.ReminV.status = ReminVieWStatus_1;
        self.ReminV.tag = i;
        [self.BView_backview addSubview:self.ReminV];
        
        /*是否选中*/
        NSString *is_selected = [NSString stringWithFormat:@"%@",Array[i][@"is_selected"]];
        if ([is_selected isEqualToString:@"1"]) {
            self.ReminV.ReminIcon.selected = YES;
//            [self.ReminArray addObject:[NSString stringWithFormat:@"%@",Array[i][@"info_id"]]];

        }
        
        [self.ReminV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.mas_offset(self.BView_backview.width-20);
            make.top.mas_offset(self.ReminLabel_Y);
            make.height.mas_offset(infoLabelH+20);
        }];
        self.ReminLabel_Y = self.ReminV.bottom;
        
    }

    //reminder2
    [self.BView_backview addSubview:self.ReminderView];
    [self.ReminderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(80);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.mas_offset(self.ReminLabel_Y +10);
    }];
    /*输入图标*/
    UIImageView *ReminderIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5.5, 16, 16)];
    ReminderIcon.image = [UIImage imageNamed:@"icn_input_pen"];
    [self.ReminderView addSubview:ReminderIcon];
    
   self.ReminTF = [[UITextView alloc]initWithFrame:CGRectMake(ReminderIcon.right, 0, self.ReminderView.width - 50, 80)];
    self.ReminTF.backgroundColor = [UIColor clearColor];
    self.ReminTF.textColor = [UIColor blackColor];
    self.ReminTF.font = [UIFont systemFontOfSize:13.f];
    [self.ReminTF jk_addPlaceHolder:@"您还可以输入需要补充的提醒内容。"];
    // 限制 10个字符
//    [textView setValue:@10 forKey:@"limit"];
        self.ReminTF.jk_placeHolderTextView.textColor = UIColorFromRGB(0xCCCCCC);
    [self.ReminderView addSubview:self.ReminTF];
    
    NSString *reminder2 = [NSString stringWithFormat:@"%@",Data[@"reminder2"]];
    if ([[MethodCommon judgeStringIsNull:reminder2] isEqualToString:@""]) {
        
    }else{
        self.ReminTF.jk_placeHolderTextView.hidden = YES;

        self.ReminTF.text = reminder2;

    }
        

    
    self.BView_backview.height = self.ReminderView.bottom - 20;
    UIButton *but = (UIButton *)[self viewWithTag:self.isSelete+10];
    if (self.isSelete == 1) {
        [self ButtonAction:but];
    }
#pragma mark ———————— 照片数据
    NSString *door_face_pic = [NSString stringWithFormat:@"%@",Data[@"door_face_pic"]];
    [self.facade setImageWithURL:[NSURL URLWithString:door_face_pic] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];

#pragma mark ———————— 证件数据
    /** 身份证照片 */
    NSString *card_pic = [NSString stringWithFormat:@"%@",Data[@"hand_held_ID_card_pic"]];
    // 用指定字符串分割字符串，返回一个数组
    NSArray *CardArray = [card_pic componentsSeparatedByString:@","];
    
    [self.IdCardOn setImageWithURL:[NSURL URLWithString:CardArray[0]] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
    [self.IdCardUnder setImageWithURL:[NSURL URLWithString:CardArray[1]] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
}
-(void)setReminData:(NSArray *)ReminData{
    _ReminData = ReminData;
    self.ReminLabel_Y = 60;
    CGRect rect = CGRectNull;
    for (int i = 0; i<ReminData.count; i++) {
        NSString *lableString = [NSString stringWithFormat:@"%@",ReminData[i][@"info_content"]];
        rect = [lableString boundingRectWithSize:CGSizeMake(self.BView_backview.width-80, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        CGFloat infoLabelH = ceilf(rect.size.height);
        
        self.ReminV = [[SelectedRemin alloc]initWithFrame:CGRectMake(10, self.ReminLabel_Y, self.BView_backview.width-20, infoLabelH+30)];
        self.ReminV.delagate = self;
        self.ReminV.Data = ReminData[i];
        self.ReminV.status = ReminVieWStatus_1;
        self.ReminV.tag = i;
        [self.BView_backview addSubview:self.ReminV];
        
        
        [self.ReminV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.mas_offset(self.BView_backview.width-20);
            make.top.mas_offset(self.ReminLabel_Y);
            make.height.mas_offset(infoLabelH+20);
        }];
        self.ReminLabel_Y = self.ReminV.bottom;
        
    }
    
    [self.BView_backview addSubview:self.ReminderView];
    [self.ReminderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(80);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.mas_offset(self.ReminLabel_Y +10);
    }];
    /*输入图标*/
    UIImageView *ReminderIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5.5, 16, 16)];
    ReminderIcon.image = [UIImage imageNamed:@"icn_input_pen"];
    [self.ReminderView addSubview:ReminderIcon];
    
    self.ReminTF = [[UITextView alloc]initWithFrame:CGRectMake(ReminderIcon.right, 0, self.ReminderView.width - 50, 80)];
    self.ReminTF.backgroundColor = [UIColor yellowColor];
    self.ReminTF.textColor = [UIColor blackColor];
    self.ReminTF.font = [UIFont systemFontOfSize:13.f];
    [self.ReminTF jk_addPlaceHolder:@"您还可以输入需要补充的提醒内容。"];
    // 限制 10个字符
    //    [textView setValue:@10 forKey:@"limit"];
    self.ReminTF.jk_placeHolderTextView.textColor = UIColorFromRGB(0xCCCCCC);
    [self.ReminderView addSubview:self.ReminTF];
    
    
    
    
    
    self.BView_backview.height = self.ReminderView.bottom - 20;
    UIButton *but = (UIButton *)[self viewWithTag:self.isSelete+10];
    if (self.isSelete == 1) {
        [self ButtonAction:but];
    }
    
    
    
}
#pragma mark - 保存选择温馨提示数据
-(void)SelectedReminAction:(UIView *)ReminV and:(UIButton *)icon{
    NSLog(@"%ld",icon.tag);
    if (icon.isSelected) {
        [self.ReminArray addObject:[NSString stringWithFormat:@"%ld",(long)icon.tag]];
    } else {
        [self.ReminArray removeObject:[NSString stringWithFormat:@"%ld",(long)icon.tag]];
    }
    [self reminActionArray];
   
}
-(void)reminActionArray{
    NSMutableArray *Aray = [NSMutableArray array];
    
    for (NSString *reminID in self.ReminArray) {
        
        for (NSDictionary *dict in self.ReminData) {
            NSString *ID = [NSString stringWithFormat:@"%@",dict[@"info_id"]];
            if ([reminID isEqualToString:ID]) {
                [Aray addObject:dict];
            }
            
        }
        
    }
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(SetReminder:)]) {
        [self.delagate SetReminder:Aray];
        
    }
}
#pragma mark - 懒加载
#pragma mark ———————— 店铺信息UI ————————
-(UIView *)AView{
    if (!_AView) {
        _AView = [[UIView alloc] init];
        _AView.frame = CGRectMake(0,50,self.width,238);
        _AView.backgroundColor =[UIColor clearColor];
    }
    return _AView;
}
-(UILabel *)AView_address{
    if (!_AView_address) {
        _AView_address = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_address.font = [UIFont systemFontOfSize:15];
        _AView_address.text = @"点击标记地址";
        _AView_address.textColor = UIColorFromRGB(0xCCCCCC);
        _AView_address.numberOfLines = 2;
    }
    return _AView_address;
}

-(UITextField *)AView_MenP{
    if (!_AView_MenP) {
        _AView_MenP = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_MenP.placeholder = @"详细地址，例5楼501室";
        _AView_MenP.textColor = UIColorFromRGB(0x222222);
        _AView_MenP.font = [UIFont systemFontOfSize:15];
    }
    return _AView_MenP;
}
-(UITextField *)AView_Name{
    if (!_AView_Name) {
        _AView_Name = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_Name.placeholder = @"请输入联系人真实姓名";
        _AView_Name.textColor = UIColorFromRGB(0x222222);
        _AView_Name.font = [UIFont systemFontOfSize:15];
    }
    return _AView_Name;
}
-(UITextField *)AView_Phone{
    if (!_AView_Phone) {
        _AView_Phone = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_Phone.placeholder = @"请输入联系人真实手机号";
        _AView_Phone.textColor = UIColorFromRGB(0x222222);
        _AView_Phone.font = [UIFont systemFontOfSize:15];
        _AView_Phone.keyboardType = UIKeyboardTypePhonePad;
    }
    return _AView_Phone;
}
-(UITextField *)AView_GPhone{
    if (!_AView_GPhone) {
        _AView_GPhone = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_GPhone.placeholder = @"可选填，座机号码";
        _AView_GPhone.textColor = UIColorFromRGB(0x222222);
        _AView_GPhone.font = [UIFont systemFontOfSize:15];
        _AView_GPhone.keyboardType = UIKeyboardTypePhonePad;
    }
    return _AView_GPhone;
}
-(UITextField *)AView_Cycle{
    if (!_AView_Cycle) {
        _AView_Cycle = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_Cycle.placeholder = @"请选择营业的周期";
        _AView_Cycle.textColor = UIColorFromRGB(0x222222);
        _AView_Cycle.font = [UIFont systemFontOfSize:15];
    }
    return _AView_Cycle;
}
-(UITextField *)AView_Time{
    if (!_AView_Time) {
        _AView_Time = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_Time.placeholder = @"请选择营业的时间";
        _AView_Time.textColor = UIColorFromRGB(0x222222);
        _AView_Time.font = [UIFont systemFontOfSize:15];
    }
    return _AView_Time;
}
-(UITextField *)AView_price{
    if (!_AView_price) {
        _AView_price = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_price.placeholder = @"请输入店铺人均消费金额（元）";
        _AView_price.textColor = UIColorFromRGB(0x222222);
        _AView_price.font = [UIFont systemFontOfSize:15];
        _AView_price.keyboardType = UIKeyboardTypePhonePad;
    }
    return _AView_price;
}
-(UITextField *)AView_jie{
    if (!_AView_jie) {
        _AView_jie = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_jie.placeholder = @"简短的店铺描述，15字之内";
        _AView_jie.textColor = UIColorFromRGB(0x222222);
        _AView_jie.font = [UIFont systemFontOfSize:15];
        _AView_jie.delegate = self;
        [_AView_jie addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    }
    return _AView_jie;
}
-(UILabel *)AView_jieSun{
    if (!_AView_jieSun) {
        _AView_jieSun = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _AView_jieSun.font = [UIFont systemFontOfSize:15];
        _AView_jieSun.text = @"0/15";
        _AView_jieSun.textColor = UIColorFromRGB(0x999999);
        _AView_jieSun.numberOfLines = 1;
    }
    return _AView_jieSun;
}
#pragma mark ———————— 温馨提醒UI ————————
-(UIView *)BView{
    if (!_BView) {
        _BView = [[UIView alloc] init];
        _BView.frame = CGRectMake(0,50,self.width,322);
        _BView.backgroundColor =[UIColor clearColor];
        _BView. hidden = YES;
    }
    return _BView;
}
-(UIView *)ReminderView{
    if (!_ReminderView) {
        _ReminderView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, ScreenW-30, 80)];
        _ReminderView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _ReminderView.layer.cornerRadius = 5;
        _ReminderView.layer.borderColor  = UIColorFromRGB(0xEAEAEA).CGColor;
        _ReminderView.layer.borderWidth = 1;
    }
    return _ReminderView;
}
#pragma mark ———————— 照片UI ————————
-(UIView *)CView{
    if (!_CView) {
        _CView = [[UIView alloc] init];
        _CView.frame = CGRectMake(0,50,self.width,398);
        _CView.backgroundColor =[UIColor clearColor];
        _CView. hidden = YES;
        
    }
    return _CView;
}
#pragma mark ———————— 证件UI ————————
-(UIView *)DView{
    if (!_DView) {
        _DView = [[UIView alloc] init];
        _DView.frame = CGRectMake(0,50,self.width,680);
        _DView.backgroundColor =[UIColor clearColor];
        _DView. hidden = YES;
        
    }
    return _DView;
}

-(NSMutableArray *)ReminArray{
    if (!_ReminArray) {
        _ReminArray = [NSMutableArray array];
    }
    return _ReminArray;
}
@end
