//
//  MoenytypeCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/3.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoenytypeCell : UITableViewCell
@property (nonatomic, assign) BOOL isSelect;
@property (strong, nonatomic)  UIButton *selectBtn;
@property (strong, nonatomic)  UILabel *TextLabel;
@property (nonatomic, strong) NSDictionary  *Data;
@property (nonatomic, copy) void(^qhxSelectBlock)(BOOL choice,NSInteger btntag);

@end

NS_ASSUME_NONNULL_END
