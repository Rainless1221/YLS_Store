//
//  StoreNameViewController.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"
#import "NameOfShop.h"

@interface StoreNameViewController : BaseViewController
/** 基础层 **/
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)NameOfShop * StoreView;
/** logo图片地址 **/
@property (strong,nonatomic)NSString * store_logo;
/** 经营类型 */
@property (strong,nonatomic)NSString * category_id;
@property (strong,nonatomic)NSString * sec_category_id;
/*店铺数据*/
@property (strong,nonatomic)NSDictionary * Data_dict;

@end
