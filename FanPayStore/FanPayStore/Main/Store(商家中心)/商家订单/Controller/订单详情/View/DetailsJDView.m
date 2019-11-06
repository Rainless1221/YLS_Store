//
//  DetailsJDView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "DetailsJDView.h"

@implementation DetailsJDView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(11,0,350,60);
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size: 18];
    label.text = @"订单信息";
    [self addSubview:label];
    
    /*图片*/
    
    [self addSubview:self.Detailsimage];
    [self.Detailsimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(75);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(183);
    }];
    
    /*名称*/
    [self addSubview:self.hotelName];
    [self.hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Detailsimage.mas_bottom).offset(16);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
    }];
    
    /*细节*/
    [self addSubview:self.hotelM];
    [self.hotelM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotelName.mas_bottom).offset(13);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
    }];
    
    /*价格*/
    [self addSubview:self.hotelPrice];
    [self.hotelPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotelM.mas_bottom).offset(13);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Detailsimage.mas_bottom).offset(110);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(0.5);
    }];
    
#pragma mark - 入驻时间
    UILabel *label_r = [[UILabel alloc] init];
    label_r.numberOfLines = 0;
    label_r.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_r.textAlignment = 1;
    label_r.font = [UIFont systemFontOfSize:12];
    label_r.text = @"入驻时间";
    [self addSubview:label_r];
    
    UILabel *label_t = [[UILabel alloc] init];
    label_t.numberOfLines = 0;
    label_t.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_t.textAlignment = 1;
    label_t.font = [UIFont systemFontOfSize:12];
    label_t.text = @"退房时间";
    [self addSubview:label_t];

    [label_r mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.width/2);
    }];
    [label_t mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(20);
        make.left.equalTo(label_r.mas_right).offset(0);
        make.width.mas_equalTo(self.width/2);
    }];
    
    
    [self addSubview:self.hotelR];
    [self.hotelR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_r.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.width/2);
    }];
    
    [self addSubview:self.hotelT];
    [self.hotelT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_r.mas_bottom).offset(10);
        make.left.equalTo(self.hotelR.mas_right).offset(0);
        make.width.mas_equalTo(self.width/2);
    }];
    
    
    UILabel *label_r_time = [[UILabel alloc] init];
    label_r_time.numberOfLines = 0;
    label_r_time.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_r_time.textAlignment = 1;
    label_r_time.font = [UIFont systemFontOfSize:12];
    label_r_time.text = @"14:00后";
    [self addSubview:label_r_time];
    
    UILabel *label_t_time = [[UILabel alloc] init];
    label_t_time.numberOfLines = 0;
    label_t_time.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_t_time.textAlignment = 1;
    label_t_time.font = [UIFont systemFontOfSize:12];
    label_t_time.text = @"12:00前";
    [self addSubview:label_t_time];
    
    [label_r_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotelT.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.width/2);
    }];
    [label_t_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotelT.mas_bottom).offset(10);
        make.left.equalTo(label_r_time.mas_right).offset(0);
        make.width.mas_equalTo(self.width/2);
    }];
    
    
    
    
    
    
    
    
    UIView *view_line_1 = [[UIView alloc] init];
    view_line_1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self addSubview:view_line_1];
    [view_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(100);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(0.5);
    }];
    
