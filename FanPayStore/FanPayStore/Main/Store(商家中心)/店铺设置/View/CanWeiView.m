//
//  CanWeiView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2020/1/1.
//  Copyright © 2020 mocoo_ios. All rights reserved.
//

#import "CanWeiView.h"

@implementation CanWeiView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.56];
        
        [self addSubview:self.Baseview];
        [self.Baseview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ScreenW-30, 279));
            make.center.mas_offset(0);
        }];
#pragma mark - 标题
        [self.Baseview addSubview:self.CanLabel];
        [self.CanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(50);
            make.top.mas_offset(0);
        }];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [self.Baseview addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(0.5);
            make.top.mas_offset(50);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
        [self.Baseview addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(30);
            make.right.mas_offset(-30);
            make.height.mas_offset(0.5);
            make.top.equalTo(view.mas_bottom).offset(79);
        }];
        
#pragma mark -输入框
        [self.Baseview addSubview:self.CanField];
        [self.CanField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(30);
            make.right.mas_offset(-30);
            make.height.mas_offset(30);
            make.bottom.equalTo(lineView.mas_top).offset(-5);
        }];
        
#pragma mark - 按钮
        [self.Baseview addSubview:self.cancel];
        [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(0);
            make.width.mas_offset(50);
            make.height.mas_offset(50);
        }];
        
        [self.Baseview addSubview:self.CanButton];
        [self.CanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(30);
            make.right.mas_offset(-30);
            make.height.mas_offset(44);
            make.bottom.mas_offset(-50);
        }];
    }
    return self;
}
-(void)CanButtonAction{
    
    if (self.CanField.text.length==0||self.CanField.text==nil) {
        return;
    }
    if (self.delagate && [self.delagate respondsToSelector:@selector(Can_card:)]) {
            [self.delagate Can_card:self.CanField.text];
        }
     [self removeFromSuperview];
}
-(void)cancelAction{
    [self removeFromSuperview];
    
}
#pragma mark - 懒加载
-(UIView *)Baseview{
    if (!_Baseview) {
        _Baseview = [[UIView alloc]initWithFrame:CGRectMake(15, 157, ScreenW-30, 353)];
        _Baseview.backgroundColor = [UIColor whiteColor];
        _Baseview.layer.cornerRadius = 6;
    }
    return _Baseview;
}

-(UILabel *)CanLabel{
    if (!_CanLabel) {
        _CanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 30)];
        _CanLabel.textAlignment = 1;
        _CanLabel.textColor = UIColorFromRGB(0x222222);
        _CanLabel.font = [UIFont systemFontOfSize:15];
        _CanLabel.text = @"输入餐位费金额";
    }
    return _CanLabel;
}

-(UIButton *)CanButton{
    if (!_CanButton) {
        _CanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _CanButton.frame = CGRectMake(0,0,ScreenW-90,44);
        [_CanButton setTitle:@"确定" forState:UIControlStateNormal];
        [_CanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _CanButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
        _CanButton.layer.cornerRadius = 10;
        _CanButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_CanButton addTarget:self action:@selector(CanButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _CanButton;
}
-(UIButton *)cancel{
    if (!_cancel) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel setImage:[UIImage imageNamed:@"suspension_layer_btn_close_pressed"] forState:UIControlStateNormal];
        [_cancel setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
        _cancel.frame = CGRectMake(0,0,ScreenW-90,44);
        [_cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancel;
}
-(UITextField *)CanField{
    if (!_CanField) {
        _CanField = [[UITextField alloc]initWithFrame:CGRectMake(30, 130, 285, 20)];
        _CanField.textColor = UIColorFromRGB(0x222222);
        _CanField.font = [UIFont systemFontOfSize:18];
        _CanField.placeholder = @"请输入金额";
       _CanField.keyboardType = UIKeyboardTypeDecimalPad;
        _CanField.textAlignment = 1;
    }
    return _CanField;
}
@end
