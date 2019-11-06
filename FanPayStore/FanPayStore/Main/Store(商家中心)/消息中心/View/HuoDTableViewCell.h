//
//  HuoDTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/6.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuoDTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *add_time;
@property (weak, nonatomic) IBOutlet UIImageView *news_pic;
@property (weak, nonatomic) IBOutlet UILabel *news_content;
@property (weak, nonatomic) IBOutlet UILabel *news_title;
@property (strong,nonatomic)NSDictionary * Data;

@end
