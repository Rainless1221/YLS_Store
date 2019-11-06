//
//  FBHPickerView.h
//  app
//
//  Created by mocoo_ios on 2019/5/9.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerDelegate <NSObject>
/*选择方法*/
- (void)DatePickerView:(NSString *)year withMonth:(NSString *)month withDay:(NSString *)day withDate:(NSString *)date withTag:(NSInteger) tag;

@end

typedef NS_ENUM(NSInteger,TimeShowMode){
    /**
     * 只显示今天之前的时间
     */
    ShowTimeBeforeToday = 1,
    /**
     * 显示今天之后的时间
     */
    ShowTimeAfterToday,
    /**
     * 不限制时间
     */
    ShowAllTime,
    
};
@interface FBHPickerView : UIView
@property (nonatomic, assign) id<DatePickerDelegate> delegate;

@end
