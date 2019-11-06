//
//  FdetailsTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/4.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FdetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goods_pic;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
@property (weak, nonatomic) IBOutlet UILabel *discount_price;
@property (weak, nonatomic) IBOutlet UILabel *goods_desc;

@property (strong,nonatomic)NSDictionary * Data;

@end
