//
//  ThirdMacros.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h

/*
 com.fanpay.store  正式使用的ID
 
 2a9612630fc354cf81e190386d61f93a   高德地图（自己的账号）
 8c716f749247fc62a4a4620c1ff644ac   高德地图（公司账号）
 //微信
 wxcb0bd6cf8ebad3e7
 //极光
 7eaaacb9a28a08b978850a0e
 // 腾讯
 //友盟统计
 5b04e3f6b27b0a174800003d
 */

//第三方配置
/** 1 为com.fanpay.store  0 为com.fanpay.TestStore **/
#define  Bundle_Id 0
#if Bundle_Id

#pragma mark - com.fanpay.store
// 友盟统计
#define UMengKey                         @"5b04e3f6b27b0a174800003d"
//正式
#define kSecret_Wechat                   @"2dbf84a4524c223c50ac03e10a4e31bc"
//微信
#define kAppKey_Wechat                   @"wxcb0bd6cf8ebad3e7"
// 腾讯
#define kAppKey_Tencent                  @"1106139910"
//极光
#define kAppKey_JPush                    @"7eaaacb9a28a08b978850a0e"
//百度地图
#define kAppKey_Baidu                    @"9G24cpB9ktTZBscmCrDI8gl9N3R0ZZwa"
//高德地图
#define kAppKey_gaode                    @"8c716f749247fc62a4a4620c1ff644ac"



#else

#pragma mark - com.fanpay.TestStore
//友盟统计
#define UMengKey                          @"5b04e3f6b27b0a174800003d"
//测试
#define kSecret_Wechat                   @"2dbf84a4524c223c50ac03e10a4e31bc"
//微信
#define kAppKey_Wechat                   @"wxcb0bd6cf8ebad3e7"
//腾讯
#define kAppKey_Tencent                  @"1106139910"
//极光
#define kAppKey_JPush                    @"ab1278157e5b5ab84576085f"
//百度地图
#define kAppKey_Baidu                    @"Yiz2p3ez6R0CrkrhWeWtaKL61brdEV8A"
//高德地图
#define kAppKey_gaode                    @"9c4c59f82a69ac736cb751610cb66935"

#endif
/*
 com.fanpay.TestStore  测试使用的ID
 9c4c59f82a69ac736cb751610cb66935   高德地图 （自己的账号）
 （）   高德地图（公司账号）
 //微信
 wx0fa37784184ae6c7
 //极光
 ab1278157e5b5ab84576085f
 // 腾讯
 //友盟统计
 
 */



#endif /* ThirdMacros_h */
