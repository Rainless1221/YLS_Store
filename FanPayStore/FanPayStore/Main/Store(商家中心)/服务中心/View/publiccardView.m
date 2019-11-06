//
//  publiccardView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/29.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "publiccardView.h"

@implementation publiccardView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.BaseView1];
        [self addSubview:self.BaseView2];
        [self addSubview:self.determineButton];
        [self.BaseView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.height.mas_offset(202);
        }];
        [self.BaseView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.BaseView1.mas_bottom).offset(15);
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.height.mas_offset(245);
        }];
        [self.determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.BaseView2.mas_bottom).offset(51);
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.height.mas_offset(44);
        }];
        
        /** 横线 **/
        for (int i = 1; i<=3; i++) {
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = UIColorFromRGB(0xEAEAEA);
            [self.BaseView1 addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(50*i);
                make.left.mas_offset(10);
                make.right.mas_offset(-10);
                make.height.mas_offset(1);
            }];
        }
        NSArray *labelArr = @[@"银行卡号",@"卡类型",@"手机号",@"身份证"];
        for (int i = 0; i<labelArr.count; i++) {
            UILabel *cardLabel = [[UILabel alloc]init];
            cardLabel.text = labelArr[i];
            cardLabel.textColor = [UIColor blackColor];
            cardLabel.textAlignment = 0;
            cardLabel.font = [UIFont systemFontOfSize:15];
            [self.BaseView1 addSubview:cardLabel];
            [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(2+i*50);
                make.left.mas_offset(10);
                make.height.mas_offset(46);
                make.width.mas_offset(65);
            }];
        }
        
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = UIColorFromRGB(0xEAEAEA);
        [self.BaseView2 addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(50);
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(1);
        }];
        NSArray *labelArr1 = @[@"证件图片",@"上传银行开户许可证照片"];
        for (int i = 0; i<labelArr1.count; i++) {
            UILabel *cardLabel = [[UILabel alloc]init];
            cardLabel.text = labelArr1[i];
            cardLabel.textColor = [UIColor blackColor];
            cardLabel.textAlignment = 0;
            cardLabel.font = [UIFont systemFontOfSize:15];
            [self.BaseView2 addSubview:cardLabel];
            [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(2+i*50);
                make.left.mas_offset(10);
                make.height.mas_offset(46);
                make.width.mas_offset(200);
            }];
        }
        UILabel *cardLabel = [[UILabel alloc]init];
        cardLabel.text = @"必须上传银行开户许可证正面照片。";
        cardLabel.textColor = UIColorFromRGB(0xCCCCCC);
        cardLabel.textAlignment = 0;
        cardLabel.font = [UIFont systemFontOfSize:13];
        [self.BaseView2 addSubview:cardLabel];
        [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(44);
            make.left.mas_offset(10);
            make.height.mas_offset(15);
        }];
        
        /** 填写信息 **/
        [self.BaseView1 addSubview:self.card];
        [self.BaseView1 addSubview:self.cardPhone];
        [self.BaseView1 addSubview:self.cardtype];
        [self.BaseView1 addSubview:self.carduser];
        
        [self.card mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(2);
            make.left.mas_offset(75);
            make.right.mas_offset(-35);
            make.height.mas_offset(46);
        }];
        [self.cardtype mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(52);
            make.left.mas_offset(75);
            make.right.mas_offset(-35);
            make.height.mas_offset(46);
        }];
        
        [self.cardPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(102);
            make.left.mas_offset(75);
            make.right.mas_offset(-35);
            make.height.mas_offset(46);
        }];
        
        [self.carduser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(152);
            make.left.mas_offset(75);
            make.right.mas_offset(-35);
            make.height.mas_offset(46);
        }];
        
        
        /** 添加证件 **/
        [self.BaseView2 addSubview:self.cardButton];
        [self.cardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cardLabel.mas_bottom).offset(20);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(103, 103));
        }];

        
        
        /** 协议 */
        
        UILabel *xieyi = [[UILabel alloc]init];
        xieyi.textColor = [UIColor blackColor];
        xieyi.text = @"查看";
        xieyi.font= [UIFont systemFontOfSize:12];
        [self addSubview:xieyi];
        [xieyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.equalTo(self.BaseView2.mas_bottom).offset(5);
            make.height.mas_offset(22);
        }];
        
        
        UIButton *xieyiButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [xieyiButton setTitle:@"《银行卡服务协议》" forState:UIControlStateNormal];
        [xieyiButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        xieyiButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:xieyiButton];
        [xieyiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(xieyi.mas_right).offset(2);
            make.top.equalTo(self.BaseView2.mas_bottom).offset(5);
            make.height.mas_offset(22);
        }];
    }
    return self;
}
#pragma mark - GET

