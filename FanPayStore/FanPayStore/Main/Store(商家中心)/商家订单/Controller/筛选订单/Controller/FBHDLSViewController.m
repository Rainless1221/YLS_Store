//
//  FBHDLSViewController.m
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHDLSViewController.h"

@interface FBHDLSViewController ()<UIScrollViewDelegate,zyyyDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)DDLSView * scrollView;
@property (strong,nonatomic)NSString * AorEstr;
@end

@implementation FBHDLSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商家订单历史";

    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
    
    
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    
    self.scrollView.adeTime.text = [NSString stringWithFormat:@"%02ld-%02ld-%02ld",(long)comp.year,(long)comp.month,(long)comp.day];
    self.scrollView.endTime.text = [NSString stringWithFormat:@"%02ld-%02ld-%02ld",(long)comp.year,(long)comp.month,(long)comp.day];
    
}
#pragma mark -- 选择当天/七天/一月
-(void)dateTime:(UIButton *)Btn{
    //当前时间
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp1 = [gregorian components: unitFlags
                                           fromDate:dt];
    
    
    NSDate *appointDate;
    NSTimeInterval oneDay = 24 * 60 * 60;
    switch (Btn.tag) {
        case 10:
            appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * 0)];
            
            break;
        case 11:
            appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * -7)];
            
            break;
        case 12:
            appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * -30)];
            
            break;
        case 13:
            appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * -90)];
            
            break;
        case 14:
            appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * -180)];
            
            break;
        case 15:
            appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * -30*12)];
            
            break;
        default:
            break;
    }
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:appointDate];
    
    self.scrollView.adeTime.text = [NSString stringWithFormat:@"%02ld-%02ld-%02ld ",(long)comp.year,(long)comp.month,(long)comp.day];
    self.scrollView.endTime.text = [NSString stringWithFormat:@"%02ld-%02ld-%02ld ",(long)comp1.year,(long)comp1.month,(long)comp1.day];
    
}
#pragma mark - 日历
-(void)setFSCalendar{
    CalendarView *tipview = [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    tipview.calendarBlock = ^(NSInteger day, NSInteger year, NSInteger month) {
        
        if ([self.AorEstr isEqualToString:@"ade"]) {
            self.scrollView.adeTime.text = [NSString stringWithFormat:@"%02ld-%02ld-%02ld",year,month,day];
        }else{
            self.scrollView.endTime.text = [NSString stringWithFormat:@"%02ld-%02ld-%02ld",year,month,day];
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:tipview];
}

#pragma mark - zyyyDelegate (选择的时间)
-(void)moveImageBtnClick:(zyyy_DateListView *)Zview andData:(NSDictionary *)Dict{
    if ([self.AorEstr isEqualToString:@"ade"]) {
        self.scrollView.adeTime.text = [NSString stringWithFormat:@"%@-%@-%@",Dict[@"year"],Dict[@"month"],Dict[@"day"]];
    }else{
        self.scrollView.endTime.text = [NSString stringWithFormat:@"%@-%@-%@",Dict[@"year"],Dict[@"month"],Dict[@"day"]];
    }
    
}
-(void)TimeAction:(UIButton *)Btn{
    if (Btn.tag == 1) {
        self.AorEstr = @"ade";
    }else{
        self.AorEstr = @"end";
    }
    
    [self setFSCalendar];
    
}

#pragma mark - Get
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 735);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}

-(DDLSView *)scrollView{
    if (!_scrollView) {
        _scrollView =
        [[NSBundle mainBundle] loadNibNamed:@"DDLSView" owner:nil options:nil][0];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 735);
        YBWeakSelf
        _scrollView.TimeBlock = ^(UIButton *btn) {
            [weakSelf TimeAction:btn];
        };
        _scrollView.KuaiTimeBlock = ^(UIButton *btn) {
            [weakSelf dateTime:btn];
        };
        //开始筛选
        _scrollView.DataTimeBlock = ^{
//            [PublicMethods writeToUserD:weakSelf.scrollView.adeTime.text andKey:@"adeTime"];
//            [PublicMethods writeToUserD:weakSelf.scrollView.endTime.text andKey:@"endTime"];
            
            NSString *adetime = [NSString stringWithFormat:@"%@",weakSelf.scrollView.adeTime.text ];
            NSString *endTime = [NSString stringWithFormat:@"%@",weakSelf.scrollView.endTime.text ];
            NSArray *arr = @[adetime,endTime];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"adeOrendTime" object:arr];

            
            
            for (UIViewController *controller in weakSelf.navigationController.viewControllers) {
                if ([controller isKindOfClass:[FBHOrderViewController class]]) {
                    [weakSelf.navigationController popToViewController:controller animated:YES];
                }
            }
            
        };
    }
    return _scrollView;
}

@end
