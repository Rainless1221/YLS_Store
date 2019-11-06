//
//  EquipmentCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/21.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EquipmentCell : UITableViewCell
@property (strong,nonatomic)UILabel * machine_name;
@property (strong,nonatomic)UILabel * machine_code;
@property (strong,nonatomic)NSDictionary * Data;
@property (nonatomic, copy) void(^unbindingBlock)(void);

@end

NS_ASSUME_NONNULL_END
