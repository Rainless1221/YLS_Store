//
//  prefeTimeView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "prefeTimeView.h"

@implementation prefeTimeView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setViews];
        
      
    }
    return self;
}
- (void)setViews{
    CGFloat widrh =  (self.frame.size.width-180)/2;

    self.pickerView = [[UIPickerView alloc]init];
//    self.pickerView.backgroundColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(widrh);
        make.width.offset(180);
        make.height.offset(140);
    }];
    
    NSCalendar *calendar0 = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps  = [calendar0 components:unitFlags fromDate:[NSDate date]];
    NSInteger year=[comps year];
    
    startYear=year;
    yearRange=200;
    
    [self setCurrentDate:[NSDate date]];
  
    
    
  
    
}
//默认时间的处理
-(void)setCurrentDate:(NSDate *)currentDate
{
    //获取当前时间
    NSCalendar *calendar0 = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps  = [calendar0 components:unitFlags fromDate:[NSDate date]];
    
    NSInteger year=[comps year];
    NSInteger month=[comps month];
    NSInteger day=[comps day];
    NSInteger hour=[comps hour];
    NSInteger minute=[comps minute];
    NSInteger second=[comps second];
    
    selectedYear=year;
    selectedMonth=month;
    selectedDay=day;
    selectedHour=hour;
    selectedMinute=minute;
    selectedSecond =second;
    
    dayRange = [self isAllDay:year andMonth:month];

    [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
    [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
    [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
    
    
    [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
    [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
    [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
    
}
#pragma mark - 选择对应月份的天数
-(NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month
{
    int day=0;
    switch(month)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
            if(((year%4==0)&&(year%100!=0))||(year%400==0))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}
#pragma mark - pickerView的delegate方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
        {
            selectedYear=startYear + row;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [self.pickerView reloadComponent:2];
        }
            break;
        case 1:
        {
            selectedMonth=row+1;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [self.pickerView reloadComponent:2];
        }
            break;
        case 2:
        {
            selectedDay=row+1;
        }
            break;
            
        default:
            break;
    }
    _Year = [NSString stringWithFormat:@"%ld",selectedYear];
    _Month = [NSString stringWithFormat:@"%.2ld",selectedMonth];
    _Day = [NSString stringWithFormat:@"%.2ld",selectedDay];
    _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld",selectedYear,selectedMonth,selectedDay];
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            return yearRange;
        }
            break;
        case 1:
        {
            return 12;
        }
            break;
        case 2:
        {
            return dayRange;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *rowLabel = [[UILabel alloc]init];
    rowLabel.textAlignment = NSTextAlignmentCenter;
    //    rowLabel.backgroundColor = [UIColor whiteColor];
    rowLabel.frame = CGRectMake(0, 0, 39,self.frame.size.width);
    rowLabel.textAlignment = NSTextAlignmentCenter;
    rowLabel.font = [UIFont systemFontOfSize:25];
    rowLabel.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    [pickerView.subviews[1] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
    [pickerView.subviews[2] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
    [pickerView.subviews[1] setFrame:CGRectMake(0, 48, self.pickerView.frame.size.width, 1.0)];
    [pickerView.subviews[2] setFrame:CGRectMake(0, 96, self.pickerView.frame.size.width, 1.0)];
    [rowLabel sizeToFit];
    
    switch (component) {
        case 0:
        {
            rowLabel.text=[NSString stringWithFormat:@"%ld",(long)(startYear + row)];
        }
            break;
        case 1:
        {
            rowLabel.text=[NSString stringWithFormat:@"%ld",(long)row+1];
        }
            break;
        case 2:
        {
            
            rowLabel.text=[NSString stringWithFormat:@"%ld",(long)row+1];
        }
            break;
            
        default:
            break;
    }
    
    return rowLabel;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 48;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
        {
            return 64;
        }
            break;
        case 1:
        {
            return 50;
            break;
        case 2:
            {
                
                return 50;
            }
            break;
            
        default:
            break;
            
        }
    }
    return 0;
    
}

@end
