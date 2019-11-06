//
//  StoreStatusView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "StoreStatusView.h"

@implementation StoreStatusView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        
    }
    return self;
}
#pragma mark --- createUI ---
-(void)createUI{
#pragma mark --------------店铺名称等--------------------
    
    
    self.View_Names = [[UIView alloc] init];
    self.View_Names.frame = CGRectMake(autoScaleW(15),autoScaleW(108),ScreenW - autoScaleW(30),185.5);
    self.View_Names.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.View_Names.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.View_Names.layer.shadowOffset = CGSizeMake(0,5);
    self.View_Names.layer.shadowOpacity = 1;
    self.View_Names.layer.shadowRadius = 10;
    self.View_Names.layer.cornerRadius = 5;
    
    [self addSubview:self.View_Names];
    
    
    
    [self.View_Names addSubview:self.store_logo];
    [self.store_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(-autoScaleW(72/2));
        make.size.mas_offset(CGSizeMake(72, 72));
        make.centerX.mas_offset(0);
    }];
    
    
    
    [self.View_Names addSubview:self.store_name];
    [self.store_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_logo.mas_bottom).offset(40);
        make.size.mas_offset(CGSizeMake(self.View_Names.width, 15));
        make.centerX.mas_offset(0);
    }];
    [self.View_Names addSubview:self.fans_number];
    [self.fans_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_name.mas_bottom).offset(12);
        make.size.mas_offset(CGSizeMake(self.View_Names.width/3, 24));
        make.centerX.mas_offset(-(self.View_Names.width/4));
    }];
    [self.View_Names addSubview:self.goods_number];
    [self.goods_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_name.mas_bottom).offset(12);
        make.size.mas_offset(CGSizeMake(self.View_Names.width/3, 24));
        make.centerX.mas_offset(self.View_Names.width/4);
    }];
    
    [self.View_Names addSubview:self.category_icon];
    [self.category_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_logo.mas_bottom).offset(13);
        make.size.mas_offset(CGSizeMake(16, 16));
        make.left.mas_offset(autoScaleW(122));
    }];
    
    [self.View_Names addSubview:self.category_name];
    [self.category_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_logo.mas_bottom).offset(13);
        make.size.mas_offset(CGSizeMake(self.category_name.width, 15));
        make.left.equalTo(self.category_icon.mas_right).offset(5);
    }];
    UIView *view_line1 = [[UIView alloc] init];
    view_line1.frame = CGRectMake(0,self.View_Names.height - 50,self.View_Names.width,0.5);
    view_line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_Names addSubview:view_line1];
    
    /* 点击编辑 */
    UIButton *NamesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NamesButton.frame = CGRectMake(124,147,96,28);
    [NamesButton setTitle:@" 点击编辑" forState:UIControlStateNormal];
    [NamesButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
    [NamesButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(14)]];
    NamesButton.layer.borderWidth = 1;
    NamesButton.layer.borderColor = UIColorFromRGB(0x8D8D8D).CGColor;
    NamesButton.layer.cornerRadius = 14;NamesButton.tag = 1;
    [NamesButton setImage:[UIImage imageNamed:@"ico_edit_b_info"] forState:UIControlStateNormal];
    [NamesButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.View_Names addSubview:NamesButton];

#pragma mark --------------店铺信息--------------------
    self.View_Store = [[UIView alloc] init];
    self.View_Store.frame = CGRectMake(autoScaleW(15),self.View_Names.bottom + 15,ScreenW - autoScaleW(30),294.5);
    self.View_Store.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.View_Store.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.View_Store.layer.shadowOffset = CGSizeMake(0,5);
    self.View_Store.layer.shadowOpacity = 1;
    self.View_Store.layer.shadowRadius = 10;
    self.View_Store.layer.cornerRadius = 5;
    
    
    [self addSubview:self.View_Store];
    
    
    UILabel *label_Store = [[UILabel alloc] init];
    label_Store.frame = CGRectMake(10,18,autoScaleW(100),14.5);
    label_Store.numberOfLines = 0;
    [self.View_Store addSubview:label_Store];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"店铺信息" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_Store.attributedText = string;
    
    /** 店铺个人等信息 */
