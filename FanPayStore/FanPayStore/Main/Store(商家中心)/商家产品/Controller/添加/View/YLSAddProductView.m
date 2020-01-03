//
//  YLSAddProductView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSAddProductView.h"

@implementation YLSAddProductView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
#pragma mark - 商品信息
    [self addSubview:self.GoodsView];
    [self.GoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(356);
    }];
    /*line 横行*/
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.GoodsView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(0.5);
        make.top.mas_offset(50);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.GoodsView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(0.5);
        make.top.mas_offset(100.5);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.GoodsView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(0.5);
        make.bottom.mas_offset(-90);
    }];
    
    self.PINGView = [[UIView alloc] init];
    self.PINGView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    [self.GoodsView addSubview:self.PINGView];
    [self.PINGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(63);
        make.top.mas_offset(151.5);
    }];
    /*标题*/
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"商品名称";
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:15];
    label1.numberOfLines = 0;
    [self.GoodsView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.size.mas_offset(CGSizeMake(65, 50));
    }];
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"商品原价";
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont systemFontOfSize:15];
    label2.numberOfLines = 0;
    [self.GoodsView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(50);
        make.size.mas_offset(CGSizeMake(65, 50));
    }];
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"折扣价格";
    label3.textColor = [UIColor blackColor];
    label3.font = [UIFont systemFontOfSize:15];
    label3.numberOfLines = 0;
    [self.GoodsView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(100.5);
        make.size.mas_offset(CGSizeMake(65, 50));
    }];
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"平台价";
    label4.textColor = [UIColor blackColor];
    label4.font = [UIFont systemFontOfSize:15];
    label4.numberOfLines = 0;
    [self.PINGView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(15);
        make.width.mas_offset(65);
    }];
    UILabel *label5 = [[UILabel alloc] init];
    label5.text = @"商品库存";
    label5.textColor = [UIColor blackColor];
    label5.font = [UIFont systemFontOfSize:15];
    label5.numberOfLines = 0;
    [self.GoodsView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.PINGView.mas_bottom).offset(0);
        make.size.mas_offset(CGSizeMake(65, 50));
    }];
    
    
    /**
     信息填写
     */
    self.goods_name = [[UITextField alloc]initWithFrame:CGRectMake(75, 0, 120, 50)];
    self.goods_name.placeholder = @"请输入商品名称";
    self.goods_name.textColor = UIColorFromRGB(0x222222);
    self.goods_name.font = [UIFont systemFontOfSize:15];
    [self.GoodsView addSubview:self.goods_name];
    [self.goods_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.right.mas_offset(-10);
        make.left.equalTo(label1.mas_right).offset(10);
        make.height.mas_offset(50);
    }];
    
    self.goods_price = [[UITextField alloc]initWithFrame:CGRectMake(75, 0, 120, 50)];
    self.goods_price.placeholder = @"请输入商品原价，单位（元）";
    self.goods_price.textColor = UIColorFromRGB(0x222222);
    self.goods_price.font = [UIFont systemFontOfSize:15];
    self.goods_price.keyboardType = UIKeyboardTypeDecimalPad;
    self.goods_price.delegate = self;
    [self.GoodsView addSubview:self.goods_price];
    [self.goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.right.mas_offset(-10);
        make.left.equalTo(label1.mas_right).offset(10);
        make.height.mas_offset(50);
    }];
    self.discount_price = [[UITextField alloc]initWithFrame:CGRectMake(75, 0, 120, 50)];
    self.discount_price.placeholder = @"请输入商品优惠价格，单位（元）";
    self.discount_price.textColor = UIColorFromRGB(0x222222);
    self.discount_price.font = [UIFont systemFontOfSize:15];
    self.discount_price.keyboardType = UIKeyboardTypeDecimalPad;
    self.discount_price.delegate = self;
    [self.GoodsView addSubview:self.discount_price];
    [self.discount_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(0);
        make.right.mas_offset(-10);
        make.left.equalTo(label1.mas_right).offset(10);
        make.height.mas_offset(50);
    }];
    
    self.goods_Ping = [[UILabel alloc]initWithFrame:CGRectMake(75, 0, 120, 50)];
    self.goods_Ping.text = @"平台价为优惠价+服务费之和";
    self.goods_Ping.textColor = UIColorFromRGB(0xCCCCCC);
    self.goods_Ping.font = [UIFont systemFontOfSize:15];
    [self.PINGView addSubview:self.goods_Ping];
    [self.goods_Ping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.left.equalTo(label4.mas_right).offset(10);
        make.centerY.equalTo(label4.mas_centerY).offset(0);
    }];
    UILabel *Pinglabel = [[UILabel alloc] init];
    Pinglabel.numberOfLines = 0;
    Pinglabel.text = @"*平台价格为用户所见价格";
    Pinglabel.font = [UIFont systemFontOfSize:12];
    Pinglabel.textColor = UIColorFromRGB(0xFF6969);
    [self.PINGView addSubview:Pinglabel];
    [Pinglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.left.equalTo(label4.mas_right).offset(10);
        make.top.equalTo(self.goods_Ping.mas_bottom).offset(5);
    }];
    
    self.goods_num = [[UITextField alloc]initWithFrame:CGRectMake(75, 0, 120, 50)];
    self.goods_num.placeholder = @"请输入商品库存";
    self.goods_num.textColor = UIColorFromRGB(0x222222);
    self.goods_num.font = [UIFont systemFontOfSize:15];
    self.goods_num.keyboardType = UIKeyboardTypeDecimalPad;
    [self.GoodsView addSubview:self.goods_num];
    [self.goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.PINGView.mas_bottom).offset(0);
        make.right.mas_offset(-10);
        make.left.equalTo(label1.mas_right).offset(10);
        make.height.mas_offset(50);
    }];
    
    /*icon*/
    UIImageView *iconMiao = [[UIImageView alloc]init];
    iconMiao.image = [UIImage imageNamed:@"icn_input_pen"];
    [self.GoodsView addSubview:iconMiao];
    [iconMiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(9.5);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(16, 16));
    }];
    self.goods_Miao = [[UITextView alloc]initWithFrame:CGRectMake(35, 0, self.GoodsView.width - 40, 78)];
    self.goods_Miao.backgroundColor = [UIColor clearColor];
    self.goods_Miao.textColor = [UIColor blackColor];
    self.goods_Miao.font = [UIFont systemFontOfSize:13.f];
    [self.goods_Miao jk_addPlaceHolder:@"输入商品描述（50字内）"];
    // 限制 10个字符
    //    [textView setValue:@10 forKey:@"limit"];
    self.goods_Miao.jk_placeHolderTextView.textColor = UIColorFromRGB(0xCCCCCC);
    [self.GoodsView addSubview:self.goods_Miao];
    [self.goods_Miao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(0);
        make.right.bottom.mas_offset(-10);
        make.left.equalTo(iconMiao.mas_right).offset(8);
    }];
    
    
