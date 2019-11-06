//
//  DetailsYSView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/29.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "DetailsYSView.h"

@implementation DetailsYSView

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
    
    UIView *view_line_1 = [[UIView alloc] init];
    view_line_1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self addSubview:view_line_1];
    [view_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(0.5);
    }];
    
    
#pragma mark - GOODS列表
    NSArray *goodsArr = @[@{@"goods_name":@"海胆酱焗南瓜",@"goods_price":@"¥35",@"goods_num":@"×1"},
                          @{@"goods_name":@"黑松露虾仁",@"goods_price":@"¥68",@"goods_num":@"×1"},
                          @{@"goods_name":@"越式牛仔粒",@"goods_price":@"¥78",@"goods_num":@"×1"}];
    
//    for (int i =0; i<goodsArr.count; i++) {
//
//        UILabel *goodsName = [[UILabel alloc]init];
//        goodsName.text = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
//        goodsName.textColor = UIColorFromRGB(0x222222);
//        goodsName.font = [UIFont systemFontOfSize:15];
//        [self addSubview:goodsName];
//        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(view_line_1.mas_bottom).offset(12+35*i);
//            make.left.mas_offset(10);
//            make.size.mas_offset(CGSizeMake(self.width/2, 25));
//        }];
//
//
//        UILabel *goods_price = [[UILabel alloc]init];
//        goods_price.text = [NSString stringWithFormat:@"¥ %@",goodsArr[i][@"goods_price"]];
//        goods_price.textColor = UIColorFromRGB(0x222222);
//        goods_price.font = [UIFont systemFontOfSize:14];
//        [self addSubview:goods_price];
//        [goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(view_line_1.mas_bottom).offset(12+35*i);
//            make.left.equalTo(goodsName.mas_right).offset(10);
//            make.size.mas_offset(CGSizeMake(self.width/4, 25));
//        }];
//
//        UILabel *goods_num = [[UILabel alloc]init];
//        goods_num.text = [NSString stringWithFormat:@"x%@",goodsArr[i][@"goods_num"]];
//        goods_num.textColor = UIColorFromRGB(0x999999);
//        goods_num.font = [UIFont systemFontOfSize:12];
//        goods_num.textAlignment = 2;
//        [self addSubview:goods_num];
//        [goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(view_line_1.mas_bottom).offset(12+35*i);
//            make.right.mas_offset(-10);
//            make.size.mas_offset(CGSizeMake(self.width/4, 25));
//        }];
//    }
    
    
#pragma mark -   /*实付*/
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
        make.size.mas_offset(CGSizeMake(90, 70));
    }];
    [self addSubview:self.hotelSF];
    [self.hotelSF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.right.mas_offset(-10);
        make.height.mas_offset(70);
    }];
    UIView *view_line_2 = [[UIView alloc] init];
    view_line_2.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self addSubview:view_line_2];
    [view_line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label_paid_type.mas_top).offset(0);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(0.5);
    }];
    

    
   

    
}
-(void)setStatus:(DetailsVieWStatus)status{
    _status = status;
    // 判断
    if (_status == DetailsVieWStatus_1) {

     
#pragma mark -   /*优惠金额*/
        UILabel *label_YH  = [[UILabel alloc] init];
        label_YH.numberOfLines = 0;
        label_YH.font = [UIFont fontWithName:@"American Typewriter" size: 14];
        label_YH.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        label_YH.text = @"优惠金额";
        label_YH.textAlignment = 0;
        [self addSubview:label_YH];
        [label_YH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.hotelSF.mas_top).offset(-20);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(90, 13));
        }];
        
        [self addSubview:self.hotelY];
        [self.hotelY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.hotelSF.mas_top).offset(-20);
            make.right.mas_offset(-10);
        }];
        
#pragma mark -   /*服务费用*/
        UILabel *label_FW  = [[UILabel alloc] init];
        label_FW.numberOfLines = 0;
        label_FW.font = [UIFont fontWithName:@"American Typewriter" size: 14];
        label_FW.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        label_FW.text = @"服务费用";
        label_FW.textAlignment = 0;
        [self addSubview:label_FW];
        [label_FW mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label_YH.mas_top).offset(-20);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(90, 13));
        }];
        [self addSubview:self.hotelFW];
        [self.hotelFW mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label_YH.mas_top).offset(-20);
            make.right.mas_offset(-10);
        }];
        
        UIView *view_line_4 = [[UIView alloc] init];
        view_line_4.backgroundColor = UIColorFromRGB(0xEAEAEA);
        [self addSubview:view_line_4];
        [view_line_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo( label_FW.mas_top).offset(-10);
            make.left.mas_offset(@(10));
            make.right.mas_offset(@(-10));
            make.height.mas_equalTo(0.5);
        }];
        
    
    }else if (_status == DetailsVieWStatus_2){

#pragma mark -   /*退款金额*/
        self.label_TKBeiZhu.text = @"备注：菜金酒水退款";
        [self addSubview:self.label_TKBeiZhu];
        [self.label_TKBeiZhu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.hotelSF.mas_top).offset(-20);
            make.left.mas_offset(10);
            make.right.mas_offset(0);
        }];
        
        self.label_TK.text = @"退款金额";
        [self addSubview:self.label_TK];
        [self.label_TK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.label_TKBeiZhu.mas_top).offset(-11);
            make.left.mas_offset(10);
//            make.size.mas_offset(CGSizeMake(90, 44));
        }];
        
        [self addSubview:self.TK];
        [self.TK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.label_TKBeiZhu.mas_top).offset(-11);
            make.right.mas_offset(-10);
