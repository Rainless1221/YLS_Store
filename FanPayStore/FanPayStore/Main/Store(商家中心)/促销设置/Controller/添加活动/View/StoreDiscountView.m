//
//  StoreDiscountView.m
//  FanBeiHua
//
//  Created by 苹果笔记本 on 2019/4/19.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "StoreDiscountView.h"
#import "CCDatePickerView.h"


@implementation StoreDiscountView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
#pragma mark -翻呗类型
    
    UILabel *leixing = [[UILabel alloc]init];
    leixing.text = @"翻呗类型";
    leixing.textColor = UIColorFromRGB(0x282828);
    leixing.font = [UIFont systemFontOfSize:20];
    [self addSubview:leixing];
    [leixing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    [self addSubview:self.DiscountButton1];
    [self addSubview:self.DiscountButton2];
    [self.DiscountButton1 addSubview:self.Discount1];
    [self.DiscountButton2 addSubview:self.Discount2];

    [self.DiscountButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leixing.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.height.mas_offset(60);
        make.width.mas_offset((ScreenW-45)/2);
    }];
    [self.DiscountButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leixing.mas_bottom).offset(10);
        make.left.equalTo(self.DiscountButton1.mas_right).offset(15);
        make.height.mas_offset(60);
        make.width.mas_offset((ScreenW-45)/2);
    }];
    [self.Discount1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(22, 22));
    }];
    [self.Discount2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(22, 22));
    }];
    
#pragma mark -翻呗额度

    UILabel *erdu = [[UILabel alloc]init];
    erdu.text = @"翻呗额度";
    erdu.textColor = UIColorFromRGB(0x282828);
    erdu.font = [UIFont systemFontOfSize:20];
    [self addSubview:erdu];
    [erdu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leixing.mas_bottom).offset(80);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    
    self.discount_condition.text = @"1200";
    [self addSubview:self.discount_condition];
    [self.discount_condition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(erdu.mas_bottom).offset(20);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(60);
    }];
    
    //滑动条
    sliderView = [[SliderView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    sliderView.delegate = self;
    sliderView.minValue = 50;
    sliderView.value = 1200;
    sliderView.maxValue = 2050;
    sliderView.normalColor = [UIColor colorWithRed:227/255.f green:238/255.f blue:255/255.f alpha:1.0];
    sliderView.trackColors = @[(__bridge id)[UIColor colorWithRed:227/255.f green:238/255.f blue:255/255.f alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.f green:238/255.f blue:255/255.f alpha:1.0].CGColor];
    sliderView.trackSize = CGSizeMake(ScreenW-60, 20);
    sliderView.thumbSize = CGSizeMake(40, 24);
    sliderView.thumbImage = [UIImage imageNamed:@"btn_slider"];
    [self addSubview:sliderView];
    [sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.discount_condition.mas_bottom).offset(20);
        make.left.mas_offset(0);
        make.size.mas_offset(CGSizeMake(ScreenW, 65));
    }];
    
    //最大最小值
    UILabel *min = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 50, 25)];
    min.text = @"0";
    min.textColor = UIColorFromRGB(0x999999);
    [self addSubview:min];
    [min mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sliderView.mas_bottom).offset(-20);
        make.size.mas_offset(CGSizeMake(50, 25));
        make.left.mas_offset(15);
    }];
    UILabel *max = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW-65, 25, 50, 25)];
    max.text = @"2000";
    max.textColor = UIColorFromRGB(0x999999);
    [self addSubview:max];
    [max mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sliderView.mas_bottom).offset(-20);
        make.size.mas_offset(CGSizeMake(50, 25));
        make.right.mas_offset(-15);
    }];

    
    
