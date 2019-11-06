//
//  TotalRevenue.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/9.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "TotalRevenue.h"

@implementation TotalRevenue

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    [self addSubview:self.logoimage];
    [self addSubview:self.Store_Name];
    [self addSubview:self.Store_day];
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(ScreenW-30-75, self.Store_day.bottom, 65, 24);
    label_1.numberOfLines = 0;
    label_1.textColor = UIColorFromRGB(0x222222);
    label_1.font = [UIFont systemFontOfSize:13] ;
    label_1.text = @"工作日";
    label_1.textAlignment = 2;
    [self addSubview:label_1];
    
    /*line*/
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, self.logoimage.bottom+15, self.width-20, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:line];
    
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(10,line.bottom+20,100,14.5);
    label_2.numberOfLines = 0;
    label_2.textColor = UIColorFromRGB(0x222222);
    label_2.font = [UIFont systemFontOfSize:15];
    label_2.text = @"总营收";
    [self addSubview:label_2];
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(10,label_2.bottom+72,100,12);
    label_3.numberOfLines = 0;
    label_3.textColor = UIColorFromRGB(0x999999);
    label_3.font = [UIFont systemFontOfSize:13];
    label_3.text = @"今日营收";
    [self addSubview:label_3];
    
    
    UILabel *label_4 = [[UILabel alloc] init];
    label_4.frame = CGRectMake(self.width/2,label_2.bottom+72,100,14.5);
    label_4.numberOfLines = 0;
    label_4.textColor = UIColorFromRGB(0x999999);
    label_4.font = [UIFont systemFontOfSize:13];
    label_4.text = @"同比昨日增长";
    [self addSubview:label_4];
    
    
    
    [self addSubview:self.Store_revenue1];
    [self addSubview:self.Store_revenue2];
    [self addSubview:self.Store_revenue3];

    [self.Store_revenue1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_2.mas_bottom).offset(15);
        make.right.mas_offset(0);
        make.left.mas_offset(10);
        make.height.mas_offset(25);
    }];
    
    
    [self.Store_revenue2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_3.mas_bottom).offset(15);
        make.right.mas_offset(0);
        make.left.mas_offset(10);
        make.height.mas_offset(25);
    }];
    
    [self.Store_revenue3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_3.mas_bottom).offset(15);
        make.right.mas_offset(0);
        make.left.equalTo(label_4.mas_left).offset(0);
        make.height.mas_offset(25);
    }];
    
    self.Store_Name.text  = @"大房子创意菜";
    self.Store_day.text  = @"168";
    self.Store_revenue1.text = @"164652.00";
    self.Store_revenue2.text = @"2756.00";
    [self.Store_revenue3 setTitle:@"12.2%" forState:UIControlStateNormal];

    
}

#pragma mark - 懒加载
- (UIImageView *)logoimage{
    if (!_logoimage) {
        _logoimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 52, 52)];
        _logoimage.image = [UIImage imageNamed:@"register_empty_avatar"];
        _logoimage.layer.cornerRadius = 26;
    }
    return _logoimage;
}
-(UILabel *)Store_Name{
    if (!_Store_Name) {
        _Store_Name = [[UILabel alloc]initWithFrame:CGRectMake(self.logoimage.right+12, 20, 150, 15)];
        _Store_Name.font = [UIFont systemFontOfSize:15];
        _Store_Name.textColor = UIColorFromRGB(0x222222);
    }
    return _Store_Name;
}
-(UILabel *)Store_day{
    if (!_Store_day) {
        _Store_day = [[UILabel alloc]initWithFrame:CGRectMake(self.right-75, 20, 65, 24)];
        _Store_day.font = [UIFont systemFontOfSize:32];
        _Store_day.textColor = UIColorFromRGB(0x222222);
    }
    return _Store_day;
}
-(UILabel *)Store_revenue1{
    if (!_Store_revenue1) {
        _Store_revenue1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.width, 24)];
        _Store_revenue1.textColor = UIColorFromRGB(0xF7AE2A);
        _Store_revenue1.font = [UIFont systemFontOfSize:32];
        _Store_revenue1.numberOfLines = 0;

    }
    return _Store_revenue1;
}
-(UILabel *)Store_revenue2{
    if (!_Store_revenue2) {
        _Store_revenue2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.width, 24)];
        _Store_revenue2.textColor = UIColorFromRGB(0x3D8AFF);
        _Store_revenue2.font = [UIFont systemFontOfSize:24];
        _Store_revenue2.numberOfLines = 0;
        
    }
    return _Store_revenue2;
}
-(UIButton *)Store_revenue3{
    if (!_Store_revenue3) {
        _Store_revenue3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Store_revenue3 setTitleColor:UIColorFromRGB(0x38A94D) forState:UIControlStateNormal];
        [_Store_revenue3 setTitleColor:UIColorFromRGB(0xEC4F3C) forState:UIControlStateSelected];
        [_Store_revenue3.titleLabel setFont:[UIFont systemFontOfSize:24]];
        [_Store_revenue3 setImage:[UIImage imageNamed:@"icn_revenue_decline"] forState:UIControlStateNormal];
        [_Store_revenue3 setImage:[UIImage imageNamed:@"icn_revenue_growth"] forState:UIControlStateSelected];
        _Store_revenue3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _Store_revenue3;
}
@end
