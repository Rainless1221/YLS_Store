//
//  PhotoModel.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/2.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoModel : NSObject
@property (nonatomic, copy) NSString *goods_pic;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *discount_price;
@property (nonatomic, copy) NSString *p_goods_id;

@property (nonatomic, copy) NSString *isSelected;

@end

NS_ASSUME_NONNULL_END
