//
//  OrderTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/23.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.BaseView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW - 30, 494)];
        self.BaseView.backgroundColor = [UIColor whiteColor];
        self.BaseView.layer.cornerRadius =  5;
        self.BaseView.layer.shadowOpacity = 0.2;
        self.BaseView.layer.shadowOffset = CGSizeMake(0, 0.5);
        self.BaseView.clipsToBounds = YES;

        [self addSubview:self.BaseView];
//        [self.BaseView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.mas_offset(15);
//            make.right.mas_offset(-15);
//            make.height.mas_offset(495);
//        }];
        NSInteger coun = (ScreenW - 30)/13;
        for (int i = 0; i<coun; i++) {
            UIView *view_1 = [[UIView alloc] init];
            view_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
            view_1.layer.cornerRadius = 5;
            [self.BaseView addSubview:view_1];
            [view_1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(5);
                make.left.mas_offset(i*13+5);
                make.size.mas_offset(CGSizeMake(11, 11));
            }];
            
        }
        
        self.statusImage = [[UIImageView alloc]init];
        self.statusImage.image = [UIImage imageNamed:@"btn_check_box_pressed"];
        [self.BaseView addSubview:self.statusImage];
        [self.statusImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(17);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(16, 16));
        }];
        
        
        self.statusLabel = [[UILabel alloc]init];
        self.statusLabel.text = @"订单已支付";
        self.statusLabel.textColor = UIColorFromRGB(0x3D8AFF);
        self.statusLabel.font = [UIFont systemFontOfSize:15];
        [self.BaseView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.statusImage.mas_centerY).offset(0);
            make.left.equalTo(self.statusImage.mas_right).offset(11);
        }];
        
        
        self.add_time = [[UILabel alloc]init];
        self.add_time.text = @"2018-12-12 14:30";
        self.add_time.textAlignment = 2;
        self.add_time.textColor = UIColorFromRGB(0x999999);
        self.add_time.font = [UIFont systemFontOfSize:12];
        [self.BaseView addSubview:self.add_time];
        [self.add_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.statusImage.mas_centerY).offset(0);
            make.right.mas_offset(-10);
        }];
        
        self.LineHengxian = [[UIView alloc]init];
        self.LineHengxian.backgroundColor = UIColorFromRGB(0xEAEAEA);
        [self.BaseView addSubview:self.LineHengxian];
        [self.LineHengxian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.top.mas_offset(50);
            make.height.mas_offset(1);
        }];
        
        self.goodText = [[UILabel alloc]init];
        self.goodText.text = @"商品列表";
        self.goodText.textColor = UIColorFromRGB(0x999999);
        self.goodText.font = [UIFont systemFontOfSize:14];
        [self.BaseView addSubview:self.goodText];
        [self.goodText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.equalTo(self.LineHengxian.mas_bottom).offset(12);
        }];
        
        
        self.DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
        self.DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        self.DeleteButton.layer.cornerRadius = 16;
        self.DeleteButton.layer.borderWidth = 1;
        self.DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
        [self.DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];

        [self.BaseView addSubview:self.DeleteButton];
        [self.DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-25);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(80, 32));
        }];
        
        self.DetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.DetailButton setTitle:@"查看明细" forState:UIControlStateNormal];
        [self.DetailButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [self.DetailButton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
        self.DetailButton.titleLabel.font = [UIFont systemFontOfSize:14];
        self.DetailButton.layer.cornerRadius = 16;
        self.DetailButton.layer.borderWidth = 1;
        self.DetailButton.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
        [self.DetailButton addTarget:self action:@selector(DetailAction) forControlEvents:UIControlEventTouchUpInside];
        [self.BaseView addSubview:self.DetailButton];
        [self.DetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-25);
            make.right.equalTo(self.DeleteButton.mas_left).offset(-10);
            make.size.mas_offset(CGSizeMake(80, 32));
        }];
        
        UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
        [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
        [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
        [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
        [self.BaseView addSubview:dayinBtn];
        [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-25);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(100, 32));
        }];
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = UIColorFromRGB(0xEAEAEA);
        [self.BaseView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-150);
            make.height.mas_offset(1);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"本次订单已评价";
        label.textColor = UIColorFromRGB(0x222222);
        label.font = [UIFont systemFontOfSize:15];
        [self.BaseView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.equalTo(line.mas_bottom).offset(20);
        }];
        
        //星星
        StarEvaluator *starEvaluator = [[StarEvaluator alloc] initWithFrame:CGRectMake(25, 395, 120, 30)];
        starEvaluator.delegate= self;
        [self.BaseView addSubview:starEvaluator];
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
        self.star.textColor = UIColorFromRGB(0x3D8AFF);
        self.star.font = [UIFont systemFontOfSize:15];
        [self.BaseView addSubview:self.star];
        [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.equalTo(label.mas_bottom).offset(15);
        }];
        
        
        self.FBtext = [[UILabel alloc]init];
        self.FBtext.text = @"翻呗优惠";
        self.FBtext.textColor = UIColorFromRGB(0x3D8AFF);
        self.FBtext.font = [UIFont systemFontOfSize:14];
        [self.BaseView addSubview:self.FBtext];
        [self.FBtext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.bottom.mas_offset(-170);
        }];
        
        self.FBlbale = [[UILabel alloc]init];
        self.FBlbale.text = @"-¥40";
        self.FBlbale.textColor = UIColorFromRGB(0x3D8AFF);
        self.FBlbale.font = [UIFont systemFontOfSize:14];
        [self.BaseView addSubview:self.FBlbale];
        [self.FBlbale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-170);
        }];
        self.FWtext = [[UILabel alloc]init];
        self.FWtext.text = @"服务费用";
        self.FWtext.textColor = UIColorFromRGB(0x999999);
        self.FWtext.font = [UIFont systemFontOfSize:14];
        [self.BaseView addSubview:self.FWtext];
        [self.FWtext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.bottom.equalTo(self.FBtext.mas_top).offset(-12);
        }];
        
        self.FWlbale = [[UILabel alloc]init];
        self.FWlbale.text = @"¥2";
        self.FWlbale.textColor = UIColorFromRGB(0x222222);
        self.FWlbale.font = [UIFont systemFontOfSize:14];
        [self.BaseView addSubview:self.FWlbale];
        [self.FWlbale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.bottom.equalTo(self.FBlbale.mas_top).offset(-12);
        }];
        
        
        
        self.Zongnum = [[UILabel alloc]init];
        self.Zongnum.text = @"总计     共3件商品";
        self.Zongnum.textColor = UIColorFromRGB(0x999999);
        self.Zongnum.font = [UIFont systemFontOfSize:14];
        [self.BaseView addSubview:self.Zongnum];
        [self.Zongnum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.bottom.equalTo(self.FWtext.mas_top).offset(-12);
        }];
        
        
        self.Zongprice = [[UILabel alloc]init];
        self.Zongprice.text = @"¥141";
        self.Zongprice.textColor = UIColorFromRGB(0x222222);
        self.Zongprice.font = [UIFont systemFontOfSize:24];
        [self.BaseView addSubview:self.Zongprice];
        [self.Zongprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.bottom.equalTo(self.FWlbale.mas_top).offset(-12);
        }];
        
        self.detailsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.detailsButton setTitle:@"查询其余*件" forState:UIControlStateNormal];
        [self.detailsButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.detailsButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [self.detailsButton addTarget:self action:@selector(DetailAction) forControlEvents:UIControlEventTouchUpInside];
        [self.BaseView  addSubview:self.detailsButton];
        [self.detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.Zongnum.mas_top).offset(-20);
            make.left.mas_offset(10);
            make.height.mas_offset(25);
        }];
        self.detailslabel = [[UILabel alloc]init];
        self.detailslabel.text = @"...";
        self.detailslabel.textColor = UIColorFromRGB(0x222222);
        self.detailslabel.font = [UIFont systemFontOfSize:24];
        [self.BaseView addSubview:self.detailslabel];
        [self.detailslabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.bottom.equalTo(self.detailsButton.mas_top).offset(-12);
        }];
        
    }
    return self;
}
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    
    
}


