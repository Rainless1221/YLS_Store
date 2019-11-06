//
//  Account_TXTableViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account_TXTableViewCell : UITableViewCell
@property (strong,nonatomic)UIView * CellBase;
/*类型*/
@property (strong,nonatomic)UILabel * cellLabel;

@property (strong,nonatomic)UILabel * cellText;

@property (strong,nonatomic)UILabel * celltype;

@property (strong,nonatomic)UIImageView * cellIcon;
@property (strong,nonatomic)UIImageView * cellIcon_jt;

@property (strong,nonatomic)NSDictionary * Data;
@property (strong,nonatomic)NSDictionary * TableData;

@end

NS_ASSUME_NONNULL_END