#pragma mark -翻呗起始日期

    UILabel *Time = [[UILabel alloc]init];
    Time.text = @"翻呗起始日期";
    Time.textColor = UIColorFromRGB(0x282828);
    Time.font = [UIFont systemFontOfSize:20];
    [self addSubview:Time];
    [Time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sliderView.mas_bottom).offset(40);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    [self addSubview:self.beginView];
    [self addSubview:self.endView];

    
    [self.beginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Time.mas_bottom).offset(20);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake((ScreenW-60)/2, 50));
    }];
    [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Time.mas_bottom).offset(20);
        make.left.equalTo(self.beginView.mas_right).offset(30);
        make.size.mas_offset(CGSizeMake((ScreenW-60)/2, 50));
    }];
    
    
    [self.beginView addSubview:self.begin_date];
    [self.endView addSubview:self.end_date];
    [self.beginView addSubview:self.begin_time];
    [self.endView addSubview:self.end_time];
    [self.begin_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
        make.height.mas_offset(30);
    }];
    [self.end_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
        make.height.mas_offset(30);
    }];
    [self.begin_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.begin_date.mas_bottom).offset(0);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
        make.height.mas_offset(30);
    }];
    [self.end_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.end_date.mas_bottom).offset(0);
        make.left.mas_offset(10);
        make.right.mas_offset(0);
        make.height.mas_offset(30);
    }];
#pragma mark -翻呗商品
    UILabel *goodlabel = [[UILabel alloc]init];
    goodlabel.text = @"翻呗商品";
    goodlabel.textColor = UIColorFromRGB(0x282828);
    goodlabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:goodlabel];
    [goodlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.beginView.mas_bottom).offset(29);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    [self addSubview:self.GoodView];
    [self.GoodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodlabel.mas_bottom).offset(20);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 106));
    }];
    
    
#pragma mark -保存设置
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(15,30,ScreenW-30,44);
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW-30,44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    [Button.layer addSublayer:gl];
    
    Button.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    Button.layer.shadowOffset = CGSizeMake(0,4);
    Button.layer.shadowOpacity = 1;
    Button.layer.shadowRadius = 9;
    
    [Button setTitle:@"保存设置" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [Button addTarget:self action:@selector(ButtomAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:Button];
    [Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodView.mas_bottom).offset(30);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 44));
    }];
    
    
    
    
    
#pragma mark -温馨提醒
    UILabel *Title = [[UILabel alloc]init];
    Title.text = @"温馨提醒";
    Title.textColor = UIColorFromRGB(0x282828);
    Title.font = [UIFont systemFontOfSize:20];
    [self addSubview:Title];
    [Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Button.mas_bottom).offset(48);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    
    NSArray *titleArr = @[@"翻呗自由设置",@"翻呗开始日期设置",@"翻呗结束时间设置"];
    NSArray *tetleArr = @[@"商家可根据自身需要进行设置",@"商家可根据自身需要进行日期设置",@"商家可根据自身需要进行时间设置"];
    
    for (int i =0; i<titleArr.count; i++) {
        
        
        
        UILabel *Title1 = [[UILabel alloc]init];
        Title1.text = [NSString stringWithFormat:@"%@",titleArr[i]];
        Title1.textColor = UIColorFromRGB(0x282828);
        Title1.font = [UIFont systemFontOfSize:15];
        [self addSubview:Title1];
        [Title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Title.mas_bottom).offset(20+i*56);
            make.left.mas_offset(31);
            make.size.mas_offset(CGSizeMake(ScreenW-31, 30));
        }];
        
        UIView *yuan = [[UIView alloc]init];
        yuan.backgroundColor= UIColorFromRGB(0x3D8AFF);
        yuan.layer.cornerRadius = 3;
        yuan.layer.masksToBounds = YES;
        [self addSubview:yuan];
        [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.equalTo(Title1.mas_centerY).offset(0);
            make.size.mas_offset(CGSizeMake(6, 6));
            
        }];
    }
    
    
    for (int i =0; i<tetleArr.count; i++) {
        
        UILabel *Title1 = [[UILabel alloc]init];
        Title1.text = [NSString stringWithFormat:@"%@",tetleArr[i]];
        Title1.textColor = UIColorFromRGB(0x999999);
        Title1.font = [UIFont systemFontOfSize:13];
        [self addSubview:Title1];
        [Title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Title.mas_bottom).offset(40+i*56);
            make.left.mas_offset(31);
            make.size.mas_offset(CGSizeMake(ScreenW-31, 30));
        }];
        
    }
    
    
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
    
    NSDate *appointDate;
    NSTimeInterval oneDay = 24 * 60 * 60;
    
    appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * 365)];
    // 获取不同时间字段的信息
    NSDateComponents* comp1 = [gregorian components: unitFlags
                                          fromDate:appointDate];
    
    NSString *time1 = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)comp.year,(long)comp.month,(long)comp.day];
    [_begin_date setTitle:time1 forState:UIControlStateNormal];

    NSString *time2 = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)comp1.year,(long)comp1.month,(long)comp1.day];
    [_end_date setTitle:time2 forState:UIControlStateNormal];

    