#pragma mark -  赋值
- (void)setData:(NSDictionary *)Data{
    _Data = Data;
    /**
     * 订单内的商品
     */
    NSArray *goods = Data[@"goods_info"];
    NSInteger  goodMen = goods.count;

    if (goodMen>3) {

            goodMen = 3;
            self.BaseView.height = 450+goodMen*30;

    }else{
        self.detailsButton.hidden = YES;
        self.detailslabel.hidden = YES;
        self.BaseView.height = 400+goodMen*30;
    }

    for (int i = 0; i<goodMen; i++) {
        UILabel *goodsName = [[UILabel alloc]init];
        goodsName.text = [NSString stringWithFormat:@"%@",goods[i][@"goods_name"]];
        goodsName.textColor = UIColorFromRGB(0x222222);
        goodsName.font = [UIFont systemFontOfSize:15];

        [self.BaseView addSubview:goodsName];
        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodText.mas_bottom).offset(12+35*i);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(self.BaseView.width/2, 20));
        }];
        
        UILabel *goods_price = [[UILabel alloc]init];
        goods_price.text = [NSString stringWithFormat:@"¥%@",goods[i][@"goods_price"]];
        goods_price.textColor = UIColorFromRGB(0x222222);
        goods_price.font = [UIFont systemFontOfSize:14];

        [self.BaseView addSubview:goods_price];
        [goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodText.mas_bottom).offset(12+35*i);
            make.left.equalTo(goodsName.mas_right).offset(0);
            make.size.mas_offset(CGSizeMake(self.BaseView.width/4, 20));
        }];
        
        UILabel *goods_num = [[UILabel alloc]init];
        goods_num.text = [NSString stringWithFormat:@"x%@",goods[i][@"goods_num"]];
        goods_num.textColor = UIColorFromRGB(0x999999);
        goods_num.font = [UIFont systemFontOfSize:12];

        goods_num.textAlignment = 2;
        [self.BaseView addSubview:goods_num];
        [goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodText.mas_bottom).offset(12+35*i);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(self.BaseView.width/4, 20));
        }];
        
    }
    
    //1待付款 2已付款 3已评价 4已取消
    NSInteger status = [Data[@"order_status"] integerValue];
    if ( status == 1) {
        self.statusImage.image = [UIImage imageNamed:@"icn_order_to_be_paid"];
        self.statusLabel.text = @"订单待支付";
    }else if (status == 2){
        self.statusImage.image = [UIImage imageNamed:@"icn_order_paid"];
        self.statusLabel.text = @"订单已支付";
    }else if (status == 4){
        self.statusImage.image = [UIImage imageNamed:@"icn_order_complete"];
        self.statusLabel.text = @"订单已评价";
    }else if(status == 3){
        self.statusImage.image = [UIImage imageNamed:@"icn_order_paid"];
        self.statusLabel.text = @"订单待评价";
    }else{
        self.statusImage.image = [UIImage imageNamed:@"icn_order_paid"];
        self.statusLabel.text = @"订单已取消";
    }
    //下单时间
    self.add_time.text = [NSString stringWithFormat:@"%@",Data[@"add_time"]];
    //订单内商品总数
    NSString *nums = [NSString stringWithFormat:@"%@",Data[@"total_goods_num"]];
    self.Zongnum.text = [NSString stringWithFormat:@"总计     共%@件商品",nums];
    NSInteger i = [nums integerValue] -3;
    
    [self.detailsButton setTitle:[NSString stringWithFormat:@"查询其余%ld件",i] forState:UIControlStateNormal];
    //订单内商品总价
    self.Zongprice.text = [NSString stringWithFormat:@"%@",Data[@"total_goods_price"]];
    //服务费用
    NSString *service_money =[NSString stringWithFormat:@"%@",Data[@"service_money"]];
    if ([[MethodCommon judgeStringIsNull:service_money] isEqualToString:@""]) {
        service_money =@"0";
    }
    self.FWlbale.text = [NSString stringWithFormat:@"¥%@",service_money];
    //翻呗优惠
    self.FBlbale.text = [NSString stringWithFormat:@"-¥%@",Data[@"save_money"]];
    //evaluate_score 评分
    NSString *score = [NSString stringWithFormat:@"%@",Data[@"evaluate_score"]];
    self.starEvaluator.currentValue = [score integerValue];
    self.star.text = [NSString stringWithFormat:@"%@ 分",score];
    
    
}
- (CGFloat)getCellHeight {
    return  self.BaseView.bottom;
}

