//
//  MoneyTableViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoneyTableViewCell : UITableViewCell
@property (strong,nonatomic)UIView * CellBase;

/*图标*/
@property (strong,nonatomic)UIImageView * cellIcon;
@property (strong,nonatomic)UIImageView * cellIcon_jt;
/*类型*/
@property (strong,nonatomic)UILabel * cellLabel;

@property (strong,nonatomic)NSDictionary * Data;

@end

NS_ASSUME_NONNULL_END
