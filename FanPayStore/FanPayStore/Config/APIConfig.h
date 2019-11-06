//
//  APIConfig.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h

/*
 正式服地址： http://fanbuy.imocoo.com    或    http://ex.double.com.cn/
 测试服地址：http://120.39.244.157     appFanBuy&20190802
 */

#if EZhangCheVersion == 88
#define DOMAIN_EZHANGCHE @"http://xx.com/api/merchant/"
#else
#define DOMAIN_EZHANGCHE @"http://xx.com/api/merchant/"
#endif

//url拼接
#define RequestUrl(domain,path) [NSString stringWithFormat:@"%@%@",domain,path]
//地址拼接
#define kBaseUrl(path) [NSString stringWithFormat:@"%@%@",DOMAIN_EZHANGCHE,path]
//商家注册
#define FBHApi_register   @"register"
/**
 原图片前缀
 */
#define FBHApi_Url_original   @"http://img.double.com.cn/"

#define  Bundle_Url 1
#if Bundle_Url
/**
 现在图片前缀 https://exbuy.double.com.cn  http://ex.double.com.cn
 */
#define FBHApi_Url   @"https://exbuy.double.com.cn"

#else
/**
 */
#define FBHApi_Url   @"http://103.27.7.20"

#endif



/*客服*/
#define FBHApi_HTML_kefu  @"http://webchat.7moor.com/wapchat.html?accessId=1841bfd0-5062-11e9-bcb5-ab95be009593&fromUrl=&urlTitle="

//http://exbuy.double.com.cn/h5/other/withdrawal_agreement.html   收银
#define FBHApi_HTML_shouyi  @"https://exbuy.double.com.cn/h5/other/withdrawal_agreement.html"

//http://exbuy.double.com.cn/h5/other/entry_agreement.html    入驻协议
#define FBHApi_HTML_Ruzhu  @"https://exbuy.double.com.cn/h5/other/entry_agreement.html"

//http://exbuy.double.com.cn/h5/other/legal_notices.html   法律声明
#define FBHApi_HTML_Falu  @"https://exbuy.double.com.cn/h5/other/legal_notices.html"

//http://exbuy.double.com.cn/h5/other/privacy_agreement.html   隐私协议
#define FBHApi_HTML_Yinsi  @"https://exbuy.double.com.cn/h5/other/privacy_agreement.html"

//http://exbuy.double.com.cn/h5/other/service_agreement.html  服务协议
#define FBHApi_HTML_Fuwu  @"https://exbuy.double.com.cn/h5/other/service_agreement.html"

//http://exbuy.double.com.cn/h5/other/user_agreement.html  用户协议
#define FBHApi_HTML_yonghu  @"https://exbuy.double.com.cn/h5/other/user_agreement.html"


#endif /* APIConfig_h */
