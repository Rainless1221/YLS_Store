//
//  RoomsView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RoomsView.h"

@implementation RoomsView
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
    label_1.text = @"房间信息";
    [self addSubview:label_1];
    
    /*line*/
    UIView *line_1 = [[UIView alloc] init];
    line_1.frame = CGRectMake(10,60,self.BaseView_1.width-20,0.5);
    line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_1 addSubview:line_1];
    
    UIView *line_11 = [[UIView alloc] init];
    line_11.frame = CGRectMake(10,line_1.bottom+60,self.BaseView_1.width-20,0.5);
    line_11.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_1 addSubview:line_11];
    
    
   
    
    [self.BaseView_1 addSubview:self.RoomsLabel_1];
    [self.BaseView_1 addSubview:self.RoomsLabel_2];
    [self.RoomsLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(38);
        make.right.mas_offset(-84);
        make.height.mas_offset(13);
    }];
    
    [self.RoomsLabel_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line_1.mas_bottom).offset(38);
        make.right.mas_offset(-84);
        make.height.mas_offset(13);
    }];
    
    [self.BaseView_1 addSubview:self.Roomstype_1];
    [self.BaseView_1 addSubview:self.Roomstype_2];
    [self.BaseView_1 addSubview:self.Roomstype_3];
    [self.Roomstype_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    [self.Roomstype_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.equalTo(line_1.mas_bottom).offset(0);
        make.height.mas_offset(50);
    }];
    [self.Roomstype_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.equalTo(line_11.mas_bottom).offset(0);
        make.height.mas_offset(50);
    }];
    
    
    NSArray *labelArr = @[@"房间信息",@"房间设施",@"房间照片"];
    
    for (int i =0; i<labelArr.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*60,100,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr[i]];
        [self.BaseView_1 addSubview:label_1];
        
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(self.BaseView_1.width - 20, 20+i*60, 6, 10)];
        icon.image = [UIImage imageNamed:@"ico_arrow_right_black"];
        [self.BaseView_1 addSubview:icon];
        
        
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = CGRectMake(0, i*60, self.BaseView_1.width, 60);
        [Button addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        Button.tag = i+10;
//        Button.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.3];
        [self.BaseView_1 addSubview:Button];
        
    }
    
#pragma mark ----------------------
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(15,self.BaseView_1.bottom+20,100,14.5);
    label_2.numberOfLines = 0;
    label_2.text = @"预定设置";
    [self addSubview:label_2];

    /*line*/
    UIView *line_2 = [[UIView alloc] init];
    line_2.frame = CGRectMake(10,60,self.BaseView_2.width-20,0.5);
    line_2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_2 addSubview:line_2];
    
    UIView *line_22 = [[UIView alloc] init];
    line_22.frame = CGRectMake(10,line_2.bottom+60,self.BaseView_2.width-20,0.5);
    line_22.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_2 addSubview:line_22];

    
    

    [self.BaseView_2 addSubview:self.RoomsLabel_3];
    [self.BaseView_2 addSubview:self.RoomsLabel_4];
    [self.BaseView_2 addSubview:self.RoomsLabel_5];
    [self.RoomsLabel_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(38);
        make.right.mas_offset(-84);
        make.height.mas_offset(13);
    }];
    [self.RoomsLabel_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line_2.mas_bottom).offset(38);
        make.right.mas_offset(-84);
        make.height.mas_offset(13);
    }];
    [self.RoomsLabel_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line_22.mas_bottom).offset(38);
        make.right.mas_offset(-84);
        make.height.mas_offset(13);
    }];
    
    
    [self.BaseView_2 addSubview:self.Roomstype_4];
    [self.BaseView_2 addSubview:self.Roomstype_5];
    [self.BaseView_2 addSubview:self.Roomstype_6];
    [self.Roomstype_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    [self.Roomstype_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.equalTo(line_2.mas_bottom).offset(0);
        make.height.mas_offset(50);
    }];
    [self.Roomstype_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.equalTo(line_22.mas_bottom).offset(0);
        make.height.mas_offset(50);
    }];
    
    
    NSArray *labelArr_1 = @[@"定价",@"预定规则",@"优惠促销（选填）"];
    
    for (int i =0; i<labelArr.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*60,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_1[i]];
        [self.BaseView_2 addSubview:label_1];
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(self.BaseView_1.width - 20, 20+i*60, 6, 10)];
        icon.image = [UIImage imageNamed:@"ico_arrow_right_black"];
        [self.BaseView_2 addSubview:icon];
        
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = CGRectMake(0, i*60, self.BaseView_1.width, 60);
        [Button addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        Button.tag = i+20;
//        Button.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.3];
        [self.BaseView_2 addSubview:Button];
    }
    