//    NSArray *infoArr = @[@"联系人",@"手机号码",@"固定号码",@"营业周期",@"营业时间"];
    
    UIImageView *image_info = [[UIImageView alloc]initWithFrame:CGRectMake(10, 71, autoScaleW(19), 19)];
    image_info.image = [UIImage imageNamed:@"icn_blue_location"];
    [self.View_Store addSubview:image_info];
    
    [self.View_Store addSubview:self.store_address];
    [self.store_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image_info.mas_right).offset(10);
        make.top.mas_offset(71);
        make.right.mas_offset(-22);
        make.height.mas_offset(autoScaleW(34.5));
    }];
    
    UILabel *label_info1 = [[UILabel alloc]initWithFrame:CGRectMake(10,self.store_address.bottom+14,60,13)];
    label_info1.numberOfLines = 0;
    label_info1.font = [UIFont systemFontOfSize:autoScaleW(14)];
    label_info1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_info1.text = @"联系人";
    [self.View_Store addSubview:label_info1];
    
    [self.View_Store addSubview:self.merchant_name];
    [self.merchant_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label_info1.mas_right).offset(10);
        make.centerY.equalTo(label_info1.mas_centerY).offset(0);
        make.right.mas_offset(-22);
    }];
    
    
    
    
    UILabel *label_info2 = [[UILabel alloc]initWithFrame:CGRectMake(10,label_info1.bottom +15,60,13)];
    label_info2.numberOfLines = 0;
    label_info2.font = [UIFont systemFontOfSize:autoScaleW(14)];
    label_info2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_info2.text = @"手机号码";
    [self.View_Store addSubview:label_info2];
    
    [self.View_Store addSubview:self.merchant_mobile];
    [self.merchant_mobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label_info2.mas_right).offset(10);
        make.centerY.equalTo(label_info2.mas_centerY).offset(0);
        make.right.mas_offset(-22);
    }];
    
    
    UILabel *label_info3 = [[UILabel alloc]initWithFrame:CGRectMake(10,label_info2.bottom +15,60,13)];
    label_info3.numberOfLines = 0;
    label_info3.font = [UIFont systemFontOfSize:autoScaleW(14)];
    label_info3.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_info3.text = @"固定号码";
    [self.View_Store addSubview:label_info3];
    
    [self.View_Store addSubview:self.merchant_telephone];
    [self.merchant_telephone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label_info3.mas_right).offset(10);
        make.centerY.equalTo(label_info3.mas_centerY).offset(0);
        make.right.mas_offset(-22);
    }];
    
    
    UILabel *label_info4 = [[UILabel alloc]initWithFrame:CGRectMake(10,label_info3.bottom +15,60,13)];
    label_info4.numberOfLines = 0;
    label_info4.font = [UIFont systemFontOfSize:autoScaleW(14)];
    label_info4.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_info4.text = @"营业周期";
    [self.View_Store addSubview:label_info4];
    
    
    [self.View_Store addSubview:self.business_times];
    [self.business_times mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label_info4.mas_right).offset(10);
        make.centerY.equalTo(label_info4.mas_centerY).offset(0);
        make.right.mas_offset(-22);
    }];
    
    
    UILabel *label_info5 = [[UILabel alloc]initWithFrame:CGRectMake(10,label_info4.bottom +15,60,13)];
    label_info5.numberOfLines = 0;
    label_info5.font = [UIFont systemFontOfSize:autoScaleW(14)];
    label_info5.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_info5.text = @"营业时间";
    [self.View_Store addSubview:label_info5];
    
    
    
    [self.View_Store addSubview:self.business_hours];
    [self.business_hours mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label_info5.mas_right).offset(10);
        make.centerY.equalTo(label_info5.mas_centerY).offset(0);
        make.right.mas_offset(-22);
    }];
    
    
    UIView *view_line2 = [[UIView alloc] init];
    view_line2.frame = CGRectMake(10, 50,self.View_Store.width - 20,0.5);
    view_line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_Store addSubview:view_line2];

    UIView *view_line3 = [[UIView alloc] init];
    view_line3.frame = CGRectMake(10,self.View_Store.height - 50,self.View_Store.width-20,0.5);
    view_line3.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_Store addSubview:view_line3];

    /* 点击编辑 */
    UIButton *StoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    StoreButton.frame = CGRectMake(124,self.View_Store.height - 39,96,28);
    [StoreButton setTitle:@" 点击编辑" forState:UIControlStateNormal];
    [StoreButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
    [StoreButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(14)]];
    StoreButton.layer.borderWidth = 1;
    StoreButton.layer.borderColor = UIColorFromRGB(0x8D8D8D).CGColor;
    StoreButton.layer.cornerRadius = 14;StoreButton.tag = 2;
    [StoreButton setImage:[UIImage imageNamed:@"ico_edit_b_info"] forState:UIControlStateNormal];

    [StoreButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.View_Store addSubview:StoreButton];
    
    
