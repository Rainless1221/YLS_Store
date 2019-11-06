//
//  FBHDdetailsController.h
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

@interface FBHDdetailsController : BaseViewController
@property (strong,nonatomic)NSString * navigationTitle;
@property (assign,nonatomic)NSInteger status;
@property (strong,nonatomic)NSString * order_id;
/**
 UI
 */
@property (strong,nonatomic)UIView * GoodsView;
@property (strong,nonatomic)UIView * OtherView;
@property (strong,nonatomic)UIView * ScoreView;

@property (strong,nonatomic)UILabel * actual_money;//实付
@property (strong,nonatomic)UILabel * save_money;//优惠
@end
