//
//  WorkbenchBaseView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WorkbenchDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
//@required
-(void)MoreAction;
-(void)SetupAction;
-(void)Calendar;
-(void)OrderButtonAction:(NSInteger )Btntag;
-(void)OrderOrFang:(NSInteger)btnTag;
-(void)Setstatus:(NSInteger)statusType;
@end

@interface WorkbenchBaseView : UIView <SGAdvertScrollViewDelegate>
/** 头像*/
@property (strong,nonatomic)UIImageView * store_logo;
/* 商铺名称 */
@property (strong,nonatomic)FL_Button * store_name;
/* 商铺地址 */
@property (strong,nonatomic)FL_Button * store_address;
/* 营业周期 */
@property (strong,nonatomic)UILabel * open_period;
/* 设置 */
@property (strong,nonatomic)UIButton * SetupButton;
/* notice */
@property (strong,nonatomic)UIView * noticeView;
/*通知喇叭*/
@property (strong,nonatomic)UIImageView * icon2;
/* 更多 */
@property (strong,nonatomic)UIButton * More;
/* 轮播 */
@property (weak, nonatomic)  SGAdvertScrollView *advertScrollViewCenter;

/* 营业 */
@property (strong,nonatomic)UIView * statusView;
@property (strong,nonatomic)UILabel * status;
@property (strong,nonatomic)UIButton * statusBtn1;
@property (strong,nonatomic)UIButton * statusBtn2;

/* 当天数据 */
@property (strong,nonatomic)UIView * todayView;
@property (strong,nonatomic)UILabel * today_income;
@property (strong,nonatomic)UILabel * today_order_num;
@property (strong,nonatomic)UILabel * today_reserve_num;
@property (strong,nonatomic)UILabel * to_do_list_num;
@property (strong,nonatomic)UILabel * cumulative_visitor_num;
@property (strong,nonatomic)UILabel * successful_conversion_rate;


/** 曲线*/
@property (strong,nonatomic)UIView * currentView;
@property (strong,nonatomic)UIView * currentLine;
@property (assign,nonatomic)NSInteger order_num;
@property (assign,nonatomic)NSInteger visitor_num;
@property (strong,nonatomic)UILabel * current_month_num;
@property (strong,nonatomic)UILabel * current_month;
/** 数据 */
@property (strong,nonatomic)NSDictionary * Data;
@property (strong,nonatomic)NSDictionary * Current_Data;

/** 订单*/
@property (strong,nonatomic)UIView * orderView;
@property (strong,nonatomic)FL_Button *thirdBtn;
@property (strong,nonatomic)UILabel * badgeLable;
/** 商家中心*/
@property (strong,nonatomic)UIView * StorecenterView;
@property (strong,nonatomic)FL_Button *haveBtn;


@property(nonatomic,weak)id<WorkbenchDelegate>delagate;

@end
