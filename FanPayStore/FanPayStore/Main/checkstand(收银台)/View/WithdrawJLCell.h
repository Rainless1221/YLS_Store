//
//  WithdrawJLCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/26.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawJLCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *add_time;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *withdraw_desc;
@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (strong,nonatomic)NSDictionary * Data;

@end
