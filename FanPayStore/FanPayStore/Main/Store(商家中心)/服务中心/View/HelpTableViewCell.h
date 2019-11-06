//
//  HelpTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/14.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *helpLabel;
@property (strong,nonatomic)NSDictionary * Data;
@end
