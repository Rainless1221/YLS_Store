//
//  FBHSZTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/4.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBHSZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *discount_amount;
@property (weak, nonatomic) IBOutlet UILabel *datetime;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (nonatomic, strong) NSDictionary  *Data;

@end
