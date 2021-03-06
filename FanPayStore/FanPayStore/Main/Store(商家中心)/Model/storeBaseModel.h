//
//  storeBaseModel.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface storeBaseModel : NSObject
@property (nonatomic, copy) NSString *store_name;//商家店铺名称
@property (nonatomic, copy) NSString *store_address;//商家店铺地址
@property (nonatomic, copy) NSString *store_pic;//店铺环境图片 多张则以逗号隔开
@property (nonatomic, copy) NSString *store_category;
@property (nonatomic, copy) NSString *category_pic;
@property (nonatomic, copy) NSString *fans_number;
@property (nonatomic, copy) NSString *goods_number;
@property (nonatomic, copy) NSString *order_num_to_be_paid;
@property (nonatomic, copy) NSString *have_unread_news;
@property (nonatomic, copy) NSString *store_logo;
@property (nonatomic, copy) NSString *store_code;
@property (nonatomic, copy) NSString *branch_type;
@property (nonatomic, copy) NSString *merchant_name;
@property (nonatomic, copy) NSString *merchant_mobile;
@property (nonatomic, copy) NSString *business_times;
@property (nonatomic, copy) NSString *business_hours;
@property (nonatomic, copy) NSString *choice_printer;//选择打印机类型 1表云打印 2表蓝牙打印
@property (nonatomic, copy) NSString *open_status;//开关状态 1表开启 2表关闭
@property (nonatomic, copy) NSString *appointment_switch;//预约开关状态 1表开启 2表关闭
@property (nonatomic, copy) NSString *meel_fee_switch;//餐位费开关状态 1表开启 2表关闭
@property (nonatomic, copy) NSString *meel_fee;//餐位费
//保存
-(void)saveUserData;
//清理
+(instancetype)clearUserData;
//解档
+(instancetype)getUseData;
@end
