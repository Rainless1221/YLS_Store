//
//  RevenuedetailsView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "RevenuedetailsView.h"

@implementation RevenuedetailsView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    /* 图标*/
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(28);
        make.size.mas_offset(CGSizeMake(48, 48));
    }];
    UIView *line= [[UIView alloc]initWithFrame:CGRectMake(38, 96, ScreenW-80, 1)];
    line.backgroundColor = UIColorFromRGB(0xDCDCDC);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(20);
        make.left.mas_offset(38);
        make.right.mas_offset(-38);
        make.height.mas_offset(1);
    }];
    
    
    /*额度*/
    [self addSubview:self.amount];
    [self.amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(20);
        make.left.mas_offset(38);
        make.right.mas_offset(-38);
    }];
    /*描述*/
    [self addSubview:self.desc];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amount.mas_bottom).offset(15);
        make.left.mas_offset(38);
        make.right.mas_offset(-38);
    }];
    
    [self addSubview:self.TextLabel1];
    [self addSubview:self.TextLabel2];
    [self addSubview:self.TextLabel3];
    [self addSubview:self.TextLabel4];
    [self addSubview:self.status1];
    [self addSubview:self.status2];
    [self addSubview:self.status3];
    [self addSubview:self.status4];
    
    [self.TextLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desc.mas_bottom).offset(30);
        make.left.mas_offset(10);
        make.height.mas_offset(12);
        make.width.mas_offset(80);
    }];
    [self.status1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desc.mas_bottom).offset(30);
        make.right.mas_offset(-10);
//        make.left.equalTo(self.TextLabel1.mas_right).offset(40);
        make.width.mas_offset(self.width - (10+self.TextLabel1.right+33));
    }];
    [self.status1 sizeToFit];
    
    [self.TextLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.status1.mas_bottom).offset(20);
        make.left.mas_offset(10);
        make.height.mas_offset(12);
        make.width.mas_offset(80);
    }];
    
    [self.status2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.status1.mas_bottom).offset(20);
        make.right.mas_offset(-10);
    }];
    
    [self.TextLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.status2.mas_bottom).offset(20);
        make.left.mas_offset(10);
        make.height.mas_offset(12);
        make.width.mas_offset(80);
    }];
    
    [self.status3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.status2.mas_bottom).offset(20);
        make.right.mas_offset(-10);
    }];
    
    [self.TextLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.TextLabel3.mas_bottom).offset(20);
        make.left.mas_offset(10);
        make.height.mas_offset(12);
        make.width.mas_offset(80);
    }];
    
    [self.status4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.TextLabel3.mas_bottom).offset(20);
        make.right.mas_offset(-10);
    }];
    
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    
    NSString *type = [NSString stringWithFormat:@"%@",Data[@"type"]];
    if ([type isEqualToString:@"2"]) {
        self.icon.image = [UIImage imageNamed:@"icn_order_withdraw"];
        self.amount.textColor = UIColorFromRGB(0x3D8AFF);
        self.amount.text = [NSString stringWithFormat:@"%@",Data[@"amount"]];
        self.desc.text = @"提现";
        self.TextLabel3.text = @"记录ID";
        
        /*商家信息*/
        self.status1.text = [NSString stringWithFormat:@"%@",Data[@"content"]];
        /*商家名称*/
        self.status2.text = [NSString stringWithFormat:@"%@",Data[@"store_name"]];
        /*记录ID*/
        self.status3.text = [NSString stringWithFormat:@"%@",Data[@"order_sn"]];
        /*订单时间*/
        self.status4.text = [NSString stringWithFormat:@"%@",Data[@"time"]];
    }else if([type isEqualToString:@"3"]){
        self.icon.image = [UIImage imageNamed:@"icn_order_commission_small"];
        self.amount.textColor = UIColorFromRGB(0x38A94D);
        self.amount.text = [NSString stringWithFormat:@"%@",Data[@"amount"]];
        self.desc.text = @"返佣";
        self.TextLabel3.text = @"记录ID";
        
        /*商家信息*/
        self.status1.text = [NSString stringWithFormat:@"%@",Data[@"content"]];
        /*商家名称*/
        self.status2.text = [NSString stringWithFormat:@"%@",Data[@"store_name"]];
        /*订单标号*/
        self.status3.text = [NSString stringWithFormat:@"%@",Data[@"order_sn"]];
        /*订单时间*/
        self.status4.text = [NSString stringWithFormat:@"%@",Data[@"time"]];
    }else{
        self.icon.image = [UIImage imageNamed:@"icn_order_income"];
        self.amount.textColor = UIColorFromRGB(0xF7AE2A);
        self.amount.text = [NSString stringWithFormat:@"+%@",Data[@"amount"]];
        self.desc.text = @"营收";
        self.TextLabel3.text = @"订单标号";
        
        /*商家信息*/
        self.status1.text = [NSString stringWithFormat:@"%@",Data[@"content"]];
        /*商家名称*/
        self.status2.text = [NSString stringWithFormat:@"%@",Data[@"store_name"]];
        /*订单标号*/
        self.status3.text = [NSString stringWithFormat:@"%@",Data[@"order_sn"]];
        /*订单时间*/
        self.status4.text = [NSString stringWithFormat:@"%@",Data[@"time"]];
    }
   
    
}
#pragma mark - GET
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 48, 48)];
        _icon.image = [UIImage imageNamed:@"icn_order_withdraw"];
    }
    return _icon;
}
-(UILabel *)amount{
    if (!_amount) {
        _amount = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 15)];
        _amount.textColor = UIColorFromRGB(0x3D8AFF);
        _amount.font = [UIFont systemFontOfSize:24];
        _amount.textAlignment = 1;
