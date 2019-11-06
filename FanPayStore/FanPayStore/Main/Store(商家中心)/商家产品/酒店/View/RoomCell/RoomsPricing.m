//
//  RoomsPricing.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/15.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RoomsPricing.h"

@implementation RoomsPricing
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}

#pragma mark - UI
-(void)createUI{
    [self addSubview:self.BaseView_1];
    [self addSubview:self.BaseView_2];
    [self addSubview:self.BaseView_3];
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(15,20,100,14.5);
    label_1.numberOfLines = 0;
    label_1.text = @"基础价格";
    [self addSubview:label_1];
    
    /*line*/
    UIView *line_1 = [[UIView alloc] init];
    line_1.frame = CGRectMake(10,50,self.BaseView_1.width-20,0.5);
    line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_1 addSubview:line_1];
    
    NSArray *labelArr_1 = @[@"平日价格",@"假日价格"];
    
    for (int i =0; i<labelArr_1.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_1[i]];
        [self.BaseView_1 addSubview:label_1];
        
        UILabel *label_11 = [[UILabel alloc] init];
        label_11.frame = CGRectMake(self.BaseView_1.right-60,i*50,60,50);
        label_11.numberOfLines = 0;
        label_11.font = [UIFont systemFontOfSize:15];
        label_11.text = @"元/晚";
        [self.BaseView_1 addSubview:label_11];
        
    }
    [self.BaseView_1 addSubview:self.pricing_1];
    [self.BaseView_1 addSubview:self.pricing_2];
    [self.pricing_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(94);
        make.top.mas_offset(0);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.pricing_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(94);
        make.top.equalTo(line_1.mas_bottom).offset(0);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];

    
#pragma mark ----------------------
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(15,self.BaseView_1.bottom+20,100,14.5);
    label_2.numberOfLines = 0;
    label_2.text = @"其他费用";
    [self addSubview:label_2];
    
    UIView *line_2 = [[UIView alloc] init];
    line_2.frame = CGRectMake(10,50,self.BaseView_1.width-20,0.5);
    line_2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_2 addSubview:line_2];
    
    NSArray *labelArr_2 = @[@"是否加客",@"清洁费"];
    
    for (int i =0; i<labelArr_2.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_2[i]];
        [self.BaseView_2 addSubview:label_1];

        
    }

    NSArray *labelArr_22 = @[@"是",@"否"];
    for (int i =0; i<labelArr_22.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.BaseView_2.width-130+i*65, 0, 65, 50);
        [button setTitle:[NSString stringWithFormat:@"%@",labelArr_22[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(weiAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [self.BaseView_2 addSubview:button];
        
    }
    
    UILabel *label_22 = [[UILabel alloc] init];
    label_22.frame = CGRectMake(self.BaseView_2.right-70,self.BaseView_2.bottom,60,50);
    label_22.numberOfLines = 0;
    label_22.font = [UIFont systemFontOfSize:15];
    label_22.text = @"元";
    label_22.textAlignment = 2;
    [self.BaseView_2 addSubview:label_22];
    [label_22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.right.mas_offset(-7);
        make.size.mas_offset(CGSizeMake(40, 50));
    }];
    
    
    [self.BaseView_2 addSubview:self.pricing_5];
    [self.pricing_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(94);
        make.bottom.mas_offset(0);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    
    
#pragma mark ----------------------
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(15,self.BaseView_2.bottom+20,100,14.5);
    label_3.numberOfLines = 0;
    label_3.text = @"退订政策";
    [self addSubview:label_3];
    
    self.tuilabel = [[UILabel alloc] init];
    self.tuilabel.frame = CGRectMake(10,15,150,14.5);
    self.tuilabel.numberOfLines = 0;
    self.tuilabel.font = [UIFont systemFontOfSize:15];
    self.tuilabel.text = @"退款政策 ";
    [self.BaseView_3 addSubview:self.tuilabel];
    
    self.tuitext = [[UILabel alloc] init];
    self.tuitext.frame = CGRectMake(10,self.tuilabel.bottom+5,276,33);
    self.tuitext.numberOfLines = 0;
    self.tuitext.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.tuitext.font = [UIFont systemFontOfSize:12];
    self.tuitext.text = @"选择用户退定订单距离入住时间的周期，可获得退款的额度。";
    [self.BaseView_3 addSubview:self.tuitext];
    
    UIImageView *icon_1 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW-46, 38, 6, 10)];
    icon_1.image = [UIImage imageNamed:@"ico_arrow_right_black"];
    [self.BaseView_3 addSubview:icon_1];
    
    self.BaseView_3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [self.BaseView_3 addGestureRecognizer:tapGesturRecognizer];

}

/*是否加客*/
-(void)weiAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}
/*选退款政策*/
-(void)tapAction:(id)tap{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(TuiAtion:)]) {
        [self.delagate TuiAtion:tap];
    }
    
}
#pragma mark - 懒加载
-(UIView *)BaseView_1{
    if (!_BaseView_1) {
        _BaseView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, 49, ScreenW-30, 101)];
        _BaseView_1.backgroundColor = [UIColor whiteColor];
        _BaseView_1.layer.cornerRadius = 5;
    }
    return _BaseView_1;
}
-(UIView *)BaseView_2{
    if (!_BaseView_2) {
        _BaseView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_1.bottom+49, ScreenW-30, 101)];
        _BaseView_2.backgroundColor = [UIColor whiteColor];
        _BaseView_2.layer.cornerRadius = 5;
    }
    return _BaseView_2;
}
-(UIView *)BaseView_3{
    if (!_BaseView_3) {
        _BaseView_3 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_2.bottom+49, ScreenW-30, 85)];
        _BaseView_3.backgroundColor = [UIColor whiteColor];
        _BaseView_3.layer.cornerRadius = 5;
    }
    return _BaseView_3;
}
-(UITextField *)pricing_1{
    if (!_pricing_1) {
        _pricing_1 = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _pricing_1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _pricing_1.font = [UIFont systemFontOfSize:14];
        _pricing_1.placeholder = @"请输入非节日价格";
    }
    return _pricing_1;
}
-(UITextField *)pricing_2{
    if (!_pricing_2) {
        _pricing_2 = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _pricing_2.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _pricing_2.font = [UIFont systemFontOfSize:14];
        _pricing_2.placeholder = @"请输入周末及法定节假日价格";
    }
    return _pricing_2;
}
-(UITextField *)pricing_3{
    if (!_pricing_3) {
        _pricing_3 = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _pricing_3.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _pricing_3.font = [UIFont systemFontOfSize:14];
        _pricing_3.placeholder = @"请输入费用";
    }
    return _pricing_3;
}
-(UITextField *)pricing_4{
    if (!_pricing_4) {
        _pricing_4 = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _pricing_4.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _pricing_4.font = [UIFont systemFontOfSize:14];
        _pricing_4.placeholder = @"请输入人数";
    }
    return _pricing_4;
}
-(UITextField *)pricing_5{
    if (!_pricing_5) {
        _pricing_5 = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _pricing_5.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _pricing_5.font = [UIFont systemFontOfSize:14];
        _pricing_5.placeholder = @"请输入清洁费价格";
    }
    return _pricing_5;
}
@end
