//
//  FSTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *head_pic;//头像
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *seximage;//用户性别 0为保密 1为男性 2为女性
@property (nonatomic, strong) NSDictionary  *Data;
@property (nonatomic, strong) NSDictionary  *Data1;

@end
