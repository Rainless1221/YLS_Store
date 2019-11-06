//
//  CashTDViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashTDViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *TextLabl;
@property (weak, nonatomic) IBOutlet UIButton *SeleButton;

@property (nonatomic, assign) BOOL isSelect;
@property (strong,nonatomic)NSDictionary * Data;
@property (nonatomic, copy) void(^qhxSelectBlock)(BOOL choice,NSInteger btntag);

@end
