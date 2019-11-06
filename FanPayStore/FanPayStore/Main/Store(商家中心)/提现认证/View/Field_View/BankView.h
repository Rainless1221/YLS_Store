//
//  BankView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//  银行卡信息

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankView : UIView<UITextFieldDelegate>
@property (strong,nonatomic)UILabel * Thetitle_3;
@property (strong,nonatomic)UIView * WeiView_4;
@property (strong,nonatomic)UIView * WeiView_5;
@property (strong,nonatomic)UITextField * bank_account_no;
@property (strong,nonatomic)UITextField * bank_account_name;
@property (strong,nonatomic)UITextField * bank_account_type;
@property (strong,nonatomic)UITextField * bank_card_type;
@property (strong,nonatomic)UITextField * Field_8;
@property (strong,nonatomic)UITextField * bank_type;
@property (strong,nonatomic)UITextField * bank_name;
@property (strong,nonatomic)UILabel * bank_name1;

@property (strong,nonatomic)UITextField * bank_telephone_no;

@property (strong,nonatomic)UIButton * bank_card_front_pic;
@property (strong,nonatomic)UIButton * bank_card_back_pic;



@property (strong,nonatomic)UIButton * type1;
@property (strong,nonatomic)UIButton * type2;
@property (strong,nonatomic)UIButton * type3;
@property (strong,nonatomic)UIButton * type4;
@property (strong,nonatomic)UIButton * type5;

@property (strong,nonatomic)ysepayModel * Data;

@property (nonatomic, copy) void(^SettypeBlock)(UIButton *btn);
@property (nonatomic, copy) void(^ImagePicBlock)(UIButton *Btn);

@end

NS_ASSUME_NONNULL_END
