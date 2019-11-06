//
//  ysepayModel.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/3.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ysepayModel : NSObject
@property (nonatomic, copy) NSString *legal_name;
@property (nonatomic, copy) NSString *legal_tel;
@property (nonatomic, copy) NSString *cert_no;
@property (nonatomic, copy) NSString *ID_card_front_pic;
@property (nonatomic, copy) NSString *ID_card_back_pic;
@property (nonatomic, copy) NSString *bank_account_no;
@property (nonatomic, copy) NSString *bank_account_name;
@property (nonatomic, copy) NSString *bank_account_type;
@property (nonatomic, copy) NSString *bank_card_type;
@property (nonatomic, copy) NSString *bank_province;
@property (nonatomic, copy) NSString *bank_city;
@property (nonatomic, copy) NSString *bank_type;
@property (nonatomic, copy) NSString *bank_name;
@property (nonatomic, copy) NSString *bank_telephone_no;
@property (nonatomic, copy) NSString *bank_card_front_pic;
@property (nonatomic, copy) NSString *bank_card_back_pic;
@property (nonatomic, copy) NSString *customer_agreement_pic;
@property (nonatomic, copy) NSString *business_license_pic;
@property (nonatomic, copy) NSString *bus_license;
@property (nonatomic, copy) NSString *bus_license_expire;
@property (nonatomic, copy) NSString *opening_permit_pic;
//保存
-(void)saveUserData;
//清理
+(instancetype)clearUserData;
//解档
+(instancetype)getUseData;
@end

NS_ASSUME_NONNULL_END
