//
//  BrandNewOrderCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/21.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//
#define  OrderGodds_H      26.5
#define  OrderView_H      43

#import "BrandNewOrderCell.h"

@implementation BrandNewOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
    }
    
    return self;
}
#pragma mark - UI
-(void)createUI{
    /*订单层视图*/
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
    /*预约*/
    [self.orderView addSubview:self.YuyueView];
    [self.YuyueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    self.YYicon = [[UIImageView alloc]init];
    self.YYicon.image = [UIImage imageNamed:@"icn_booking_big"];
    [self.YuyueView addSubview:self.YYicon];
    [self.YYicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(36, 36));
    }];
    self.yylabel = [[UILabel alloc]init];
    self.yylabel.font = [UIFont systemFontOfSize:12];
    self.yylabel.backgroundColor =  [UIColor colorWithRed:224/255.0 green:242/255.0 blue:255/255.0 alpha:1.0];
    self.yylabel.text = @"预约";
    self.yylabel.textAlignment = 1;
    self.yylabel.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    [self.YuyueView addSubview:self.yylabel];
    [self.yylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.equalTo(self.YYicon.mas_right).offset(10);
        make.width.mas_offset(36);
    }];
    
    self.YYTimeLabel = [[UILabel alloc]init];
    self.YYTimeLabel .font = [UIFont systemFontOfSize:16];
    self.YYTimeLabel .text = @"2019-12-12 12:30";
    self.YYTimeLabel .textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    [self.YuyueView addSubview:self.YYTimeLabel ];
    [self.YYTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.equalTo(self.yylabel.mas_right).offset(10);
        make.right.mas_offset(0);
    }];
    
    /*订单的状态*/
    [self.orderView addSubview:self.iconBtn];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.YuyueView.mas_bottom).offset(0);
        make.height.mas_offset(50);
    }];
    /*订单下单时间*/
    [self.orderView addSubview:self.TimeLabel];
    [self.TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(self.YuyueView.mas_bottom).offset(0);
        make.height.mas_offset(50);
    }];
    /*订单横线*/
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(10,self.iconBtn.bottom,self.orderView.width-20,0.5);
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.orderView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.iconBtn.mas_bottom).offset(0);
        make.right.mas_offset(-10);
        make.height.mas_offset(0.5);
    }];
    /*订单核销状态*/
    [self.orderView addSubview:self.HexiaoBtn];
    [self.HexiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.top.equalTo(self.iconBtn.mas_bottom).offset(-1);
        make.size.mas_offset(CGSizeMake(50, 25));
    }];
    self.OrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 62.5, 150, 13)];
    self.OrderLabel.text = @"商品列表";
    self.OrderLabel.textColor = UIColorFromRGB(0x999999);
    self.OrderLabel.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.OrderLabel];
    [self.OrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line.mas_bottom).offset(12);
    }];
    /*剩余支付时间*/
    [self.orderView addSubview:self.PaymentTime];
    [self.PaymentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(9.5);
        make.bottom.mas_offset(-25);
        make.width.mas_offset(164.5);
        make.height.mas_offset(32);
    }];
    /*打印订单*/
    [self.orderView addSubview:self.PrintBtn];
    [self.PrintBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
    /*删除按钮*/
    [self.orderView addSubview:self.DeleteButton];
    [self.DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    /*确认退款按钮*/
    [self.orderView addSubview:self.ConfirmButton];
    [self.ConfirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    /*确认退款按钮*/
    [self.orderView addSubview:self.contactButton];
    [self.contactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.equalTo(self.DeleteButton.mas_left).offset(-10);
        make.height.mas_offset(32);
        make.width.mas_offset(80);
    }];
    
    /*总计多少件商品*/
    [self.orderView addSubview:self.numlabel];
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(43);
    }];
    
    [self.orderView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.equalTo(self.numlabel.mas_bottom).offset(0);
    }];
    
    self.save_money_Label1 = [[UILabel alloc]init];
    self.save_money_Label1.text = @"门店金额";
    self.save_money_Label1.textColor = UIColorFromRGB(0x999999);
    self.save_money_Label1.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money_Label1];
    [self.save_money_Label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.numlabel.mas_bottom).offset(11.5);
    }];
    [self.orderView addSubview:self.account_money];
    [self.account_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(self.numlabel.mas_bottom).offset(11.5);
    }];
    
    self.save_money_Label = [[UILabel alloc]init];
    self.save_money_Label.text = @"用户实付";
    self.save_money_Label.textColor = UIColorFromRGB(0x999999);
    self.save_money_Label.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.save_money_Label];
    [self.save_money_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.save_money_Label1.mas_bottom).offset(11.5);
    }];
    [self.orderView addSubview:self.save_money];
    [self.save_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(self.save_money_Label1.mas_bottom).offset(11.5);
    }];

    self.service_money_Label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.numlabel.bottom+11.5, 150, 13)];
    self.service_money_Label.text = @"服务费用";
    self.service_money_Label.textColor = UIColorFromRGB(0x999999);
    self.service_money_Label.font = [UIFont systemFontOfSize:14];
    [self.orderView addSubview:self.service_money_Label];
    [self.service_money_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.save_money_Label.mas_bottom).offset(11.5);
    }];
    
    [self.orderView addSubview:self.service_money];
    [self.service_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(self.save_money_Label.mas_bottom).offset(11.5);
    }];
    
    /*退款详情*/
    [self.orderView addSubview:self.TkiconButton];
    [self.TkiconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.service_money_Label.mas_bottom).offset(36);
    }];
     /*退款状态*/
    [self.orderView addSubview:self.label_TKtype];
    [self.label_TKtype mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(self.TkiconButton.mas_centerY).offset(0);
    }];
    
    [self.orderView addSubview:self.label_TKmoney_Label];
    [self.label_TKmoney_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.TkiconButton.mas_bottom).offset(12.5);
    }];
    /*退款金额*/
    [self.orderView addSubview:self.label_TKmoney];
    [self.label_TKmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(self.label_TKmoney_Label.mas_centerY).offset(0);
    }];
    /*退款备注*/
    [self.orderView addSubview:self.label_TKBeiZhu];
    [self.label_TKBeiZhu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-5);
        make.top.equalTo(self.label_TKmoney_Label.mas_bottom).offset(11.5);
    }];
    /**评论分割线*/
    self.PLLine = [[UIView alloc]initWithFrame:CGRectMake(10, self.numlabel.bottom+250., 1, 1)];
    self.PLLine.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.orderView addSubview:self.PLLine];
    [self.PLLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(0.5);
        make.top.equalTo(self.service_money_Label.mas_bottom).offset(20);
    }];
    /*评论标题*/
    [self.orderView addSubview:self.label_Eval];
    [self.label_Eval mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.PLLine.mas_bottom).offset(20);
    }];
    /*评论分*/
    [self.orderView addSubview:self.star];
    [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(self.label_Eval.mas_bottom).offset(20);
    }];
    /*星星*/
    StarEvaluator *starEvaluator = [[StarEvaluator alloc] initWithFrame:CGRectMake(25, 395, 120, 30)];
    starEvaluator.delegate = self;
    starEvaluator.userInteractionEnabled = NO;
    starEvaluator.currentValue = 4;
    self.starEvaluator = starEvaluator;
    [self.orderView addSubview:starEvaluator];
    [starEvaluator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(self.star.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(120, 30));
    }];
    
    
    self.detailslabel.text = @"...";
    self.detailslabel.textColor = UIColorFromRGB(0x222222);
    self.detailslabel.font = [UIFont systemFontOfSize:24];
    [self.detailsButton setTitle:@"查询其余*件" forState:UIControlStateNormal];
    [self.detailsButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.detailsButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    self.detailsButton.tag = [_Data[@"order_id"] integerValue];
    [self.detailsButton addTarget:self action:@selector(TheRestAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.orderView addSubview:self.detailslabel];
    [self.detailslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.OrderLabel.mas_bottom).offset(OrderGodds_H);
    }];
    
    
    [self.orderView  addSubview:self.detailsButton];
    [self.detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailslabel.mas_bottom).offset(5);
        make.left.mas_offset(10);
        make.height.mas_offset(25);
    }];
    
    self.ZuiLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.numlabel.bottom+290., 1, 1)];
    [self.orderView addSubview:self.ZuiLine];
}
#pragma mark - 数据 赋值
-(void)setData:(NSDictionary *)Data{
    _Data = Data;
    NSInteger pay_status = [Data[@"pay_status"] integerValue];//支付状态 0 未支付，1 已支付
    NSInteger trade_status = [Data[@"trade_status"] integerValue];//交易状态 0 进行中 1.已完成(未核销)，2.已结算（已核销），3.已分佣,4 已取消
    NSInteger eval_status = [Data[@"eval_status"] integerValue]; // 评价状态 0 未评价，1.已评价
    NSInteger refund_status = [Data[@"refund_status"] integerValue]; //  退款状态 0 未退款 1发起退款中 2.退款已确认，3退款已完成，4.退款已取消
     NSInteger order_type = [Data[@"order_type"] integerValue]; //  订单类型 1表示到店，2表示预约
    NSString *arrive_time = [NSString stringWithFormat:@"%@",Data[@"arrive_time"]]; //到店时间
    if ([[MethodCommon judgeStringIsNull:arrive_time] isEqualToString:@""]) {
        arrive_time = @"";
    }
    NSInteger appointment_timeout = [Data[@"appointment_timeout"] integerValue]; //  预约是否超时 0未超时，1已超时
    NSString *appointment_time = [NSString stringWithFormat:@"%@",Data[@"appointment_time"]];//预约时间 预约单有值，到店单值为null

   
#pragma mark - /*是否预约、或是超时*/
    if (arrive_time.length>0) {
        self.contactButton.hidden = YES;
        self.YuyueView.height = 0;
        self.YuyueView.hidden = YES;
        [self.YuyueView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
    }else{
        if (order_type ==2) {
            [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_booking"] forState:UIControlStateNormal];
            self.contactButton.hidden = NO;
            if ([[MethodCommon judgeStringIsNull:appointment_time] isEqualToString:@""]) {
                appointment_time = @"";
            }
            self.YYTimeLabel.text = appointment_time;
            self.YuyueView.height = 50;
            self.YuyueView.hidden = NO;
            [self.YuyueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(50);
            }];
            if (appointment_timeout == 0) {
                /*未超时*/
                self.YuyueView.backgroundColor = UIColorFromRGB(0xF8FCFF);
                self.YYicon.image = [UIImage imageNamed:@"icn_booking_big"];
                self.yylabel.backgroundColor =  UIColorFromRGB(0xE0F2FF);
                self.yylabel.textColor = UIColorFromRGB(0x3D8AFF);
                self.yylabel.text = @"预约";
                self.YYTimeLabel .textColor = UIColorFromRGB(0x3D8AFF);
                [self.yylabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_offset(36);
                }];
            }else{
                /*超时*/
                self.YuyueView.backgroundColor = UIColorFromRGB(0xFFF9FA);
                self.YYicon.image = [UIImage imageNamed:@"icn_booking_timeout_big"];
                self.yylabel.backgroundColor =  UIColorFromRGB(0xFCE9E8);
                self.yylabel.textColor = UIColorFromRGB(0xEE4E3E);
                self.yylabel.text = @"预约超时";
                self.YYTimeLabel .textColor = UIColorFromRGB(0xEE4E3E);
                [self.yylabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_offset(60);
                }];
            }
        }else{
            self.contactButton.hidden = YES;
            self.YuyueView.height = 0;
            self.YuyueView.hidden = YES;
            [self.YuyueView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(0);
            }];
        }
        
    }
   
