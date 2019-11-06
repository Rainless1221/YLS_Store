//
//  RoomsPricing.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/15.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RoomsPricingDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)TuiAtion:(UIButton *)sender;


@end

@interface RoomsPricing : UIView
@property (strong,nonatomic)UIView * BaseView_1;
@property (strong,nonatomic)UIView * BaseView_2;
@property (strong,nonatomic)UIView * BaseView_3;

@property (strong,nonatomic)UITextField * pricing_1;
@property (strong,nonatomic)UITextField * pricing_2;
@property (strong,nonatomic)UITextField * pricing_3;
@property (strong,nonatomic)UITextField * pricing_4;
@property (strong,nonatomic)UITextField * pricing_5;


/*退订*/
@property (strong,nonatomic)UILabel * tuilabel;
@property (strong,nonatomic)UILabel * tuitext;

/*代理*/
@property(nonatomic,weak)id<RoomsPricingDelegate>delagate;
@end

NS_ASSUME_NONNULL_END
