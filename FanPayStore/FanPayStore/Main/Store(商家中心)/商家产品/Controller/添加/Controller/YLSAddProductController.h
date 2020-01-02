//
//  YLSAddProductController.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSAddProductController : BaseViewController
/*编辑时、传过来的数据*/
@property (strong,nonatomic)NSDictionary * Data;
/*编辑时、商品ID*/
@property (strong,nonatomic)NSString * goodId;

@end

NS_ASSUME_NONNULL_END
