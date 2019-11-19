//
//  OrderViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/23.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//
#define  OrderGodds_H      35

#import "OrderViewCell.h"

@implementation OrderViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        
    }
    
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    //背景
    [self addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_offset(0);
        make.bottom.mas_offset(-15);
    }];
    NSInteger coun = (ScreenW - 33)/15;
    for (int i = 0; i<coun; i++) {
        UIView *view_1 = [[UIView alloc] init];
        view_1.backgroundColor = UIColorFromRGB(0xF6F6F6);
        view_1.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2].CGColor;
        view_1.layer.shadowOffset = CGSizeMake(0,0);
        view_1.layer.shadowOpacity = 1;
        view_1.layer.shadowRadius = 2;
        view_1.layer.cornerRadius = 5;
        [self.orderView addSubview:view_1];
        [view_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(7);
            make.left.mas_offset(i*15+10);
            make.size.mas_offset(CGSizeMake(7, 13));
        }];
        
    }
    //状态
    [self.orderView addSubview:self.iconBtn];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    //时间
    [self.orderView addSubview:self.TimeLabel];
    [self.TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    //line
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(10,50,self.orderView.width-20,0.5);
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.orderView addSubview:line];
    
    UILabel *label_1 = [[UILabel alloc]init];
    label_1.text = @"商品列表";
    label_1.textColor = UIColorFromRGB(0x999999);
    label_1.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line.mas_bottom).offset(12);
    }];
    
    
    
}
- (void)setStatus:(OrderVieWStatus)status{
    _status = status;
    // 判断
    if (_status == OrderVieWStatus_1) {
        [self bePaid];
        
    }else if (_status == OrderVieWStatus_2){
        [self HavePaid];
        
    }else if (_status == OrderVieWStatus_3){
        [self evaluation_1];
        
    }
    else if (_status == OrderVieWStatus_4){
        [self evaluation];
        
    }else if (_status == OrderVieWStatus_5){
         [self cancel];
        
    }else if (_status == OrderVieWStatus_6){
        [self refund];
        
    }else if (_status == OrderVieWStatus_7){
        [self refund_type];
        
    }else if (_status == OrderVieWStatus_8){
        
        [self TK];
        
    }else{
        
    }
    
}
#pragma mark - 待支付
-(void)bePaid{
    [self.iconBtn setTitle:@"订单待支付" forState:UIControlStateNormal];
    
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    /*联系买家*/
    UIButton *DetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    DetailButton.frame = CGRectMake(0, 0, 80, 32);
    [DetailButton setTitle:@"联系买家" forState:UIControlStateNormal];
    [DetailButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [DetailButton setBackgroundColor:UIColorFromRGB(0xF7AE2B)];
    DetailButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DetailButton.layer.cornerRadius = 16;
    DetailButton.layer.borderWidth = 1;
    DetailButton.layer.borderColor = [UIColorFromRGB(0xF7AE2B) CGColor];
    [DetailButton addTarget:self action:@selector(DetailAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DetailButton];
    [DetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.equalTo(DeleteButton.mas_left).offset(-10);
        make.height.mas_offset(32);
        make.width.mas_offset(80);
    }];
    /*剩余支付时间*/
//    UILabel *label = [[UILabel alloc] init];
//    label.numberOfLines = 0;
//    label.text = @"剩余支付时间";
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = UIColorFromRGB(0x3D8AFF);
//    [self.orderView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.centerY.equalTo(DetailButton.mas_centerY).offset(0);
//    }];
    self.PaymentTime  = [[UILabel alloc] init];
    self.PaymentTime.numberOfLines = 0;
    self.PaymentTime.text = @"剩余支付时间";
    self.PaymentTime.font = [UIFont systemFontOfSize:14];
    self.PaymentTime.textColor = UIColorFromRGB(0x3D8AFF);
    [self.orderView addSubview:self.PaymentTime];
    [self.PaymentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(DetailButton.mas_centerY).offset(0);
    }];
    /*优惠*/
    UILabel *preferentiallabel = [[UILabel alloc]init];
    preferentiallabel.text = @"优惠金额";
    preferentiallabel.textColor = UIColorFromRGB(0xF7AE2B);
    preferentiallabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:preferentiallabel];
    [preferentiallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-77);
    }];
    
    UILabel *servicelabel = [[UILabel alloc]init];
    servicelabel.text = @"服务费用";
    servicelabel.textColor = UIColorFromRGB(0x999999);
    servicelabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:servicelabel];
    [servicelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(preferentiallabel.mas_top).offset(-12);
    }];
    
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"总计     共 件商品";
    self.numlabel.textColor = UIColorFromRGB(0x999999);
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.numlabel];
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(servicelabel.mas_top).offset(-12);
    }];
    
    /*优惠金额*/
    self.save_money = [[UILabel alloc]init];
    self.save_money.textColor = UIColorFromRGB(0xF7AE2B);
    self.save_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money];
    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-77);
    }];
    /*服务费用*/
    self.service_money = [[UILabel alloc]init];
    self.service_money.textColor = UIColorFromRGB(0x222222);
    self.service_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.service_money];
    [self.service_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.save_money.mas_top).offset(-12);
    }];
    
    
    /**/
    self.goods_price = [[UILabel alloc]init];
    self.goods_price.textColor = UIColorFromRGB(0x222222);
    self.goods_price.font = [UIFont systemFontOfSize:24];
    [self.orderView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.service_money.mas_top).offset(-12);
    }];
    
}
#pragma mark - 已支付
-(void)HavePaid{

    [self.iconBtn setTitle:@"订单已支付" forState:UIControlStateNormal];
    
    self.HexiaoBtn.selected = NO;
    [self.orderView addSubview:self.HexiaoBtn];
    [self.HexiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.top.mas_offset(49);
        make.size.mas_offset(CGSizeMake(50, 25));
    }];
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dayinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
    [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
    [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
    [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:dayinBtn];
    [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
    /*优惠*/
    UILabel *preferentiallabel = [[UILabel alloc]init];
    preferentiallabel.text = @"优惠金额";
    preferentiallabel.textColor = UIColorFromRGB(0xF7AE2B);
    preferentiallabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:preferentiallabel];
    [preferentiallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-77);
    }];
    UILabel *servicelabel = [[UILabel alloc]init];
    servicelabel.text = @"服务费用";
    servicelabel.textColor = UIColorFromRGB(0x999999);
    servicelabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:servicelabel];
    [servicelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(preferentiallabel.mas_top).offset(-12);
    }];
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"总计     共 件商品";
    self.numlabel.textColor = UIColorFromRGB(0x999999);
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.numlabel];
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(servicelabel.mas_top).offset(-12);
    }];
    
    /*优惠金额*/
    self.save_money = [[UILabel alloc]init];
    self.save_money.textColor = UIColorFromRGB(0xF7AE2B);
    self.save_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money];
    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-77);
    }];
    /*服务费用*/
    self.service_money = [[UILabel alloc]init];
    self.service_money.textColor = UIColorFromRGB(0x222222);
    self.service_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.service_money];
    [self.service_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.save_money.mas_top).offset(-12);
    }];
    
    
    
    /**/
    self.goods_price = [[UILabel alloc]init];
    self.goods_price.textColor = UIColorFromRGB(0x222222);
    self.goods_price.font = [UIFont systemFontOfSize:24];
    [self.orderView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.service_money.mas_top).offset(-12);
    }];
    
}
#pragma mark - 待评价
-(void)evaluation_1{

    [self.iconBtn setTitle:@"订单已支付" forState:UIControlStateNormal];
    
    self.HexiaoBtn.selected = YES;
    [self.orderView addSubview:self.HexiaoBtn];
    [self.HexiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.top.mas_offset(49);
        make.size.mas_offset(CGSizeMake(50, 25));
    }];
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    /*优惠*/
    UILabel *preferentiallabel = [[UILabel alloc]init];
    preferentiallabel.text = @"优惠金额";
    preferentiallabel.textColor = UIColorFromRGB(0xF7AE2B);
    preferentiallabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:preferentiallabel];
    [preferentiallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-77);
    }];
    UILabel *servicelabel = [[UILabel alloc]init];
    servicelabel.text = @"服务费用";
    servicelabel.textColor = UIColorFromRGB(0x999999);
    servicelabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:servicelabel];
    [servicelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(preferentiallabel.mas_top).offset(-12);
    }];
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"总计     共 件商品";
    self.numlabel.textColor = UIColorFromRGB(0x999999);
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.numlabel];
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(servicelabel.mas_top).offset(-12);
    }];
    /*优惠金额*/
    self.save_money = [[UILabel alloc]init];
    self.save_money.textColor = UIColorFromRGB(0xF7AE2B);
    self.save_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money];
    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-77);
    }];
    /*服务费用*/
    self.service_money = [[UILabel alloc]init];
    self.service_money.textColor = UIColorFromRGB(0x222222);
    self.service_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.service_money];
    [self.service_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.save_money.mas_top).offset(-12);
    }];
    
    
    /**/
    self.goods_price = [[UILabel alloc]init];
    self.goods_price.textColor = UIColorFromRGB(0x222222);
    self.goods_price.font = [UIFont systemFontOfSize:24];
    [self.orderView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.service_money.mas_top).offset(-12);
    }];
    
    UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dayinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
    [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
    [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
    [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:dayinBtn];
    [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
}
#pragma mark - 评价
-(void)evaluation{
    [self.iconBtn setTitle:@"订单已评价" forState:UIControlStateNormal];
    
    
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    //line
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(10,50,self.orderView.width-20,0.5);
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.orderView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-150);
        make.height.mas_offset(0.5);
    }];
    
    UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dayinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
    [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
    [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
    [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:dayinBtn];
    [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
    /*优惠*/
    UILabel *preferentiallabel = [[UILabel alloc]init];
    preferentiallabel.text = @"优惠金额";
    preferentiallabel.textColor = UIColorFromRGB(0xF7AE2B);
    preferentiallabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:preferentiallabel];
    [preferentiallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(line.mas_top).offset(-20);
    }];
    UILabel *servicelabel = [[UILabel alloc]init];
    servicelabel.text = @"服务费用";
    servicelabel.textColor = UIColorFromRGB(0x999999);
    servicelabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:servicelabel];
    [servicelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(preferentiallabel.mas_top).offset(-12);
    }];
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"总计     共 件商品";
    self.numlabel.textColor = UIColorFromRGB(0x999999);
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.numlabel];
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(servicelabel.mas_top).offset(-12);
    }];
    
    /*优惠金额*/
    self.save_money = [[UILabel alloc]init];
    self.save_money.textColor = UIColorFromRGB(0xF7AE2B);
    self.save_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money];
    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(line.mas_top).offset(-20);
    }];
    
    
    /*服务费用*/
    self.service_money = [[UILabel alloc]init];
    self.service_money.textColor = UIColorFromRGB(0x222222);
    self.service_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.service_money];
    [self.service_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.save_money.mas_top).offset(-12);
    }];
    
    /**/
    self.goods_price = [[UILabel alloc]init];
    self.goods_price.textColor = UIColorFromRGB(0x222222);
    self.goods_price.font = [UIFont systemFontOfSize:24];
    [self.orderView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.service_money.mas_top).offset(-12);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"本次订单已评价";
    label.textColor = UIColorFromRGB(0x222222);
    label.font = [UIFont systemFontOfSize:15];
    [self.orderView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line.mas_bottom).offset(20);
    }];
    //星星
    StarEvaluator *starEvaluator = [[StarEvaluator alloc] initWithFrame:CGRectMake(25, 395, 120, 30)];
    starEvaluator.delegate = self;
    [self.orderView addSubview:starEvaluator];
    self.starEvaluator = starEvaluator;
    [starEvaluator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(label.mas_bottom).offset(15);
        make.size.mas_offset(CGSizeMake(120, 30));
    }];
    self.starEvaluator.userInteractionEnabled = NO;
    self.starEvaluator.currentValue = 4;
    
    self.star = [[UILabel alloc]init];
    self.star.text = @"分";
    self.star.textColor = UIColorFromRGB(0xF7AE2B);
    self.star.font = [UIFont systemFontOfSize:15];
    [self.orderView addSubview:self.star];
    [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(label.mas_bottom).offset(15);
    }];
    
}
#pragma mark - 退单
-(void)refund{
    self.orderView.height =  350+3*30;

    [self.iconBtn setTitle:@"订单退款" forState:UIControlStateNormal];

    /*确认退款*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"确认退款" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [DeleteButton setBackgroundColor:UIColorFromRGB(0xFF6969)];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0xFF6969) CGColor];
    [DeleteButton addTarget:self action:@selector(refundAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    /*拒绝*/
    UIButton *DetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DetailButton setTitle:@"拒绝" forState:UIControlStateNormal];
    [DetailButton setTitleColor:UIColorFromRGB(0xFF6969) forState:UIControlStateNormal];
    DetailButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DetailButton.layer.cornerRadius = 16;
    DetailButton.layer.borderWidth = 1;
    DetailButton.layer.borderColor = [UIColorFromRGB(0xFF6969) CGColor];
    [DetailButton addTarget:self action:@selector(RefusedAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.orderView addSubview:DetailButton];
//    [DetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_offset(-25);
//        make.right.equalTo(DeleteButton.mas_left).offset(-10);
//        make.size.mas_offset(CGSizeMake(80, 32));
//    }];
    
    UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dayinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
    [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
    [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
    [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:dayinBtn];
    [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
    /*优惠*/
    UILabel *preferentiallabel = [[UILabel alloc]init];
    preferentiallabel.text = @"优惠金额";
    preferentiallabel.textColor = UIColorFromRGB(0xF7AE2B);
    preferentiallabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:preferentiallabel];
    [preferentiallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-77);
    }];
    UILabel *servicelabel = [[UILabel alloc]init];
    servicelabel.text = @"服务费用";
    servicelabel.textColor = UIColorFromRGB(0x999999);
    servicelabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:servicelabel];
    [servicelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(preferentiallabel.mas_top).offset(-12);
    }];
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"总计     共 件商品";
    self.numlabel.textColor = UIColorFromRGB(0x999999);
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.numlabel];
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(servicelabel.mas_top).offset(-12);
    }];
    
    /*优惠金额*/
    self.save_money = [[UILabel alloc]init];
    self.save_money.textColor = UIColorFromRGB(0xF7AE2B);
    self.save_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money];
    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-77);
    }];
    
    /*服务费用*/
    self.service_money = [[UILabel alloc]init];
    self.service_money.textColor = UIColorFromRGB(0x222222);
    self.service_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.service_money];
    [self.service_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.save_money.mas_top).offset(-12);
    }];
    
    /**/
    self.goods_price = [[UILabel alloc]init];
    self.goods_price.textColor = UIColorFromRGB(0x222222);
    self.goods_price.font = [UIFont systemFontOfSize:24];
    [self.orderView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.service_money.mas_top).offset(-12);
    }];
    
    
    self.refundTime = [[UILabel alloc]init];
    self.refundTime.textColor = UIColorFromRGB(0xFF6969);
    self.refundTime.font = [UIFont systemFontOfSize:14];
    self.refundTime.textAlignment = 1;
    self.refundTime.layer.borderWidth = 1;
    self.refundTime.layer.borderColor = UIColorFromRGB(0xFF6969).CGColor;
    self.refundTime.layer.cornerRadius = 12;
    self.refundTime.text = @"退款中，剩余：22:40:36";
