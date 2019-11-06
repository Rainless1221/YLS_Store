//
//  ServiceFacility.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/9.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ServiceDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)Facility:(UIView *)ReminV and:(UIButton* )icon;

@end

@interface ServiceFacility : UIView
@property (strong,nonatomic)UIView * BaseView_1;
@property (strong,nonatomic)UIView * BaseView_2;
@property(nonatomic,weak)id<ServiceDelegate>delagate;

@end

NS_ASSUME_NONNULL_END
