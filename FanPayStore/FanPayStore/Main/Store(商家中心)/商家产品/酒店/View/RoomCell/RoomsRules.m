//
//  RoomsRules.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RoomsRules.h"

@implementation RoomsRules
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
    label_1.text = @"预定规则";
    [self addSubview:label_1];
    
    /*line*/
//    UIView *line_1 = [[UIView alloc] init];
//    line_1.frame = CGRectMake(10,50,self.BaseView_1.width-20,0.5);
//    line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
//    [self.BaseView_1 addSubview:line_1];
//
    
    NSArray *labelArr_1 = @[@"预定方式",@"最少预定天数",@"最多预定天数",@"当天预定时间"];
    
    for (int i =0; i<labelArr_1.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_1[i]];
        [self.BaseView_1 addSubview:label_1];
        
        UIView *line_1 = [[UIView alloc] init];
        line_1.frame = CGRectMake(10,50*i,self.BaseView_1.width-20,0.5);
        line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [self.BaseView_1 addSubview:line_1];
    }
    
    [self.BaseView_1 addSubview:self.Rules_1];
    [self.Rules_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(124);
        make.right.mas_offset(-25);
        make.height.mas_offset(50);
    }];
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(self.BaseView_1.width - 125, 50, 115, 50)];
    numberButton.delegate = self;
    // 初始化时隐藏减按钮
    numberButton.decreaseHide = NO;
    numberButton.increaseImage = [UIImage imageNamed:@"increase_eleme"];
    numberButton.decreaseImage = [UIImage imageNamed:@"decrease_meituan"];
    
    numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
        NSLog(@"%f",number);
    };
    [self.BaseView_1 addSubview:numberButton];
    
    
    
#pragma mark ----------------------
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(15,self.BaseView_1.bottom+20,100,14.5);
    label_2.numberOfLines = 0;
    label_2.text = @"入离时间";
    [self addSubview:label_2];
    
    UIView *line_2 = [[UIView alloc] init];
    line_2.frame = CGRectMake(10,50,self.BaseView_1.width-20,0.5);
    line_2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_2 addSubview:line_2];
    
    NSArray *labelArr_2 = @[@"最早入住时间",@"最晚入住时间",@"最晚入住时间"];
    
    for (int i =0; i<labelArr_2.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_2[i]];
        [self.BaseView_2 addSubview:label_1];
        
        UIView *line_1 = [[UIView alloc] init];
        line_1.frame = CGRectMake(10,50*i,self.BaseView_1.width-20,0.5);
        line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [self.BaseView_2 addSubview:line_1];
        
        UIImageView *icon_1 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW-46, 20+51*i, 6, 10)];
        icon_1.image = [UIImage imageNamed:@"ico_arrow_right_black"];
        [self.BaseView_2 addSubview:icon_1];
        
    }
    
    [self.BaseView_2 addSubview:self.Rules_2];
    [self.BaseView_2 addSubview:self.Rules_3];
    [self.BaseView_2 addSubview:self.Rules_4];
    [self.Rules_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(124);
        make.right.mas_offset(-25);
        make.height.mas_offset(50);
    }];
    [self.Rules_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Rules_2.mas_bottom).offset(0);
        make.left.mas_offset(124);
        make.right.mas_offset(-25);
        make.height.mas_offset(50);
    }];
    [self.Rules_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Rules_3.mas_bottom).offset(0);
        make.left.mas_offset(124);
        make.right.mas_offset(-25);
        make.height.mas_offset(50);
    }];
    
#pragma mark ----------------------
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(15,self.BaseView_2.bottom+20,100,14.5);
    label_3.numberOfLines = 0;
    label_3.text = @"入离时间";
    [self addSubview:label_3];
    
    NSArray *labelArr_3 = @[@"对房客要求",@"给预定房客留言"];
    
    for (int i =0; i<labelArr_3.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_3[i]];
        [self.BaseView_3 addSubview:label_1];
        
        UIView *line_1 = [[UIView alloc] init];
        line_1.frame = CGRectMake(10,50*i,self.BaseView_1.width-20,0.5);
        line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [self.BaseView_3 addSubview:line_1];
        
        UIImageView *icon_1 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW-46, 20+51*i, 6, 10)];
        icon_1.image = [UIImage imageNamed:@"ico_arrow_right_black"];
        [self.BaseView_3 addSubview:icon_1];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*50, self.BaseView_3.width, 50);
        [button addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [self.BaseView_3 addSubview:button];
        
    }
    
    
}
#pragma mark - 要求/留言
-(void)BtnAction:(UIButton *)sender{
    if (self.delagate && [self.delagate respondsToSelector:@selector(rulesAtion:)]) {
        [self.delagate rulesAtion:sender];
    }
    
}
#pragma mark - 懒加载
-(UIView *)BaseView_1{
    if (!_BaseView_1) {
        _BaseView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, 49, ScreenW-30, 202)];
        _BaseView_1.backgroundColor = [UIColor whiteColor];
        _BaseView_1.layer.cornerRadius = 5;
    }
    return _BaseView_1;
}
-(UIView *)BaseView_2{
    if (!_BaseView_2) {
        _BaseView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_1.bottom+49, ScreenW-30, 151)];
        _BaseView_2.backgroundColor = [UIColor whiteColor];
        _BaseView_2.layer.cornerRadius = 5;
    }
    return _BaseView_2;
}
-(UIView *)BaseView_3{
    if (!_BaseView_3) {
        _BaseView_3 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_2.bottom+49, ScreenW-30, 101)];
        _BaseView_3.backgroundColor = [UIColor whiteColor];
        _BaseView_3.layer.cornerRadius = 5;
    }
    return _BaseView_3;
}
-(UITextField *)Rules_1{
    if (!_Rules_1) {
        _Rules_1 = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _Rules_1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _Rules_1.font = [UIFont systemFontOfSize:14];
        _Rules_1.placeholder = @"请选择提前预定时间";
    }
    return _Rules_1;
}
-(UITextField *)Rules_2{
    if (!_Rules_2) {
        _Rules_2 = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _Rules_2.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _Rules_2.font = [UIFont systemFontOfSize:14];
        _Rules_2.placeholder = @"请选择最早入住时间";
    }
    return _Rules_2;
}
-(UITextField *)Rules_3{
    if (!_Rules_3) {
        _Rules_3 = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _Rules_3.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _Rules_3.font = [UIFont systemFontOfSize:14];
        _Rules_3.placeholder = @"请选择最晚入住时间";
    }
    return _Rules_3;
}
-(UITextField *)Rules_4{
    if (!_Rules_4) {
        _Rules_4 = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _Rules_4.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _Rules_4.font = [UIFont systemFontOfSize:14];
        _Rules_4.placeholder = @"请选择最晚退房时间";
    }
    return _Rules_4;
}
@end
