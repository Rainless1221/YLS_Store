//
//  goodDetailsView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/6.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "goodDetailsView.h"

@implementation goodDetailsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.goodView];
        [self.goodView addSubview:self.discount_price];
        [self.goodView addSubview:self.goods_price];
        [self.goodView addSubview:self.goods_count];
        [self.goodView addSubview:self.goods_desc];
        [self.goodView addSubview:self.goodname];
        [self.goodView addSubview:self.labelButton];
        
        //修改信息
        FL_Button *Btn = [FL_Button buttonWithType:UIButtonTypeCustom];
        [Btn setTitle:@"修改信息" forState:UIControlStateNormal];
        [Btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [Btn setImage:[UIImage imageNamed:@"icn_b_order_all"] forState:UIControlStateNormal];
        Btn.status = FLAlignmentStatusTop;
        Btn.fl_padding = 5;
        [Btn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [self.goodView addSubview:Btn];
        [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(45, 40));
        }];
        
        
        
        [self addSubview:self.ImageView];
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0,50,self.ImageView.width,0.5);
        view.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [self.ImageView addSubview:view];

        //列表 切换
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [Button setImage:[UIImage imageNamed:@"icn_product_evaluate_active"] forState:UIControlStateNormal];
//        [Button setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [self.ImageView addSubview:Button];
        [Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(40, 40));
        }];
        
        UIButton *Button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [Button1 setImage:[UIImage imageNamed:@"icn_product_evaluate_active"] forState:UIControlStateNormal];
//        [Button1 setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [self.ImageView addSubview:Button1];
        [Button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.right.equalTo(Button.mas_left).offset(-10);
            make.size.mas_offset(CGSizeMake(40, 40));
        }];
        
        
        
        //图文/评价
        UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [typeButton setTitle:@"图文" forState:UIControlStateNormal];
        [typeButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateSelected];
        [typeButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [typeButton.titleLabel setFont:[UIFont systemFontOfSize:16]];

        typeButton.selected = YES;
        [self.ImageView addSubview:typeButton];
        [typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(50, 40));
        }];
        
        UIButton *typeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [typeButton1 setTitle:@"评价" forState:UIControlStateNormal];
        [typeButton1 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateSelected];
        [typeButton1 setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [typeButton1.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        
        [self.ImageView addSubview:typeButton1];
        [typeButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.left.equalTo(typeButton.mas_right).offset(-10);
            make.size.mas_offset(CGSizeMake(50, 40));
        }];
    }
    return self;
}

#pragma mark - 懒加载
-(UIView *)goodView {
    if (!_goodView) {
        _goodView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 287)];
        _goodView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _goodView.layer.cornerRadius = 16;
    }
    return _goodView;
}

-(UIView *)ImageView{
    if (!_ImageView) {
        _ImageView = [[UIView alloc]initWithFrame:CGRectMake(0, _goodView.bottom+15, ScreenW, 287)];
        _ImageView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _ImageView;
}
-(UILabel *)discount_price{
    if (!_discount_price) {
        _discount_price = [[UILabel alloc]initWithFrame:CGRectMake(15, 21, 87, 21)];
        _discount_price.font = [UIFont systemFontOfSize:autoScaleW(19)];
        _discount_price.textColor= UIColorFromRGB(0xEE4E3E);
        _discount_price.text = @"¥ 29.00";
    }
    return _discount_price;
}
-(UILabel *)goods_price{
    if (!_goods_price) {
        _goods_price = [[UILabel alloc]initWithFrame:CGRectMake(112, 30, 52, 12)];
        _goods_price.font = [UIFont systemFontOfSize:autoScaleW(13)];
        _goods_price.textColor= UIColorFromRGB(0x3D8AFF);
        _goods_price.text = @"¥ 35.00";
    }
    return _goods_price;
}
-(UILabel *)goods_count{
    if (!_goods_count) {
        _goods_count = [[UILabel alloc]initWithFrame:CGRectMake(173, 30, 52, 12)];
        _goods_count.font = [UIFont systemFontOfSize:autoScaleW(16)];
        _goods_count.textColor= UIColorFromRGB(0x3D8AFF);
        _goods_count.text = @"102 份";
    }
    return _goods_count;
}
-(UILabel *)goodname{
    if (!_goodname) {
        _goodname = [[UILabel alloc]initWithFrame:CGRectMake(14, 101, 200, 19)];
        _goodname.font = [UIFont systemFontOfSize:autoScaleW(20)];
        _goodname.textColor= UIColorFromRGB(0x222222);
        _goodname.text = @"焦糖糯米蛋糕";
    }
    return _goodname;
}
-(UILabel *)goods_desc{
    if (!_goods_desc) {
        _goods_desc = [[UILabel alloc]initWithFrame:CGRectMake(16, 140, 338, 70)];
        _goods_desc.font = [UIFont systemFontOfSize:autoScaleW(13)];
        _goods_desc.textColor= UIColorFromRGB(0x999999);
        _goods_desc.numberOfLines = 0;

        _goods_desc.text = @"这是野路的糯米蛋糕系列中的第一款，也是开店至今仍是最畅销的一款，许多客人都会将它列为必点甜点。在糯米蛋糕胚的基础上，抹上奶油，";
    }
    return _goods_desc;
}
-(UIButton *)labelButton{
    if (!_labelButton) {
        _labelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _labelButton.frame = CGRectMake(15, 61, 50, 20);
        _labelButton.layer.borderWidth = 1;
        _labelButton.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        _labelButton.layer.cornerRadius = 10;
        
        [_labelButton setTitle:@"#甜品" forState:UIControlStateNormal];
        [_labelButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [_labelButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _labelButton;
}
@end
