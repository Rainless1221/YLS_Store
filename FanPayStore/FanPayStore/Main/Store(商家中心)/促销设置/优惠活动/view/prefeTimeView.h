//
//  prefeTimeView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface prefeTimeView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSInteger yearRange;
    NSInteger dayRange;
    NSInteger startYear;
    NSInteger selectedYear;
    NSInteger selectedMonth;
    NSInteger selectedDay;
    NSInteger selectedHour;
    NSInteger selectedMinute;
    NSInteger selectedSecond;

}
@property (strong,nonatomic)UIPickerView *pickerView;/**<年>*/
@property (nonatomic,strong) NSString *string;
@property (strong,nonatomic)NSString * Year;
@property (strong,nonatomic)NSString * Month;
@property (strong,nonatomic)NSString * Day;

@end

NS_ASSUME_NONNULL_END
