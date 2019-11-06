//
//  CustomLabel.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/27.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomLabel : UILabel
// 用来决定上下左右内边距，也可以提供一个借口供外部修改，在这里就先固定写死
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

@end

NS_ASSUME_NONNULL_END
