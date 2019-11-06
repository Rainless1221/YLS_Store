//
//  TotalRevenue.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/9.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TotalRevenue : UIView
@property (strong,nonatomic)UIImageView * logoimage;
@property (strong,nonatomic)UILabel * Store_Name;
@property (strong,nonatomic)UILabel * Store_day;
@property (strong,nonatomic)UILabel * Store_revenue1;
@property (strong,nonatomic)UILabel * Store_revenue2;
@property (strong,nonatomic)UIButton * Store_revenue3;

@end

NS_ASSUME_NONNULL_END
