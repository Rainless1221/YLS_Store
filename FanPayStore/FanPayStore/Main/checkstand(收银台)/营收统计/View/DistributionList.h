//
//  DistributionList.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DistributionList : UIView <UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * DistriTableView;
@property (strong,nonatomic)NSMutableArray * DistriData;
@end

NS_ASSUME_NONNULL_END