#pragma mark - 商品标签
    [self addSubview:self.TheLabelView];
    [self.TheLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsView.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(50);
    }];
    UILabel *label6 = [[UILabel alloc] init];
    label6.text = @"商品标签";
    label6.textColor = [UIColor blackColor];
    label6.font = [UIFont systemFontOfSize:15];
    label6.numberOfLines = 0;
    [self.TheLabelView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.size.mas_offset(CGSizeMake(65, 50));
    }];
    
    /*箭头*/
    UIImageView *Jiantou1 = [[UIImageView alloc]init];
    Jiantou1.image = [UIImage imageNamed:@"ico_arrow_right_black"];
    [self.TheLabelView addSubview:Jiantou1];
    [Jiantou1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(6, 9.9));
    }];
    
    self.TheLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.TheLabelButton.frame = CGRectMake(85, 9, 140, 32);
    [self.TheLabelButton setTitle:@"请选择商品标签" forState:UIControlStateNormal];
    self.TheLabelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.TheLabelButton addTarget:self action:@selector(LabelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.TheLabelButton setTitleColor:UIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
    [self.TheLabelView addSubview:self.TheLabelButton];
    [self.TheLabelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
//        make.left.equalTo(label6.mas_right).offset(10);
        make.left.mas_offset(85);
        make.height.mas_offset(32);
    }];
    
