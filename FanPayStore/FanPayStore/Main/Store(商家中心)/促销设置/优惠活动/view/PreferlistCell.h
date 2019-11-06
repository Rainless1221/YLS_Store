//
//  PreferlistCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreferlistCell : UITableViewCell
@property (strong,nonatomic)UIView * CellBase;
//折扣
@property (strong,nonatomic)UIView * PreferLabel_view;
@property (strong,nonatomic)UILabel * PreferLabel;
@property (strong,nonatomic)UILabel * PreferLabel_text;
//时间
@property (strong,nonatomic)UILabel * PreferLabel_time;
@property (strong,nonatomic)YYLabel * PreferLabel_day;

@property (strong,nonatomic)UIImageView  * icons;

@property (strong,nonatomic)NSDictionary * Data;

@end

NS_ASSUME_NONNULL_END
