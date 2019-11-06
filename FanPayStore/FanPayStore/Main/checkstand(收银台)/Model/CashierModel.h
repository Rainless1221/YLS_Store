//
//  CashierModel.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CashierModel : NSObject
@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *store_logo;
@property (nonatomic, copy) NSString *current_balance;
@property (nonatomic, copy) NSString *today_income;
@property (nonatomic, copy) NSString *cumulative_income;
@property (nonatomic, copy) NSString *notice;
@end
