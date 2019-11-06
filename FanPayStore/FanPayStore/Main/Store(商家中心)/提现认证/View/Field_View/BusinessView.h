//
//  BusinessView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//  营业执照信息

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BusinessView : UIView
@property (strong,nonatomic)UILabel * Thetitle_4;
@property (strong,nonatomic)UIView * WeiView_6;
@property (strong,nonatomic)UIView * WeiView_7;
@property (strong,nonatomic)UITextField * bus_license;
@property (strong,nonatomic)UITextField * bus_license_expire;
@property (strong,nonatomic)UIButton * business_license_pic;
@property (strong,nonatomic)ysepayModel * Data;

@property (nonatomic, copy) void(^ImagePicBlock)(UIButton *Btn);

@end

NS_ASSUME_NONNULL_END
