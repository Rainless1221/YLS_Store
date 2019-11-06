//
//  IdentityView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//  身份证信息

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IdentityView : UIView
@property (strong,nonatomic)UILabel * Thetitle_2;
@property (strong,nonatomic)UIView * WeiView_2;
@property (strong,nonatomic)UIView * WeiView_3;
@property (strong,nonatomic)UITextField * cert_no;
@property (strong,nonatomic)UIButton * ID_card_front_pic;
@property (strong,nonatomic)UIButton * ID_card_back_pic;
@property (strong,nonatomic)ysepayModel * Data;

@property (nonatomic, copy) void(^ImagePicBlock)(UIButton *Btn);


@end

NS_ASSUME_NONNULL_END
