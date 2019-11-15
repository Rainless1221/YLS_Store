//
//  Store_Menu_View.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol editorActionDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
/**/
-(void)editorAction:(NSInteger )Typeinteger;

@end

@interface Store_Menu_View : UIView
@property (strong,nonatomic)UIView * Menu_line;
@property (strong,nonatomic)UIView * AView;
@property (strong,nonatomic)UIView * BView;
@property (strong,nonatomic)UIView * CView;
@property (strong,nonatomic)UIView * DView;
#pragma mark ———————— 店铺信息 ————————

@property (strong,nonatomic)UILabel * AView_text1;
@property (strong,nonatomic)UILabel * AView_text2;
@property (strong,nonatomic)UILabel * AView_text3;
@property (strong,nonatomic)UILabel * AView_text4;
@property (strong,nonatomic)UILabel * AView_text5;
@property (strong,nonatomic)UILabel * AView_text6;
@property (strong,nonatomic)UILabel * AView_text7;
@property (strong,nonatomic)UILabel * AView_text8;
@property (strong,nonatomic)UILabel * AView_text9;

@property (strong,nonatomic)UILabel * AView_Add;
@property (strong,nonatomic)UILabel * AView_Name;
@property (strong,nonatomic)UILabel * AView_Phone;
@property (strong,nonatomic)UILabel * AView_Gphone;
@property (strong,nonatomic)UILabel * AView_Cycle;
@property (strong,nonatomic)UILabel * AView_Time;
@property (strong,nonatomic)UILabel * AView_price;
@property (strong,nonatomic)UILabel * AView_Jie;
@property (strong,nonatomic)UILabel * AView_Key;
#pragma mark ———————— 温馨提醒 ————————

@property (strong,nonatomic)UIView * BView_backview;
@property (assign,nonatomic)CGFloat ReminLabel_Y;
@property (strong,nonatomic)UILabel * reminder2;
@property (strong,nonatomic)SelectedRemin *ReminV;

#pragma mark ———————— 照片 ————————
@property (strong,nonatomic)UILabel * CView_text1;
@property (strong,nonatomic)UILabel * CView_text2;
@property (strong,nonatomic)UILabel * CView_text3;
@property (strong,nonatomic)UILabel * CView_text4;
@property (strong,nonatomic)UIImageView * CView_Image1;
@property (assign,nonatomic)CGFloat Image_Y;



#pragma mark ———————— 证件 ————————

@property (strong,nonatomic)UILabel * DView_text1;
@property (strong,nonatomic)UILabel * DView_text2;
@property (strong,nonatomic)UILabel * DView_text3;
@property (strong,nonatomic)UILabel * DView_text4;
@property (strong,nonatomic)UILabel * DView_text5;
@property (strong,nonatomic)UILabel * DView_text6;
@property (strong,nonatomic)UIImageView * DView_Image1;
@property (strong,nonatomic)UIImageView * DView_Image2;
@property (strong,nonatomic)UIImageView * DView_Image3;
@property (strong,nonatomic)UIImageView * DView_Image4;
@property (assign,nonatomic)CGFloat DImage_Y;

/*高度值*/
@property (assign,nonatomic)CGFloat SizeHeight;
@property (nonatomic, copy) void(^SizeHejightBlock)(CGFloat Height);

/*标记信息模块*/
@property (assign,nonatomic)NSInteger TypeView;
@property(nonatomic,weak)id<editorActionDelegate>delagate;



/*赋值*/
@property (strong,nonatomic)NSDictionary * Data;

-(void)ButtonAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
