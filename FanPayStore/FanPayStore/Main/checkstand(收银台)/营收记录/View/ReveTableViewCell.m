//
//  ReveTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "ReveTableViewCell.h"

@implementation ReveTableViewCell
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    self.image.transform = CGAffineTransformMakeScale(-1.0, 1.0);
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    
    NSString *type = [NSString stringWithFormat:@"%@",Data[@"type"]];
    if ([type isEqualToString:@"2"]) {
        self.typeIcon.image = [UIImage imageNamed:@"icn_order_withdraw"];
        
        
        /*月份*/
        NSString *mon = [NSString stringWithFormat:@"%@",Data[@"months"]];
        NSString *str5 = [mon substringFromIndex:mon.length-2];
        NSString *months = [self months:str5];
        self.months.text = months;
        
        /*日期*/
        NSString *Time1 = [NSString stringWithFormat:@"%@",Data[@"time"]];
        NSString *Timelen1 = [Time1 substringFromIndex:Time1.length-11];
        NSString *strTime = [Timelen1 substringToIndex:2];
        self.time.text = strTime;
        /*时间*/
        NSString *TimeS = [NSString stringWithFormat:@"%@",Data[@"time"]];
        NSString *Timelen = [TimeS substringFromIndex:TimeS.length-8];
        NSString *str3 = [Timelen substringToIndex:5];
        self.reveTime.text = str3;
        
        /*描述*/
        self.content.text = [NSString stringWithFormat:@"%@",Data[@"content"]];
        /*金额*/
        self.amount.textColor = UIColorFromRGB(0x3D8AFF);
        self.amount.text= [NSString stringWithFormat:@"%@",Data[@"amount"]];

        
        
    }else{
        self.typeIcon.image = [UIImage imageNamed:@"icn_order_income"];
        
        /*月份*/
        NSString *mon = [NSString stringWithFormat:@"%@",Data[@"months"]];
        NSString *str5 = [mon substringFromIndex:mon.length-2];
        NSString *months = [self months:str5];
        self.months.text = months;
        /*日期*/
        NSString *Time1 = [NSString stringWithFormat:@"%@",Data[@"time"]];
        NSString *Timelen1 = [Time1 substringFromIndex:Time1.length-11];
        NSString *strTime = [Timelen1 substringToIndex:2];
        self.time.text = strTime;
        /*时间*/
        NSString *TimeS = [NSString stringWithFormat:@"%@",Data[@"time"]];
        NSString *Timelen = [TimeS substringFromIndex:TimeS.length-8];
        NSString *str3 = [Timelen substringToIndex:5];
        self.reveTime.text = str3;
        
        /*描述*/
        self.content.text = [NSString stringWithFormat:@"%@",Data[@"content"]];
        /*金额*/
        self.amount.textColor = UIColorFromRGB(0xF7AE2A);
        self.amount.text= [NSString stringWithFormat:@"+%@",Data[@"amount"]];
    }
    
}
#pragma mark - 转换月份
-(NSString *)months:(NSString *)monthsTime{
    
    NSInteger mon = [monthsTime integerValue];
    
    switch (mon) {
        case 1:
            monthsTime = @"一月";
            break;
        case 2:
            monthsTime = @"二月";
            break;
        case 3:
            monthsTime = @"三月";
            break;
        case 4:
            monthsTime = @"四月";
            break;
        case 5:
            monthsTime = @"五月";
            break;
        case 6:
            monthsTime = @"六月";
            break;
        case 7:
            monthsTime = @"七月";
            break;
        case 8:
            monthsTime = @"八月";
            break;
        case 9:
            monthsTime = @"九月";
            break;
        case 10:
            monthsTime = @"十月";
            break;
        case 11:
            monthsTime = @"十一月";
            break;
        case 12:
            monthsTime = @"十二月";
            break;
        default:
            break;
    }
    
    return  monthsTime;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