#pragma mark -   /*是否核销 - 展示核销状态*/
    if (trade_status ==0) {
        self.HexiaoBtn.hidden = NO;
        self.HexiaoBtn.selected = NO;
    }else if (trade_status ==1) {
         self.HexiaoBtn.hidden = NO;
        self.HexiaoBtn.selected = NO;
    }else if (trade_status ==4){
        self.HexiaoBtn.hidden = YES;
    }else{
        self.HexiaoBtn.hidden = NO;
        self.HexiaoBtn.selected = YES;
    }
  #pragma mark -   /*订单的状态*/
    NSString *order_status_txt = [NSString stringWithFormat:@"%@",Data[@"order_status_txt"]];
    if ([[MethodCommon judgeStringIsNull:order_status_txt] isEqualToString:@""]) {
        order_status_txt = @"";
    }
    [self.iconBtn setTitle:[NSString stringWithFormat:@" %@",order_status_txt] forState:UIControlStateNormal];
#pragma mark -    /*订单下单时间*/
    NSString *add_time = [NSString stringWithFormat:@"%@",Data[@"add_time"]];
    if ([[MethodCommon judgeStringIsNull:add_time] isEqualToString:@""]) {
        add_time =@"";
    }
    self.TimeLabel.text = add_time;

#pragma mark -     /*是否支付 - 展示支付时间 0 未支付，1 已支付*/
    if (pay_status ==0) {
        self.PaymentTime.hidden = NO;
//        self.contactButton.hidden = NO;
        self.PrintBtn.hidden = YES;
        if (trade_status ==4) {
             self.PaymentTime.hidden = YES;
//             self.contactButton.hidden = YES;
            [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_cancel"] forState:UIControlStateNormal];
        }else{
            /*待支付订单的剩余支付时间 remaining_payment_time*/
            NSString *remaining_payment_time = [NSString stringWithFormat:@"%@",Data[@"remaining_payment_time"]];
            if ([[MethodCommon judgeStringIsNull:remaining_payment_time] isEqualToString:@""]) {
                remaining_payment_time = @"00:00:00";
                self.PaymentTime.hidden = YES;
                self.contactButton.hidden = YES;
            }else{
                            [self countDownWithTime:remaining_payment_time]; /*动态计算剩余时间方法*/
            }
            self.PaymentTime.text = [NSString stringWithFormat:@"剩余支付时间%@",remaining_payment_time];
        }

    }else if (pay_status ==1) {
        self.PaymentTime.hidden = YES;
//        self.contactButton.hidden = YES;
        self.PrintBtn.hidden = NO;
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_paid"] forState:UIControlStateNormal];
    }else{
        self.PaymentTime.hidden = YES;
//        self.contactButton.hidden = YES;
        self.PrintBtn.hidden = NO;
    }

#pragma mark -      /*是否退款 - 展示退款状态*/
    if (refund_status == 1) {
        self.DeleteButton.hidden = YES;
        self.ConfirmButton.hidden = NO;
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_refund"] forState:UIControlStateNormal];
        self.contactButton.hidden = YES;
        self.YuyueView.height = 0;
        self.YuyueView.hidden = YES;
        [self.YuyueView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
    }else{
         self.DeleteButton.hidden = NO;
        self.ConfirmButton.hidden = YES;
    }
#pragma mark -      /*商品列表 */
    NSArray *OrderGoodsArray = Data[@"goods_info"];
    NSInteger  GoodsMen = OrderGoodsArray.count;
    UIButton *detailsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *detailslabel = [[UILabel alloc]init];

    CGFloat Y = 87.5;
    CGFloat suxing_h = 0;
    /**循环创建商品l*/
    for (int i = 0; i<GoodsMen; i++) {
        if (_order_id ==1) {
            detailsButton.hidden = YES;
            detailslabel.hidden = YES;
        }else{
            if (i>=3){
                if (i==3) {
                    detailslabel.text = @"...";
                    detailslabel.textColor = UIColorFromRGB(0x222222);
                    detailslabel.font = [UIFont systemFontOfSize:24];
                    [self.orderView addSubview:detailslabel];
                    [detailslabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_offset(10);
                        make.top.equalTo(self.OrderLabel.mas_bottom).offset(OrderGodds_H*i+suxing_h);
                    }];

                    [detailsButton setTitle:@"查询其余*件" forState:UIControlStateNormal];
                    [detailsButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
                    [detailsButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
                    detailsButton.tag = [Data[@"order_id"] integerValue];
                    [detailsButton addTarget:self action:@selector(TheRestAction:) forControlEvents:UIControlEventTouchUpInside];
                    [self.orderView  addSubview:detailsButton];
                    [detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(detailslabel.mas_bottom).offset(5);
                        make.left.mas_offset(10);
                        make.height.mas_offset(25);
                    }];
                    Y = self.OrderLabel.bottom+OrderGodds_H*i+48+suxing_h;


                }
                continue;
            }

        }

        UILabel *goodsName = [[UILabel alloc]init];
        goodsName.text = [NSString stringWithFormat:@"%@",OrderGoodsArray[i][@"goods_name"]];
        goodsName.textColor = UIColorFromRGB(0x222222);
        goodsName.font = [UIFont systemFontOfSize:15];
        [self.orderView addSubview:goodsName];
        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.OrderLabel.mas_bottom).offset(OrderGodds_H*i+12+suxing_h);
            make.left.mas_offset(10);
            make.right.mas_offset(-100);
        }];
        
        
       
        UILabel *goods_price = [[UILabel alloc]init];
        goods_price.text = [NSString stringWithFormat:@"¥%@",OrderGoodsArray[i][@"goods_price"]];
        goods_price.textColor = UIColorFromRGB(0x222222);
        goods_price.font = [UIFont systemFontOfSize:14];
        [self.orderView addSubview:goods_price];
        [goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.OrderLabel.mas_bottom).offset(OrderGodds_H*i+12+suxing_h);
            make.left.equalTo(goodsName.mas_right).offset(0);
            make.width.mas_offset(90);
        }];

        UILabel *goods_num = [[UILabel alloc]init];
        goods_num.text = [NSString stringWithFormat:@"x%@",OrderGoodsArray[i][@"goods_num"]];
        goods_num.textColor = UIColorFromRGB(0x999999);
        goods_num.font = [UIFont systemFontOfSize:12];
        goods_num.textAlignment = 2;
        [self.orderView addSubview:goods_num];
        [goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.OrderLabel.mas_bottom).offset(OrderGodds_H*i+12+suxing_h);
            make.right.mas_offset(-10);
            make.width.mas_offset(40);
        }];
        
        NSString *goods_attributes= [NSString stringWithFormat:@"%@",OrderGoodsArray[i][@"goods_attributes"]];
        if ([[MethodCommon judgeStringIsNull:goods_attributes] isEqualToString:@""]) {
//            suxing_h = 0;
        }else{
            suxing_h = suxing_h+12;
            UILabel *goodsName1 = [[UILabel alloc]init];
            goodsName1.text = goods_attributes;
            goodsName1.textColor = UIColorFromRGB(0x999999);
            goodsName1.font = [UIFont systemFontOfSize:12];
            [self.orderView addSubview:goodsName1];
            [goodsName1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(goodsName.mas_bottom).offset(0);
                make.left.mas_offset(10);
                make.right.mas_offset(-100);
            }];
        }
        
        Y = self.OrderLabel.bottom+OrderGodds_H*i+24+suxing_h;
    }