#pragma mark - 商品属性
    [self addSubview:self.AttributeView];
    [self.AttributeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.TheLabelView.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(50);
    }];
    UILabel *label7 = [[UILabel alloc] init];
    label7.text = @"商品属性";
    label7.textColor = [UIColor blackColor];
    label7.font = [UIFont systemFontOfSize:15];
    label7.numberOfLines = 0;
    [self.AttributeView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.size.mas_offset(CGSizeMake(65, 50));
    }];
    /*箭头*/
    UIImageView *Jiantou2 = [[UIImageView alloc]init];
    Jiantou2.image = [UIImage imageNamed:@"ico_arrow_right_black"];
    [self.AttributeView addSubview:Jiantou2];
    [Jiantou2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label7.mas_centerY).offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(6, 9.9));
    }];
    self.AttributelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.AttributelButton setTitle:@"添加商品属性，如辣味、甜度" forState:UIControlStateNormal];
    self.AttributelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.AttributelButton setTitleColor:UIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
    self.AttributelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.AttributelButton addTarget:self action:@selector(AttributeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.AttributeView addSubview:self.AttributelButton];
    [self.AttributelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(label6.mas_right).offset(10);
        make.height.mas_offset(50);
        make.right.mas_offset(-24);
    }];
    
#pragma mark - 商品类型
//    [self addSubview:self.GoodTypeView];
//    [self.GoodTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.AttributeView.mas_bottom).offset(15);
//        make.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(50);
//    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.text = @"商品类型";
    label8.textColor = [UIColor blackColor];
    label8.font = [UIFont systemFontOfSize:15];
    label8.numberOfLines = 0;
    [self.GoodTypeView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.size.mas_offset(CGSizeMake(65, 50));
    }];
    
    NSArray *buttonArray = @[@"选填",@"必填",@"提示"];
    for (int i=0; i<3; i++) {
        NSString *typetitle = [NSString stringWithFormat:@"%@",buttonArray[i]];
        UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [typeButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [typeButton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        typeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [typeButton setTitle:typetitle forState:UIControlStateNormal];
        typeButton.layer.borderWidth = 1;
        typeButton.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        typeButton.layer.cornerRadius = 16;
        typeButton.tag = i+1;
        [typeButton addTarget:self action:@selector(TypeAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            typeButton.selected = YES;
            typeButton.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
        }
        [self.GoodTypeView addSubview:typeButton];
        [typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.left.equalTo(label8.mas_right).offset(10 + 70*i);
            make.height.mas_offset(32);
            make.width.mas_offset(61);
        }];
    }
    
    #pragma mark - 商品图片
    [self addSubview:self.GoodPicImageView];
    [self.GoodPicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AttributeView.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-50);
    }];
    UILabel *label9 = [[UILabel alloc] init];
    label9.text = @"添加商品图片";
    label9.textColor = [UIColor blackColor];
    label9.font = [UIFont systemFontOfSize:15];
    label9.numberOfLines = 0;
    [self.GoodPicImageView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.size.mas_offset(CGSizeMake(200, 38));
    }];
    UILabel *label10 = [[UILabel alloc] init];
    label10.text = @"尽量保持产品整体可见。";
    label10.textColor = UIColorFromRGB(0xCCCCCC);
    label10.font = [UIFont systemFontOfSize:13];
    label10.numberOfLines = 0;
    [self.GoodPicImageView addSubview:label10];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(label9.mas_bottom).offset(0);
        make.height.mas_offset(15);
    }];
    
    #pragma mark - 提示的文本
    [self addSubview:self.ErrorView];
    [self.ErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodPicImageView.mas_bottom).offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(37);
    }];
    UIButton *Erroricon = [UIButton buttonWithType:UIButtonTypeCustom];
    [Erroricon setImage:[UIImage imageNamed:@"icn_message_warning"] forState:UIControlStateNormal];
    [Erroricon setTitle:@"    名称、价格、库存为必填，描述为选填项" forState:UIControlStateNormal];
    [Erroricon setTitleColor:UIColorFromRGB(0xFF6969) forState:UIControlStateNormal];
    Erroricon.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.ErrorView addSubview:Erroricon];
    [Erroricon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_offset(0);
//        make.width.mas_offset(200);
    }];
    
}
#pragma mark - 选择标签事件
-(void)LabelAction:(UITapGestureRecognizer *)tap{
    if (self.delagate && [self.delagate respondsToSelector:@selector(andTheLabel)]) {
        [self.delagate andTheLabel];
    }
}
-(void)LabelBtnAction:(UIButton *)Btn{
    if (Btn.selected !=YES) {
        if (self.delagate && [self.delagate respondsToSelector:@selector(andTheLabel)]) {
            [self.delagate andTheLabel];
        }
    }
   
}
#pragma mark - 选择属性事件
-(void)AttributeAction:(UITapGestureRecognizer *)tap{
//    if (self.delagate && [self.delagate respondsToSelector:@selector(andAttribute)]) {
//        [self.delagate andAttribute];
//    }
}
-(void)AttributeAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(andAttribute)]) {
        [self.delagate andAttribute];
    }
}
#pragma mark - 选择类型事件
-(void)TypeAction:(UIButton  *)tap{
    for (int i = 0; i<3; i++) {
        
        if (tap.tag == i+1) {
            UIButton *but = (UIButton *)[self viewWithTag:i+1];
            but.selected = YES;
             but.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+1];
        but.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        but.selected = NO;
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL returnValue = YES;
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString * plat_price_rate = [PublicMethods readFromUserD:@"plat_price_rate"];
    
    if ([[MethodCommon judgeStringIsNull:plat_price_rate] isEqualToString:@""]) {
        plat_price_rate = @"0.2";
    }
    NSString *price = [self reviseString:plat_price_rate];
    double plat = [price doubleValue];


    if (textField ==  self.goods_price) {
        if (text.length>0&&self.discount_price.text.length>0) {
            [self get_plat_price_rate1:text];
        }else{
            self.goods_Ping.text = @"平台价为优惠价+服务费之和";
            self.goods_Ping.textColor = UIColorFromRGB(0xCCCCCC);
        }
        
        
    }else{
        if (text.length>0&&self.goods_price.text.length>0) {
            [self get_plat_price_rate:text];
        }else{
            self.goods_Ping.text = @"平台价为优惠价+服务费之和";
            self.goods_Ping.textColor = UIColorFromRGB(0xCCCCCC);
        }
        
        
    }
        

    
    return returnValue;
}
-(NSString *)reviseString:(NSString *)str{
    
    double value = [str doubleValue];
    NSString *temp = [NSString stringWithFormat:@"%lf", value];
    NSDecimalNumber *resultNumber = [NSDecimalNumber decimalNumberWithString:temp];
    return [resultNumber stringValue];
    
}
-(void)get_plat_price_rate:(NSString *)discount_price{
    
    //get_plat_price_according_goods_price_and_discount_price
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_plat_price_according_goods_price_and_discount_price:model.merchant_id andstore_id:model.store_id  andgoods_price:[NSString stringWithFormat:@"%@",self.goods_price.text] anddiscount_price:discount_price  Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            
            self.goods_Ping.text = [NSString stringWithFormat:@"%@",DIC[@"plat_price"]];
            self.goods_Ping.textColor = UIColorFromRGB(0x222222);
            
        }else{
            self.goods_Ping.text = [NSString stringWithFormat:@"%@",resDic[@"message"]];
            self.goods_Ping.textColor = UIColorFromRGB(0xCCCCCC);
            
        }
        
    } andfailure:^{
        
    }];
}
-(void)get_plat_price_rate1:(NSString *)discount_price{
    
    //get_plat_price_according_goods_price_and_discount_price
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_plat_price_according_goods_price_and_discount_price:model.merchant_id andstore_id:model.store_id  andgoods_price:discount_price anddiscount_price:[NSString stringWithFormat:@"%@",self.discount_price.text]  Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            
            self.goods_Ping.text = [NSString stringWithFormat:@"%@",DIC[@"plat_price"]];
            self.goods_Ping.textColor = UIColorFromRGB(0x222222);
            
        }else{
            self.goods_Ping.text = [NSString stringWithFormat:@"%@",resDic[@"message"]];
            self.goods_Ping.textColor = UIColorFromRGB(0xCCCCCC);
            
        }
        
    } andfailure:^{
        
    }];
}

