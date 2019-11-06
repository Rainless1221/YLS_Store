//
//  SliderView.h
//  SliderView
//
//  Created by Scott on 2018/4/11.
//  Copyright © 2018年 無解. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SliderView;
@protocol SliderViewDelegate <NSObject>

@optional
// 代理方法 动态获取
- (void)starEvaluator:(SliderView *)evaluator currentValue:(float)value;

@end

@interface SliderView : UIControl

@property (assign, nonatomic) id<SliderViewDelegate>delegate;

/*
 ***  最小值
 */
@property (nonatomic, assign) CGFloat minValue;

/*
 *** 最大值
 */
@property (nonatomic, assign) CGFloat maxValue;

/*
 *** 默认值
 */
@property (nonatomic, assign) CGFloat value;

/*
 *** 轨道colors
 */
@property (nonatomic, retain) NSArray *trackColors;

/*
 *** 轨道默认color
 */
@property (nonatomic, strong) UIColor *normalColor;

/*
 *** 轨道size
 */
@property (nonatomic, assign) CGSize trackSize;

/*
 *** 滑块size
 */
@property (nonatomic, assign) CGSize thumbSize;

/*
 *** 滑块背景图片
 */
@property (nonatomic, strong) UIImage *thumbImage;

/*
 *** 当前展示的值
 */
@property (nonatomic, strong) UILabel *valueLabel;

//刷新视图
- (void)reloadData:(CGFloat)value;


@end
