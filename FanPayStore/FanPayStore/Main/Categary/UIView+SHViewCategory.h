//
//  UIView+SHViewCategory.h
//  EZhangChe
//
//  Created by admin on 2017/8/14.
//  Copyright © 2017年 moco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SHViewCategory)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

- (void)removeAllSubviews;

- (UIView *)findSuperViewWithClass:(Class)superViewClass;
/* 截图 */
- (UIImage *)screenshot;

@end
