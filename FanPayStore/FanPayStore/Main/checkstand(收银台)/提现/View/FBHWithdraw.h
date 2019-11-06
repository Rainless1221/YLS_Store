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
-(void)Cardbanks;
-(void)WithdrawAmount:(NSString *)amount;
@end

@interface FBHWithdraw : UIView
@property(nonatomic,weak)id<WithdrawDelegate>delagate;

/**当前可提现 */
@property (strong,nonatomic)UIImageView * withdrawableView;
/*提现金额*/
@property (strong,nonatomic)UILabel * withdrawable_cash;
/**服务费 */
@property (strong,nonatomic)UILabel * service_charges_rate;
/*开始的余额变服务费 */
@property (strong,nonatomic)UILabel * cash;
/*全部*/
@property (strong,nonatomic)UIButton * allButton;
/**确定提现 */
@property (strong,nonatomic)UIButton * get_withdrawalButton;
/* 输入提现金额 */
@property (strong,nonatomic)UITextField * withdraw_amount;
/*银行卡信息*/
@property (strong,nonatomic)UIImageView * card;
@property (strong,nonatomic)UILabel * cardName;
@property (strong,nonatomic)FL_Button * cardButton;
/** 数据 */
@property (strong,nonatomic)NSDictionary * Data;
@end
