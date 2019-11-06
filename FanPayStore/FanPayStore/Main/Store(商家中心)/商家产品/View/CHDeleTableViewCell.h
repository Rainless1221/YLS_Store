//
//  CHDeleTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/22.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHDeleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goods_pic;
@property (weak, nonatomic) IBOutlet UILabel *goodname;
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
@property (weak, nonatomic) IBOutlet UILabel *goods_count;
@property (weak, nonatomic) IBOutlet UILabel *goods_desc;

@property (strong,nonatomic)NSDictionary * Data;

@end
