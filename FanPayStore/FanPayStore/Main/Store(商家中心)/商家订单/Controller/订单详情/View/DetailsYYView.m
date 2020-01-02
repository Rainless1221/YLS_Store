//
//  DetailsYYView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/12/18.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "DetailsYYView.h"

@implementation DetailsYYView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(44, 44));
    }];
    
    //预约时间
    [self addSubview:self.YYlabel];
    [self.YYlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.equalTo(self.icon.mas_right).offset(8);
    }];
    
    //时间
    [self addSubview:self.YYTime];
    [self.YYTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(-20);
        make.right.mas_offset(-10);
    }];
    
    
    [self addSubview:self.YYTime_T];
    [self.YYTime_T mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(5);
        make.right.mas_offset(-10);
    }];
    
}
#pragma mark - 懒加载
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"icn_booking_medium"];
    }
    return _icon;
}
-(UILabel *)YYlabel{
    if (!_YYlabel) {
        _YYlabel = [[UILabel alloc]init];
        _YYlabel.font = [UIFont systemFontOfSize:12];
        _YYlabel.text = @"预约时间";
        _YYlabel.textColor = UIColorFromRGB(0x3D8AFF);
    }
    return _YYlabel;
}
-(UILabel *)YYTime{
    if (!_YYTime) {
        _YYTime = [[UILabel alloc]init];
        _YYTime.font = [UIFont systemFontOfSize:12];
        _YYTime.textColor = UIColorFromRGB(0x3D8AFF);
        _YYTime.text = @"2019-12-12";
    }
    return _YYTime;
}
-(UILabel *)YYTime_T{
    if (!_YYTime_T) {
        _YYTime_T = [[UILabel alloc]init];
        _YYTime_T.font = [UIFont systemFontOfSize:26];
        _YYTime_T.textColor = UIColorFromRGB(0x3D8AFF);
        _YYTime_T.text = @"12:30";
    }
    return _YYTime_T;
}
@end
