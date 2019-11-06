//
//  prefeZView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "prefeZView.h"

@implementation prefeZView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setViews];
        
    
    }
    return self;
}
- (void)setViews{
    
    CGFloat widrh =  (self.frame.size.width-150)/2;
    //年
    self.yearPicker = [[UIPickerView alloc]init];
    self.yearPicker.delegate = self;
    self.yearPicker.dataSource = self;
    [self addSubview:self.yearPicker];
    [self.yearPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(widrh);
        make.width.offset(50);
        make.height.offset(140);
    }];
    
    
    UIView *yuan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    yuan.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    yuan.layer.cornerRadius = 5;
    [self addSubview:yuan];
    [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    //月
    self.monthPicker = [[UIPickerView alloc]init];
    self.monthPicker.delegate = self;
    self.yearPicker.dataSource = self;
    [self addSubview:self.monthPicker];
    [self.monthPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo(self.yearPicker.mas_right).offset(50);
        make.width.offset(50);
        make.height.offset(140);
    }];
    
    
    
    
    
    
    
}
#pragma mark - pickerView的delegate方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == self.yearPicker) {
        [self.monthPicker reloadAllComponents];
        //        [self.dayPicker reloadAllComponents];
    }else if (pickerView == self.monthPicker){
//        [self.dayPicker reloadAllComponents];
    }else{
        
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.yearPicker) {
        
        return 6;
        
    }else if (pickerView == self.monthPicker){
        return 10;
    }else{
        return 0;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *rowLabel = [[UILabel alloc]init];
    rowLabel.textAlignment = NSTextAlignmentCenter;
    //    rowLabel.backgroundColor = [UIColor whiteColor];
    rowLabel.frame = CGRectMake(0, 0, 50,self.frame.size.width);
    rowLabel.textAlignment = NSTextAlignmentCenter;
    rowLabel.font = [UIFont systemFontOfSize:25];
    rowLabel.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    
    if (pickerView == self.yearPicker) {
        
        [pickerView.subviews[1] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
        [pickerView.subviews[2] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
        [pickerView.subviews[1] setFrame:CGRectMake(0 , 48, 50, 2)];
        [pickerView.subviews[2] setFrame:CGRectMake(0, 96, 50, 2)];
        [rowLabel sizeToFit];
        
        rowLabel.text = [NSString stringWithFormat:@"%.1ld",row % 10 +1];
        
    }else if (pickerView == self.monthPicker){
        [pickerView.subviews[1] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
        [pickerView.subviews[2] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
        [pickerView.subviews[1] setFrame:CGRectMake(0 , 48, 50, 2)];
        [pickerView.subviews[2] setFrame:CGRectMake(0, 96, 50, 2)];
        [rowLabel sizeToFit];
        
        rowLabel.text = [NSString stringWithFormat:@"%.1ld",row % 10 ];
    }
    
    
    
    return rowLabel;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 48;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 64;
    
}
@end
