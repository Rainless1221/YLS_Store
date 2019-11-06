//
//  RoomsCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomsCell : UITableViewCell
@property (strong,nonatomic)UIView * BaseView;
@property (strong,nonatomic)UILabel * celltext;

@property (strong,nonatomic)NSDictionary * Data;

@end

NS_ASSUME_NONNULL_END
