//
//  LawPeopleView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//      法人信息

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LawPeopleView : UIView
@property (strong,nonatomic)UILabel * Thetitle_1;
@property (strong,nonatomic)UIView * WeiView_1;
@property (strong,nonatomic)UITextField * legal_name;
@property (strong,nonatomic)UITextField * legal_tel;
@property (strong,nonatomic)ysepayModel * Data;
@end

NS_ASSUME_NONNULL_END