#pragma mark - /*总计部分*/
    NSString *nums = [NSString stringWithFormat:@"%@",Data[@"total_goods_num"]];
    if ([[MethodCommon judgeStringIsNull:nums] isEqualToString:@""]) {
        nums = @"0";
    }
    self.numlabel.text = [NSString stringWithFormat:@"共%@件商品  商家实收",nums];
    NSInteger i = [nums integerValue] - 3;
    [detailsButton setTitle:[NSString stringWithFormat:@"查询其余%ld件",i] forState:UIControlStateNormal];
    
    
    self.numlabel.top = Y+43+self.YuyueView.height;
    [self.numlabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(Y+43+self.YuyueView.height);
    }];


  #pragma mark - /*评论部分*/


    self.PLLine.top = self.numlabel.bottom+100;

    //评价状态 0 未评价，1.已评价
    if (eval_status == 0) {
        self.PLLine.hidden = YES;
        self.label_Eval.hidden = YES;
        self.star.hidden = YES;
        self.starEvaluator.hidden = YES;
        self.ZuiLine.top = self.PLLine.bottom+100;

        if (refund_status >= 1 && refund_status <4) {
            self.PLLine.top = self.numlabel.bottom+69+100;
            self.ZuiLine.top = self.PLLine.bottom+140;
            self.TkiconButton.hidden = NO;
            self.label_TKtype.hidden = NO;
            self.label_TKmoney_Label.hidden = NO;
            self.label_TKmoney.hidden = NO;
            self.label_TKBeiZhu.hidden = NO;

        }else{
            self.TkiconButton.hidden = YES;
            self.label_TKtype.hidden = YES;
            self.label_TKmoney_Label.hidden = YES;
            self.label_TKmoney.hidden = YES;
            self.label_TKBeiZhu.hidden = YES;

        }

    }else{
        self.PLLine.hidden = NO;
        self.label_Eval.hidden = NO;
        self.star.hidden = NO;
        self.starEvaluator.hidden = NO;
        self.ZuiLine.top = self.PLLine.bottom+190;

        if (refund_status >= 1 && refund_status <4) {
            self.PLLine.top = self.numlabel.bottom+69+100;
            [self.PLLine mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.service_money_Label.mas_bottom).offset(20);
            }];
            self.ZuiLine.top = self.PLLine.bottom+210;
            self.TkiconButton.hidden = NO;
            self.label_TKtype.hidden = NO;
            self.label_TKmoney_Label.hidden = NO;
            self.label_TKmoney.hidden = NO;
            self.label_TKBeiZhu.hidden = NO;
        }else{
            self.TkiconButton.hidden = YES;
            self.label_TKtype.hidden = YES;
            self.label_TKmoney_Label.hidden = YES;
            self.label_TKmoney.hidden = YES;
            self.label_TKBeiZhu.hidden = YES;

        }
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateNormal];
    }

