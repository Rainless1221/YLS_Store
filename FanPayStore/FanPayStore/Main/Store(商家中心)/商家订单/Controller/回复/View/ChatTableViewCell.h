//
//  ChatTableViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/25.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatTableViewCell : UITableViewCell
@property (strong,nonatomic)UILabel * M_label;
@property (strong,nonatomic)UILabel * Time_label;
@property (strong,nonatomic)UILabel * Chat_label;
@property (strong,nonatomic)NSDictionary * Data;
@end

NS_ASSUME_NONNULL_END