//    [self.orderView addSubview:self.refundTime];
//    [self.refundTime mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.height.mas_offset(25);
//        make.width.mas_offset(180);
//        make.bottom.equalTo(self.goods_price.mas_top).offset(-20);
//    }];
}
#pragma mark - 退单成功/失败
-(void)refund_type{
    self.orderView.height =  350+3*30;
    
    [self.iconBtn setTitle:@"订单退款" forState:UIControlStateNormal];
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    
    UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dayinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
    [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
    [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
    [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:dayinBtn];
    [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
    /*优惠*/
    UILabel *preferentiallabel = [[UILabel alloc]init];
    preferentiallabel.text = @"优惠金额";
    preferentiallabel.textColor = UIColorFromRGB(0xF7AE2B);
    preferentiallabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:preferentiallabel];
    [preferentiallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-77);
    }];
    UILabel *servicelabel = [[UILabel alloc]init];
    servicelabel.text = @"服务费用";
    servicelabel.textColor = UIColorFromRGB(0x999999);
    servicelabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:servicelabel];
    [servicelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(preferentiallabel.mas_top).offset(-12);
    }];
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"总计     共 件商品";
    self.numlabel.textColor = UIColorFromRGB(0x999999);
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.numlabel];
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(servicelabel.mas_top).offset(-12);
    }];
    
    /*优惠金额*/
    self.save_money = [[UILabel alloc]init];
    self.save_money.textColor = UIColorFromRGB(0xF7AE2B);
    self.save_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money];
    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-77);
    }];
    
    /*服务费用*/
    self.service_money = [[UILabel alloc]init];
    self.service_money.textColor = UIColorFromRGB(0x222222);
    self.service_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.service_money];
    [self.service_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.save_money.mas_top).offset(-12);
    }];
    
    /**/
    self.goods_price = [[UILabel alloc]init];
    self.goods_price.textColor = UIColorFromRGB(0x222222);
    self.goods_price.font = [UIFont systemFontOfSize:24];
    [self.orderView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.service_money.mas_top).offset(-12);
    }];
    
    
    self.refundTime = [[UILabel alloc]init];
    self.refundTime.textColor = UIColorFromRGB(0xFF6969);
    self.refundTime.font = [UIFont systemFontOfSize:14];
    self.refundTime.textAlignment = 1;
    self.refundTime.layer.borderWidth = 1;
    self.refundTime.layer.borderColor = UIColorFromRGB(0xFF6969).CGColor;
    self.refundTime.layer.cornerRadius = 12;
    self.refundTime.text = @"退款成功";
    [self.orderView addSubview:self.refundTime];
    [self.refundTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(24);
        make.width.mas_offset(IPHONEWIDTH(85));
        make.bottom.equalTo(self.goods_price.mas_top).offset(-8);
    }];
}
#pragma mark - 退款
-(void)TK{
    
    [self.iconBtn setTitle:@"订单退款" forState:UIControlStateNormal];
    
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dayinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
    [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
    [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
    [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:dayinBtn];
    [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
    /**备注*/
    self.label_TKBeiZhu = [[UILabel alloc]initWithFrame:CGRectMake(10, 323, 150, 13)];
    self.label_TKBeiZhu.numberOfLines = 2;
    self.label_TKBeiZhu.textColor = UIColorFromRGB(0x999999);
    self.label_TKBeiZhu.font = [UIFont systemFontOfSize:14];
    self.label_TKBeiZhu.text = @"备注：";
    [self.orderView addSubview:self.label_TKBeiZhu];
    [self.label_TKBeiZhu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-5);
        make.bottom.mas_offset(-77);
    }];
    /*退款金额标题*/
    UILabel *tklabel = [[UILabel alloc]init];
    tklabel.text = @"退款金额";
    tklabel.textColor = UIColorFromRGB(0xFF6969);
    tklabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:tklabel];
    [tklabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(self.label_TKBeiZhu.mas_top).offset(-12);
    }];
    /**金额*/
    self.label_TKmoney = [[UILabel alloc]initWithFrame:CGRectMake(10, 323, 150, 13)];
    self.label_TKmoney.numberOfLines = 2;
    self.label_TKmoney.textColor = UIColorFromRGB(0xFF6969);
    self.label_TKmoney.font = [UIFont systemFontOfSize:14];
    self.label_TKmoney.text = @"-¥";
    [self.orderView addSubview:self.label_TKmoney];
    [self.label_TKmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.label_TKBeiZhu.mas_top).offset(-12);
    }];
    UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconButton setImage:[UIImage imageNamed:@"icn_order_clock"] forState:UIControlStateNormal];
    [iconButton setTitle:@"   退款详情" forState:UIControlStateNormal];
    [iconButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    iconButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.orderView addSubview:iconButton];
    [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(self.label_TKmoney.mas_top).offset(-12);
    }];
    /*退款详情状态*/
    self.label_TKtype = [[UILabel alloc]init];
    self.label_TKtype.textColor = UIColorFromRGB(0xF7AE2B);
    self.label_TKtype.font = [UIFont systemFontOfSize:14];
    self.label_TKtype.text = @"退款处理中";
    [self.orderView addSubview:self.label_TKtype];
    [self.label_TKtype mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.label_TKmoney.mas_top).offset(-12);
    }];
    /*优惠*/
    UILabel *preferentiallabel = [[UILabel alloc]init];
    preferentiallabel.text = @"优惠金额";
    preferentiallabel.textColor = UIColorFromRGB(0xF7AE2B);
    preferentiallabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:preferentiallabel];
    [preferentiallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(iconButton.mas_top).offset(-36);
    }];
    UILabel *servicelabel = [[UILabel alloc]init];
    servicelabel.text = @"服务费用";
    servicelabel.textColor = UIColorFromRGB(0x999999);
    servicelabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:servicelabel];
    [servicelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(preferentiallabel.mas_top).offset(-12);
    }];
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"总计     共 件商品";
    self.numlabel.textColor = UIColorFromRGB(0x999999);
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.numlabel];
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(servicelabel.mas_top).offset(-12);
    }];
    
    /*优惠金额*/
    self.save_money = [[UILabel alloc]init];
    self.save_money.textColor = UIColorFromRGB(0xF7AE2B);
    self.save_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money];
    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(iconButton.mas_top).offset(-36);
    }];
    /*服务费用*/
    self.service_money = [[UILabel alloc]init];
    self.service_money.textColor = UIColorFromRGB(0x222222);
    self.service_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.service_money];
    [self.service_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.save_money.mas_top).offset(-12);
    }];
    
    
    
    /**/
    self.goods_price = [[UILabel alloc]init];
    self.goods_price.textColor = UIColorFromRGB(0x222222);
    self.goods_price.font = [UIFont systemFontOfSize:24];
    [self.orderView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.service_money.mas_top).offset(-12);
    }];
    
}
#pragma mark - 取消
-(void)cancel{
    
    [self.iconBtn setTitle:@"订单已取消" forState:UIControlStateNormal];
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    /*优惠*/
    UILabel *preferentiallabel = [[UILabel alloc]init];
    preferentiallabel.text = @"优惠金额";
    preferentiallabel.textColor = UIColorFromRGB(0xF7AE2B);
    preferentiallabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:preferentiallabel];
    [preferentiallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-77);
    }];
    UILabel *servicelabel = [[UILabel alloc]init];
    servicelabel.text = @"服务费用";
    servicelabel.textColor = UIColorFromRGB(0x999999);
    servicelabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:servicelabel];
    [servicelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(preferentiallabel.mas_top).offset(-12);
    }];
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"总计     共 件商品";
    self.numlabel.textColor = UIColorFromRGB(0x999999);
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.numlabel];
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(servicelabel.mas_top).offset(-12);
    }];
    
    /*优惠金额*/
    self.save_money = [[UILabel alloc]init];
    self.save_money.textColor = UIColorFromRGB(0xF7AE2B);
    self.save_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money];
    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-77);
    }];
    
    
    /*服务费用*/
    self.service_money = [[UILabel alloc]init];
    self.service_money.textColor = UIColorFromRGB(0x222222);
    self.service_money.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.service_money];
    [self.service_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.save_money.mas_top).offset(-12);
    }];
    /**/
    self.goods_price = [[UILabel alloc]init];
    self.goods_price.textColor = UIColorFromRGB(0x222222);
    self.goods_price.font = [UIFont systemFontOfSize:24];
    [self.orderView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.service_money.mas_top).offset(-12);
    }];
    
}



