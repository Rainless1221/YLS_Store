//
//  bankcardTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/5.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bankcardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *BankIcon;
@property (weak, nonatomic) IBOutlet UILabel *BankName;
@property (weak, nonatomic) IBOutlet UILabel *BankType;
@property (weak, nonatomic) IBOutlet UILabel *BankInt;
@property (weak, nonatomic) IBOutlet UIImageView *Bankcard;


@property (strong,nonatomic)NSDictionary * Data;
@property (strong,nonatomic)NSDictionary * RData;
@property (strong,nonatomic)NSDictionary * BData;

@end
