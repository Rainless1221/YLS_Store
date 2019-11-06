//
//  PreferReusableView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "PreferReusableView.h"

@implementation PreferReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,15,self.width-30,140);
//    view.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0,0,self.width-30,140);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:71/255.0 green:210/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:75/255.0 green:149/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(1.0)];
//    gl.cornerRadius = 5;
//
//    [view.layer addSublayer:gl];
    
   view.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self addSubview:view];
    
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(15,12,66,11.5);
    label_1.numberOfLines = 0;
    label_1.text = @"当前折扣";
    label_1.font = [UIFont systemFontOfSize:12];
    label_1.textColor = [UIColor whiteColor];
    [view addSubview:label_1];
    
    
    FL_Button *button_Set = [FL_Button buttonWithType:UIButtonTypeCustom];
    [button_Set setTitle:@"去设置" forState:UIControlStateNormal];
    [button_Set setTitleColor:UIColorFromRGB(0xFCFDFF) forState:UIControlStateNormal];
    [button_Set setImage:[UIImage imageNamed:@"ico_arrow_right_white"] forState:UIControlStateNormal];
    button_Set.layer.borderWidth = 1;
    button_Set.layer.borderColor = UIColorFromRGB(0xFCFDFF).CGColor;
    button_Set.status = FLAlignmentStatusCenter;
    button_Set.fl_padding = 5;
    button_Set.layer.cornerRadius = 25/2;
    button_Set.titleLabel.font = [UIFont systemFontOfSize:12];
    [button_Set addTarget:self action:@selector(button_SetAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button_Set];
    [button_Set mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(12);
        make.right.mas_equalTo(-15);
        make.height.mas_offset(25);
        make.width.mas_offset(70);
    }];
    

    
    
    /*
     折扣
     */
    [view addSubview:self.label_Z];
    [self.label_Z mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(46);
        make.height.mas_offset(40);
    }];
    
    
    /*
     时间
     */
    [view addSubview:self.lable_time];
    [self.lable_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.equalTo(self.label_Z.mas_bottom).offset(16);
        make.height.mas_offset(20);
    }];
    
    
    
#pragma mark -----------
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"优惠商品";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-12);
        make.left.mas_offset(15);
    }];
    
    
    UIButton *button_guan = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_guan setImage:[UIImage imageNamed:@"icn_commodity_manage"] forState:UIControlStateNormal];
    button_guan.titleLabel.font = [UIFont systemFontOfSize:13];
    [button_guan setTitle:@" 管理" forState:UIControlStateNormal];
    [button_guan addTarget:self action:@selector(Guan_SetAction:) forControlEvents:UIControlEventTouchUpInside];
    [button_guan setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self addSubview:button_guan];
    [button_guan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_offset(0);
        make.height.mas_offset(35);
        make.width.mas_offset(80);
    }];
    
    
    NSString *protocol = [NSString stringWithFormat:@"0.0折"];
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:18]];
    NSRange ProRange = [protocol rangeOfString:@"折"];
    [attri_str setFont:[UIFont systemFontOfSize:51] range:NSMakeRange(0, 1)];
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"FFFFFF"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    self.label_Z.attributedText = attri_str;
    self.label_Z.textAlignment = 1;
    self.label_Z.textColor = [UIColor whiteColor];
}

#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    /*
     折扣
     */
    
    
    NSString *pir = [NSString stringWithFormat:@"%@",Data[@"discount"]];
    if ([[MethodCommon judgeStringIsNull:pir] isEqualToString:@""]) {
        pir = @"0.0";
    }
    NSString *protocol = [NSString stringWithFormat:@"%@折",pir];
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:18]];
    attri_str.color= [UIColor whiteColor];
    NSRange ProRange = [protocol rangeOfString:@"折"];
    [attri_str setFont:[UIFont systemFontOfSize:51] range:NSMakeRange(0, 1)];
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"FFFFFF"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    self.label_Z.attributedText = attri_str;
    self.label_Z.textAlignment = 1;
    
    /*时间*/
    NSString *bengin = [NSString stringWithFormat:@"%@",Data[@"begin_date"]];
    NSString *time = [NSString stringWithFormat:@"%@ —— %@",bengin,Data[@"end_date"]];
    if ([[MethodCommon judgeStringIsNull:bengin] isEqualToString:@""]) {
        time = @"暂无";
    }
    self.lable_time.text = [NSString stringWithFormat:@"活动时间：%@",time];
    
}


-(void)button_SetAction{
    
    if (self.SetPrefeActionBlock) {
        self.SetPrefeActionBlock();
    }
    
}
-(void)Guan_SetAction:(UIButton *)Btn{
    Btn.selected = !Btn.selected;
    
    if (self.GuanPrefeActionBlock) {
        self.GuanPrefeActionBlock(Btn);
    }
}
#pragma mark - 懒加载
-(YYLabel *)label_Z{
    if (!_label_Z) {
        _label_Z = [[YYLabel alloc]initWithFrame:CGRectMake(0, 46, self.width, 38)];
        _label_Z.textAlignment = 1;
        _label_Z.font = [UIFont systemFontOfSize:51];
        _label_Z.textColor = [UIColor whiteColor];
    }
    return _label_Z;
}
-(UILabel *)lable_time{
    if (!_lable_time) {
        _lable_time = [[UILabel alloc]initWithFrame:CGRectMake(0, 46, self.width, 38)];
        _lable_time.textAlignment = 1;
        _lable_time.font = [UIFont systemFontOfSize:12];
        _lable_time.textColor = [UIColor whiteColor];
        _lable_time.text = @"活动时间：暂无";
    }
    return _lable_time;
}
@end
