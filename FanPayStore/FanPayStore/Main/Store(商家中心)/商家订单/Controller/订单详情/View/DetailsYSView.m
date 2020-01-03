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
        self.clipsToBounds=YES;
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
    
    UIImageView *iocn = [[UIImageView alloc]init];
    iocn.image = [UIImage imageNamed:@"input_arrow_right_deepgray"];
    [self addSubview:iocn];
    [iocn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY).offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(6, 9.9));
    }];
    
    UIView *view_line_1 = [[UIView alloc] init];
    view_line_1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self addSubview:view_line_1];
    [view_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(0.5);
    }];
    NSInteger lineW = (ScreenW-50)/9;
    for (int i=0; i<=lineW; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*9+9, 0, 5, 0.5)];
        line.backgroundColor = UIColorFromRGBA(0xFFFFFF, 0.7);
        [view_line_1 addSubview:line];
    }
    UIView *view_1 = [[UIView alloc] init];
    view_1.backgroundColor = UIColorFromRGB(0xF6F6F6);
    view_1.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.22].CGColor;
    view_1.layer.shadowOffset = CGSizeMake(0,0);
    view_1.layer.shadowOpacity = 1;
    view_1.layer.shadowRadius = 2;
    view_1.layer.cornerRadius = 5;
    [self addSubview:view_1];
    [view_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view_line_1.mas_centerY).offset(0);
        make.left.mas_offset(-5);
        make.size.mas_offset(CGSizeMake(10, 9));
    }];
    UIView *view_11 = [[UIView alloc] init];
    view_11.backgroundColor = UIColorFromRGB(0xF6F6F6);
    view_11.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.22].CGColor;
    view_11.layer.shadowOffset = CGSizeMake(0,0);
    view_11.layer.shadowOpacity = 1;
    view_11.layer.shadowRadius = 2;
    view_11.layer.cornerRadius = 5;
    [self addSubview:view_11];
    [view_11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view_line_1.mas_centerY).offset(0);
        make.right.mas_offset(5);
        make.size.mas_offset(CGSizeMake(10, 9));
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
        [self addSubview:view_1];
        [view_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(7);
            make.left.mas_offset(i*15+10);
            make.size.mas_offset(CGSizeMake(7, 13));
        }];
        
    }
#pragma mark - GOODS列表
//    NSArray *goodsArr = @[@{@"goods_name":@"海胆酱焗南瓜",@"goods_price":@"¥35",@"goods_num":@"×1"},
//                          @{@"goods_name":@"黑松露虾仁",@"goods_price":@"¥68",@"goods_num":@"×1"},
//                          @{@"goods_name":@"越式牛仔粒",@"goods_price":@"¥78",@"goods_num":@"×1"}];
//
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
    label_paid_type.text = @"商家实收";
    label_paid_type.textAlignment = 0;
    [self addSubview:label_paid_type];
    [label_paid_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 57));
    }];
    [self addSubview:self.hotelSF];
    [self.hotelSF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.right.mas_offset(-10);
        make.height.mas_offset(57);
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
    for (int i=0; i<=lineW; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*9+9, 0, 5, 0.5)];
        line.backgroundColor = UIColorFromRGBA(0xFFFFFF, 0.7);
        [view_line_2 addSubview:line];
    }

    
    
    self.view_line_4 = [[UIView alloc] init];
    self.view_line_4.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self addSubview:self.view_line_4];
    [self.view_line_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(95+35);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(0.5);
    }];
#pragma mark -   /*门店金额*/
    self.label_YH1  = [[UILabel alloc] init];
    self.label_YH1.numberOfLines = 0;
    self.label_YH1.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    self.label_YH1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.label_YH1.text = @"门店金额";
    self.label_YH1.textAlignment = 0;
    [self addSubview:self.label_YH1];
    [self.label_YH1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_line_4.mas_bottom).offset(19);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    [self addSubview:self.hotelY1];
    [self.hotelY1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_line_4.mas_bottom).offset(19);
        make.right.mas_offset(-10);
    }];

    
#pragma mark -   /*优惠金额*/
    self.label_YH  = [[UILabel alloc] init];
    self.label_YH.numberOfLines = 0;
    self.label_YH.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    self.label_YH.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.label_YH.text = @"用户实付";
    self.label_YH.textAlignment = 0;
    [self addSubview:self.label_YH];
    [self.label_YH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_YH1.mas_bottom).offset(11.5);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    [self addSubview:self.hotelY];
    [self.hotelY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_YH1.mas_bottom).offset(11.5);
        make.right.mas_offset(-10);
    }];
    
