//
//  StoreStatus_View.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreStatus_View : UIView
//店铺logo
@property (strong,nonatomic)UIImageView * store_logo;
//店铺名称
@property (strong,nonatomic)UILabel * store_name;
//店铺ID
@property (strong,nonatomic)UILabel * store_ID;
//类型logo
@property (strong,nonatomic)UIImageView * type_imageView;
//类型
@property (strong,nonatomic)UILabel * category_name;
//粉丝
@property (strong,nonatomic)UILabel * fans_num;
//商品
@property (strong,nonatomic)UILabel * goods_num;

/*赋值*/
@property (strong,nonatomic)NSDictionary * Data;

@property (nonatomic, copy) void(^StoreNameBlock)(void);

@end

NS_ASSUME_NONNULL_END