//        _amount.text = @"2000.00";
    }
    return _amount;
}
-(UILabel *)desc{
    if (!_desc) {
        _desc = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 15)];
        _desc.textColor = UIColorFromRGB(0x999999);
        _desc.font = [UIFont systemFontOfSize:13];
        _desc.textAlignment = 1;
//        _desc.text = @"提现";
    }
    return _desc;
}
-(UILabel *)TextLabel1{
    if (!_TextLabel1) {
        _TextLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 15)];
        _TextLabel1.textColor = UIColorFromRGB(0x999999);
        _TextLabel1.font = [UIFont systemFontOfSize:13];
        _TextLabel1.text = @"商品信息";
    }
    return _TextLabel1;
}
-(UILabel *)TextLabel2{
    if (!_TextLabel2) {
        _TextLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 15)];
        _TextLabel2.textColor = UIColorFromRGB(0x999999);
        _TextLabel2.font = [UIFont systemFontOfSize:13];
        _TextLabel2.text = @"商家名称";
    }
    return _TextLabel2;
}
-(UILabel *)TextLabel3{
    if (!_TextLabel3) {
        _TextLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 15)];
        _TextLabel3.textColor = UIColorFromRGB(0x999999);
        _TextLabel3.font = [UIFont systemFontOfSize:13];
        _TextLabel3.text = @"记录ID";

    }
    return _TextLabel3;
}
-(UILabel *)TextLabel4{
    if (!_TextLabel4) {
        _TextLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 15)];
        _TextLabel4.textColor = UIColorFromRGB(0x999999);
        _TextLabel4.font = [UIFont systemFontOfSize:13];
        _TextLabel4.text = @"订单时间";

    }
    return _TextLabel4;
}

-(UILabel *)status1{
    if (!_status1) {
        _status1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 15)];
        _status1.textColor = UIColorFromRGB(0x999999);
        _status1.font = [UIFont systemFontOfSize:13];
        _status1.textAlignment = 2;
        _status1.numberOfLines = 0;
//        _status1.text = @"商家提现";
        
    }
    return _status1;
}
-(UILabel *)status2{
    if (!_status2) {
        _status2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 15)];
        _status2.textColor = UIColorFromRGB(0x999999);
        _status2.font = [UIFont systemFontOfSize:13];
        _status2.textAlignment = 2;
//        _status2.text = @"大房子创意菜";
    }
    return _status2;
}
-(UILabel *)status3{
    if (!_status3) {
        _status3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 15)];
        _status3.textColor = UIColorFromRGB(0x999999);
        _status3.font = [UIFont systemFontOfSize:13];
        _status3.textAlignment = 2;
//        _status3.text = @"345678904";
    }
    return _status3;
}
-(UILabel *)status4{
    if (!_status4) {
        _status4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 15)];
        _status4.textColor = UIColorFromRGB(0x999999);
        _status4.font = [UIFont systemFontOfSize:13];
        _status4.textAlignment = 2;
//        _status4.text = @"2018-12-12  14:30";
    }
    return _status4;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
