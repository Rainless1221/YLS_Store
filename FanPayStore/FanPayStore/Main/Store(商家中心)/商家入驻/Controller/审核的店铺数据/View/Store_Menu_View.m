//
//  Store_Menu_View.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "Store_Menu_View.h"

@implementation Store_Menu_View

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.TypeView = 0;
        [self createUI];
    }
    return self;
}
#pragma mark -  UI
-(void)createUI{
    //横线
    UIView *line_view = [[UIView alloc] init];
    line_view.frame = CGRectMake(0,0,self.width,1);
    line_view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:line_view];
    [line_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(50);
        make.height.mas_offset(1);
    }];
    //横线
    UIView *bottomline_view = [[UIView alloc] init];
    bottomline_view.frame = CGRectMake(0,0,self.width,1);
    bottomline_view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:bottomline_view];
    [bottomline_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-50);
        make.height.mas_offset(1);
    }];
    
    //编辑按钮
    UIButton *Button_editor  = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button_editor setTitle:@"点击编辑" forState:UIControlStateNormal];
    Button_editor.titleLabel.font = [UIFont systemFontOfSize:14];
    [Button_editor setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Button_editor setImage:[UIImage imageNamed:@"ico_edit_b_info"] forState:UIControlStateNormal];
    Button_editor.layer.cornerRadius = 14;
    Button_editor.layer.borderWidth =1;
    [Button_editor addTarget:self action:@selector(editorAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:Button_editor];
    [Button_editor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.bottom.mas_offset(-11);
        make.size.mas_offset(CGSizeMake(96, 28));
    }];
    
    NSArray *menuArray = @[@"店铺信息",@"温馨提醒",@"照片",@"证件"];
    for (int i = 0; i<menuArray.count; i++) {
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = CGRectMake(self.width/4*i, 0, self.width/4, 50);
        [Button setTitle:[NSString stringWithFormat:@"%@",menuArray[i]] forState:UIControlStateNormal];
        [Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Button setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        Button.titleLabel.font = [UIFont systemFontOfSize:15];
        Button.tag = i+10;
        [Button addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Button];
        if (i == 0) {
            Button.selected = YES;
            self.Menu_line.centerX = Button.centerX;
            [self addSubview:self.Menu_line];

        }
        
    }
    
    self.SizeHeight = 290+100;
    self.TypeView =0;
#pragma mark ———————— 店铺信息 ————————
    [self addSubview:self.AView];
    [self.AView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(52);
        make.bottom.mas_offset(-52);
    }];
    self.AView_text1 = [[UILabel alloc]initWithFrame:CGRectMake(10,20, 60, 13)];
    self.AView_text1.text = @"店铺地址";
    self.AView_text1.textColor = UIColorFromRGB(0x999999);
    self.AView_text1.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_text1];
    [self.AView_text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(65, 13));
    }];
    
    self.AView_Add = [[UILabel alloc]initWithFrame:CGRectMake(self.AView_text1.right+15,20, 60, 13)];
    self.AView_Add.text = @"暂无  ";
    self.AView_Add.textColor = UIColorFromRGB(0x222222);
    self.AView_Add.font = [UIFont systemFontOfSize:14];
    self.AView_Add.numberOfLines = 2;
    [self.AView addSubview:self.AView_Add];
    [self.AView_Add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.equalTo(self.AView_text1.mas_right).offset(15);
        make.right.mas_offset(-10);
    }];
    
    self.AView_text2 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.AView_Add.bottom+14, 60, 13)];
    self.AView_text2.text = @"联系人";
    self.AView_text2.textColor = UIColorFromRGB(0x999999);
    self.AView_text2.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_text2];
    [self.AView_text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_Add.mas_bottom).offset(14);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(65, 13));
    }];
    self.AView_Name = [[UILabel alloc]initWithFrame:CGRectMake(self.AView_text2.right+15,self.AView_text2.top, 60, 13)];
    self.AView_Name.text = @"暂无";
    self.AView_Name.textColor = UIColorFromRGB(0x222222);
    self.AView_Name.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_Name];
    [self.AView_Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_Add.mas_bottom).offset(14);
        make.left.equalTo(self.AView_text1.mas_right).offset(15);
        make.right.mas_offset(-10);
    }];
    
    self.AView_text3 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.AView_Name.bottom+14, 60, 13)];
    self.AView_text3.text = @"手机号码";
    self.AView_text3.textColor = UIColorFromRGB(0x999999);
    self.AView_text3.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_text3];
    [self.AView_text3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text2.mas_bottom).offset(14);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(65, 13));
    }];
    self.AView_Phone = [[UILabel alloc]initWithFrame:CGRectMake(self.AView_text3.right+15,self.AView_text3.top, 60, 13)];
    self.AView_Phone.text = @"暂无";
    self.AView_Phone.textColor = UIColorFromRGB(0x222222);
    self.AView_Phone.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_Phone];
    [self.AView_Phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text2.mas_bottom).offset(14);
        make.left.equalTo(self.AView_text1.mas_right).offset(15);
        make.right.mas_offset(-10);
    }];
    self.AView_text4 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.AView_Phone.bottom+14, 60, 13)];
    self.AView_text4.text = @"固定号码";
    self.AView_text4.textColor = UIColorFromRGB(0x999999);
    self.AView_text4.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_text4];
    [self.AView_text4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text3.mas_bottom).offset(14);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(65, 13));
    }];
    
    self.AView_Gphone = [[UILabel alloc]initWithFrame:CGRectMake(self.AView_text4.right+15,self.AView_text4.top, 60, 13)];
    self.AView_Gphone.text = @"暂无";
    self.AView_Gphone.textColor = UIColorFromRGB(0x222222);
    self.AView_Gphone.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_Gphone];
    [self.AView_Gphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text3.mas_bottom).offset(14);
        make.left.equalTo(self.AView_text1.mas_right).offset(15);
        make.right.mas_offset(-10);
    }];
    
    self.AView_text5 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.AView_Gphone.bottom+14, 60, 13)];
    self.AView_text5.text = @"营业周期";
    self.AView_text5.textColor = UIColorFromRGB(0x999999);
    self.AView_text5.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_text5];
    [self.AView_text5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text4.mas_bottom).offset(14);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(65, 13));
    }];
    
    self.AView_Cycle = [[UILabel alloc]initWithFrame:CGRectMake(self.AView_text5.right+15,self.AView_text5.top, 60, 13)];
    self.AView_Cycle.text = @"暂无";
    self.AView_Cycle.textColor = UIColorFromRGB(0x222222);
    self.AView_Cycle.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_Cycle];
    [self.AView_Cycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text4.mas_bottom).offset(14);
        make.left.equalTo(self.AView_text1.mas_right).offset(15);
        make.right.mas_offset(-10);
    }];
    
    self.AView_text6 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.AView_Cycle.bottom+14, 60, 13)];
    self.AView_text6.text = @"营业时间";
    self.AView_text6.textColor = UIColorFromRGB(0x999999);
    self.AView_text6.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_text6];
    [self.AView_text6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text5.mas_bottom).offset(14);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(65, 13));
    }];
    
    self.AView_Time= [[UILabel alloc]initWithFrame:CGRectMake(self.AView_text6.right+15,self.AView_text6.top, 60, 13)];
    self.AView_Time.text = @"暂无";
    self.AView_Time.textColor = UIColorFromRGB(0x222222);
    self.AView_Time.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_Time];
    [self.AView_Time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text5.mas_bottom).offset(14);
        make.left.equalTo(self.AView_text1.mas_right).offset(15);
        make.right.mas_offset(-10);
    }];
    
    self.AView_text7 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.AView_Time.bottom+14, 60, 13)];
    self.AView_text7.text = @"人均消费";
    self.AView_text7.textColor = UIColorFromRGB(0x999999);
    self.AView_text7.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_text7];
    [self.AView_text7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text6.mas_bottom).offset(14);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(65, 13));
    }];
    
    self.AView_price= [[UILabel alloc]initWithFrame:CGRectMake(self.AView_text7.right+15,self.AView_text7.top, 60, 13)];
    self.AView_price.text = @"暂无";
    self.AView_price.textColor = UIColorFromRGB(0x222222);
    self.AView_price.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_price];
    [self.AView_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text6.mas_bottom).offset(14);
        make.left.equalTo(self.AView_text1.mas_right).offset(15);
        make.right.mas_offset(-10);
    }];
    
    self.AView_text8 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.AView_Time.bottom+14, 60, 13)];
    self.AView_text8.text = @"商家简介";
    self.AView_text8.textColor = UIColorFromRGB(0x999999);
    self.AView_text8.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_text8];
    [self.AView_text8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text7.mas_bottom).offset(14);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(65, 13));
    }];
    
    self.AView_Jie= [[UILabel alloc]initWithFrame:CGRectMake(self.AView_text7.right+15,self.AView_text7.top, 60, 13)];
    self.AView_Jie.text = @"暂无";
    self.AView_Jie.textColor = UIColorFromRGB(0x222222);
    self.AView_Jie.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_Jie];
    [self.AView_Jie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text7.mas_bottom).offset(14);
        make.left.equalTo(self.AView_text1.mas_right).offset(15);
        make.right.mas_offset(-10);
    }];
    
    self.AView_text9 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.AView_Time.bottom+14, 60, 13)];
    self.AView_text9.text = @"关键字";
    self.AView_text9.textColor = UIColorFromRGB(0x999999);
    self.AView_text9.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_text9];
    [self.AView_text9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text8.mas_bottom).offset(14);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(65, 13));
    }];
    
    self.AView_Key= [[UILabel alloc]initWithFrame:CGRectMake(self.AView_text8.right+15,self.AView_text8.top, 60, 13)];
    self.AView_Key.text = @"暂无";
    self.AView_Key.textColor = UIColorFromRGB(0x222222);
    self.AView_Key.font = [UIFont systemFontOfSize:14];
    [self.AView addSubview:self.AView_Key];
    [self.AView_Key mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AView_text8.mas_bottom).offset(14);
        make.left.equalTo(self.AView_text1.mas_right).offset(15);
        make.right.mas_offset(-10);
    }];