#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    //商品名
    NSString *goods_name = [NSString stringWithFormat:@"%@",Data[@"goods_name"]];
    if ([[MethodCommon judgeStringIsNull:goods_name] isEqualToString:@""]) {
        
    }else{
        self.goods_name.text = goods_name;
        
    }
    
    
    NSString *goods_price = [NSString stringWithFormat:@"%@",Data[@"goods_price"]];
    if ([[MethodCommon judgeStringIsNull:goods_price] isEqualToString:@""]) {
        
    }else{
        self.goods_price.text = goods_price;
    }
    
    
    
    NSString *discount_price = [NSString stringWithFormat:@"%@",Data[@"discount_price"]];
    if ([[MethodCommon judgeStringIsNull:discount_price] isEqualToString:@""]) {
        
    }else{
        self.discount_price.text = discount_price;
    }
    
    
    
    NSString *goods_num = [NSString stringWithFormat:@"%@",Data[@"goods_count"]];
    if ([[MethodCommon judgeStringIsNull:goods_num] isEqualToString:@""]) {
        
    }else{
        self.goods_num.text = goods_num;
    }
    
    
    NSString *goods_description1 = [NSString stringWithFormat:@"%@",Data[@"goods_desc"]];
    if ([[MethodCommon judgeStringIsNull:goods_description1] isEqualToString:@""]) {
        
    }else{
        self.goods_Miao.text = goods_description1;
        self.goods_Miao.jk_placeHolderTextView.hidden = YES;
    }
    
    
    [self get_plat_price_rate:self.discount_price.text];
    
    
   
    
    
}

