//
//  CodeTableViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/13.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CodeTableViewCell : UITableViewCell
@property (strong,nonatomic)UIView * CellBase;
@property (strong,nonatomic)UILabel * zhuo;
@property (strong,nonatomic)UILabel * munt;
@property (strong,nonatomic)UIImageView * icon;

@property (strong,nonatomic)UIButton * addButton;
@property (strong,nonatomic)NSDictionary * Data;

@property (nonatomic, copy) void(^addCodeBlock)(void);
@property (nonatomic, copy) void(^deleCodeBlock)(void);
@property (nonatomic, copy) void(^BaseCodeBlock)(void);

@end

NS_ASSUME_NONNULL_END
