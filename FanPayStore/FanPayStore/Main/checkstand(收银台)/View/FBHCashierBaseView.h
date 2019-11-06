//
//  FBHCashierBaseView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CashierDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
//@required
-(void)list_checkstand:(NSString *)begin_date andEnd:(NSString *)end_date;
-(void)getWithdraw;
-(void)getincomeMore;
-(void)Revenuedetails:(NSDictionary *)Dara;
-(void)labelTouchUpInside;
-(void)StatisticalAction;
-(void)OrderButtonAction:(NSInteger )Btntag;

@end

@interface FBHCashierBaseView : UIView <SGAdvertScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
/*代理*/
@property(nonatomic,weak)id<CashierDelegate>delagate;


@property (strong,nonatomic)UIView * View1;
@property (strong,nonatomic)UIView * View2;
@property (strong,nonatomic)UIView * View3;
/*当前余额*/
@property (strong,nonatomic)UILabel * current_balance;
@property (strong,nonatomic)NSString * current_balance_String;
/*今日营收（元）*/
@property (strong,nonatomic)UILabel * today_income;
/*累计营收（元）*/
@property (strong,nonatomic)UILabel * cumulative_income;
@property (strong,nonatomic)UIButton * lookButton;

/** 订单*/
@property (strong,nonatomic)UIView * orderView;
@property (strong,nonatomic)FL_Button *thirdBtn;
@property (strong,nonatomic)UILabel * badgeLable;


/*通知喇叭*/
@property (strong,nonatomic)UIImageView * icon2;
/* 更多 */
@property (strong,nonatomic)UIButton * More;
/* 轮播 */
@property (weak, nonatomic)  SGAdvertScrollView *advertScrollViewCenter;


/*begin_date*/
@property (strong,nonatomic)UILabel * begin_date;

/*end_date*/
@property (strong,nonatomic)UILabel * end_date;

/**总营收 */
@property (strong,nonatomic)UILabel * total_income;
/**总支出 */
@property (strong,nonatomic)UILabel * total_expense;
/** 列表  **/
@property (strong,nonatomic)UITableView * IncomeTableview;
@property (strong,nonatomic)NSMutableArray * IncomeArray;

@property (strong,nonatomic)UIButton * TimeButton;
@property (strong,nonatomic)UIView * timeline;
/*数据*/
@property (strong,nonatomic)NSDictionary * Data;

-(void)TimeAction:(UIButton *)sender;
@end
