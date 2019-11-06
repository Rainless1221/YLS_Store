//
//  AccountView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/2.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//  开户许可证或印签卡信息

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountView : UIView
@property (strong,nonatomic)UILabel * Thetitle_4;
@property (strong,nonatomic)UIView * WeiView_6;
@property (strong,nonatomic)UIButton * opening_permit_pic;
@property (strong,nonatomic)ysepayModel * Data;

@property (nonatomic, copy) void(^ImagePicBlock)(UIButton *Btn);

@end

NS_ASSUME_NONNULL_END