- (void)setIsDetails:(BOOL)isDetails{
    
    /**
     * 订单内的商品
     */
    NSArray *goods = _Data[@"goods_info"];
    NSInteger  goodMen = goods.count;
    
    if (goodMen>3) {
        if (isDetails == YES) {
            self.BaseView.height = 400+goodMen*30;
//            CGFloat height= 400+goodMen*30;
//            NSLog(@"%lf",height);
        }else{
            goodMen = 3;
            self.BaseView.height = 400+goodMen*30;
        }
        
    }else{
        self.detailsButton.hidden = YES;
        self.detailslabel.hidden = YES;
        self.BaseView.height = 250+goodMen*30;
    }
    
    for (int i = 0; i<goodMen; i++) {
        UILabel *goodsName = [[UILabel alloc]init];
        goodsName.text = [NSString stringWithFormat:@"%@",goods[i][@"goods_name"]];
        goodsName.textColor = UIColorFromRGB(0x222222);
        [self.BaseView addSubview:goodsName];
        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodText.mas_bottom).offset(12+35*i);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(self.BaseView.width/2, 20));
        }];
    }
}
/** 刷新界面排版 */
//-(void)detailsAction{
//    if (self.detailsBlock) {
//        self.detailsBlock(YES);
//    }
//}

/** 删除 */
-(void)DeleteAction{

    if (self.delagate && [self.delagate respondsToSelector:@selector(delete_order1:)]) {
        [self.delagate delete_order1:self.Data];
    }
}
-(void)DayinAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(printe1:)]) {
        [self.delagate printe1:self.Data];
    }
    
}
/** 查看明细 */
-(void)DetailAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(Delete:)]) {
        [self.delagate Delete:self.Data];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