//    refund_status 0 未退款 1发起退款中 2.退款已确认，3退款已完成，4.退款已取消
    self.label_TKtype.text = (refund_status==1||refund_status==2) ? @"退款处理中":(refund_status==3)? @"退款完成":@"退款取消";

    //服务费用
    NSString *service_money =[NSString stringWithFormat:@"%@",Data[@"service_money"]];
    if ([[MethodCommon judgeStringIsNull:service_money] isEqualToString:@""]) {
        service_money =@"0";
    }
    self.service_money.text = [NSString stringWithFormat:@"¥%@",service_money];

    //优惠金额
//    self.save_money.text = [NSString stringWithFormat:@"¥%@",Data[@"save_money"]];
    //account_money。门店金额
    NSString *account_money =[NSString stringWithFormat:@"%@",Data[@"account_money"]];
    if ([[MethodCommon judgeStringIsNull:account_money] isEqualToString:@""]) {
        account_money =@"0";
    }
    self.account_money.text = [NSString stringWithFormat:@"¥%@",account_money];
//order_money。商家实收
    //actual_money      实际支付金额
    NSString *actual_money =[NSString stringWithFormat:@"%@",Data[@"actual_money"]];
    if ([[MethodCommon judgeStringIsNull:actual_money] isEqualToString:@""]) {
        actual_money =@"0";
    }
    self.save_money.text = [NSString stringWithFormat:@"¥%@",actual_money];

    //evaluate_score 评分
    NSString *score = [NSString stringWithFormat:@"%@",Data[@"evaluate_score"]];
    self.starEvaluator.currentValue = [score integerValue];
    self.star.text = [NSString stringWithFormat:@"%@ 分",score];

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
    //订单内商品总价
    NSString *protocol = [NSString stringWithFormat:@"¥ %@",Data[@"order_money"]];
    NSMutableAttributedString *attri_str=[[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:24]];
    NSRange ProRange = [protocol rangeOfString:@"¥"];
    [attri_str setFont:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 1)];
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"F7AE2B"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    self.goods_price.attributedText = attri_str;

    /*消费者手机号*/
    self.user_mobile = [NSString stringWithFormat:@"%@",Data[@"user_mobile"]];
    
}
#pragma mark - 事件  操作
/** 删除 */
-(void)DeleteAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(delete_order:)]) {
        [self.delagate delete_order:self.Data];
    }
}
/** 打印 */
-(void)DayinAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(printe:)]) {
        [self.delagate printe:self.Data];
    }
    
}
/*联系*/
-(void)contactAction{
    NSString *telephoneNumber = self.user_mobile;
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:str];
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
            NSLog(@"OpenSuccess=%d",success);
            
        }];
    } else {
        // Fallback on earlier versions
    }
}
/*退单*/
-(void)refundAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(Refund:)]) {
        [self.delagate Refund:self.Data];
    }
}
-(void)TheRestAction:(UIButton *)sender{

//    if (self.TheRestBlock) {
//        self.TheRestBlock();
//    }
    if (self.delagate && [self.delagate respondsToSelector:@selector(detail:)]) {
        [self.delagate detail:self.Data];
    }
}
//-(void)setOrder_id:(NSInteger)order_id{
//    _order_id = order_id;
//    NSInteger pay_status = [_Data[@"pay_status"] integerValue];//支付状态 0 未支付，1 已支付
//    NSInteger trade_status = [_Data[@"trade_status"] integerValue];//交易状态 0 进行中 1.已完成(未核销)，2.已结算（已核销），3.已分佣,4 已取消
//    NSInteger eval_status = [_Data[@"eval_status"] integerValue]; // 评价状态 0 未评价，1.已评价
//    NSInteger refund_status = [_Data[@"refund_status"] integerValue]; //  退款状态 0 未退款 1发起退款中 2.退款已确认，3退款已完成，4.退款已取消
//#pragma mark -   /*是否核销 - 展示核销状态*/
//    if (trade_status ==0) {
//        self.HexiaoBtn.selected = NO;
//    }else if (trade_status ==1) {
//        self.HexiaoBtn.selected = NO;
//    }else{
//        self.HexiaoBtn.selected = YES;
//    }
//#pragma mark -   /*订单的状态*/
//    NSString *order_status_txt = [NSString stringWithFormat:@"%@",_Data[@"order_status_txt"]];
//    if ([[MethodCommon judgeStringIsNull:order_status_txt] isEqualToString:@""]) {
//        order_status_txt = @"";
//    }
//    [self.iconBtn setTitle:[NSString stringWithFormat:@" %@",order_status_txt] forState:UIControlStateNormal];
//#pragma mark -    /*订单下单时间*/
//    NSString *add_time = [NSString stringWithFormat:@"%@",_Data[@"add_time"]];
//    if ([[MethodCommon judgeStringIsNull:add_time] isEqualToString:@""]) {
//        add_time =@"";
//    }
//    self.TimeLabel.text = add_time;
//
//#pragma mark -     /*是否支付 - 展示支付时间 0 未支付，1 已支付*/
//    if (pay_status ==0) {
//        self.PaymentTime.hidden = NO;
//        self.contactButton.hidden = NO;
//        self.PrintBtn.hidden = YES;
//        if (trade_status ==4) {
//            self.PaymentTime.hidden = YES;
//            self.contactButton.hidden = YES;
//        }else{
//            /*待支付订单的剩余支付时间 remaining_payment_time*/
//            NSString *remaining_payment_time = [NSString stringWithFormat:@"%@",_Data[@"remaining_payment_time"]];
//            if ([[MethodCommon judgeStringIsNull:remaining_payment_time] isEqualToString:@""]) {
//                remaining_payment_time = @"00:00:00";
//                self.PaymentTime.hidden = YES;
//                self.contactButton.hidden = YES;
//            }else{
//                [self countDownWithTime:remaining_payment_time]; /*动态计算剩余时间方法*/
//            }
//            self.PaymentTime.text = [NSString stringWithFormat:@"剩余支付时间%@",remaining_payment_time];
//        }
//
//    }else if (pay_status ==1) {
//        self.PaymentTime.hidden = YES;
//        self.contactButton.hidden = YES;
//        self.PrintBtn.hidden = NO;
//    }else{
//        self.PaymentTime.hidden = YES;
//        self.contactButton.hidden = YES;
//        self.PrintBtn.hidden = NO;
//    }
//
//#pragma mark -      /*是否退款 - 展示退款状态*/
//    if (refund_status == 1) {
//        self.DeleteButton.hidden = YES;
//        self.ConfirmButton.hidden = NO;
//    }else{
//        self.DeleteButton.hidden = NO;
//        self.ConfirmButton.hidden = YES;
//    }
//#pragma mark -      /*商品列表 */
//    NSArray *OrderGoodsArray = _Data[@"goods_info"];
//    NSInteger  GoodsMen = OrderGoodsArray.count;
//
//    CGFloat Y = 87.5;
//    /**循环创建商品l*/
//    for (int i = 0; i<GoodsMen; i++) {
//        if (_order_id ==1) {
//            self.detailsButton.hidden = YES;
//            self.detailslabel.hidden = YES;
//        }else{
//
//            if (i>=3){
//                if (i==3) {
//                    self.detailsButton.hidden = NO;
//                    self.detailslabel.hidden = NO;
//
//                    [self.detailslabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.top.equalTo(self.OrderLabel.mas_bottom).offset(OrderGodds_H*i);
//                    }];
//                    Y = self.OrderLabel.bottom+OrderGodds_H*i+48;
//
//
//                }
//                continue;
//            }
//
//        }
//
//        UILabel *goodsName = [[UILabel alloc]init];
//        goodsName.text = [NSString stringWithFormat:@"%@",OrderGoodsArray[i][@"goods_name"]];
//        goodsName.textColor = UIColorFromRGB(0x222222);
//        goodsName.font = [UIFont systemFontOfSize:15];
//        [self.orderView addSubview:goodsName];
//        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.OrderLabel.mas_bottom).offset(OrderGodds_H*i+12);
//            make.left.mas_offset(10);
//            make.right.mas_offset(-100);
//        }];
//        UILabel *goods_price = [[UILabel alloc]init];
//        goods_price.text = [NSString stringWithFormat:@"¥%@",OrderGoodsArray[i][@"goods_price"]];
//        goods_price.textColor = UIColorFromRGB(0x222222);
//        goods_price.font = [UIFont systemFontOfSize:14];
//        [self.orderView addSubview:goods_price];
//        [goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.OrderLabel.mas_bottom).offset(OrderGodds_H*i+12);
//            make.left.equalTo(goodsName.mas_right).offset(0);
//            make.width.mas_offset(90);
//        }];
//
//        UILabel *goods_num = [[UILabel alloc]init];
//        goods_num.text = [NSString stringWithFormat:@"x%@",OrderGoodsArray[i][@"goods_num"]];
//        goods_num.textColor = UIColorFromRGB(0x999999);
//        goods_num.font = [UIFont systemFontOfSize:12];
//        goods_num.textAlignment = 2;
//        [self.orderView addSubview:goods_num];
//        [goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.OrderLabel.mas_bottom).offset(OrderGodds_H*i+12);
//            make.right.mas_offset(-10);
//            make.width.mas_offset(40);
//        }];
//        Y = self.OrderLabel.bottom+OrderGodds_H*i+24;
//    }
//#pragma mark - /*总计部分*/
//    NSString *nums = [NSString stringWithFormat:@"%@",_Data[@"total_goods_num"]];
//    if ([[MethodCommon judgeStringIsNull:nums] isEqualToString:@""]) {
//        nums = @"0";
//    }
//    self.numlabel.text = [NSString stringWithFormat:@"总计     共%@件商品",nums];
//    NSInteger i = [nums integerValue] - 3;
//    [self.detailsButton setTitle:[NSString stringWithFormat:@"查询其余%ld件",i] forState:UIControlStateNormal];
//
//    self.numlabel.top = Y+43;
//    [self.numlabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(Y+43);
//    }];
//
//
//#pragma mark - /*评论部分*/
//
//
//    self.PLLine.top = self.numlabel.bottom+90;
//
//    //评价状态 0 未评价，1.已评价
//    if (eval_status == 0) {
//        self.PLLine.hidden = YES;
//        self.label_Eval.hidden = YES;
//        self.star.hidden = YES;
//        self.starEvaluator.hidden = YES;
//        self.ZuiLine.top = self.PLLine.bottom+80;
//
//        if (refund_status >= 1 && refund_status <4) {
//            self.PLLine.top = self.numlabel.bottom+69+90;
//            self.ZuiLine.top = self.PLLine.bottom+120;
//            self.TkiconButton.hidden = NO;
//            self.label_TKtype.hidden = NO;
//            self.label_TKmoney_Label.hidden = NO;
//            self.label_TKmoney.hidden = NO;
//            self.label_TKBeiZhu.hidden = NO;
//
//        }else{
//            self.TkiconButton.hidden = YES;
//            self.label_TKtype.hidden = YES;
//            self.label_TKmoney_Label.hidden = YES;
//            self.label_TKmoney.hidden = YES;
//            self.label_TKBeiZhu.hidden = YES;
//
//        }
//
//    }else{
//        self.PLLine.hidden = NO;
//        self.label_Eval.hidden = NO;
//        self.star.hidden = NO;
//        self.starEvaluator.hidden = NO;
//        self.ZuiLine.top = self.PLLine.bottom+170;
//
//        if (refund_status >= 1 && refund_status <4) {
//            self.PLLine.top = self.numlabel.bottom+69+120;
//            [self.PLLine mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.save_money_Label.mas_bottom).offset(130);
//            }];
//            self.ZuiLine.top = self.PLLine.bottom+190;
//            self.TkiconButton.hidden = NO;
//            self.label_TKtype.hidden = NO;
//            self.label_TKmoney_Label.hidden = NO;
//            self.label_TKmoney.hidden = NO;
//            self.label_TKBeiZhu.hidden = NO;
//        }else{
//            self.TkiconButton.hidden = YES;
//            self.label_TKtype.hidden = YES;
//            self.label_TKmoney_Label.hidden = YES;
//            self.label_TKmoney.hidden = YES;
//            self.label_TKBeiZhu.hidden = YES;
//
//        }
//
//    }
//
//    //    refund_status 0 未退款 1发起退款中 2.退款已确认，3退款已完成，4.退款已取消
//    self.label_TKtype.text = (refund_status==1) ? @"退款处理中":(refund_status==3)? @"退款完成":@"退款取消";
//
//    //服务费用
//    NSString *service_money =[NSString stringWithFormat:@"%@",_Data[@"service_money"]];
//    if ([[MethodCommon judgeStringIsNull:service_money] isEqualToString:@""]) {
//        service_money =@"0";
//    }
//    self.service_money.text = [NSString stringWithFormat:@"¥%@",service_money];
//
//    //优惠金额
//    self.save_money.text = [NSString stringWithFormat:@"-¥%@",_Data[@"save_money"]];
//
//
//    //evaluate_score 评分
//    NSString *score = [NSString stringWithFormat:@"%@",_Data[@"evaluate_score"]];
//    self.starEvaluator.currentValue = [score integerValue];
//    self.star.text = [NSString stringWithFormat:@"%@ 分",score];
//
//    /*退款金额*/
//    NSString *refund_amount =[NSString stringWithFormat:@"%@",_Data[@"refund_amount"]];
//    if ([[MethodCommon judgeStringIsNull:refund_amount] isEqualToString:@""]) {
//        self.label_TKmoney.text = @"-¥00";
//    }else{
//        self.label_TKmoney.text = [NSString stringWithFormat:@"-¥%@",refund_amount];
//    }
//    /*退款备注*/
//    NSString *refund_remark =[NSString stringWithFormat:@"%@",_Data[@"refund_remark"]];
//    if ([[MethodCommon judgeStringIsNull:refund_remark] isEqualToString:@""]) {
//        self.label_TKBeiZhu.text = @"备注：";
//    }else{
//        self.label_TKBeiZhu.text = [NSString stringWithFormat:@"备注：%@",refund_remark];
//    }
//    //订单内商品总价
//    NSString *protocol = [NSString stringWithFormat:@"¥ %@",_Data[@"total_goods_price"]];
//    NSMutableAttributedString *attri_str=[[NSMutableAttributedString alloc] initWithString:protocol];
//    //设置字体颜色
//    [attri_str setFont:[UIFont systemFontOfSize:24]];
//    NSRange ProRange = [protocol rangeOfString:@"¥"];
//    [attri_str setFont:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 1)];
//    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"222222"] backgroundColor:[UIColor whiteColor] userInfo:nil];
//    self.goods_price.attributedText = attri_str;
//
//    /*消费者手机号*/
//    self.user_mobile = [NSString stringWithFormat:@"%@",_Data[@"user_mobile"]];
//}
/**
 倒计时
 
 */
