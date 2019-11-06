//
//  TheHotelCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/11.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheHotelCell : UITableViewCell
@property (strong,nonatomic)UIView * BaseView;//背景view
@property (strong,nonatomic)UIImageView * cellimage;//图片
@property (strong,nonatomic)UILabel * cellName;//名称
@property (strong,nonatomic)YYLabel * cellnote;
@property (strong,nonatomic)YYLabel * celljiage;
@property (strong,nonatomic)UILabel * cellbiaoqian;//标签
@property (strong,nonatomic)UIButton * DeleteButton;//下架按钮
@property (strong,nonatomic)UIButton * DetailButton;//编辑按钮

@end

NS_ASSUME_NONNULL_END
