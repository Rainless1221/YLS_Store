//
//  PeriodView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/21.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeriodView : UIView
@property (strong,nonatomic)UIView * BaseView;
@property (strong,nonatomic)NSMutableArray * PerArray;

@property (nonatomic, copy) void(^PeriodBlock)(NSString *PeriodString);

@end
