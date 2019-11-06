//
//  ThelabelCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThelabelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Thelabel;
@property (weak, nonatomic) IBOutlet UIButton *DeleteButton;

@property (strong,nonatomic)NSDictionary * Data;

@end