#pragma mark - 房费
    
    /*房费*/
    UILabel *label_P = [[UILabel alloc] init];
    label_P.numberOfLines = 0;
    label_P.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_P.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_P.text = @"房费";
    label_P.textAlignment = 0;
    [self addSubview:label_P];
    [label_P mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view_line_1.mas_bottom).offset(20);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    
    [self addSubview:self.hotelF];
    [self.hotelF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view_line_1.mas_bottom).offset(20);
        make.right.mas_equalTo(-10);
    }];
    
    
    
    /*早餐*/
    UILabel *label_Z  = [[UILabel alloc] init];
    label_Z.numberOfLines = 0;
    label_Z.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_Z.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_Z.text = @"早餐";
    label_Z.textAlignment = 0;
    [self addSubview:label_Z];
    [label_Z mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_P.mas_bottom).offset(12);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    
    
    [self addSubview:self.hotelZ];
    [self.hotelZ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_P.mas_bottom).offset(12);
        make.right.mas_offset(-10);
    }];
    
    
    /*服务费用*/
    UILabel *label_FW  = [[UILabel alloc] init];
    label_FW.numberOfLines = 0;
    label_FW.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_FW.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_FW.text = @"服务费用";
    label_FW.textAlignment = 0;
    [self addSubview:label_FW];
    [label_FW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_Z.mas_bottom).offset(12);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    [self addSubview:self.hotelFW];
    [self.hotelFW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_Z.mas_bottom).offset(12);
        make.right.mas_offset(-10);
    }];
    
    
    
    
    /*酒店优惠*/
    UILabel *label_YH  = [[UILabel alloc] init];
    label_YH.numberOfLines = 0;
    label_YH.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_YH.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_YH.text = @"酒店优惠";
    label_YH.textAlignment = 0;
    [self addSubview:label_YH];
    [label_YH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_FW.mas_bottom).offset(12);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    
    [self addSubview:self.hotelY];
    [self.hotelY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_FW.mas_bottom).offset(12);
        make.right.mas_offset(-10);
    }];
    
    
    
    
    
    UIView *view_line_2 = [[UIView alloc] init];
    view_line_2.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self addSubview:view_line_2];
    [view_line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view_line_1.mas_bottom).offset(126);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    /*实付*/
    UILabel *label_paid_type  = [[UILabel alloc] init];
    label_paid_type.numberOfLines = 0;
    label_paid_type.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_paid_type.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_paid_type.text = @"实付";
    label_paid_type.textAlignment = 0;
    [self addSubview:label_paid_type];
    [label_paid_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 60));
    }];
    [self addSubview:self.hotelSF];
    [self.hotelSF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.right.mas_offset(-10);
    }];
    
    
    self.Detailsimage.backgroundColor = [UIColor redColor];
    self.hotelName.text = @"栖云民宿 - 云坞";
    self.hotelM.text = @"28 m 双人床×1 独卫";
    self.hotelPrice.text = @"980 元/晚";
    self.hotelR.text = @"07月06日";
    self.hotelT.text = @"07月08日";
    self.hotelF.text = @"¥1960";
    self.hotelZ.text = @"¥60";
    self.hotelFW.text = @"¥80";

    self.hotelY.text = @"-¥110";
    self.hotelSF.text = @"¥1990";
    
}
#pragma mark - 懒加载
-(UIImageView *)Detailsimage{
    if (!_Detailsimage) {
        _Detailsimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 75, ScreenW-20, 183)];
        _Detailsimage.layer.cornerRadius = 5;
    }
    return _Detailsimage;
}
-(UILabel *)hotelName{
    if (!_hotelName) {
        _hotelName = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, self.width, 17)];
        _hotelName.numberOfLines = 0;
        _hotelName.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _hotelName.font = [UIFont fontWithName:@"Arial-BoldMT" size: 18];
    }
    return _hotelName;
}
-(UILabel *)hotelM{
    if (!_hotelM) {
        _hotelM = [[UILabel alloc]initWithFrame:CGRectMake(10, self.hotelName.bottom+13, self.width, 12)];
        _hotelM.numberOfLines = 0;
        _hotelM.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _hotelM.font = [UIFont fontWithName:@"Arial-BoldMT" size: 15];
    }
    return _hotelM;
}
-(UILabel *)hotelPrice{
    if (!_hotelPrice) {
        _hotelPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, self.hotelM.bottom+13, self.width, 12)];
        _hotelPrice.numberOfLines = 0;
        _hotelPrice.textColor = [UIColor colorWithRed:238/255.0 green:78/255.0 blue:62/255.0 alpha:1.0];
        _hotelPrice.font = [UIFont fontWithName:@"Arial-BoldMT" size: 15];
    }
    return _hotelPrice;
}
-(UILabel *)hotelR{
    if (!_hotelR) {
        _hotelR = [[UILabel alloc]initWithFrame:CGRectMake(0, self.hotelM.bottom+130, self.width, 12)];
        _hotelR.numberOfLines = 0;
        _hotelR.textAlignment = 1;
        _hotelR.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _hotelR.font = [UIFont fontWithName:@"Arial-BoldMT" size: 20];
    }
    return _hotelR;
}
-(UILabel *)hotelT{
    if (!_hotelT) {
        _hotelT = [[UILabel alloc]initWithFrame:CGRectMake(0, self.hotelM.bottom+130, self.width, 12)];
        _hotelT.numberOfLines = 0;
        _hotelT.textAlignment = 1;
        _hotelT.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _hotelT.font = [UIFont fontWithName:@"Arial-BoldMT" size: 20];
    }
    return _hotelT;
}
-(UILabel *)hotelF{
    if (!_hotelF) {
        _hotelF = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _hotelF.numberOfLines = 0;
        _hotelF.textAlignment = 1;
        _hotelF.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _hotelF.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _hotelF;
}
-(UILabel *)hotelZ{
    if (!_hotelZ) {
        _hotelZ = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _hotelZ.numberOfLines = 0;
        _hotelZ.textAlignment = 1;
        _hotelZ.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _hotelZ.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _hotelZ;
}
-(UILabel *)hotelFW{
    if (!_hotelFW) {
        _hotelFW = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _hotelFW.numberOfLines = 0;
        _hotelFW.textAlignment = 1;
        _hotelFW.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _hotelFW.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _hotelFW;
}
-(UILabel *)hotelY{
    if (!_hotelY) {
        _hotelY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _hotelY.numberOfLines = 0;
        _hotelY.textAlignment = 1;
        _hotelY.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _hotelY.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _hotelY;
}
-(UILabel *)hotelSF{
    if (!_hotelSF) {
        _hotelSF = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _hotelSF.numberOfLines = 0;
        _hotelSF.textAlignment = 1;
        _hotelSF.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _hotelSF.font = [UIFont fontWithName:@"Arial-BoldMT" size: 24];
    }
    return _hotelSF;
}
@end
