//
//  CashierTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashierTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UIImageView *shuxian;
@property (weak, nonatomic) IBOutlet UILabel *Timelabel;
@property (weak, nonatomic) IBOutlet UILabel *Textlabel;
@property (weak, nonatomic) IBOutlet UILabel *Mlabel;
@property (weak, nonatomic) IBOutlet UILabel *Zhuanglabel;

@property (strong,nonatomic)NSDictionary * Data;
@end
