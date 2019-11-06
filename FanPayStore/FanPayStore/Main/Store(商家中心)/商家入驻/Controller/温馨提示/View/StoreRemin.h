//
//  StoreRemin.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/8.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreRemin : UIView<ReminDelegate>
@property (strong,nonatomic)NSMutableArray * reminderArray;

@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)NSMutableArray * Data1;
@end

NS_ASSUME_NONNULL_END