#pragma mark ----------------------

    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(15,self.BaseView_2.bottom+20,100,14.5);
    label_3.numberOfLines = 0;
    label_3.text = @"标签";
    [self addSubview:label_3];
    

    UILabel *label_33 = [[UILabel alloc] init];
    label_33.frame = CGRectMake(10,15,150,14.5);
    label_33.numberOfLines = 0;
    label_33.font = [UIFont systemFontOfSize:15];
    label_33.text = @"商品标签";
    [self.BaseView_3 addSubview:label_33];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(self.BaseView_1.width - 20, 20, 6, 10)];
    icon.image = [UIImage imageNamed:@"ico_arrow_right_black"];
    [self.BaseView_3 addSubview:icon];
    
    
}


#pragma mark - 选择
-(void)BtnAction:(UIButton *)sender{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(Fill:)]) {
        [self.delagate Fill:sender];
    }
    
}
#pragma mark - 懒加载
-(UIView *)BaseView_1{
    if (!_BaseView_1) {
        _BaseView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, 49, ScreenW-30, 243)];
        _BaseView_1.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_1;
}
-(UIView *)BaseView_2{
    if (!_BaseView_2) {
        _BaseView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_1.bottom+49, ScreenW-30, 180)];
        _BaseView_2.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_2;
}
-(UIView *)BaseView_3{
    if (!_BaseView_3) {
        _BaseView_3 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_2.bottom+49, ScreenW-30, 50)];
        _BaseView_3.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_3;
}
-(UILabel *)RoomsLabel_1{
    if (!_RoomsLabel_1) {
        _RoomsLabel_1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 13)];
        _RoomsLabel_1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _RoomsLabel_1.font = [UIFont systemFontOfSize:12];
        _RoomsLabel_1.text = @"暂无";
    }
    return _RoomsLabel_1;
}
-(UILabel *)RoomsLabel_2{
    if (!_RoomsLabel_2) {
        _RoomsLabel_2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 13)];
        _RoomsLabel_2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _RoomsLabel_2.font = [UIFont systemFontOfSize:12];
        _RoomsLabel_2.text = @"暂无";
    }
    return _RoomsLabel_2;
}
-(UILabel *)RoomsLabel_3{
    if (!_RoomsLabel_3) {
        _RoomsLabel_3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 13)];
        _RoomsLabel_3.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _RoomsLabel_3.font = [UIFont systemFontOfSize:12];
        _RoomsLabel_3.text = @"暂无";
    }
    return _RoomsLabel_3;
}
-(UILabel *)RoomsLabel_4{
    if (!_RoomsLabel_4) {
        _RoomsLabel_4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 13)];
        _RoomsLabel_4.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _RoomsLabel_4.font = [UIFont systemFontOfSize:12];
        _RoomsLabel_4.text = @"暂无";
    }
    return _RoomsLabel_4;
}
-(UILabel *)RoomsLabel_5{
    if (!_RoomsLabel_5) {
        _RoomsLabel_5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 13)];
        _RoomsLabel_5.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _RoomsLabel_5.font = [UIFont systemFontOfSize:12];
        _RoomsLabel_5.text = @"暂无";
    }
    return _RoomsLabel_5;
}
-(UILabel *)Roomstype_1{
    if (!_Roomstype_1) {
        _Roomstype_1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 50)];
        _Roomstype_1.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Roomstype_1.font = [UIFont systemFontOfSize:12];
        _Roomstype_1.text = @"待完成";
    }
    return _Roomstype_1;
}
-(UILabel *)Roomstype_2{
    if (!_Roomstype_2) {
        _Roomstype_2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 50)];
        _Roomstype_2.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Roomstype_2.font = [UIFont systemFontOfSize:12];
        _Roomstype_2.text = @"待完成";
    }
    return _Roomstype_2;
}
-(UILabel *)Roomstype_3{
    if (!_Roomstype_3) {
        _Roomstype_3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 50)];
        _Roomstype_3.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Roomstype_3.font = [UIFont systemFontOfSize:12];
        _Roomstype_3.text = @"待完成";
    }
    return _Roomstype_3;
}
-(UILabel *)Roomstype_4{
    if (!_Roomstype_4) {
        _Roomstype_4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 50)];
        _Roomstype_4.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Roomstype_4.font = [UIFont systemFontOfSize:12];
        _Roomstype_4.text = @"待完成";
    }
    return _Roomstype_4;
}
-(UILabel *)Roomstype_5{
    if (!_Roomstype_5) {
        _Roomstype_5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 50)];
        _Roomstype_5.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Roomstype_5.font = [UIFont systemFontOfSize:12];
        _Roomstype_5.text = @"待完成";
    }
    return _Roomstype_5;
}
-(UILabel *)Roomstype_6{
    if (!_Roomstype_6) {
        _Roomstype_6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 38, ScreenW-130, 50)];
        _Roomstype_6.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Roomstype_6.font = [UIFont systemFontOfSize:12];
        _Roomstype_6.text = @"待完成";
    }
    return _Roomstype_6;
}
@end
