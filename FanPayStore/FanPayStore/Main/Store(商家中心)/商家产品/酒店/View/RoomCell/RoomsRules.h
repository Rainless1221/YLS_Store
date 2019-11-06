//
//  RoomsRules.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RoomsRulesDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)rulesAtion:(UIButton *)sender;


@end

@interface RoomsRules : UIView 

@property (strong,nonatomic)UIView * BaseView_1;
@property (strong,nonatomic)UIView * BaseView_2;
@property (strong,nonatomic)UIView * BaseView_3;
@property (strong,nonatomic)UITextField * Rules_1;
@property (strong,nonatomic)UITextField * Rules_2;
@property (strong,nonatomic)UITextField * Rules_3;
@property (strong,nonatomic)UITextField * Rules_4;
/*代理*/
@property(nonatomic,weak)id<RoomsRulesDelegate>delagate;
@end

NS_ASSUME_NONNULL_END
