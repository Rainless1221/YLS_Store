//
//  DDMenuView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/22.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuBlock)(NSString *btntag);
@interface DDMenuView : UIView

@property (strong,nonatomic)UIButton * QB_Button;
@property (strong,nonatomic)UIButton * DZF_Button;
@property (strong,nonatomic)UIButton * YZF_Button;
@property (strong,nonatomic)UIButton * refund_Button;

@property (strong,nonatomic)NSArray *SArrayTag;

@property (strong,nonatomic)UIButton * MenButton;
@property (assign,nonatomic)NSInteger isSelete;
@property (strong,nonatomic)UIView * view_line;
@property (strong,nonatomic)UILabel * badgeLable;

@property (nonatomic, copy) MenuBlock Menublock;

@end
