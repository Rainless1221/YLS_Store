//
//  YBCacheConstant.h
//  YBAFNetworking
//
//  Created by  on 16/11/8.
//  Copyright © 2016年 YBing. All rights reserved.
//

#ifndef YBCacheConstant_h
#define YBCacheConstant_h

#ifdef DEBUG // 调试状态, 打开LOG功能
#define YBLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define YBLog(...)
#endif

/**
 缓存的有效期  单位是s
 */
#define kYBCache_Expire_Time (3600*24)

/**
 请求的API
 */

//测试http://elsapi.en8.top:81/api/
#define kAPI_URL @"https://exbuy.double.com.cn/api/"

//正式
#define kAPI_URL1 @"https://exbuy.double.com.cn/api/"


//图片地址
//#define IMGS_URL @"http://yuenisuoxiang.oss-cn-shenzhen.aliyuncs.com/business/"


/**
 弱引用
 */
#define YBWeakSelf __weak typeof(self) weakSelf = self;

/**
 *  沙盒Cache路径
 */
#define kCachePath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])

#endif /* YBCacheConstant_h */
