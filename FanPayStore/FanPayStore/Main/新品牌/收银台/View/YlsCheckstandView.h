//
//  YlsCheckstandView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/4.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YlsCheckstandView : UIView
@property (strong,nonatomic)UIView * checkView1;
@property (strong,nonatomic)UIView * checkView2;
@property (strong,nonatomic)UIView * checkView3;
@property (strong,nonatomic)UIView * checkView4;
@property (strong,nonatomic)UIView * checkView5;
/*当前余额*/
@property (strong,nonatomic)UILabel * current_balance;
/*[ 平均优惠力度 ]*/
@property (strong,nonatomic)UILabel * Label_balance;
@end

NS_ASSUME_NONNULL_END
