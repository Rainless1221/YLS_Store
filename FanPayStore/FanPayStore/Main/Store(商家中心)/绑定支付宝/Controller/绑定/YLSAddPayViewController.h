//
//  YLSAddPayViewController.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSAddPayViewController : BaseViewController
@property (strong,nonatomic)UITextField * AccountTF;//请输入支付宝帐号
@property (strong,nonatomic)UITextField * PayNameTF;//请输入真实姓名
@property (strong,nonatomic)UITextField * MSMTF;//请输入验证码
@property (strong,nonatomic)UILabel * PayPhone;
@property (strong,nonatomic)UIButton * AddButton ;
@end

NS_ASSUME_NONNULL_END
