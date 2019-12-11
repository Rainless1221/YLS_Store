//
//  PayTableViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayTableViewCell : UITableViewCell
@property (strong,nonatomic)UILabel * PayName;
@property (strong,nonatomic)UILabel *  Account;
@property (strong,nonatomic)UIButton * Status;
/*数据*/
@property (strong,nonatomic)NSDictionary * Data;
@end

NS_ASSUME_NONNULL_END
