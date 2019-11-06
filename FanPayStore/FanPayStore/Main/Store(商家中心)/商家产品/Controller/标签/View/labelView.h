//
//  labelView.h
//  app
//
//  Created by mocoo_ios on 2019/5/17.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThelabelcellDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)Addlabelcell:(NSString *)lableString and:(NSInteger)integer;

@end

@interface labelView : UIView

/**
 *  标签列表的高度
 */
@property (nonatomic, assign) CGFloat tagListH;

/**
 *  标签颜色
 */
@property (nonatomic, strong) UIColor *tagColor;

/**
 *  标签背景颜色
 */
@property (nonatomic, strong) UIColor *tagBackgroundColor;
/**
 *  边框颜色
 */
@property (nonatomic, strong) UIColor *borderColor;



/**
 *  选中标签颜色
 */
@property (nonatomic, strong) UIColor *SeletagColor;

/**
 *  选中标签背景颜色
 */
@property (nonatomic, strong) UIColor *SeletagBackgroundColor;
/**
 *  边框颜色
 */
@property (nonatomic, strong) UIColor *SeleborderColor;

@property (nonatomic, strong) NSMutableArray *tagArray;

@property (nonatomic, strong) NSMutableArray *tagButtons;
/**
 *  按钮
 */
@property (strong,nonatomic)UIButton * LabelButton;

@property(nonatomic,weak)id<ThelabelcellDelegate>delagate;


- (void)addTag:(NSString *)tagStr;

- (void)clickTag:(UIButton *)button;

@end
