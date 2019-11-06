//
//  CalendarView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/10.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"//一款开源iOS日历控件

@interface CalendarView : UIView <FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
/** 日历 **/
@property (weak, nonatomic) FSCalendar *calendar;

@property (strong,nonatomic)UIView * BaseView;

@property (nonatomic, copy) void(^calendarBlock)(NSInteger day,NSInteger year,NSInteger month);
@property (nonatomic, copy) void(^DetermineBlock)(void);

@end
