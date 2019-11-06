//
//  ModelConfig.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#ifndef ModelConfig_h
#define ModelConfig_h

#import <MJExtension/MJExtension.h>
#import "BaseModel.h"
#import "APIConfig.h"

//用户信息
#import "UserModel.h"
#import "AddressModel.h"//地址信息
//
////商家信息
#import "storeBaseModel.h"//商家信息
#import "insert_storeM.h"//申请入住数据存储
#import "store_goodsModel.h"//商品信息
//
////银行信息
#import "Bank_infoModel.h"
//
////收银台
#import "CashierModel.h"

#import "ysepayModel.h"

#pragma mark - key的快捷宏
//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"
//用户model缓存
#define KUserModelCache @"KUserModelCache"
#endif /* ModelConfig_h */
