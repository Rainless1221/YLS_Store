//
//  FillInViewController.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/2.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FillInViewController : BaseViewController
@property (strong,nonatomic)NSString * NavString;
/*
 商户类型：1小微商户 2个体商户 3企业商户
 */
@property (assign,nonatomic)int cust_type;

@property (strong,nonatomic)ysepayModel * Data;

@end

NS_ASSUME_NONNULL_END