#pragma mark -   /*服务费用*/
    self.label_FW  = [[UILabel alloc] init];
    self.label_FW.numberOfLines = 0;
    self.label_FW.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    self.label_FW.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.label_FW.text = @"服务费用";
    self.label_FW.textAlignment = 0;
    [self addSubview:self.label_FW];
    [self.label_FW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_YH.mas_bottom).offset(11.5);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    
    [self addSubview:self.hotelFW];
    [self.hotelFW mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.label_YH.mas_bottom).offset(11.5);
        make.right.mas_offset(-10);
    }];

    
    
}
-(void)setStatus:(DetailsVieWStatus)status{
    _status = status;
    // 判断
    if (_status == DetailsVieWStatus_1) {
//#pragma mark -   /*优惠金额*/
//        UILabel *label_YH  = [[UILabel alloc] init];
//        label_YH.numberOfLines = 0;
//        label_YH.font = [UIFont fontWithName:@"American Typewriter" size: 14];
//        label_YH.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        label_YH.text = @"优惠金额";
//        label_YH.textAlignment = 0;
//        [self addSubview:label_YH];
//        [label_YH mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.hotelSF.mas_top).offset(-20);
//            make.left.mas_offset(10);
//            make.size.mas_offset(CGSizeMake(90, 13));
//        }];
        
//        [self addSubview:self.hotelY];
//        [self.hotelY mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.hotelSF.mas_top).offset(-20);
//            make.right.mas_offset(-10);
//        }];
        
//#pragma mark -   /*服务费用*/
//        UILabel *label_FW  = [[UILabel alloc] init];
//        label_FW.numberOfLines = 0;
//        label_FW.font = [UIFont fontWithName:@"American Typewriter" size: 14];
//        label_FW.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        label_FW.text = @"服务费用";
//        label_FW.textAlignment = 0;
//        [self addSubview:label_FW];
//        [label_FW mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(label_YH.mas_top).offset(-20);
//            make.left.mas_offset(10);
//            make.size.mas_offset(CGSizeMake(90, 13));
//        }];
        
//        [self addSubview:self.hotelFW];
//        [self.hotelFW mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(label_YH.mas_top).offset(-20);
//            make.right.mas_offset(-10);
//        }];
//
//        UIView *view_line_4 = [[UIView alloc] init];
//        view_line_4.backgroundColor = UIColorFromRGB(0xEAEAEA);
//        [self addSubview:view_line_4];
//        [view_line_4 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo( label_FW.mas_top).offset(-10);
//            make.left.mas_offset(@(10));
//            make.right.mas_offset(@(-10));
//            make.height.mas_equalTo(0.5);
//        }];
//        NSInteger lineW = (ScreenW-50)/9;
//        for (int i=0; i<=lineW; i++) {
//            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*9+9, 0, 5, 0.5)];
//            line.backgroundColor = UIColorFromRGBA(0xFFFFFF, 0.7);
//            [view_line_4 addSubview:line];
//        }
//
//        UIView *view_111 = [[UIView alloc] init];
//        view_111.backgroundColor = UIColorFromRGB(0xF6F6F6);
//        view_111.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor;
//        view_111.layer.shadowOffset = CGSizeMake(0,0);
//        view_111.layer.shadowOpacity = 1;
//        view_111.layer.shadowRadius = 2;
//        view_111.layer.cornerRadius = 5;
//        [self addSubview:view_111];
//        [view_111 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(view_line_4.mas_centerY).offset(0);
//            make.left.mas_offset(-5);
//            make.size.mas_offset(CGSizeMake(10, 9));
//        }];
//        UIView *view_1111 = [[UIView alloc] init];
//        view_1111.backgroundColor = UIColorFromRGB(0xF6F6F6);
//        view_1111.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor;
//        view_1111.layer.shadowOffset = CGSizeMake(0,0);
//        view_1111.layer.shadowOpacity = 1;
//        view_1111.layer.shadowRadius = 2;
//        view_1111.layer.cornerRadius = 5;
//        [self addSubview:view_1111];
//        [view_1111 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(view_line_4.mas_centerY).offset(0);
//            make.right.mas_offset(5);
//            make.size.mas_offset(CGSizeMake(10, 9));
//        }];
        
    }else if (_status == DetailsVieWStatus_2){

        self.view_line_3 = [[UIView alloc] init];
        self.view_line_3.backgroundColor = UIColorFromRGB(0xEAEAEA);
        [self addSubview:self.view_line_3];
        [self.view_line_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo( self.view_line_4.mas_bottom).offset(97);
            make.left.mas_offset(@(10));
            make.right.mas_offset(@(-10));
            make.height.mas_equalTo(0.5);
        }];
        NSInteger lineW = (ScreenW-50)/9;
        for (int i=0; i<=lineW; i++) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*9+9, 0, 5, 0.5)];
            line.backgroundColor = UIColorFromRGBA(0xFFFFFF, 0.7);
            [self.view_line_3 addSubview:line];
        }
        
