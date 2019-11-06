//
//  FBHTabBar.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/12.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBHTabBar;

@protocol FBHTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(FBHTabBar *)tabBar;

@end

@interface FBHTabBar : UITabBar
@property (strong,nonatomic) UIButton *plusBtn;

@property (nonatomic, weak) id<FBHTabBarDelegate> tabBarDelegate;

@end