#pragma mark - 懒加载
-(UIView *)GoodsView{
    if (!_GoodsView) {
        _GoodsView = [[UIView alloc]init];
        _GoodsView.backgroundColor = [UIColor whiteColor];
        _GoodsView.layer.cornerRadius = 5;
    }
    return _GoodsView;
}
-(UIView *)TheLabelView{
    if (!_TheLabelView) {
        _TheLabelView = [[UIView alloc]init];
        _TheLabelView.backgroundColor = [UIColor whiteColor];
        _TheLabelView.layer.cornerRadius = 5;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LabelAction:)];
        [_TheLabelView addGestureRecognizer:tapGesturRecognizer];
    }
    return _TheLabelView;
}
-(UIView *)AttributeView{
    if (!_AttributeView) {
        _AttributeView = [[UIView alloc]init];
        _AttributeView.backgroundColor = [UIColor whiteColor];
        _AttributeView.layer.cornerRadius = 5;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AttributeAction:)];
        [_AttributeView addGestureRecognizer:tapGesturRecognizer];
    }
    return _AttributeView;
}
-(UIView *)GoodTypeView{
    if (!_GoodTypeView) {
        _GoodTypeView = [[UIView alloc]init];
        _GoodTypeView.backgroundColor = [UIColor whiteColor];
        _GoodTypeView.layer.cornerRadius = 5;
    }
    return _GoodTypeView;
}
-(UIView *)GoodPicImageView{
    if (!_GoodPicImageView) {
        _GoodPicImageView = [[UIView alloc]init];
        _GoodPicImageView.backgroundColor = [UIColor whiteColor];
        _GoodPicImageView.layer.cornerRadius = 5;
    }
    return _GoodPicImageView;
}
-(UIView *)ErrorView{
    if (!_ErrorView) {
        _ErrorView = [[UIView alloc]init];
        _ErrorView.backgroundColor = [UIColor clearColor];
        _ErrorView.layer.cornerRadius = 5;
    }
    return _ErrorView;
}
@end