- (CGFloat)getCellHeight {
    return  self.orderView.bottom;
}

#pragma mark - 操作
/** 删除 */
-(void)DeleteAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(delete_order:)]) {
        [self.delagate delete_order:self.Data];
    }
}
/** 查看明细 */
-(void)DetailAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(detail:)]) {
        [self.delagate detail:self.Data];
    }
    
}
/** 打印 */
-(void)DayinAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(printe:)]) {
        [self.delagate printe:self.Data];
    }
    
}
/*退单*/
-(void)refundAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(Refund:)]) {
        [self.delagate Refund:self.Data];
    }
}
/*拒绝*/
-(void)RefusedAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(Refused:)]) {
        [self.delagate Refused:self.Data];
    }
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    _Data = Data;

    NSArray *goods = Data[@"goods_info"];
    NSInteger  goodMen = goods.count;
    NSInteger orderV_H = 280;
    
    
//0全部、1待付款、2待使用、3待评价、4已评价、5已取消、6待退单、7退单完成、8退单失败、9待退款、10退款完成、11退款失败） 传入2，获取2,3的订单信息； 传入6，获取6,7,8的订单信息 传入9
    NSInteger status = [Data[@"order_status"] integerValue];
//    NSInteger pay_status = [Data[@"pay_status"] integerValue];//支付状态 0 未支付，1 已支付
//    NSInteger trade_status = [Data[@"trade_status"] integerValue];//交易状态 0 进行中 1.已完成(未核销)，2.已结算（已核销），3.已分佣,4 已取消
//    NSInteger eval_status = [Data[@"eval_status"] integerValue];//评价状态 0 未评价，1.已评价
    NSString *order_status_txt = [NSString stringWithFormat:@"%@",Data[@"order_status_txt"]];
    
    if ([[MethodCommon judgeStringIsNull:order_status_txt] isEqualToString:@""]) {
        order_status_txt =@"";
    }
    [self.iconBtn setTitle:order_status_txt forState:UIControlStateNormal];

    if ( status == 1) {
//        [self.iconBtn setTitle:@"订单待支付" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_to_be_paid"] forState:UIControlStateNormal];

    }else if (status == 2){
//        [self.iconBtn setTitle:@"订单已支付" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_paid"] forState:UIControlStateNormal];

    }else if(status == 3){
//        [self.iconBtn setTitle:@"订单已支付" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_paid"] forState:UIControlStateNormal];

    }else if (status == 4){
//        [self.iconBtn setTitle:@"订单已评价" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateNormal];
        orderV_H = 380;
        
    }else if(status == 5){
//        [self.iconBtn setTitle:@"订单已取消" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_cancel"] forState:UIControlStateNormal];
        orderV_H = 280;

    }else if(status == 6){
//        [self.iconBtn setTitle:@"订单退款" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_refund"] forState:UIControlStateNormal];
        orderV_H = 270;
        /*
         退款剩余时间
         remaining_process_refund_time
         */
        NSString *remaining_process_refund_time = [NSString stringWithFormat:@"%@",Data[@"remaining_process_refund_time"]];
        if ([[MethodCommon judgeStringIsNull:remaining_process_refund_time] isEqualToString:@""]) {
            remaining_process_refund_time = @"";
        }
        self.refundTime.text = [NSString stringWithFormat:@"退款中，剩余：%@",remaining_process_refund_time];
        

    }else if(status == 7){
//        [self.iconBtn setTitle:@"订单退款" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_refund"] forState:UIControlStateNormal];
        orderV_H = 295;
        self.refundTime.text = @"退款成功";

    }else if(status == 8){
         orderV_H = 295;
//        [self.iconBtn setTitle:@"订单退款" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_refund"] forState:UIControlStateNormal];
        self.refundTime.text = @"退款失败";

    }else if(status == 9){
        orderV_H = 390;
//        [self.iconBtn setTitle:@"订单退款" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_refund"] forState:UIControlStateNormal];
        self.label_TKtype.text = @"退款完成";
    }else if(status == 11){
        orderV_H = 390;
//        [self.iconBtn setTitle:@"订单退款" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_refund"] forState:UIControlStateNormal];
        self.label_TKtype.text = @"退款失败";
    }else{
        orderV_H = 380;

    }
    
    UIButton *detailsButton = [UIButton buttonWithType:UIButtonTypeCustom];

    if (goodMen>3) {
        goodMen = 3;
        
        self.orderView.height = orderV_H+goodMen*OrderGodds_H+OrderGodds_H/2;
        
        [detailsButton setTitle:@"查询其余*件" forState:UIControlStateNormal];
        [detailsButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [detailsButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [detailsButton addTarget:self action:@selector(DetailAction) forControlEvents:UIControlEventTouchUpInside];
        [self.orderView  addSubview:detailsButton];
        [detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.goods_price.mas_top).offset(-20);
            make.left.mas_offset(10);
            make.height.mas_offset(25);
        }];
        UILabel *detailslabel = [[UILabel alloc]init];
        detailslabel.text = @"...";
        detailslabel.textColor = UIColorFromRGB(0x222222);
        detailslabel.font = [UIFont systemFontOfSize:24];
        [self.orderView addSubview:detailslabel];
        [detailslabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.bottom.equalTo(detailsButton.mas_top).offset(-12);
        }];
        
        
    }else{
        self.orderView.height = orderV_H+goodMen*OrderGodds_H;

    }
    
    for (int i = 0; i<goodMen; i++) {
        UILabel *goodsName = [[UILabel alloc]init];
        goodsName.text = [NSString stringWithFormat:@"%@",goods[i][@"goods_name"]];
        goodsName.textColor = UIColorFromRGB(0x222222);
        goodsName.font = [UIFont systemFontOfSize:15];
        [self.orderView addSubview:goodsName];
        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(88+OrderGodds_H*i);
            make.left.mas_offset(10);
            make.right.mas_offset(-100);
//            make.size.mas_offset(CGSizeMake(self.orderView.width*0.8, 20));
            make.height.mas_offset(20);
        }];
        UILabel *goods_price = [[UILabel alloc]init];
        goods_price.text = [NSString stringWithFormat:@"¥%@",goods[i][@"goods_price"]];
        goods_price.textColor = UIColorFromRGB(0x222222);
        goods_price.font = [UIFont systemFontOfSize:14];
        [self.orderView addSubview:goods_price];
        [goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(88+OrderGodds_H*i);
            make.left.equalTo(goodsName.mas_right).offset(0);
            make.size.mas_offset(CGSizeMake(50, 20));
        }];
        
        UILabel *goods_num = [[UILabel alloc]init];
        goods_num.text = [NSString stringWithFormat:@"x%@",goods[i][@"goods_num"]];
        goods_num.textColor = UIColorFromRGB(0x999999);
        goods_num.font = [UIFont systemFontOfSize:12];
        goods_num.textAlignment = 2;
        [self.orderView addSubview:goods_num];
        [goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(88+OrderGodds_H*i);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(50, 20));
        }];
    }
    
    //下单时间
    self.TimeLabel.text = [NSString stringWithFormat:@"%@",Data[@"add_time"]];
    
    //订单内商品总数
    NSString *nums = [NSString stringWithFormat:@"%@",Data[@"total_goods_num"]];
    self.numlabel.text = [NSString stringWithFormat:@"总计     共%@件商品",nums];
    NSInteger i = [nums integerValue] - 3;
    
    [detailsButton setTitle:[NSString stringWithFormat:@"查询其余%ld件",i] forState:UIControlStateNormal];
    
    //订单内商品总价
    NSString *protocol = [NSString stringWithFormat:@"¥ %@",Data[@"total_goods_price"]];
    NSMutableAttributedString *attri_str=[[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:24]];
    NSRange ProRange = [protocol rangeOfString:@"¥"];
    [attri_str setFont:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 1)];
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"222222"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    self.goods_price.attributedText = attri_str;
    
