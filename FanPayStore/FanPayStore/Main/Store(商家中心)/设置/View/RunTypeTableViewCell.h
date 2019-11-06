//
//  RunTypeTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/14.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunTypeTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL isSelect;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *TextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (nonatomic, strong) NSDictionary  *Data;

@property (nonatomic, copy) void(^qhxSelectBlock)(BOOL choice,NSInteger btntag);


@end
