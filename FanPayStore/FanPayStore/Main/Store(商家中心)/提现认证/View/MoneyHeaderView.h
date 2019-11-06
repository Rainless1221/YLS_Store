//
//  MoneyHeaderView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoneyHeaderView : UITableViewHeaderFooterView
@property (strong,nonatomic)UIView * CellBase;
@property (strong,nonatomic)UIView * line_1;
@property (strong,nonatomic)UIView * line_2;
@property (strong,nonatomic)UIImageView * icon_1;
@property (strong,nonatomic)UIImageView * icon_2;
@property (strong,nonatomic)UIImageView * icon_3;
@property (strong,nonatomic)UILabel * legal_name;
@property (strong,nonatomic)UILabel * cust_type;
@property (strong,nonatomic)UILabel * legal_tel;
@property (strong,nonatomic)UILabel * cell_card;
@property (strong,nonatomic)UILabel * cell_text;
@property (strong,nonatomic)UIButton * cell_setup;
@property (strong,nonatomic)FL_Button * cell_details;

@property (strong,nonatomic)UILabel * bank_type;//银行卡所属银行
@property (strong,nonatomic)UILabel * bank_card_type;//银行卡性质
@property (strong,nonatomic)UILabel * cell_bank1;
@property (strong,nonatomic)UILabel * bank_account_no;//结算银行卡卡号
@property (strong,nonatomic)UILabel * cell_amount1;
@property (strong,nonatomic)UILabel * withdraw_amount;//提现的金额




@property (strong,nonatomic)NSDictionary * Data;

@property (nonatomic, copy) void(^SetupBlock)(void);

@end

NS_ASSUME_NONNULL_END
