//
//  BannerView.h
//  ConcreteClass
//
//  Created by 浅佳科技 on 2018/11/30.
//  Copyright © 2018年 蒲仁飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapActionBlock)(NSInteger index);

@interface BannerView : UIView

/*
  *     images   图片数组
  *     tapBlock  点击事件
  */
+(void)showBannerWithFrame:(CGRect)frame images:(NSArray*)images superView:(UIView *)superView tapBlock:(TapActionBlock)tapBlock;

@end

NS_ASSUME_NONNULL_END
