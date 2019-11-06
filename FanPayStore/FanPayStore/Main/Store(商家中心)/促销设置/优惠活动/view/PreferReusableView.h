//
//  PreferReusableView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreferReusableView : UICollectionReusableView
@property (strong,nonatomic)YYLabel * label_Z;
@property (strong,nonatomic)UILabel * lable_time;
@property (strong,nonatomic)NSDictionary * Data;


@property (nonatomic, copy) void(^SetPrefeActionBlock)(void);
@property (nonatomic, copy) void(^GuanPrefeActionBlock)(UIButton *guan);

@end

NS_ASSUME_NONNULL_END
