//
//  DetailsTKView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/23.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "DetailsTKView.h"

@implementation DetailsTKView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    [self addSubview:self.TKbutton];
    [self.TKbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_offset(35);
    }];
    [self addSubview:self.Button1];
    [self.Button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.TKbutton.mas_bottom).offset(5);
        make.left.mas_offset(30);
        make.size.mas_offset(CGSizeMake(75, 55));
    }];
    [self addSubview:self.Button2];
    [self.Button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.TKbutton.mas_bottom).offset(5);
        make.right.mas_offset(-30);
        make.size.mas_offset(CGSizeMake(75, 55));
    }];
    
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    lineview.layer.cornerRadius = 0.5;
    [self addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.bottom.mas_offset(-55);
        make.height.mas_offset(1);
        make.left.equalTo(self.Button1.mas_right).offset(-10);
        make.right.equalTo(self.Button2.mas_left).offset(10);
    }];
}
-(UIButton *)TKbutton{
    if (!_TKbutton) {
        _TKbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TKbutton setTitle:@"  退款详情" forState:UIControlStateNormal];
        [_TKbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _TKbutton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_TKbutton setImage:[UIImage imageNamed:@"icn_order_clock"] forState:UIControlStateNormal];
    }
    return _TKbutton;
}
-(FL_Button*)Button1{
    if (!_Button1) {
        _Button1 = [FL_Button buttonWithType:UIButtonTypeCustom];
        _Button1.frame = CGRectMake(0, 0, 60, 60);
        [_Button1 setImage:[UIImage imageNamed:@"icn_order_process_doing"] forState:UIControlStateNormal];
        [_Button1 setImage:[UIImage imageNamed:@"icn_order_process_done"] forState:UIControlStateSelected];
        [_Button1 setTitle:@"退款处理中" forState:UIControlStateNormal];
        [_Button1 setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [_Button1 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        //样式
        _Button1.status = FLAlignmentStatusTop;
        _Button1.fl_padding = 10;
        _Button1.titleLabel.font = [UIFont systemFontOfSize:12];
        _Button1.selected = YES;
    }
    return _Button1;
}
-(FL_Button*)Button2{
    if (!_Button2) {
        _Button2 = [FL_Button buttonWithType:UIButtonTypeCustom];
        _Button2.frame = CGRectMake(0, 0, 60, 60);
        [_Button2 setImage:[UIImage imageNamed:@"icn_order_process_doing"] forState:UIControlStateNormal];
        [_Button2 setImage:[UIImage imageNamed:@"icn_order_process_done"] forState:UIControlStateSelected];
        [_Button2 setTitle:@"等待到账" forState:UIControlStateNormal];
        [_Button2 setTitle:@"到账成功" forState:UIControlStateSelected];
        [_Button2 setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [_Button2 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        //样式
        _Button2.status = FLAlignmentStatusTop;
        _Button2.fl_padding = 10;
        _Button2.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _Button2;
}
@end