//            make.height.mas_offset(44);
        }];
        self.view_line_3 = [[UIView alloc] init];
        self.view_line_3.backgroundColor = UIColorFromRGB(0xEAEAEA);
        [self addSubview:self.view_line_3];
        [self.view_line_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo( self.hotelSF.mas_top).offset(-77);
            make.left.mas_offset(@(10));
            make.right.mas_offset(@(-10));
            make.height.mas_equalTo(0.5);
        }];
        
        
#pragma mark -   /*优惠金额*/
        UILabel *label_YH  = [[UILabel alloc] init];
        label_YH.numberOfLines = 0;
        label_YH.font = [UIFont fontWithName:@"American Typewriter" size: 14];
        label_YH.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        label_YH.text = @"优惠金额";
        label_YH.textAlignment = 0;
        [self addSubview:label_YH];
        [label_YH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view_line_3.mas_top).offset(-20);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(90, 13));
        }];
        
        [self addSubview:self.hotelY];
        [self.hotelY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view_line_3.mas_top).offset(-20);
            make.right.mas_offset(-10);
        }];
        
#pragma mark -   /*服务费用*/
        UILabel *label_FW  = [[UILabel alloc] init];
        label_FW.numberOfLines = 0;
        label_FW.font = [UIFont fontWithName:@"American Typewriter" size: 14];
        label_FW.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        label_FW.text = @"服务费用";
        label_FW.textAlignment = 0;
        [self addSubview:label_FW];
        [label_FW mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label_YH.mas_top).offset(-20);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(90, 13));
        }];
        [self addSubview:self.hotelFW];
        [self.hotelFW mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label_YH.mas_top).offset(-20);
            make.right.mas_offset(-10);
        }];
        
        UIView *view_line_4 = [[UIView alloc] init];
        view_line_4.backgroundColor = UIColorFromRGB(0xEAEAEA);
        [self addSubview:view_line_4];
        [view_line_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo( label_FW.mas_top).offset(-10);
            make.left.mas_offset(@(10));
            make.right.mas_offset(@(-10));
            make.height.mas_equalTo(0.5);
        }];
        
    }
    
    
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    
    NSArray *goodsArr = Data[@"goods_info"];

    for (int i =0; i<goodsArr.count; i++) {
        
        UILabel *goodsName = [[UILabel alloc]init];
        goodsName.text = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
        goodsName.textColor = UIColorFromRGB(0x222222);
        goodsName.font = [UIFont systemFontOfSize:15];
        [self addSubview:goodsName];
        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(80+35*i);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(self.width/2, 25));
        }];
        
        
        UILabel *goods_price = [[UILabel alloc]init];
        goods_price.text = [NSString stringWithFormat:@"¥ %@",goodsArr[i][@"goods_price"]];
        goods_price.textColor = UIColorFromRGB(0x222222);
        goods_price.font = [UIFont systemFontOfSize:14];
        [self addSubview:goods_price];
        [goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(80+35*i);
            make.left.equalTo(goodsName.mas_right).offset(10);
            make.size.mas_offset(CGSizeMake(self.width/4, 25));
        }];
        
        UILabel *goods_num = [[UILabel alloc]init];
        goods_num.text = [NSString stringWithFormat:@"x%@",goodsArr[i][@"goods_num"]];
        goods_num.textColor = UIColorFromRGB(0x999999);
        goods_num.font = [UIFont systemFontOfSize:12];
        goods_num.textAlignment = 2;
        [self addSubview:goods_num];
        [goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(80+35*i);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(self.width/4, 25));
        }];
    }
    
    
    NSString *service_money = [NSString stringWithFormat:@"%@",Data[@"service_money"]];
    if ([[MethodCommon judgeStringIsNull:service_money] isEqualToString:@""]) {
        
    }else{
        self.hotelFW.text = service_money;

    }
    
    
    NSString  *save_money = [NSString stringWithFormat:@"-¥%@",Data[@"save_money"]];
    if ([[MethodCommon judgeStringIsNull:save_money] isEqualToString:@""]) {
        
    }else{
        self.hotelY.text = save_money;

    }
    
     self.TK.text = [NSString stringWithFormat:@"-¥%@",Data[@"save_money"]];;
    
    
    NSString *actual_money = [NSString stringWithFormat:@"¥%@",Data[@"actual_money"]];
    if ([[MethodCommon judgeStringIsNull:actual_money] isEqualToString:@""]) {
        
    }else{
        self.hotelSF.text = actual_money;

    }
}
#pragma mark - 懒加载
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
        _hotelY.textColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
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
-(UILabel *)label_TK{
    if (!_label_TK) {
        _label_TK = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _label_TK.numberOfLines = 0;
        _label_TK.textAlignment = 0;
        _label_TK.textColor = UIColorFromRGB(0x999999);
        _label_TK.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    }
    return _label_TK;
}
-(UILabel *)label_TKBeiZhu{
    if (!_label_TKBeiZhu) {
        _label_TKBeiZhu = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _label_TKBeiZhu.numberOfLines = 0;
        _label_TKBeiZhu.textAlignment = 0;
        _label_TKBeiZhu.textColor = UIColorFromRGB(0x999999);
        _label_TKBeiZhu.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    }
    return _label_TKBeiZhu;
}
-(UILabel *)TK{
    if (!_TK) {
        _TK = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _TK.numberOfLines = 0;
        _TK.textAlignment = 1;
        _TK.textColor = UIColorFromRGB(0xFF6969);
        _TK.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _TK;
}
@end
