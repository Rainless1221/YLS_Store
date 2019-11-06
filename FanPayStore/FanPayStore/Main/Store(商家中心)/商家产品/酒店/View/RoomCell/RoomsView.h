//
//  RoomsView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RoomsDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)Fill:(UIButton *)sender;


@end

@interface RoomsView : UIView

@property (strong,nonatomic)UIView * BaseView_1;
@property (strong,nonatomic)UIView * BaseView_2;
@property (strong,nonatomic)UIView * BaseView_3;

@property (strong,nonatomic)UILabel * RoomsLabel_1;
@property (strong,nonatomic)UILabel * RoomsLabel_2;
@property (strong,nonatomic)UILabel * RoomsLabel_3;
@property (strong,nonatomic)UILabel * RoomsLabel_4;
@property (strong,nonatomic)UILabel * RoomsLabel_5;

@property (strong,nonatomic)UILabel * Roomstype_1;
@property (strong,nonatomic)UILabel * Roomstype_2;
@property (strong,nonatomic)UILabel * Roomstype_3;
@property (strong,nonatomic)UILabel * Roomstype_4;
@property (strong,nonatomic)UILabel * Roomstype_5;
@property (strong,nonatomic)UILabel * Roomstype_6;

/*代理*/
@property(nonatomic,weak)id<RoomsDelegate>delagate;

@end

NS_ASSUME_NONNULL_END
