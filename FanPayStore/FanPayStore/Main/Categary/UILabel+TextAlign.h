//
//  UILabel+TextAlign.h
//  HaveAFlaw
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (TextAlign)
//文本吸顶
@property (nonatomic, assign) BOOL isTop;
//文本置底
@property (nonatomic, assign) BOOL isBottom;
@end

NS_ASSUME_NONNULL_END