#pragma mark -   /*退款金额*/
        self.label_TK.text = @"退款金额";
        [self addSubview:self.label_TK];
        [self.label_TK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view_line_3.mas_bottom).offset(19.5);
            make.left.mas_offset(10);
        }];
        
        [self addSubview:self.TK];
        [self.TK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view_line_3.mas_bottom).offset(19.5);
            make.right.mas_offset(-10);
           
        }];
        [self addSubview:self.label_TKBeiZhu];
        [self.label_TKBeiZhu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_TK.mas_bottom).offset(11.5);
            make.left.mas_offset(10);
        }];
        
//#pragma mark -   /*优惠金额*/
//        UILabel *label_YH  = [[UILabel alloc] init];
//        label_YH.numberOfLines = 0;
//        label_YH.font = [UIFont fontWithName:@"American Typewriter" size: 14];
//        label_YH.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        label_YH.text = @"优惠金额";
//        label_YH.textAlignment = 0;
//        [self addSubview:label_YH];
//        [label_YH mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view_line_3.mas_top).offset(-20);
//            make.left.mas_offset(10);
//            make.size.mas_offset(CGSizeMake(90, 13));
//        }];
        
//        [self addSubview:self.hotelY];
//        [self.hotelY mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view_line_3.mas_top).offset(-20);
//            make.right.mas_offset(-10);
//        }];
        