#pragma mark --------------温馨提醒--------------------

    self.View_Remin = [[UIView alloc] init];
    self.View_Remin.frame = CGRectMake(autoScaleW(15),self.View_Store.bottom + 33,ScreenW - autoScaleW(30),243);
    self.View_Remin.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.View_Remin.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.View_Remin.layer.shadowOffset = CGSizeMake(0,5);
    self.View_Remin.layer.shadowOpacity = 1;
    self.View_Remin.layer.shadowRadius = 10;
    self.View_Remin.layer.cornerRadius = 5;
    
    
    
    [self addSubview:self.View_Remin];
    
    UILabel *label_Remin = [[UILabel alloc] init];
    label_Remin.frame = CGRectMake(10,18,autoScaleW(100),14.5);
    label_Remin.numberOfLines = 0;
    [self.View_Remin addSubview:label_Remin];
    
    NSMutableAttributedString *string_Remin = [[NSMutableAttributedString alloc] initWithString:@"温馨提醒" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_Remin.attributedText = string_Remin;
    
    
    

    
    self.view_line7 = [[UIView alloc] init];
    self.view_line7.frame = CGRectMake(10, 50,self.View_Remin.width - 20,0.5);
    self.view_line7.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_Remin addSubview:self.view_line7];
    
    
    self.view_line4 = [[UIView alloc] init];
    self.view_line4.frame = CGRectMake(10,self.View_Remin.height - 50,self.View_Remin.width-20,0.5);
    self.view_line4.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_Remin addSubview:self.view_line4];
    [self.view_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-50);
        make.size.mas_offset(CGSizeMake(self.View_Remin.width-20,0.5));
    }];
    
    /* 手输入 */
    self.viewText_Remin = [[UIView alloc] init];
    self.viewText_Remin.frame = CGRectMake(10,self.view_line7.bottom +25,self.View_Remin.width - 20,107);
    self.viewText_Remin.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    self.viewText_Remin.layer.cornerRadius = 5;
    [self.View_Remin addSubview:self.viewText_Remin];
    [self.viewText_Remin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-70);
        make.size.mas_offset(CGSizeMake(self.View_Remin.width - 20,107));
    }];
    
    
    [self.viewText_Remin addSubview:self.reminder_String];
    [self.reminder_String mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
    }];
    
    /* 点击编辑 */
    self.ReminButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ReminButton.frame = CGRectMake(124,self.View_Remin.height - 39,96,28);
    [self.ReminButton setTitle:@" 点击编辑" forState:UIControlStateNormal];
    [self.ReminButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.ReminButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(14)]];
    self.ReminButton.layer.borderWidth = 1;
    self.ReminButton.layer.borderColor = UIColorFromRGB(0x8D8D8D).CGColor;
    self.ReminButton.layer.cornerRadius = 14;self.ReminButton.tag = 3;
    [self.ReminButton setImage:[UIImage imageNamed:@"ico_edit_b_info"] forState:UIControlStateNormal];
    [self.ReminButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.View_Remin addSubview:self.ReminButton];
    [self.ReminButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(124);
        make.bottom.mas_offset(-11);
        make.size.mas_offset(CGSizeMake(96,28));
    }];
    
