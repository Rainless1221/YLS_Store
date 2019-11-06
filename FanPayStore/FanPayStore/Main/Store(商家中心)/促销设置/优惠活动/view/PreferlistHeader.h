//
//  PreferlistHeader.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreferlistHeader : UIView
@property (strong,nonatomic)UIView * baseView_1;
@property (strong,nonatomic)UIView * baseView_2;
@property (strong,nonatomic)UIView * baseView_3;

//类型
@property (strong,nonatomic)UIView * view_line;
@property (strong,nonatomic)NSArray *SArrayTag;
@property (assign,nonatomic)NSInteger isSelete;

//统计
@property (strong,nonatomic)UILabel * expiry_date;
@property (strong,nonatomic)UILabel * order_num;
@property (strong,nonatomic)UILabel * order_amount;

@property (strong,nonatomic)NSDictionary * Data;
@property (nonatomic, copy) void(^addActionBlock)(void);
@property (nonatomic, copy) void(^Menublock)(NSString *btntag);

@end

NS_ASSUME_NONNULL_END
