//
//  NameOfShop.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/8.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "NameOfShop.h"

@implementation NameOfShop
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.logoButton];
        [self.logoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(autoScaleW(30));
            make.right.mas_offset(-autoScaleW(30));
            make.top.mas_offset(autoScaleW(25));
            make.height.mas_offset(self.width-autoScaleW(60));
        }];
        
        [self addSubview:self.logoLabel];
        [self.logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-autoScaleW(30));
            make.top.equalTo(self.logoButton.mas_bottom).offset(autoScaleW(10));
        }];
        
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(autoScaleW(30));
            make.right.mas_offset(-autoScaleW(30));
            make.height.mas_offset(0.5);
            make.bottom.mas_offset(-autoScaleW(91));
        }];
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(autoScaleW(30));
            make.right.mas_offset(-autoScaleW(30));
            make.height.mas_offset(0.5);
            make.bottom.mas_offset(-autoScaleW(40));
        }];
        
        
        [self addSubview:self.category_icon];
        [self addSubview:self.store_category];
        [self.category_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line1.mas_bottom).offset(0);
            make.bottom.equalTo(self.line2.mas_top).offset(0);
            make.right.mas_offset(-autoScaleW(30));
            make.width.mas_offset(32);
        }];
        [self.store_category mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line1.mas_bottom).offset(0);
            make.bottom.equalTo(self.line2.mas_top).offset(0);
            make.left.mas_offset(autoScaleW(30));
            make.right.mas_offset(-autoScaleW(30));
        }];
        
        
        [self addSubview:self.store_name];
        [self.store_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.line1.mas_top).offset(0);
            make.right.mas_offset(-autoScaleW(30));
            make.left.mas_offset(autoScaleW(31));
            make.height.mas_offset(autoScaleW(50));
        }];
    }
    return self;
}
#pragma mark - 添加logo
-(void)AddlogoAviton:(UIButton *)sender{
    if (self.delagate && [self.delagate respondsToSelector:@selector(logoAction:)]) {
        [self.delagate logoAction:sender];
        
    }
}
#pragma mark - 选择类型
-(void)AddcategoryAction:(UIButton *)sender{
    if (self.delagate && [self.delagate respondsToSelector:@selector(store_category:)]) {
        [self.delagate store_category:sender];
        
    }
}
#pragma mark - 懒加载
-(UIButton *)logoButton{
    if (!_logoButton) {
        _logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoButton.frame = CGRectMake(autoScaleW(30), autoScaleW(25), self.width -autoScaleW(60), self.width -autoScaleW(60));
        [_logoButton setImage:[UIImage imageNamed:@"icn_add_shop_avatar"] forState:UIControlStateNormal];
        _logoButton.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
        [_logoButton addTarget:self action:@selector(AddlogoAviton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoButton;
}
-(UILabel *)logoLabel{
    if (!_logoLabel) {
        _logoLabel = [[UILabel alloc]initWithFrame:CGRectMake(33, self.logoButton.bottom, self.width-66, 36)];
        _logoLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _logoLabel.font = [UIFont systemFontOfSize:13];
        _logoLabel.textAlignment = 2;
        _logoLabel.text = @"上传店铺logo";
        [_logoLabel sizeToFit];
    }
    return _logoLabel;
}
-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(33, 0, self.width-66, 0.5)];
        _line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    }
    return _line1;
}
-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]initWithFrame:CGRectMake(33, 0, self.width-66, 0.5)];
        _line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    }
    return _line2;
}
-(UIButton *)store_category{
    if (!_store_category) {
        _store_category = [UIButton buttonWithType:UIButtonTypeCustom];
        _store_category.frame = CGRectMake(33, 0, self.width -66, 50);
        [_store_category.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_store_category setTitle:@"  请选择经营类型" forState:UIControlStateNormal];
        [_store_category setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateNormal];
        _store_category.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_store_category setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateSelected];
        [_store_category addTarget:self action:@selector(AddcategoryAction:) forControlEvents:UIControlEventTouchUpInside];
//        _store_category.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _store_category;
}
-(UIButton *)category_icon{
    if (!_category_icon) {
        _category_icon = [UIButton buttonWithType:UIButtonTypeCustom];
        _category_icon.frame = CGRectMake(self.store_category.right-33, 0, 32, 50);
        [_category_icon setImage:[UIImage imageNamed:@"icn_draw_drop_arrow"] forState:UIControlStateNormal];
    }
    return _category_icon;
}

-(UITextField *)store_name{
    if (!_store_name) {
        _store_name = [[UITextField alloc]initWithFrame:CGRectMake(33, 0, self.width - 66, 50)];
        _store_name.placeholder = @"  请输入店铺名称";
        _store_name.font = [UIFont systemFontOfSize:15];
        _store_name.clearButtonMode=UITextFieldViewModeWhileEditing;
        _store_name.textColor = UIColorFromRGB(0x222222);
    }
    return _store_name;
}


@end