#pragma mark --------------门脸图片--------------------

    self.View_Image = [[UIView alloc] init];
    self.View_Image.frame = CGRectMake(autoScaleW(15),self.View_Remin.bottom + 15,ScreenW - autoScaleW(30),447.5);
    self.View_Image.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.View_Image.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.View_Image.layer.shadowOffset = CGSizeMake(0,5);
    self.View_Image.layer.shadowOpacity = 1;
    self.View_Image.layer.shadowRadius = 10;
    self.View_Image.layer.cornerRadius = 5;
    
    [self addSubview:self.View_Image];
    
    UIView *view_line55 = [[UIView alloc] init];
    view_line55.frame = CGRectMake(10,autoScaleW(198),self.View_Image.width-20,0.5);
    view_line55.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_Image addSubview:view_line55];
    
    
    
    UIView *view_line5 = [[UIView alloc] init];
    view_line5.frame = CGRectMake(10,self.View_Image.height - 50,self.View_Image.width-20,0.5);
    view_line5.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_Image addSubview:view_line5];
    
    
    
    
    UILabel *label_ml = [[UILabel alloc] init];
    label_ml.frame = CGRectMake(10,20,80,13.5);
    label_ml.numberOfLines = 0;
    [self.View_Image addSubview:label_ml];
    
    NSMutableAttributedString *string_ml = [[NSMutableAttributedString alloc] initWithString:@"门脸图片" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_ml.attributedText = string_ml;
    
    
    UILabel *label_ml1 = [[UILabel alloc] init];
    label_ml1.frame = CGRectMake(10,label_ml.bottom+10,autoScaleW(200),12);
    label_ml1.numberOfLines = 0;
    [self.View_Image addSubview:label_ml1];
    
    NSMutableAttributedString *string_ml1 = [[NSMutableAttributedString alloc] initWithString:@"必须能看见完整的门匾、门框" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
    
    label_ml1.attributedText = string_ml1;
    
    /*照片*/
    self.door_face_pic = [[UIImageView alloc]initWithFrame:CGRectMake(10,75,autoScaleW(103),autoScaleW(103))];
    self.door_face_pic.layer.cornerRadius = 10;
    [self.View_Image addSubview:self.door_face_pic];
    
    
    
    
    UILabel *label_hj = [[UILabel alloc] init];
    label_hj.frame = CGRectMake(10,view_line55.bottom+20,160,13.5);
    label_hj.numberOfLines = 0;
    [self.View_Image addSubview:label_hj];
    
    NSMutableAttributedString *string_hj = [[NSMutableAttributedString alloc] initWithString:@"上传店内环境照片" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_hj.attributedText = string_hj;
    
    
    UILabel *label_hj1 = [[UILabel alloc] init];
    label_hj1.frame = CGRectMake(10,label_hj.bottom+10,autoScaleW(200),12);
    label_hj1.numberOfLines = 0;
    [self.View_Image addSubview:label_hj1];
    
    NSMutableAttributedString *string_hj1 = [[NSMutableAttributedString alloc] initWithString:@"需要包含桌椅，收银台等内容" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
    
    label_hj1.attributedText = string_hj1;
    
    /* 点击编辑 */
    UIButton *ImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ImageButton.frame = CGRectMake(124,self.View_Image.height - 39,96,28);
    [ImageButton setTitle:@"点击编辑" forState:UIControlStateNormal];
    [ImageButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
    [ImageButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(14)]];
    ImageButton.layer.borderWidth = 1;
    ImageButton.layer.borderColor = UIColorFromRGB(0x8D8D8D).CGColor;
    ImageButton.layer.cornerRadius = 14;ImageButton.tag = 4;
    [ImageButton setImage:[UIImage imageNamed:@"ico_edit_b_info"] forState:UIControlStateNormal];
    [ImageButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.View_Image addSubview:ImageButton];
    
    
    
    
    
#pragma mark --------------店铺信息-证件--------------------
    self.View_P = [[UIView alloc] init];
    self.View_P.frame = CGRectMake(autoScaleW(15),self.View_Image.bottom + 15,ScreenW - autoScaleW(30),696.5);
    self.View_P.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.View_P.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.View_P.layer.shadowOffset = CGSizeMake(0,5);
    self.View_P.layer.shadowOpacity = 1;
    self.View_P.layer.shadowRadius = 10;
    self.View_P.layer.cornerRadius = 5;
    
    
    [self addSubview:self.View_P];
    UILabel *label_P = [[UILabel alloc] init];
    label_P.frame = CGRectMake(10,18,autoScaleW(100),14.5);
    label_P.numberOfLines = 0;
    [self.View_P addSubview:label_P];
    
    NSMutableAttributedString *string_P = [[NSMutableAttributedString alloc] initWithString:@"店铺信息-证件" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_P.attributedText = string_P;
    
    UIView *view_line8 = [[UIView alloc] init];
    view_line8.frame = CGRectMake(10, 50,self.View_P.width - 20,0.5);
    view_line8.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_P addSubview:view_line8];
    
    UIView *view_line9 = [[UIView alloc] init];
    view_line9.frame = CGRectMake(10, view_line8.bottom+autoScaleW(198),self.View_P.width - 20,0.5);
    view_line9.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_P addSubview:view_line9];
    
    UIView *view_line10 = [[UIView alloc] init];
    view_line10.frame = CGRectMake(10, view_line9.bottom+autoScaleW(198),self.View_P.width - 20,0.5);
    view_line10.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_P addSubview:view_line10];
    
    UIView *view_line6 = [[UIView alloc] init];
    view_line6.frame = CGRectMake(10,self.View_P.height - 50,self.View_P.width-20,0.5);
    view_line6.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View_P addSubview:view_line6];
    
    
    UILabel *label_car = [[UILabel alloc] init];
    label_car.frame = CGRectMake(10,view_line8.bottom+20,80,13.5);
    label_car.numberOfLines = 0;
    [self.View_P addSubview:label_car];
    
    NSMutableAttributedString *string_car = [[NSMutableAttributedString alloc] initWithString:@"身份证照片" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_car.attributedText = string_car;
    
    UILabel *label_car1 = [[UILabel alloc] init];
    label_car1.frame = CGRectMake(10,label_car.bottom+10,autoScaleW(165),12);
    label_car1.numberOfLines = 0;
    [self.View_P addSubview:label_car1];
    
    NSMutableAttributedString *string_car1 = [[NSMutableAttributedString alloc] initWithString:@"身份证正面、反面照片" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
    
    label_car1.attributedText = string_car1;
    
    
    UILabel *label_yy = [[UILabel alloc] init];
    label_yy.frame = CGRectMake(10,view_line9.bottom+20,80,13.5);
    label_yy.numberOfLines = 0;
    [self.View_P addSubview:label_yy];
    
    NSMutableAttributedString *string_yy = [[NSMutableAttributedString alloc] initWithString:@"营业执照" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_yy.attributedText = string_yy;
    
    
    UILabel *label_yy1 = [[UILabel alloc] init];
    label_yy1.frame = CGRectMake(10,label_yy.bottom+10,autoScaleW(165),12);
    label_yy1.numberOfLines = 0;
    [self.View_P addSubview:label_yy1];
    
    NSMutableAttributedString *string_yy1 = [[NSMutableAttributedString alloc] initWithString:@"营业执照正面照片" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
    
    label_yy1.attributedText = string_yy1;
    
    
    
    
    
    UILabel *label_xk = [[UILabel alloc] init];
    label_xk.frame = CGRectMake(10,view_line10.bottom+20,80,13.5);
    label_xk.numberOfLines = 0;
    [self.View_P addSubview:label_xk];
    
    NSMutableAttributedString *string_xk = [[NSMutableAttributedString alloc] initWithString:@"经营许可证" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_xk.attributedText = string_xk;
    
    
    UILabel *label_xk1 = [[UILabel alloc] init];
    label_xk1.frame = CGRectMake(10,label_xk.bottom+10,autoScaleW(130),12);
    label_xk1.numberOfLines = 0;
    [self.View_P addSubview:label_xk1];
    
    NSMutableAttributedString *string_xk1 = [[NSMutableAttributedString alloc] initWithString:@"经营许可证书照片" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
    
    label_xk1.attributedText = string_xk1;
    
    /* 点击编辑 */
    UIButton *PButton = [UIButton buttonWithType:UIButtonTypeCustom];
    PButton.frame = CGRectMake(124,self.View_P.height - 39,96,28);
    [PButton setTitle:@" 点击编辑" forState:UIControlStateNormal];
    [PButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
    [PButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(14)]];
    PButton.layer.borderWidth = 1;
    PButton.layer.borderColor = UIColorFromRGB(0x8D8D8D).CGColor;
    PButton.layer.cornerRadius = 14;PButton.tag = 5;
    [PButton setImage:[UIImage imageNamed:@"ico_edit_b_info"] forState:UIControlStateNormal];
    [PButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.View_P addSubview:PButton];
    
    
}
#pragma mark --- 赋值 ---
- (void)setStoreArray:(NSMutableDictionary *)StoreArray{
    
    /** logo */
    NSString *logo_Url = [NSString stringWithFormat:@"%@",StoreArray[@"store_logo"]];
    if ([PublicMethods isUrl:logo_Url]) {
        
    }else{
        logo_Url = [NSString stringWithFormat:@"%@%@",FBHApi_Url,logo_Url];
    }
    [self.store_logo setImageWithURL:[NSURL URLWithString:logo_Url] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
    

    /** 商铺分类 */
    [self.category_name setText:[NSString stringWithFormat:@"  %@ ",StoreArray[@"category_name"]]];
    [self.category_name sizeToFit];
    [self.category_name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_logo.mas_bottom).offset(13);
        make.size.mas_offset(CGSizeMake(self.category_name.width, 15));
        make.left.equalTo(self.category_icon.mas_right).offset(5);
    }];
    
    NSString *category_pic = [NSString stringWithFormat:@"%@",StoreArray[@"category_pic"]];
    if ([PublicMethods isUrl:category_pic]) {
    }else{
        category_pic = [NSString stringWithFormat:@"%@%@",FBHApi_Url,category_pic];
    }
    NSString *imageUrl = [category_pic stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    [self.category_icon setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"icn_shop_type_cycle_green"]];
    
    
    /** 商铺名称 */
    self.store_name.text = [NSString stringWithFormat:@"%@",StoreArray[@"store_name"]];
    
    /** 粉丝数量  */
    self.fans_number.text = [NSString stringWithFormat:@"%@ 粉丝",StoreArray[@"fans_num"]];
    
    /** 商品数量  */
    self.goods_number.text = [NSString stringWithFormat:@"%@ 商品",StoreArray[@"goods_num"]];
    
    
    /////////////////////////////////////////////////
    
    /** 地址 */
    NSString *store_address = [NSString stringWithFormat:@"%@",StoreArray[@"store_address"]];
    NSString *specific_location = [NSString stringWithFormat:@"%@",StoreArray[@"specific_location"]];
    
    if ([[MethodCommon judgeStringIsNull:store_address] isEqualToString:@""]) {
        store_address = @"";
    }
    if ([[MethodCommon judgeStringIsNull:specific_location] isEqualToString:@""]) {
        specific_location = @"";
    }
    self.store_address.text = [NSString stringWithFormat:@"%@%@",store_address,specific_location];
    
    [self.store_address sizeToFit];

    /** 联系人 */
    NSString *merchant_name = [NSString stringWithFormat:@"%@",StoreArray[@"merchant_name"]];
    if ([[MethodCommon judgeStringIsNull:merchant_name] isEqualToString:@""]) {

    }else{
        self.merchant_name.text = [NSString stringWithFormat:@"%@",StoreArray[@"merchant_name"]];
        
    }
    
    
    /** 联系手机 */
    NSString *merchant_mobile = [NSString stringWithFormat:@"%@",StoreArray[@"merchant_mobile"]];
    if ([[MethodCommon judgeStringIsNull:merchant_mobile] isEqualToString:@""]) {
        
    }else{
        self.merchant_mobile.text = [NSString stringWithFormat:@"%@",StoreArray[@"merchant_mobile"]];
    }
    /** 固定电话 */
    NSString *merchant_telephone =[NSString stringWithFormat:@"%@",StoreArray[@"merchant_telephone"]];
    if ([[MethodCommon judgeStringIsNull:merchant_telephone] isEqualToString:@""]) {
        
    }else{
        self.merchant_telephone.text = [NSString stringWithFormat:@"%@",StoreArray[@"merchant_telephone"]];
    }

    /////////////////////////////////////////////////
    NSString *timeS = [NSString stringWithFormat:@"%@",StoreArray[@"business_times"]];
    if ([[MethodCommon judgeStringIsNull:timeS] isEqualToString:@""]) {
        
    }else{
        self.business_times.text = timeS;
    }
    
    NSString *hourS = [NSString stringWithFormat:@"%@",StoreArray[@"business_hours"]];
    if ([[MethodCommon judgeStringIsNull:hourS] isEqualToString:@""]) {
        
    }else{
        self.business_hours.text = hourS;
    }
    
    
    
    
    /////////////////////////////////////////////////
    UILabel *label_h = nil;
    self.reminder_Arr = StoreArray[@"reminder"];
    for (int i = 0; i<self.reminder_Arr.count; i++) {
        
        

        NSString * remin_str = [NSString stringWithFormat:@"%@",self.reminder_Arr[i][@"info_content"]];

        CGRect rect = [remin_str boundingRectWithSize:CGSizeMake(self.View_Remin.width - 45, 8000)//限制最大的宽度和高度
                                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(14)]}//传人的字体字典
                                              context:nil];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(25,(label_h.bottom)+66 - (i == 0 ? 0:66),self.View_Remin.width - 45,rect.size.height+15);
        label.numberOfLines = 0;
        label.font =  [UIFont systemFontOfSize:autoScaleW(14)];
        label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        label.text = remin_str;

        [self.View_Remin addSubview:label];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(25);
            make.top.mas_offset((label_h.bottom)+66 -(i == 0 ? 0:66));
            make.width.mas_offset(self.View_Remin.width - 45);
        }];
    
        label_h = label;
        
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(10,label.mj_y+5,6,5);
        view.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        view.layer.cornerRadius = 2;
        [self.View_Remin addSubview:view];
       
        
        
        
        CGRect frame = self.View_Remin.frame;
        frame.size.height = label.bottom + 200;
        [UIView animateWithDuration:0.25 animations:^{
            self.View_Remin.frame = frame;
        }];
    }
    
    
    
   

    NSString *remString = StoreArray[@"reminder2"];
    if ([[MethodCommon judgeStringIsNull:remString] isEqualToString:@""]) {
        
    }else{
        self.reminder_String.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        self.reminder_String.text = remString;
        [self.reminder_String sizeToFit];
    }
    self.View_Image.mj_y = self.View_Remin.bottom +15;
    self.View_P.mj_y = self.View_Image.bottom +15;
 
    
    
    ////////////////////////////////
    
    /**/
    
    
    CGRect frame = self.frame;
    frame.size.height = self.View_Names.height + self.View_Store.height + self.View_Remin.height + self.View_Image.height + self.View_P.height +autoScaleW(108) + 100;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
    }];
}

