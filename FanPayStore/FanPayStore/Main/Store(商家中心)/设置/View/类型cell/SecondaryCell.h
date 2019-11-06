//
//  SecondaryCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/9.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondaryCell : UITableViewCell
@property (nonatomic, assign) BOOL isSelect;

@property (strong,nonatomic)UILabel * category_name;
@property (strong,nonatomic)UIButton *icon;
@property (strong,nonatomic)NSDictionary * Data;

@property (nonatomic, copy) void(^qhxSelectBlock)(BOOL choice,NSInteger btntag);

@end