#pragma mark ———————— 温馨提醒 ————————
    [self addSubview:self.BView];
    [self.BView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(52);
        make.bottom.mas_offset(-52);
    }];
    self.BView_backview = [[UIView alloc] init];
    self.BView_backview.frame = CGRectMake(25,545.5,325,107);
    self.BView_backview.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    self.BView_backview.layer.cornerRadius = 5;
    [self.BView addSubview:self.BView_backview];
    [self.BView_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-20);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(107);
    }];
    self.reminder2 = [[UILabel alloc]init];
    self.reminder2.text = @"还没有填写温馨提醒~";
    self.reminder2.textColor = UIColorFromRGB(0xCCCCCC);
    self.reminder2.font = [UIFont systemFontOfSize:14];
    [self.BView_backview addSubview:self.reminder2];
    
    [self.reminder2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
    }];
    
#pragma mark ———————— 照片 ————————
    [self addSubview:self.CView];
    [self.CView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(52);
        make.bottom.mas_offset(-52);
    }];
    self.CView_text1 = [[UILabel alloc]initWithFrame:CGRectMake(10,20, 60, 13)];
    self.CView_text1.text = @"门脸图片";
    self.CView_text1.textColor = UIColorFromRGB(0x222222);
    self.CView_text1.font = [UIFont systemFontOfSize:15];
    [self.CView addSubview:self.CView_text1];
    [self.CView_text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    self.CView_text2 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.CView_text1.bottom+10, 60, 13)];
    self.CView_text2.text = @"必须能看见完整的门匾、门框";
    self.CView_text2.textColor = UIColorFromRGB(0xCCCCCC);
    self.CView_text2.font = [UIFont systemFontOfSize:13];
    [self.CView addSubview:self.CView_text2];
    [self.CView_text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CView_text1.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    
    /**
     门脸图片
     */
    self.CView_Image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10,self.CView_text2.bottom+19.5,103,103)];
    self.CView_Image1.image = [UIImage imageNamed:@"pic_default_avatar"];
    self.CView_Image1.layer.cornerRadius = 6;
    self.CView_Image1.layer.masksToBounds = YES;
    [self.CView addSubview:self.CView_Image1];

    
    UIView *CView_line1 = [[UIView alloc] init];
    CView_line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.CView addSubview:CView_line1];
    [CView_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(198);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    
    self.CView_text3 = [[UILabel alloc]initWithFrame:CGRectMake(10,CView_line1.bottom+10, 60, 13)];
    self.CView_text3.text = @"上传店内环境照片";
    self.CView_text3.textColor = UIColorFromRGB(0x222222);
    self.CView_text3.font = [UIFont systemFontOfSize:15];
    [self.CView addSubview:self.CView_text3];
    [self.CView_text3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CView_line1.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    self.CView_text4 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.CView_text3.bottom+10, 60, 13)];
    self.CView_text4.text = @"需要包含桌椅，收银台等内容";
    self.CView_text4.textColor = UIColorFromRGB(0xCCCCCC);
    self.CView_text4.font = [UIFont systemFontOfSize:13];
    [self.CView addSubview:self.CView_text4];
    [self.CView_text4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CView_text3.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    
#pragma mark ———————— 证件 ————————
    [self addSubview:self.DView];
    [self.DView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(52);
        make.bottom.mas_offset(-52);
    }];
    self.DView_text1 = [[UILabel alloc]initWithFrame:CGRectMake(10,20, 60, 13)];
    self.DView_text1.text = @"身份证照片";
    self.DView_text1.textColor = UIColorFromRGB(0x222222);
    self.DView_text1.font = [UIFont systemFontOfSize:15];
    [self.DView addSubview:self.DView_text1];
    [self.DView_text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    self.DView_text2 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.DView_text1.bottom+10, 60, 13)];
    self.DView_text2.text = @"手持身份证正面、反面照片";
    self.DView_text2.textColor = UIColorFromRGB(0xCCCCCC);
    self.DView_text2.font = [UIFont systemFontOfSize:13];
    [self.DView addSubview:self.DView_text2];
    [self.DView_text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DView_text1.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    /**
     身份证照片
     */
    self.DView_Image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10,self.DView_text2.bottom+19.5,103,103)];
    self.DView_Image1.image = [UIImage imageNamed:@"pic_default_avatar"];
    self.DView_Image1.layer.cornerRadius = 6;
    self.DView_Image1.layer.masksToBounds = YES;
    [self.DView addSubview:self.DView_Image1];
    [self.DView_Image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.DView_text2.mas_bottom).offset(19.5);
        make.size.mas_offset(CGSizeMake(103, 103));
    }];
    
    self.DView_Image2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.DView_Image1.right+8,self.DView_text2.bottom+19.5,103,103)];
    self.DView_Image2.image = [UIImage imageNamed:@"pic_default_avatar"];
    self.DView_Image2.layer.cornerRadius = 6;
    self.DView_Image2.layer.masksToBounds = YES;
    [self.DView addSubview:self.DView_Image2];
    [self.DView_Image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.DView_Image1.mas_right).offset(8);
        make.top.equalTo(self.DView_text2.mas_bottom).offset(19.5);
        make.size.mas_offset(CGSizeMake(103, 103));
    }];
    
    UIView *DView_line1 = [[UIView alloc] init];
    DView_line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.DView addSubview:DView_line1];
    [DView_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DView_Image1.mas_bottom).offset(20);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    self.DView_text3 = [[UILabel alloc]initWithFrame:CGRectMake(10,DView_line1.bottom+10, 60, 13)];
    self.DView_text3.text = @"营业执照";
    self.DView_text3.textColor = UIColorFromRGB(0x222222);
    self.DView_text3.font = [UIFont systemFontOfSize:15];
    [self.DView addSubview:self.DView_text3];
    [self.DView_text3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DView_line1.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    self.DView_text4 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.DView_text3.bottom+10, 60, 13)];
    self.DView_text4.text = @"营业执照正面照片";
    self.DView_text4.textColor = UIColorFromRGB(0xCCCCCC);
    self.DView_text4.font = [UIFont systemFontOfSize:13];
    [self.DView addSubview:self.DView_text4];
    [self.DView_text4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DView_text3.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    
    self.DView_Image3 = [[UIImageView alloc] initWithFrame:CGRectMake(10,self.DView_text4.bottom+25,103,103)];
    self.DView_Image3.image = [UIImage imageNamed:@"pic_default_avatar"];
    self.DView_Image3.layer.cornerRadius = 6;
    self.DView_Image3.layer.masksToBounds = YES;
    [self.DView addSubview:self.DView_Image3];
    [self.DView_Image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DView_text4.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(103, 103));
    }];
    UIView *DView_line2 = [[UIView alloc] init];
    DView_line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.DView addSubview:DView_line2];
    [DView_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DView_Image3.mas_bottom).offset(20);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    
    self.DView_text5 = [[UILabel alloc]initWithFrame:CGRectMake(10,DView_line2.bottom+10, 60, 13)];
    self.DView_text5.text = @"经营许可证";
    self.DView_text5.textColor = UIColorFromRGB(0x222222);
    self.DView_text5.font = [UIFont systemFontOfSize:15];
    [self.DView addSubview:self.DView_text5];
    [self.DView_text5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DView_line2.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    self.DView_text6 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.DView_text5.bottom+10, 60, 13)];
    self.DView_text6.text = @"经营许可证书照片";
    self.DView_text6.textColor = UIColorFromRGB(0xCCCCCC);
    self.DView_text6.font = [UIFont systemFontOfSize:13];
    [self.DView addSubview:self.DView_text6];
    [self.DView_text6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DView_text5.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
    }];
    
    self.DView_Image4 = [[UIImageView alloc] initWithFrame:CGRectMake(10,self.DView_text6.bottom+25,103,103)];
    self.DView_Image4.image = [UIImage imageNamed:@"pic_default_avatar"];
    self.DView_Image4.layer.cornerRadius = 6;
    self.DView_Image4.layer.masksToBounds = YES;
    [self.DView addSubview:self.DView_Image4];
    [self.DView_Image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DView_text6.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(103, 103));
    }];
    
}
#pragma mark - /*切换*/
-(void)ButtonAction:(UIButton *)sender{
    
    for (int i = 0; i<4; i++) {
        if (sender.tag == i+10) {
            sender.selected = YES;
            self.Menu_line.centerX = sender.centerX;
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
            self.SizeHeight = 290+100;
            self.TypeView =0;
            break;
        case 11:
            self.AView.hidden = YES;
            self.BView.hidden = NO;
            self.CView.hidden = YES;
            self.DView.hidden = YES;
            self.SizeHeight = self.ReminLabel_Y+250;
            self.TypeView = 1;
            break;
        case 12:
            self.AView.hidden = YES;
            self.BView.hidden = YES;
            self.CView.hidden = NO;
            self.DView.hidden = YES;
            self.SizeHeight = self.Image_Y+120;
            self.TypeView = 2;
            break;
        case 13:
            self.AView.hidden = YES;
            self.BView.hidden = YES;
            self.CView.hidden = YES;
            self.DView.hidden = NO;
            self.SizeHeight = self.DImage_Y+120;
            self.TypeView = 3;
            break;
        default:
            break;
    }
   
    if (self.SizeHejightBlock) {
        self.SizeHejightBlock(self.SizeHeight);
    }
   
    
}
#pragma mark - 编辑
-(void)editorAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(editorAction:)]) {
        [self.delagate editorAction:self.TypeView];
        
    }
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    #pragma mark ———————— 店铺信息赋值
    /*地址*/
    NSString *store_address = [NSString stringWithFormat:@"%@",Data[@"store_address"]];
    NSString *specific_location = [NSString stringWithFormat:@"%@",Data[@"specific_location"]];
    if ([[MethodCommon judgeStringIsNull:store_address] isEqualToString:@""]) {
        store_address = @"";
    }
    if ([[MethodCommon judgeStringIsNull:specific_location] isEqualToString:@""]) {
        specific_location = @"";
    }
    self.AView_Add.text = [NSString stringWithFormat:@"%@%@",store_address,specific_location];
    
    /** 联系人 */
    NSString *merchant_name = [NSString stringWithFormat:@"%@",Data[@"merchant_name"]];
    if ([[MethodCommon judgeStringIsNull:merchant_name] isEqualToString:@""]) {
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
        self.AView_Gphone.text =merchant_telephone;
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
    
    
    
    #pragma mark ———————— 温馨提示赋值

    
    NSMutableArray *Array = [NSMutableArray array];
    self.ReminLabel_Y = 5;
    CGRect rect = CGRectNull;
    
    for (NSDictionary *dict  in Data[@"reminder"]) {
        /*是否选中*/
        NSString *is_selected = [NSString stringWithFormat:@"%@",dict[@"is_selected"]];
        if ([is_selected isEqualToString:@"1"]) {
            [Array addObject:dict];
        }
        
    }
    //依次遍历self.view中的所有子视图
    for(id tmpView in [self.BView subviews])
    {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[SelectedRemin class]]){
            SelectedRemin *imgView = (SelectedRemin *)tmpView;
//            if(imgView.tag == 1) {//判断是否满足自己要删除的子视图的条件
                [imgView removeFromSuperview]; //删除子视图
//                break; //跳出for循环，因为子视图已经找到，无须往下遍历
//            }
        }
    }
    
    for (int i = 0; i<Array.count; i++) {
       
        NSString *lableString = [NSString stringWithFormat:@"%@",Array[i][@"info_content"]];
        rect = [lableString boundingRectWithSize:CGSizeMake(self.BView.width-60, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        CGFloat infoLabelH = ceilf(rect.size.height);
        
        self.ReminV = [[SelectedRemin alloc]initWithFrame:CGRectMake(0, self.ReminLabel_Y, self.BView.width-10, infoLabelH+10)];
        self.ReminV.ReminLable.text = lableString;
        self.ReminV.status = ReminVieWStatus_2;
        self.ReminV.tag = i;
        [self.BView addSubview:self.ReminV];
        
        
        [self.ReminV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.width.mas_offset(self.BView.width-10);
            make.top.mas_offset(self.ReminLabel_Y);
            make.height.mas_offset(infoLabelH);
        }];
        self.ReminLabel_Y = self.ReminV.bottom;
        
    }
    
    /** 温馨提醒 */
    NSString *remString = Data[@"reminder2"];
    if ([[MethodCommon judgeStringIsNull:remString] isEqualToString:@""]) {
        
    }else{
        self.reminder2.textColor = UIColorFromRGB(0x222222);
        self.reminder2.text = remString;
        [self.reminder2 sizeToFit];
    }
    
#pragma mark ———————— 照片赋值
    
    NSString *door_face_pic = [NSString stringWithFormat:@"%@",Data[@"door_face_pic"]];
    [self.CView_Image1 setImageWithURL:[NSURL URLWithString:door_face_pic] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
    
    
    /** 店里环境 */
    NSString *store_environment_pics = [NSString stringWithFormat:@"%@",Data[@"store_environment_pics"]];
    // 用指定字符串分割字符串，返回一个数组
    NSArray *picsarray = [store_environment_pics componentsSeparatedByString:@","];
    
    int cuon = (ScreenW - 20)/110;

    for (int i = 0; i<picsarray.count; i++) {
        NSInteger index = i % cuon;
        NSInteger page = i / cuon;
        UIImageView*CView_Image = [[UIImageView alloc] initWithFrame:CGRectMake(10+index*110,(self.CView_text4.bottom+19.5)+page*110,103,103)];
//        CView_Image.image = [UIImage imageNamed:@"pic_default_avatar"];
        [CView_Image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",picsarray[i]]] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];

        CView_Image.layer.cornerRadius = 6;
        CView_Image.layer.masksToBounds = YES;
        [self.CView addSubview:CView_Image];
        self.Image_Y = CView_Image.bottom;
    }
#pragma mark ———————— 证件赋值
    /** 身份证照片 */
    NSString *card_pic = [NSString stringWithFormat:@"%@",Data[@"hand_held_ID_card_pic"]];
    // 用指定字符串分割字符串，返回一个数组
    NSArray *CardArray = [card_pic componentsSeparatedByString:@","];
    
    [self.DView_Image1 setImageWithURL:[NSURL URLWithString:CardArray[0]] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
    [self.DView_Image2 setImageWithURL:[NSURL URLWithString:CardArray[1]] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];

    //business_license_pic
    NSString *business_license_pic = [NSString stringWithFormat:@"%@",Data[@"business_license_pic"]];
    [self.DView_Image3 setImageWithURL:[NSURL URLWithString:business_license_pic] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
    [self.DView_Image3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(self.DView.width-20,165));
    }];
    //business_permit_pic
    NSString *business_permit_pic = [NSString stringWithFormat:@"%@",Data[@"business_permit_pic"]];
    [self.DView_Image4 setImageWithURL:[NSURL URLWithString:business_permit_pic] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
    [self.DView_Image4 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(self.DView.width-20, 165));
    }];
    
    self.DImage_Y = self.DView_Image4.bottom+(165-103)+(165-103);
}
#pragma mark - 懒加载
-(UIView *)Menu_line{
    if (!_Menu_line) {
        _Menu_line = [[UIView alloc] init];
        _Menu_line.frame = CGRectMake(0,50,self.width/4,2);
        _Menu_line.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
        _Menu_line.layer.shadowColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:0.4].CGColor;
        _Menu_line.layer.shadowOffset = CGSizeMake(0,1);
        _Menu_line.layer.shadowOpacity = 1;
        _Menu_line.layer.shadowRadius = 3;
        _Menu_line.layer.cornerRadius = 1;
    }
    return _Menu_line;
}
#pragma mark ———————— 店铺信息 ————————
-(UIView *)AView{
    if (!_AView) {
        _AView = [[UIView alloc] init];
        _AView.frame = CGRectMake(0,50,self.width,238);
        _AView.backgroundColor =[UIColor whiteColor];
    }
    return _AView;
}
#pragma mark ———————— 温馨提醒 ————————
-(UIView *)BView{
    if (!_BView) {
        _BView = [[UIView alloc] init];
        _BView.frame = CGRectMake(0,50,self.width,322);
        _BView.backgroundColor =[UIColor whiteColor];
      _BView. hidden = YES;
    }
    return _BView;
}
#pragma mark ———————— 照片 ————————
-(UIView *)CView{
    if (!_CView) {
        _CView = [[UIView alloc] init];
        _CView.frame = CGRectMake(0,50,self.width,398);
        _CView.backgroundColor =[UIColor whiteColor];
        _CView. hidden = YES;

    }
    return _CView;
}
#pragma mark ———————— 证件 ————————
-(UIView *)DView{
    if (!_DView) {
        _DView = [[UIView alloc] init];
        _DView.frame = CGRectMake(0,50,self.width,680);
        _DView.backgroundColor =[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _DView. hidden = YES;

    }
    return _DView;
}



@end
