//
//  StoreDiscountView.h
//  FanBeiHua
//
//  Created by 苹果笔记本 on 2019/4/19.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDiscountView : UIView<SliderViewDelegate>
{
    SliderView *sliderView;
    NSInteger is_begin;
}
@property (assign,nonatomic)NSInteger discount_type;

/**
 类型
 */
@property (strong,nonatomic)FL_Button * DiscountButton1;
@property (strong,nonatomic)FL_Button * DiscountButton2;
@property (strong,nonatomic)UIButton * Discount1;
@property (strong,nonatomic)UIButton * Discount2;
/**
 额度
 */
@property (strong,nonatomic)UITextField * discount_condition;

/**
 时间
 */
@property (strong,nonatomic)UIView * beginView;
@property (strong,nonatomic)UIView * endView;
@property (strong,nonatomic)UIView * GoodView;



@property (strong,nonatomic)FL_Button * begin_date;
@property (strong,nonatomic)FL_Button * end_date;
@property (strong,nonatomic)FL_Button * begin_time;
@property (strong,nonatomic)FL_Button * end_time;
/*数据*/
@property (strong,nonatomic)NSDictionary * Data;
@property (nonatomic, copy) void(^saveblock)(void);

-(void)DiscountAction:(UIButton *)sender;
@end