//    self.goods_price.text = [NSString stringWithFormat:@"%@",Data[@"total_goods_price"]];
    
    //服务费用
    NSString *service_money =[NSString stringWithFormat:@"%@",Data[@"service_money"]];
    if ([[MethodCommon judgeStringIsNull:service_money] isEqualToString:@""]) {
        service_money =@"0";
    }
    self.service_money.text = [NSString stringWithFormat:@"¥%@",service_money];
    
    //优惠金额
    self.save_money.text = [NSString stringWithFormat:@"-¥%@",Data[@"save_money"]];
    
    
    //evaluate_score 评分	
    NSString *score = [NSString stringWithFormat:@"%@",Data[@"evaluate_score"]];
    self.starEvaluator.currentValue = [score integerValue];
    self.star.text = [NSString stringWithFormat:@"%@ 分",score];
    
    /*待支付订单的剩余支付时间 remaining_payment_time*/
    NSString *remaining_payment_time = [NSString stringWithFormat:@"%@",Data[@"remaining_payment_time"]];
    if ([[MethodCommon judgeStringIsNull:remaining_payment_time] isEqualToString:@""]) {
        remaining_payment_time = @"剩余支付时间";
    }
    self.PaymentTime.text = [NSString stringWithFormat:@"剩余支付时间%@",remaining_payment_time];
    
  /*退款金额*/
    NSString *refund_amount =[NSString stringWithFormat:@"%@",Data[@"refund_amount"]];
    if ([[MethodCommon judgeStringIsNull:refund_amount] isEqualToString:@""]) {
        self.label_TKmoney.text = @"-¥00";
    }else{
         self.label_TKmoney.text = [NSString stringWithFormat:@"-¥%@",refund_amount];
    }
 /*退款备注*/
    NSString *refund_remark =[NSString stringWithFormat:@"%@",Data[@"refund_remark"]];
    if ([[MethodCommon judgeStringIsNull:refund_remark] isEqualToString:@""]) {
        self.label_TKBeiZhu.text = @"备注：";
    }else{
       self.label_TKBeiZhu.text = [NSString stringWithFormat:@"备注：%@",refund_remark];
    }
    
}
#pragma mark - 懒加载
-(UIView *)orderView{
    if (!_orderView) {
        _orderView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, ScreenW-30, 350)];
        _orderView.backgroundColor = [UIColor whiteColor];
        _orderView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _orderView.layer.shadowOffset = CGSizeMake(0,2);
        _orderView.layer.shadowOpacity = 1;
        _orderView.layer.shadowRadius = 8;
        _orderView.layer.cornerRadius = 5;
        _orderView.clipsToBounds=YES;
    }
    return _orderView;
}
-(UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconBtn setImage:[UIImage imageNamed:@"icn_order_to_be_paid"] forState:UIControlStateNormal];
        [_iconBtn setTitle:@" " forState:UIControlStateNormal];
        [_iconBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
        [_iconBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _iconBtn;
}
-(UILabel *)TimeLabel{
    if (!_TimeLabel) {
        _TimeLabel = [[UILabel alloc]init];
        _TimeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _TimeLabel.font = [UIFont systemFontOfSize:12];
        _TimeLabel.textAlignment = 2;
    }
    return _TimeLabel;
}
-(UIButton *)HexiaoBtn{
    if (!_HexiaoBtn) {
        _HexiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_HexiaoBtn setTitle:@"未核销" forState:UIControlStateNormal];
        [_HexiaoBtn setTitle:@"已核销" forState:UIControlStateSelected];
        [_HexiaoBtn setBackgroundImage:[UIImage imageNamed:@"tag_fanbei_progress"] forState:UIControlStateNormal];
        [_HexiaoBtn setBackgroundImage:[UIImage imageNamed:@"tag_fanbei_end"] forState:UIControlStateSelected];
        _HexiaoBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_HexiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _HexiaoBtn;
}
@end
