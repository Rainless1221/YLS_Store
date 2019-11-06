//
//  YLSinStoreView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/18.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol QieHuActionDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
/**/
-(void)QieHuAction:(NSInteger )Typeinteger;
-(void)SetAddress:(UILabel *)addressLabel;
-(void)SetCycle:(UITextField *)Cycle;
-(void)SetTime:(UITextField *)Time;

@end

@interface YLSinStoreView : UIView<UITextFieldDelegate,SelectedReminDelegate>
@property (strong,nonatomic)UIView * AView;
@property (strong,nonatomic)UIView * BView;
@property (strong,nonatomic)UIView * CView;
@property (strong,nonatomic)UIView * DView;

@property (strong,nonatomic)UIView * BView_backview;
@property (strong,nonatomic)UIView * CView_backview;
#pragma mark ———————— 店铺信息
/*店铺信息输入框*/
@property (strong,nonatomic)UILabel * AView_address;
@property (strong,nonatomic)UITextField * AView_MenP;
@property (strong,nonatomic)UITextField * AView_Name;
@property (strong,nonatomic)UITextField * AView_Phone;
@property (strong,nonatomic)UITextField * AView_GPhone;
@property (strong,nonatomic)UITextField * AView_Cycle;
@property (strong,nonatomic)UITextField * AView_Time;
@property (strong,nonatomic)UITextField * AView_price;
@property (strong,nonatomic)UITextField * AView_jie;
@property (strong,nonatomic)UILabel * AView_jieSun;
@property (strong,nonatomic)UIButton * AView_KeyButton;
@property (strong,nonatomic)UIView * AView_KeyView;
@property (strong,nonatomic)UITextField * AView_KeyView_TF;

#pragma mark ———————— 温馨提醒
@property (strong,nonatomic)UIView * ReminderView;
@property (strong,nonatomic)SelectedRemin * ReminV;
@property (assign,nonatomic)CGFloat ReminLabel_Y;
@property (strong,nonatomic)NSArray * ReminData;
@property (strong,nonatomic)NSMutableArray * ReminArray;
@property (strong,nonatomic)UITextView * ReminTF;

#pragma mark ———————— 照片
#pragma mark ———————— 证件
/*高度值*/
@property (assign,nonatomic)CGFloat SizeHeight;

///*标记信息模块*/
@property (assign,nonatomic)NSInteger TypeView;
@property(nonatomic,weak)id<QieHuActionDelegate>delagate;
@property (assign,nonatomic)NSInteger isSelete;

/*赋值*/
@property (strong,nonatomic)NSDictionary * Data;
@end

NS_ASSUME_NONNULL_END