- (void)countDownWithTime:(NSString *)TimeString{
    
    NSString *store_pic = [NSString stringWithFormat:@"%@",TimeString];
    // 用指定字符串分割字符串，返回一个数组
    NSArray *array = [store_pic componentsSeparatedByString:@":"];
    /*时*/
    NSString * when= [NSString stringWithFormat:@"%@",array[0]];
    /*分*/
    NSString *points = [NSString stringWithFormat:@"%@",array[1]];
    /*秒*/
    NSString *seconds = [NSString stringWithFormat:@"%@",array[2]];
    
    
    
    
    __block NSInteger timeout1 = [when integerValue]; // 倒计时时间
    __block NSInteger timeout2 = [points integerValue]; // 倒计时时间
    __block NSInteger timeout3 = [seconds integerValue]; // 倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
#pragma mark - 计算时
#pragma mark - 计算分
        
#pragma mark - 计算秒
        if(timeout3<=0){ //倒计时结束，关闭
            timeout2--;
            
            if(timeout2<=0){
                timeout1--;
                
                if (timeout1<=0){
                    dispatch_source_cancel(_timer);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.PaymentTime.text = [NSString stringWithFormat:@"剩余支付时间 00:00:00"];
                    });
                }else{
                    timeout3 = 60;
                    int seconds3 = timeout3 % 60;
                    NSString *strTime3 = [NSString stringWithFormat:@"%.2d", seconds3];
                    if (seconds3 < 10) {
                        strTime3 = [NSString stringWithFormat:@"%.2d", seconds3];
                    }
                    int seconds1 = timeout1 % 60;
                    NSString *strTime1 = [NSString stringWithFormat:@"%.2d", seconds1];
                    int seconds2 = timeout2 % 60;
                    NSString *strTime2 = [NSString stringWithFormat:@"%.2d", seconds2];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        self.PaymentTime.text = [NSString stringWithFormat:@"剩余支付时间%@:%@:%@",strTime1,strTime2,strTime3];
                    });
                    timeout3--;
                }
                
                
            }else{
                timeout3 = 60;
                int seconds3 = timeout3 % 60;
                NSString *strTime3 = [NSString stringWithFormat:@"%.2d", seconds3];
                if (seconds3 < 10) {
                    strTime3 = [NSString stringWithFormat:@"%.2d", seconds3];
                }
                int seconds1 = timeout1 % 60;
                NSString *strTime1 = [NSString stringWithFormat:@"%.2d", seconds1];
                int seconds2 = timeout2 % 60;
                NSString *strTime2 = [NSString stringWithFormat:@"%.2d", seconds2];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    self.PaymentTime.text = [NSString stringWithFormat:@"剩余支付时间%@:%@:%@",strTime1,strTime2,strTime3];
                });
                timeout3--;
            }
            
            
            
        }else{
            
            int seconds3 = timeout3 % 60;
            NSString *strTime3 = [NSString stringWithFormat:@"%.2d", seconds3];
            if (seconds3 < 10) {
                strTime3 = [NSString stringWithFormat:@"%.2d", seconds3];
            }
            int seconds1 = timeout1 % 60;
            NSString *strTime1 = [NSString stringWithFormat:@"%.2d", seconds1];
            int seconds2 = timeout2 % 60;
            NSString *strTime2 = [NSString stringWithFormat:@"%.2d", seconds2];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.PaymentTime.text = [NSString stringWithFormat:@"剩余支付时间%@:%@:%@",strTime1,strTime2,strTime3];
            });
            timeout3--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}
