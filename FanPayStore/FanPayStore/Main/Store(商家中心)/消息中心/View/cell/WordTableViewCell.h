//
//  WordTableViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WordTableViewCell : UITableViewCell
@property (strong,nonatomic)UIView * CellBase;
/*类型*/
@property (strong,nonatomic)UIImageView * cellIcon;
@property (strong,nonatomic)UILabel * cellLabel;
@property (strong,nonatomic)UILabel * cellText;
@property (strong,nonatomic)UILabel * celltype;
@property (strong,nonatomic)UILabel * celltime;

@property (strong,nonatomic)NSDictionary * Data;
@property (strong,nonatomic)NSDictionary * TableData;

@end

NS_ASSUME_NONNULL_END
