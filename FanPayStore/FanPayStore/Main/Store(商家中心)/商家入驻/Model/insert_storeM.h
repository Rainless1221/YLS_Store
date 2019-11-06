//
//  insert_storeM.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface insert_storeM : NSObject
@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *sec_category_id;
@property (nonatomic, copy) NSString *store_logo;
@property (nonatomic, copy) NSString *store_address;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, copy) NSString *category_pic;
@property (nonatomic, copy) NSString *specific_location;
@property (nonatomic, copy) NSString *reminder;
@property (nonatomic, copy) NSString *reminder2;
@property (nonatomic, copy) NSString *merchant_name;
@property (nonatomic, copy) NSString *merchant_mobile;
@property (nonatomic, copy) NSString *merchant_telephone;
@property (nonatomic, copy) NSString *door_face_pic;
@property (nonatomic, copy) NSString *store_environment_pics;
@property (nonatomic, copy) NSString *hand_held_ID_card_pic;
@property (nonatomic, copy) NSString *business_license_pic;
@property (nonatomic, copy) NSString *business_permit_pic;
@property (nonatomic, copy) NSString *business_times;
@property (nonatomic, copy) NSString *business_hours;
//保存
-(void)saveUserData;
//清理
+(instancetype)clearUserData;
//解档
+(instancetype)getUseData;
@end
