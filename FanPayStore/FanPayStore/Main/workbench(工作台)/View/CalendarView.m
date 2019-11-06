//
//  CalendarView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/10.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.BaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        /** 背景颜色 */
        self.BaseView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.55];
        [self addSubview:self.BaseView];
        /** 视图点击 */
//        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//        [self.BaseView addGestureRecognizer:tapGesturRecognizer];
        
        
        
        
        
        UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 450)];
        baseView.backgroundColor = [UIColor whiteColor];
        baseView.layer.cornerRadius = 10;
        baseView.layer.masksToBounds = YES;
        [self.BaseView addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(108);
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.height.mas_offset(450);
        }];
        
        /** 日历控件 */
        FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 5, baseView.width, 370)];
        calendar.dataSource = self;
        calendar.delegate = self;
        calendar.backgroundColor = [UIColor whiteColor];
        calendar.appearance.headerDateFormat = @"yyyy年MM月";
        calendar.appearance.headerTitleColor = UIColorFromRGB(0x222222);
        calendar.appearance.weekdayTextColor = UIColorFromRGB(0x999999);
        //    calendar.firstWeekday = 0;
        calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
        //
        calendar.appearance.headerMinimumDissolvedAlpha = 0;
        //隐藏底部分割线
//        calendar.bottomBorder.hidden = YES;
        // 分割线
        calendar.appearance.separators = FSCalendarSeparatorNone;
        calendar.clipsToBounds = YES;
        
        
        calendar.appearance.todayColor = [UIColor clearColor];
        calendar.appearance.titleTodayColor = UIColorFromRGB(0x222222);
        [calendar selectDate:[NSDate date]]; // 设置默认选中日期是今天
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
        calendar.locale = locale;  // 设置周次是中文显示
        
        [baseView addSubview:calendar];
        self.calendar = calendar;
        
        //创建点击跳转显示上一月和下一月button
        UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        previousButton.frame = CGRectMake(calendar.centerX - 50 -50, 15, 45, 18);
        previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [previousButton setImage:[UIImage imageNamed:@"icn_calendar_month_prev"] forState:UIControlStateNormal];
        [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [calendar addSubview:previousButton];
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nextButton.frame = CGRectMake(calendar.centerX + 50, 15, 45, 18);
        nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [nextButton setImage:[UIImage imageNamed:@"icn_calendar_month_next"] forState:UIControlStateNormal];
        /** 旋转 */
        //    nextButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
        [calendar addSubview:nextButton];

        
        
        /**
         * 选择按钮
         **/
        UIButton *determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [determineButton setTitle:@"确定选择" forState:UIControlStateNormal];
        [determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [determineButton setBackgroundColor:UIColorFromRGB(0x4792FF)];
        [determineButton addTarget:self action:@selector(DetermineAction) forControlEvents:UIControlEventTouchUpInside];
        determineButton.layer.cornerRadius = 10;
        [baseView addSubview:determineButton];
        [determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(30);
            make.right.mas_offset(-30);
            make.bottom.mas_offset(-13);
            make.height.mas_offset(44);
        }];
        
    }
    return self;
}
//上一月按钮点击事件
- (void)previousClicked:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.calendar dateBySubstractingMonths:1 fromDate:currentMonth];
    [self.calendar setCurrentPage:previousMonth animated:YES];
    
}
//下一月按钮点击事件
- (void)nextClicked:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.calendar dateByAddingMonths:1 toDate:currentMonth];
    [self.calendar setCurrentPage:nextMonth animated:YES];
    
}
//选中某一天进行相关操作
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
     NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
   NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
//    [self.dateAry addObject:date];
    [calendar reloadData];
    NSInteger day = [gregorian component:NSCalendarUnitDay fromDate:date];
    NSInteger year = [gregorian component:NSCalendarUnitYear fromDate:date];
    NSInteger month = [gregorian component:NSCalendarUnitMonth fromDate:date];
//    [self.monthAndDayAry addObject:[NSString stringWithFormat:@"%02ld%02ld",month,day]];
    NSLog(@"did select %@,%02ld,%02ld,%2ld,",[dateFormatter stringFromDate:date],day,month,year);
    if (self.calendarBlock) {
        self.calendarBlock(day, year, month);
    }
}


/** 设置高度 **/
-(void )calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated{
    
    
    
}


-(void)DetermineAction{
    if (self.DetermineBlock) {
        self.DetermineBlock();
    }
    [self removeFromSuperview];
    
}
#pragma mark - 点击背景隐藏
-(void)tapAction:(UITapGestureRecognizer *)tap{
    
//    CGPoint touchPoint = [tap locationInView:self.BaseView];
//
//    CGRect userHeaderImageRect = [self convertRect:self.BaseView.bounds fromView:self.BaseView];
//
//    if (CGRectContainsPoint(userHeaderImageRect, touchPoint)) {
//
//        return;
//    }
    [self removeFromSuperview];
    
    
}
#pragma mark - GET

@end