//#pragma mark -   /*服务费用*/
//        UILabel *label_FW  = [[UILabel alloc] init];
//        label_FW.numberOfLines = 0;
//        label_FW.font = [UIFont fontWithName:@"American Typewriter" size: 14];
//        label_FW.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        label_FW.text = @"服务费用";
//        label_FW.textAlignment = 0;
//        [self addSubview:label_FW];
//        [label_FW mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(label_YH.mas_top).offset(-20);
//            make.left.mas_offset(10);
//            make.size.mas_offset(CGSizeMake(90, 13));
//        }];
//        [self addSubview:self.hotelFW];
//        [self.hotelFW mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(label_YH.mas_top).offset(-20);
//            make.right.mas_offset(-10);
//        }];
        
       
        }
    
    
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    
    CGFloat suxing_h = 0;
    NSArray *goodsArr = Data[@"goods_info"];

    for (int i =0; i<goodsArr.count; i++) {
        
        UILabel *goodsName = [[UILabel alloc]init];
        goodsName.text = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
        goodsName.textColor = UIColorFromRGB(0x222222);
        goodsName.font = [UIFont systemFontOfSize:15];
        [self addSubview:goodsName];
        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(80+35*i+suxing_h);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(self.width/1.6, 25));
        }];
        
       
        
        UILabel *goods_price = [[UILabel alloc]init];
        goods_price.text = [NSString stringWithFormat:@"¥ %@",goodsArr[i][@"goods_price"]];
        goods_price.textColor = UIColorFromRGB(0x222222);
        goods_price.font = [UIFont systemFontOfSize:14];
        [self addSubview:goods_price];
        [goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(80+35*i+suxing_h);
            make.left.equalTo(goodsName.mas_right).offset(15);
            make.size.mas_offset(CGSizeMake(self.width/4, 25));
        }];
        
        UILabel *goods_num = [[UILabel alloc]init];
        goods_num.text = [NSString stringWithFormat:@"x%@",goodsArr[i][@"goods_num"]];
        goods_num.textColor = UIColorFromRGB(0x999999);
        goods_num.font = [UIFont systemFontOfSize:12];
        goods_num.textAlignment = 2;
        [self addSubview:goods_num];
        [goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(80+35*i+suxing_h);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(self.width/4, 25));
        }];
        
        NSString *goods_attributes= [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_attributes"]];
        if ([[MethodCommon judgeStringIsNull:goods_attributes] isEqualToString:@""]) {
//            suxing_h = 0;
        }else{
             suxing_h = suxing_h+12;
            UILabel *goodsName1 = [[UILabel alloc]init];
            goodsName1.text = goods_attributes;
            goodsName1.textColor = UIColorFromRGB(0x999999);
            goodsName1.font = [UIFont systemFontOfSize:12];
            [self addSubview:goodsName1];
            [goodsName1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(goodsName.mas_bottom).offset(0);
                make.left.mas_offset(10);
                make.right.mas_offset(-100);
            }];
        }
        
    }
    
    
   
    [self.view_line_4 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(95+35*goodsArr.count+suxing_h);
    }];
    self.view_line_4.top = 95+35*goodsArr.count+suxing_h;
    
    NSInteger lineW = (ScreenW-50)/9;
    for (int i=0; i<=lineW; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*9+9, 0, 5, 0.5)];
        line.backgroundColor = UIColorFromRGBA(0xFFFFFF, 0.7);
        [self.view_line_4 addSubview:line];
    }
    
    UIView *view_111 = [[UIView alloc] init];
    view_111.backgroundColor = UIColorFromRGB(0xF6F6F6);
    view_111.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor;
    view_111.layer.shadowOffset = CGSizeMake(0,0);
    view_111.layer.shadowOpacity = 1;
    view_111.layer.shadowRadius = 2;
    view_111.layer.cornerRadius = 5;
    [self addSubview:view_111];
    [view_111 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view_line_4.mas_centerY).offset(0);
        make.left.mas_offset(-5);
        make.size.mas_offset(CGSizeMake(10, 9));
    }];
    UIView *view_1111 = [[UIView alloc] init];
    view_1111.backgroundColor = UIColorFromRGB(0xF6F6F6);
    view_1111.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor;
    view_1111.layer.shadowOffset = CGSizeMake(0,0);
    view_1111.layer.shadowOpacity = 1;
    view_1111.layer.shadowRadius = 2;
    view_1111.layer.cornerRadius = 5;
    [self addSubview:view_1111];
    [view_1111 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view_line_4.mas_centerY).offset(0);
        make.right.mas_offset(5);
        make.size.mas_offset(CGSizeMake(10, 9));
    }];
    
    
    
    
    
    NSString *service_money = [NSString stringWithFormat:@"%@",Data[@"service_money"]];
    if ([[MethodCommon judgeStringIsNull:service_money] isEqualToString:@""]) {
         self.hotelFW.text = @"¥";
    }else{
        self.hotelFW.text = [NSString stringWithFormat:@"¥%@",service_money];

    }
    
    /*门店金额*/
    NSString  *account_money = [NSString stringWithFormat:@"%@",Data[@"account_money"]];
    if ([[MethodCommon judgeStringIsNull:account_money] isEqualToString:@""]) {
        self.hotelY1.text = @"¥00";
    }else{
        self.hotelY1.text = [NSString stringWithFormat:@"¥%@",account_money];
        
    }
    
     /*实付金额*/
    NSString  *actual_money = [NSString stringWithFormat:@"%@",Data[@"actual_money"]];
    if ([[MethodCommon judgeStringIsNull:actual_money] isEqualToString:@""]) {
        self.hotelY.text = @"¥00";
    }else{
        self.hotelY.text = [NSString stringWithFormat:@"¥%@",actual_money];

    }
    
    
    /*实收*/
    NSString *order_money = [NSString stringWithFormat:@"%@",Data[@"order_money"]];
    if ([[MethodCommon judgeStringIsNull:order_money] isEqualToString:@""]) {
        order_money = @"00";
    }else{

    }
    NSString *protocol = [NSString stringWithFormat:@"¥%@",order_money];
    NSMutableAttributedString *attri_str=[[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:24]];
    NSRange ProRange = [protocol rangeOfString:@"¥"];
    [attri_str setFont:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 1)];
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"F7AE2B"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    self.hotelSF.attributedText = attri_str;
    
       /*退款备注*/
    NSString *refund_remark = [NSString stringWithFormat:@"%@",Data[@"refund_info"][@"refund_remark"]];
    if ([[MethodCommon judgeStringIsNull:refund_remark] isEqualToString:@""]) {
        self.label_TKBeiZhu.text = @"备注：";
    }else{
        self.label_TKBeiZhu.text = [NSString stringWithFormat: @"备注：%@",refund_remark];
    }
    /*退款金额*/
    NSString *refund_amount = [NSString stringWithFormat:@"%@",Data[@"refund_info"][@"refund_amount"]];
    if ([[MethodCommon judgeStringIsNull:refund_amount] isEqualToString:@""]) {
         self.TK.text = [NSString stringWithFormat:@"-¥00"];
    }else{
      self.TK.text = [NSString stringWithFormat:@"-¥%@",refund_amount];
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
        _hotelY.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _hotelY.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _hotelY;
}
-(UILabel *)hotelY1{
    if (!_hotelY1) {
        _hotelY1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _hotelY1.numberOfLines = 0;
        _hotelY1.textAlignment = 1;
        _hotelY1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _hotelY1.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _hotelY1;
}
-(UILabel *)hotelSF{
    if (!_hotelSF) {
        _hotelSF = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 12)];
        _hotelSF.numberOfLines = 0;
        _hotelSF.textAlignment = 1;
        _hotelSF.textColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
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
