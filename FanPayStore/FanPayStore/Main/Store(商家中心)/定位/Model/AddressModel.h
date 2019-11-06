//
//  AddressModel.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property (nonatomic, copy) NSString *DingWeiString;
@property (nonatomic, copy) NSString *DianpuString;
@property (nonatomic, copy) NSString *ShenqingString;

//维度
@property(nonatomic ,assign) double latitude;
//经度
@property(nonatomic ,assign) double longitude;
///省份名字属性
@property(nonatomic, copy) NSString *province;

///城市名字属性
@property(nonatomic, copy) NSString *city;

///区名字属性
@property(nonatomic, copy) NSString *district;

///街道名字属性
@property(nonatomic, copy) NSString *street;

///街道号码属性
@property(nonatomic, copy) NSString *streetNumber;

///位置语义化结果的定位点在什么地方周围的描述信息
@property(nonatomic, copy) NSString *locationDescribe;


@property (nonatomic ,copy) NSString *detailAddress;

@property (nonatomic ,copy) NSString *userName;

//保存
-(void)saveUserData;
//清理
+(instancetype)clearUserData;
//解档
+(instancetype)getUseData;
@end