//    self.scrollView.QtimeLabel1.text = @"00:00";
//    self.scrollView.StimeLabel1.text = @"00:00";
    
    
    
}
#pragma mark - 类型
-(void)DiscountAction:(UIButton *)sender{
    for (int i = 0; i<2; i++) {
        if (sender.tag == i+1) {
            sender.selected = YES;
            sender.backgroundColor = UIColorFromRGB(0x3D8AFF);
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+1];
        but.selected = NO;
        but.backgroundColor = UIColorFromRGB(0xFFFFFF);

    }
    
    if (sender.tag == 1) {
        self.Discount1.selected =YES;
        self.Discount2.selected =NO;
        
        [self.beginView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(CGSizeMake((ScreenW-60)/2, 50));
        }];
        [self.endView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(CGSizeMake((ScreenW-60)/2, 50));
        }];
        self.begin_time.hidden = YES;
        self.end_time.hidden = YES;

        self.discount_type = 1;
        
    }else{
        self.Discount1.selected =NO;
        self.Discount2.selected =YES;
        [self.beginView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(CGSizeMake((ScreenW-60)/2, 70));
        }];
        [self.endView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(CGSizeMake((ScreenW-60)/2, 70));
        }];
        
        self.begin_time.hidden = NO;
        self.end_time.hidden = NO;
        
        self.discount_type = 2;
    }
    
}


