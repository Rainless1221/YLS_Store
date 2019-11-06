//
//  MarkeViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/4.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarkeViewCell : UITableViewCell
@property (strong,nonatomic)UIView * CellBase;
/*图标*/
@property (strong,nonatomic)UIImageView * cellIcon;
/*活动*/
@property (strong,nonatomic)UILabel * cellLabel;
/**/
@property (strong,nonatomic)UILabel * cell_text;

@property (strong,nonatomic)UIImageView * cell_imag;

@property (strong,nonatomic)NSDictionary * Data;
@end

NS_ASSUME_NONNULL_END
