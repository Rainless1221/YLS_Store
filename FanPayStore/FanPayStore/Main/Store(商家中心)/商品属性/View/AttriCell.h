//
//  AttriCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/12/30.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttriLabView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttriCell : UITableViewCell<AttriLabDelegate>
@property (strong,nonatomic)UILabel * SuXin;
@property (strong,nonatomic)UIButton * DeleteBtn;
@property (strong,nonatomic)UIView * BaseView;
@property (strong,nonatomic)UITextField * AttriField;
@property (strong,nonatomic)UIButton * AddAttriBtn;
@property (strong,nonatomic)UITextField * AttriField1;
@property (strong, nonatomic) AttriLabView    *tagList;
/*高度*/
- (CGFloat)getCellHeight;
@end

NS_ASSUME_NONNULL_END
