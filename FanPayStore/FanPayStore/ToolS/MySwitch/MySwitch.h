//
//  MySwitch.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/18.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^MyBlock) (BOOL OnStatus);

@protocol MySwitchDelegate

- (void)onStatusDelegate;

@end


@interface MySwitch : UIView
{
    //背景View 滑块View
    UIImageView *UIImageViewBack,*UIImageViewBlock;
    //背景图片 滑块右图片 滑块左图片
    UIImage     *UIImageBack,*UIImageSliderRight,*UIImageSliderLeft;
}

//Switch 返回开关量block
@property (nonatomic,copy) MyBlock myBlock;

//Switch 返回开关量delegate
@property (nonatomic) id delegate;

//Switch 开关状态
@property (nonatomic) BOOL OnStatus;

//Switch 长 宽 滑块半径
@property (nonatomic) CGFloat Width,Height,CircleR;

//滑块距离边框边距
@property (nonatomic) CGFloat Gap;

@property (strong,nonatomic) UITapGestureRecognizer *tap;

/*  带有block 初始化
 *  @param frame
 *  @param gap  滑块距离边框的距离
 *  @param block
 *
 */
- (id)initWithFrame:(CGRect)frame withGap:(CGFloat)gap statusChange:(MyBlock)block;

/*  初始化
 *  @param frame
 *  @param gap  滑块距离边框的距离
 *
 */
- (id)initWithFrame:(CGRect)frame withGap:(CGFloat)gap;

//设置背景图片
-(void)setBackgroundImage:(UIImage *)image;

//设置左滑块图片
-(void)setLeftBlockImage:(UIImage *)image;

//设置右滑块图片
-(void)setRightBlockImage:(UIImage *)image;

-(void)tapAction:(UITapGestureRecognizer *)tap;

@end

NS_ASSUME_NONNULL_END
/**
 
 mySwitchBlock=[[MySwitch alloc] initWithFrame:CGRectMake(150, 350, 57, 31) withGap:3.0 statusChange:^(BOOL OnStatus) {
 if(OnStatus){
 NSLog(@"打开");
 }else{
 NSLog(@"关闭");
 }
 }];
 //设置背景图片
 [mySwitch setBackgroundImage:[UIImage imageNamed:@"back.png"]];
 [mySwitch setLeftBlockImage:[UIImage imageNamed:@"left_slider.png"]];
 [mySwitch setRightBlockImage:[UIImage imageNamed:@"right_slider.png"]];
 
 */

/**
 //初始化mySwitch
 mySwitch=[[MySwitch alloc] initWithFrame:CGRectMake(150, 250, 57, 31) withGap:2.0];
 //设置背景图片
 [mySwitch setBackgroundImage:[UIImage imageNamed:@"back.png"]];
 [mySwitch setLeftBlockImage:[UIImage imageNamed:@"left_slider.png"]];
 [mySwitch setRightBlockImage:[UIImage imageNamed:@"right_slider.png"]];
 mySwitch.delegate=self;
 
 - (void)onStatusDelegate{
 if(mySwitch.OnStatus){
 NSLog(@"打开");
 }else{
 NSLog(@"关闭");
 }
 }
 */
