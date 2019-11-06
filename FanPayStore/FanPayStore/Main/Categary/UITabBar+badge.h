//
//  UITabBar+badge.h
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/8/21.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
//- (void)showBadgeOnItemIndex:(int)index;
//- (void)hideBadgeOnItemIndex:(int)index;

- (void)showBadgeOnItmIndex:(int)index tabbarNum:(int)tabbarNum;
- (void)hideBadgeOnItemIndex:(int)index;
- (void)removeBadgeOnItemIndex:(int)index;

@end