-(UIView *)BaseView1{
    if (!_BaseView1) {
        _BaseView1 = [[UIView alloc]init];
        _BaseView1.backgroundColor = [UIColor whiteColor];
        _BaseView1.layer.shadowColor = [UIColor blackColor].CGColor;
        // 设置阴影偏移量
        _BaseView1.layer.shadowOffset = CGSizeMake(0,0.1);
        // 设置阴影透明度
        _BaseView1.layer.shadowOpacity = 0.8;
        // 设置阴影半径
        _BaseView1.layer.shadowRadius = 0.2;
        _BaseView1.clipsToBounds = NO;
        _BaseView1.layer.cornerRadius = 5;
    }
    return _BaseView1;
}
-(UIView *)BaseView2{
    if (!_BaseView2) {
        _BaseView2 = [[UIView alloc]init];
        _BaseView2.backgroundColor = [UIColor whiteColor];
        // 设置阴影偏移量
        _BaseView2.layer.shadowOffset = CGSizeMake(0,0.1);
        // 设置阴影透明度
        _BaseView2.layer.shadowOpacity = 0.8;
        // 设置阴影半径
        _BaseView2.layer.shadowRadius = 0.2;
        _BaseView2.clipsToBounds = NO;
        _BaseView2.layer.cornerRadius = 5;
    }
    return _BaseView2;
}
-(UIButton *)determineButton{
    if (!_determineButton) {
        _determineButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [_determineButton setTitle:@"同意协议并绑定卡" forState:UIControlStateNormal];
        [_determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_determineButton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
        _determineButton.layer.cornerRadius = 10;
    }
    return _determineButton;
}

-(UITextField *)card{
    if (!_card) {
        _card = [[UITextField alloc]init];
        _card.textColor = UIColorFromRGB(0x3D8AFF);
        _card.font = [UIFont systemFontOfSize:16];
        _card.placeholder = @"请输入银行卡号";
        _card.keyboardType= UIKeyboardTypeDecimalPad;
    }
    return _card;
}


-(UITextField *)cardPhone{
    if (!_cardPhone) {
        _cardPhone = [[UITextField alloc]init];
        _cardPhone.textColor = UIColorFromRGB(0x3D8AFF);
        _cardPhone.font = [UIFont systemFontOfSize:16];
        _cardPhone.placeholder = @"请输入手机号";
        _cardPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
        _cardPhone.keyboardType= UIKeyboardTypeDecimalPad;

    }
    return _cardPhone;
}

-(UITextField *)carduser{
    if (!_carduser) {
        _carduser = [[UITextField alloc]init];
        _carduser.textColor = UIColorFromRGB(0x3D8AFF);
        _carduser.font = [UIFont systemFontOfSize:16];
        _carduser.placeholder = @"请输入法人身份证号";
        _carduser.clearButtonMode = UITextFieldViewModeWhileEditing;
        _carduser.keyboardType= UIKeyboardTypeDecimalPad;

    }
    return _carduser;
}

-(UILabel *)cardtype{
    if (!_cardtype) {
        _cardtype = [[UILabel alloc]init];
        _cardtype.text = @"银行卡类型";
        _cardtype.textColor = UIColorFromRGB(0x3D8AFF);
        _cardtype.font = [UIFont systemFontOfSize:15];
        _cardtype.textAlignment = 0;
    }
    return _cardtype;
}

- (UIButton *)cardButton{
    if (!_cardButton) {
        _cardButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cardButton setImage:[UIImage imageNamed:@"btn_add_shop_info_image_normal"] forState:UIControlStateNormal];
        _cardButton.layer.cornerRadius = 5;
    }
    return _cardButton;
}
@end