#pragma mark - 获取高度
- (CGFloat)getCellHeight {
    return  self.ZuiLine.bottom;
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
-(UIView *)YuyueView{
    if (!_YuyueView) {
        _YuyueView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, 120, 50)];
        _YuyueView.backgroundColor = UIColorFromRGB(0xF8FCFF);
    }
    return _YuyueView;
}
-(UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconBtn.frame = CGRectMake(0, self.YuyueView.bottom, 120, 50);
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
-(UILabel *)numlabel{
    if (!_numlabel) {
        _numlabel = [[UILabel alloc]init];
        _numlabel.text = @"总计     共 件商品";
        _numlabel.textColor = UIColorFromRGB(0x999999);
        _numlabel.font = [UIFont systemFontOfSize:14];
    }
    return _numlabel;
}
-(UILabel *)goods_price{
    if (!_goods_price) {
        _goods_price = [[UILabel alloc]init];
        _goods_price.textColor = UIColorFromRGB(0xF7AE2B);
        _goods_price.font = [UIFont systemFontOfSize:24];
    }
    return _goods_price;
}
-(UILabel *)service_money{
    if (!_service_money) {
        _service_money = [[UILabel alloc]init];
        _service_money.textColor = UIColorFromRGB(0x222222);
        _service_money.font = [UIFont systemFontOfSize:14];
    }
    return _service_money;
}
-(UILabel *)save_money{
    if (!_save_money) {
        _save_money = [[UILabel alloc]init];
        _save_money.textColor = UIColorFromRGB(0x222222);
        _save_money.font = [UIFont systemFontOfSize:14];
    }
    return _save_money;
}
-(UILabel *)account_money{
    if (!_account_money) {
        _account_money = [[UILabel alloc]init];
        _account_money.textColor = UIColorFromRGB(0x222222);
        _account_money.font = [UIFont systemFontOfSize:14];
    }
    return _account_money;
}
-(UILabel *)PaymentTime{
    if (!_PaymentTime) {
        _PaymentTime  = [[UILabel alloc] init];
        _PaymentTime.numberOfLines = 0;
        _PaymentTime.text = @"剩余支付时间";
        _PaymentTime.font = [UIFont systemFontOfSize:14];
        _PaymentTime.textColor = UIColorFromRGB(0x3D8AFF);
        _PaymentTime.hidden = YES;
    }
    return _PaymentTime;
}
-(UIButton *)PrintBtn{
    if (!_PrintBtn) {
        _PrintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _PrintBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
        [_PrintBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
        [_PrintBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
        [_PrintBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        _PrintBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _PrintBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
        _PrintBtn.hidden = YES;
        [_PrintBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PrintBtn;
}
-(UIButton *)DeleteButton{
    if (!_DeleteButton) {
        _DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
        _DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _DeleteButton.layer.cornerRadius = 16;
        _DeleteButton.layer.borderWidth = 1;
        _DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
        _DeleteButton.hidden = YES;
        [_DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _DeleteButton;
}
-(UIButton *)ConfirmButton{
    if (!_ConfirmButton) {
        _ConfirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ConfirmButton setTitle:@"确认退款" forState:UIControlStateNormal];
        [_ConfirmButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_ConfirmButton setBackgroundColor:UIColorFromRGB(0xFF6969)];
        _ConfirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _ConfirmButton.layer.cornerRadius = 16;
        _ConfirmButton.layer.borderWidth = 1;
        _ConfirmButton.layer.borderColor = [UIColorFromRGB(0xFF6969) CGColor];
        [_ConfirmButton addTarget:self action:@selector(refundAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ConfirmButton;
}
-(UIButton *)contactButton{
    if (!_contactButton) {
        _contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contactButton.frame = CGRectMake(0, 0, 80, 32);
        [_contactButton setTitle:@"联系买家" forState:UIControlStateNormal];
        [_contactButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_contactButton setBackgroundColor:UIColorFromRGB(0xF7AE2B)];
        _contactButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _contactButton.layer.cornerRadius = 16;
        _contactButton.layer.borderWidth = 1;
        _contactButton.layer.borderColor = [UIColorFromRGB(0xF7AE2B) CGColor];
        [_contactButton addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactButton;
}
-(UIButton *)TkiconButton{
    if (!_TkiconButton) {
        _TkiconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TkiconButton setImage:[UIImage imageNamed:@"icn_order_clock"] forState:UIControlStateNormal];
        [_TkiconButton setTitle:@"   退款详情" forState:UIControlStateNormal];
        [_TkiconButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _TkiconButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _TkiconButton;
}
-(UILabel *)label_TKtype{
    if (!_label_TKtype) {
        _label_TKtype = [[UILabel alloc]init];
        _label_TKtype.textColor = UIColorFromRGB(0xF7AE2B);
        _label_TKtype.font = [UIFont systemFontOfSize:14];
        _label_TKtype.text = @"退款处理中";
    }
    return _label_TKtype;
}
-(UILabel *)label_TKmoney_Label{
    if (!_label_TKmoney_Label) {
        _label_TKmoney_Label = [[UILabel alloc]init];
        _label_TKmoney_Label.text = @"退款金额";
        _label_TKmoney_Label.textColor = UIColorFromRGB(0xFF6969);
        _label_TKmoney_Label.font = [UIFont systemFontOfSize:14];
    }
    return _label_TKmoney_Label;
}
-(UILabel *)label_TKmoney{
    if (!_label_TKmoney) {
        _label_TKmoney = [[UILabel alloc]initWithFrame:CGRectMake(10, 323, 150, 13)];
        _label_TKmoney.numberOfLines = 2;
        _label_TKmoney.textColor = UIColorFromRGB(0xFF6969);
        _label_TKmoney.font = [UIFont systemFontOfSize:14];
        _label_TKmoney.text = @"-¥";
    }
    return _label_TKmoney;
}
-(UILabel *)label_TKBeiZhu{
    if (!_label_TKBeiZhu) {
        _label_TKBeiZhu = [[UILabel alloc]initWithFrame:CGRectMake(10, 323, 150, 13)];
        _label_TKBeiZhu.numberOfLines = 2;
        _label_TKBeiZhu.textColor = UIColorFromRGB(0x999999);
        _label_TKBeiZhu.font = [UIFont systemFontOfSize:14];
        _label_TKBeiZhu.text = @"备注：";
    }
    return _label_TKBeiZhu;
}
-(UILabel *)label_Eval{
    if (!_label_Eval) {
        _label_Eval = [[UILabel alloc]init];
        _label_Eval.text = @"本次订单已评价";
        _label_Eval.textColor = UIColorFromRGB(0x222222);
        _label_Eval.font = [UIFont systemFontOfSize:15];
    }
    return _label_Eval;
}
-(UILabel *)star{
    if (!_star) {
        _star = [[UILabel alloc]init];
        _star.text = @"分";
        _star.textColor = UIColorFromRGB(0xF7AE2B);
        _star.font = [UIFont systemFontOfSize:15];
    }
    return _star;
}
//-(StarEvaluator *)starEvaluator{
//    if (!_starEvaluator) {
//        _starEvaluator = [[StarEvaluator alloc] initWithFrame:CGRectMake(25, 395, 120, 30)];
//        _starEvaluator.delegate = self;
//        _starEvaluator.userInteractionEnabled = NO;
//        _starEvaluator.currentValue = 4;
//    }
//    return _starEvaluator;
//}
@end