#pragma mark - 编辑
- (void)ButtonAction:(UIButton *)sender {

    if (self.TheEditorBlock) {
        self.TheEditorBlock(sender.tag);
    }
}

-(NSMutableArray *)reminder_Arr{
    if (!_reminder_Arr) {
        _reminder_Arr = [NSMutableArray array];
    }
    return _reminder_Arr;
}
#pragma mark --- 懒加载 ---
-(UIImageView *)store_logo{
    if (!_store_logo) {
        _store_logo = [[UIImageView alloc]initWithFrame:CGRectMake(147.5,78,72,72)];
        _store_logo.image = [UIImage imageNamed:@"register_empty_avatar"];
        _store_logo.layer.borderWidth = 1;
        _store_logo.layer.borderColor = [UIColor whiteColor].CGColor;
        _store_logo.layer.cornerRadius = 72/2;
        _store_logo.layer.masksToBounds = YES;
        _store_logo.centerX = self.View_Names.centerX;
    }
    return _store_logo;
}
-(UIImageView *)category_icon{
    if (!_category_icon) {
        _category_icon = [[UIImageView alloc]initWithFrame:CGRectMake(122,44,16,16)];
        _category_icon.image = [UIImage imageNamed:@"register_empty_avatar"];
        _category_icon.layer.cornerRadius = 16/2;
        _category_icon.layer.masksToBounds = YES;
    }
    return _category_icon;
}
-(UILabel *)store_name{
    if (!_store_name) {
        _store_name = [[UILabel alloc]initWithFrame:CGRectMake(140,190,95,15)];
        _store_name.numberOfLines = 0;
        _store_name.textAlignment = 1;
        _store_name.font = [UIFont systemFontOfSize:autoScaleW(16)];
        _store_name.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _store_name.text = @"";
    }
    return _store_name;
}
-(UILabel *)category_name{
    if (!_category_name) {
        _category_name = [[UILabel alloc]initWithFrame:CGRectMake(140,190,95,15)];
        _category_name.numberOfLines = 0;
        _category_name.textAlignment = 1;
        _category_name.font = [UIFont systemFontOfSize:autoScaleW(15)];
        _category_name.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return _category_name;
}
-(UILabel *)fans_number{
    if (!_fans_number) {
        _fans_number = [[UILabel alloc]initWithFrame:CGRectMake(109.5,222,29,24)];
        _fans_number.numberOfLines = 0;
        _fans_number.textAlignment = 1;
        _fans_number.font = [UIFont systemFontOfSize:autoScaleW(15)];
        _fans_number.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
        _fans_number.layer.borderWidth = 1;
        _fans_number.layer.borderColor = UIColorFromRGB(0xEAEAEA).CGColor;
        _fans_number.layer.cornerRadius = _fans_number.height/2;
        _fans_number.text = @"0 粉丝";
    }
    return _fans_number;
}

-(UILabel *)goods_number{
    if (!_goods_number) {
        _goods_number = [[UILabel alloc]initWithFrame:CGRectMake(242,222,28,24)];
        _goods_number.numberOfLines = 0;
        _goods_number.textAlignment = 1;
        _goods_number.font = [UIFont systemFontOfSize:autoScaleW(15)];
        _goods_number.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
        _goods_number.layer.borderWidth = 1;
        _goods_number.layer.borderColor = UIColorFromRGB(0xEAEAEA).CGColor;
        _goods_number.layer.cornerRadius = _goods_number.height/2;
        _goods_number.text = @"0 商品";

    }
    return _goods_number;
}

/** 个人信息等 */
-(UILabel *)store_address{
    if (!_store_address) {
        _store_address = [[UILabel alloc]initWithFrame:CGRectMake(35,73,288,34.5)];
        _store_address.numberOfLines = 0;
        _store_address.font = [UIFont systemFontOfSize:autoScaleW(14)];
        _store_address.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _store_address.text = @"暂无";
//        [_store_address sizeToFit];
    }
    return _store_address;
}

-(UILabel *)merchant_name{
    if (!_merchant_name) {
        _merchant_name = [[UILabel alloc]initWithFrame:CGRectMake(92,112,92,13.5)];
        _merchant_name.numberOfLines = 0;
        _merchant_name.font = [UIFont systemFontOfSize:autoScaleW(14)];
        _merchant_name.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _merchant_name.text = @"暂无";
        [_merchant_name sizeToFit];
    }
    return _merchant_name;
}
-(UILabel *)merchant_mobile{
    if (!_merchant_mobile) {
        _merchant_mobile = [[UILabel alloc]initWithFrame:CGRectMake(92,151,92,13.5)];
        _merchant_mobile.numberOfLines = 0;
        _merchant_mobile.font = [UIFont systemFontOfSize:autoScaleW(14)];
        _merchant_mobile.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _merchant_mobile.text = @"暂无";
        [_merchant_mobile sizeToFit];
    }
    return _merchant_mobile;
}
-(UILabel *)merchant_telephone{
    if (!_merchant_telephone) {
        _merchant_telephone = [[UILabel alloc]initWithFrame:CGRectMake(92,177,92,13.5)];
        _merchant_telephone.numberOfLines = 0;
        _merchant_telephone.font = [UIFont systemFontOfSize:autoScaleW(14)];
        _merchant_telephone.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _merchant_telephone.text = @"暂无";
        [_merchant_telephone sizeToFit];
    }
    return _merchant_telephone;
}

-(UILabel *)business_times{
    if (!_business_times) {
        _business_times = [[UILabel alloc]initWithFrame:CGRectMake(92,203,92,13.5)];
        _business_times.numberOfLines = 0;
        _business_times.font = [UIFont systemFontOfSize:autoScaleW(14)];
        _business_times.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _business_times.text = @"暂无";
        [_business_times sizeToFit];
    }
    return _business_times;
}
-(UILabel *)business_hours{
    if (!_business_hours) {
        _business_hours = [[UILabel alloc]initWithFrame:CGRectMake(92,231,92,13.5)];
        _business_hours.numberOfLines = 0;
        _business_hours.font = [UIFont systemFontOfSize:autoScaleW(14)];
        _business_hours.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _business_hours.text = @"暂无";
        [_business_hours sizeToFit];
    }
    return _business_hours;
}
-(UILabel *)reminder_String{
    if (!_reminder_String) {
        _reminder_String = [[UILabel alloc]initWithFrame:CGRectMake(35.5,726,134.5,13)];
        _reminder_String.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        _reminder_String.font = [UIFont systemFontOfSize:autoScaleW(14)];
        _reminder_String.numberOfLines = 0;
        _reminder_String.text = @"还没有填写温馨提醒~";
        [_reminder_String sizeToFit];
    }
    return _reminder_String;
}
@end
