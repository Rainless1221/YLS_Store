//
//  FBHWithdraw.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FL_Button.h"
@protocol WithdrawDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
//@required
-(void)CardAction;
@end

@interface FBHWithdraw : UIView<UITextFieldDelegate>
@property(nonatomic,weak)id<WithdrawDelegate>delagate;

/**当前可提现 */
@property (strong,nonatomic)UIImageView * withdrawableView;
/*提现金额*/
@property (strong,nonatomic)UILabel * withdrawable_cash;
/*冻结金额*/
@property (strong,nonatomic)UILabel * withdrawable_cash1;
@property (strong,nonatomic)UILabel * withdrawable_cash2;
/**服务费 */
@property (strong,nonatomic)UILabel * service_charges_rate;
/*开始的余额变服务费 */
@property (strong,nonatomic)UILabel * cash;
/*全部*/
@property (strong,nonatomic)UIButton * allButton;
/*提示*/
@property (strong,nonatomic)FL_Button *button;
/**确定提现 */
@property (strong,nonatomic)UIButton * get_withdrawalButton;
/* 输入提现金额 */
@property (strong,nonatomic)UITextField * withdraw_amount;
/*银行卡信息*/
@property (strong,nonatomic)UIImageView * card;
@property (strong,nonatomic)UILabel * cardName;
/** 银行卡ID */
@property (strong,nonatomic)NSString * bankid;
@property (strong,nonatomic)FL_Button * cardButton;
/**
 温馨提醒
 **/
@property (strong,nonatomic)UILabel * Remindlabel1;
@property (strong,nonatomic)UILabel * Remindlabel2;
@property (strong,nonatomic)UILabel * Remindlabel3;
@property (strong,nonatomic)UILabel * Remindlabel4;
@property (strong,nonatomic)UILabel * Remindlabel5;

@property (strong,nonatomic)UIButton * QieButton1;
@property (strong,nonatomic)UIButton * QieButton2;
@property (strong,nonatomic)UIView * view_line;
/**提现所有控制的费率、最大最小提现等字节*/
@property (strong,nonatomic)NSString *today_withdrawable_amount ;
@property (strong,nonatomic)NSString *withdraw_min_limit_one_time ;
@property (strong,nonatomic)NSString *withdraw_max_limit_one_time ;
@property (strong,nonatomic)NSString *service_charges_max ;
@property (strong,nonatomic)NSString *fee_payable ;
@property (strong,nonatomic)NSString *service_charges_rateD ;
/** 数据 */
@property (strong,nonatomic)NSDictionary * Data;
@end