#pragma mark -beginAction(开始时间)
-(void)beginAction:(UIButton *)sender{
    is_begin = 1;
    [self beginTime];
}
-(void)beginTime{
    if (_discount_type ==1 ) {
        CCDatePickerView *dateView=[[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        [self.window addSubview:dateView];
        dateView.blcok = ^(NSDate *dateString){
            NSLog(@"年 = %ld  月 = %ld  日 = %ld  时 = %ld  分 = %ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
            
            NSString *datestr = [NSString stringWithFormat:@"%ld-%02ld-%02ld",dateString.year,dateString.month,dateString.day];
            //        [sender setTitle:datestr forState:UIControlStateNormal];
            
            if (self->is_begin == 1) {
                [self.begin_date setTitle:datestr forState:UIControlStateNormal];

            }else{
                [self.end_date setTitle:datestr forState:UIControlStateNormal];

            }
        };
        dateView.chooseTimeLabel.text = @"选择时间";
        [dateView fadeIn];
    }else{
        CCDatePickerView *dateView=[[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        /** 时分 */
        dateView.isTime = YES;
        [self.window  addSubview:dateView];
        dateView.blcok = ^(NSDate *dateString){
            NSLog(@"年 = %ld  月 = %ld  日 = %ld  时 = %ld  分 = %ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
    
            
            NSString *datestr = [NSString stringWithFormat:@"%ld-%02ld-%02ld",dateString.year,dateString.month,dateString.day];
            
            NSString *time = [NSString stringWithFormat:@"%02ld:%02ld:00",dateString.hour,dateString.minute];

            if (self->is_begin==1) {
                [self.begin_date setTitle:datestr forState:UIControlStateNormal];
                [self.begin_time setTitle:time forState:UIControlStateNormal];

            }else{
                [self.end_date setTitle:datestr forState:UIControlStateNormal];
                [self.end_time setTitle:time forState:UIControlStateNormal];

            }
        };
        dateView.chooseTimeLabel.text = @"选择时间";
        [dateView fadeIn];
    }
    
    
}
#pragma mark -endAction(结束时间)
-(void)endAction:(UIButton *)sender{

    is_begin = 2;
    [self beginTime];
}
-(void)starEvaluator:(SliderView *)evaluator currentValue:(float)value{
    self.discount_condition.text = [NSString stringWithFormat:@"%.0f",value];
}



#pragma mark - ButtomAction
-(void)ButtomAction{
    if (self.saveblock) {
        self.saveblock();
    }
    
}


#pragma mark - GET
- (FL_Button *)DiscountButton1{
    if (!_DiscountButton1) {
        _DiscountButton1 = [FL_Button buttonWithType:UIButtonTypeCustom];
        [_DiscountButton1 setTitle:@"全天" forState:UIControlStateNormal];
        [_DiscountButton1 setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateSelected];
        [_DiscountButton1 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_DiscountButton1 setImage:[UIImage imageNamed:@"icn_fanbei_type_choose_date_white"] forState:UIControlStateSelected];
        [_DiscountButton1 setImage:[UIImage imageNamed:@"icn_fanbei_type_choose_date_blue"] forState:UIControlStateNormal];
        [_DiscountButton1 addTarget:self action:@selector(DiscountAction:) forControlEvents:UIControlEventTouchUpInside];
        _DiscountButton1.tag = 1;
        
        _DiscountButton1.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _DiscountButton1.layer.shadowOffset = CGSizeMake(0,2);
        _DiscountButton1.layer.shadowOpacity = 1;
        _DiscountButton1.layer.shadowRadius = 5;
        _DiscountButton1.layer.cornerRadius = 5;
        
//        _DiscountButton1.status = FLAlignmentStatusImageLeft;
        _DiscountButton1.fl_padding = 25;

    }
    return _DiscountButton1;
}
- (FL_Button *)DiscountButton2{
    if (!_DiscountButton2) {
        _DiscountButton2 = [FL_Button buttonWithType:UIButtonTypeCustom];
        [_DiscountButton2 setTitle:@"限时" forState:UIControlStateNormal];
        [_DiscountButton2 setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateSelected];
        [_DiscountButton2 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_DiscountButton2 setImage:[UIImage imageNamed:@"icn_fanbei_type_choose_time_white"] forState:UIControlStateSelected];
        [_DiscountButton2 setImage:[UIImage imageNamed:@"icn_fanbei_type_choose_time_blue"] forState:UIControlStateNormal];
        [_DiscountButton2 addTarget:self action:@selector(DiscountAction:) forControlEvents:UIControlEventTouchUpInside];
        _DiscountButton2.tag = 2;

        _DiscountButton2.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _DiscountButton2.layer.shadowOffset = CGSizeMake(0,2);
        _DiscountButton2.layer.shadowOpacity = 1;
        _DiscountButton2.layer.shadowRadius = 5;
        _DiscountButton2.layer.cornerRadius = 5;
        
        
//        _DiscountButton2.status = FLAlignmentStatusImageLeft;
        _DiscountButton2.fl_padding = 25;
    }
    return _DiscountButton2;
}
- (UIButton *)Discount1{
    if (!_Discount1) {
        _Discount1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Discount1 setImage:[UIImage imageNamed:@"icn_check_box_white"] forState:UIControlStateSelected];
//        [_Discount1 setImage:[UIImage imageNamed:@"icn_fanbei_type_choose_date_blue"] forState:UIControlStateNormal];
//        [_Discount1 addTarget:self action:@selector(DiscountAction:) forControlEvents:UIControlEventTouchUpInside];

//        _Discount1.tag = 1;
        
    }
    return _Discount1;
}
- (UIButton *)Discount2{
    if (!_Discount2) {
        _Discount2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Discount2 setImage:[UIImage imageNamed:@"icn_check_box_white"] forState:UIControlStateSelected];
//        [_Discount2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_Discount2 addTarget:self action:@selector(DiscountAction:) forControlEvents:UIControlEventTouchUpInside];
//        _Discount2.tag = 2;
        
        
    }
    return _Discount2;
}

-(UITextField *)discount_condition{
    if (!_discount_condition) {
        _discount_condition = [[UITextField alloc]init];
        _discount_condition.textColor = UIColorFromRGB(0x3D8AFF);
        _discount_condition.font = [UIFont systemFontOfSize:30];
        _discount_condition.textAlignment = 1;
        _discount_condition.backgroundColor = [UIColor whiteColor];
        _discount_condition.keyboardType = UIKeyboardTypeDecimalPad;
        
        _discount_condition.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _discount_condition.layer.shadowOffset = CGSizeMake(0,2);
        _discount_condition.layer.shadowOpacity = 1;
        _discount_condition.layer.shadowRadius = 5;
        _discount_condition.layer.cornerRadius = 5;
    }
    return _discount_condition;
}


-(UIView *)beginView{
    if (!_beginView) {
        _beginView = [[UIView alloc]init];
        _beginView.backgroundColor = [UIColor whiteColor];
        
        _beginView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _beginView.layer.shadowOffset = CGSizeMake(0,2);
        _beginView.layer.shadowOpacity = 1;
        _beginView.layer.shadowRadius = 5;
        _beginView.layer.cornerRadius = 5;
    }
    return _beginView;
}
-(UIView *)endView{
    if (!_endView) {
        _endView = [[UIView alloc]init];
        _endView.backgroundColor = [UIColor whiteColor];
        
        _endView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _endView.layer.shadowOffset = CGSizeMake(0,2);
        _endView.layer.shadowOpacity = 1;
        _endView.layer.shadowRadius = 5;
        _endView.layer.cornerRadius = 5;
    }
    return _endView;
}
-(UIView *)GoodView{
    if (!_GoodView) {
        _GoodView = [[UIView alloc]init];
        _GoodView.backgroundColor = [UIColor whiteColor];
        
        _GoodView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _GoodView.layer.shadowOffset = CGSizeMake(0,2);
        _GoodView.layer.shadowOpacity = 1;
        _GoodView.layer.shadowRadius = 5;
        _GoodView.layer.cornerRadius = 5;
    }
    return _GoodView;
}
-(FL_Button *)begin_date {
    if (!_begin_date) {
        _begin_date = [FL_Button buttonWithType:UIButtonTypeCustom];
        [_begin_date setTitle:@"2018-12-18" forState:UIControlStateNormal];
        [_begin_date setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [_begin_date.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_begin_date setImage:[UIImage imageNamed:@"icn_fanbei_type_choose_date_blue"] forState:UIControlStateNormal];
        [_begin_date addTarget:self action:@selector(beginAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _begin_date.status = FLAlignmentStatusImageLeft;
        _begin_date.fl_padding = autoScaleW(20);
    }
    return _begin_date;
}

-(FL_Button *)end_date {
    if (!_end_date) {
        _end_date = [FL_Button buttonWithType:UIButtonTypeCustom];
        [_end_date setTitle:@"2018-12-18" forState:UIControlStateNormal];
        [_end_date setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [_end_date.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_end_date setImage:[UIImage imageNamed:@"icn_fanbei_type_choose_date_blue"] forState:UIControlStateNormal];

        
        [_end_date addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventTouchUpInside];

        
        
        _end_date.status = FLAlignmentStatusImageLeft;
        _end_date.fl_padding = autoScaleW(20);
    }
    return _end_date;
}

-(FL_Button *)begin_time {
    if (!_begin_time) {
        _begin_time = [FL_Button buttonWithType:UIButtonTypeCustom];
        [_begin_time setTitle:@"00:00" forState:UIControlStateNormal];
        [_begin_time setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [_begin_time.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_begin_time setImage:[UIImage imageNamed:@"icn_fanbei_type_choose_time_blue"] forState:UIControlStateNormal];
        [_begin_time addTarget:self action:@selector(beginAction:) forControlEvents:UIControlEventTouchUpInside];

        
        
        _begin_time.status = FLAlignmentStatusImageLeft;
        _begin_time.fl_padding = 20;
    }
    return _begin_time;
}

-(FL_Button *)end_time {
    if (!_end_time) {
        _end_time = [FL_Button buttonWithType:UIButtonTypeCustom];
        [_end_time setTitle:@"00:00" forState:UIControlStateNormal];
        [_end_time setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [_end_time.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_end_time setImage:[UIImage imageNamed:@"icn_fanbei_type_choose_time_blue"] forState:UIControlStateNormal];
        
        [_end_time addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventTouchUpInside];

        _end_time.status = FLAlignmentStatusImageLeft;
        _end_time.fl_padding = 20;
    }
    return _end_time;
}
@end
