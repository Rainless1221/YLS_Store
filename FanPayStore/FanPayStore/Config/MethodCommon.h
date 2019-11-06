//
//  MethodCommon.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodCommon : NSObject
/*
 *  屏幕尺寸
 */
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
//判断屏幕尺寸
#define ISIPHONE5   ((double)[[UIScreen mainScreen] bounds].size.height==568 ? 1 : 0)
#define ISIPHONE6   ([[UIScreen mainScreen] bounds].size.height==667 ? 1 : 0)
#define ISIPHONE6P  ([[UIScreen mainScreen] bounds].size.height==736 ? 1 : 0)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
//是否iPhoneX YES:iPhoneX屏幕 NO:传统屏幕
#define kIs_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//状态栏高度
#define  STATUS_BAR_HEIGHT      (kIs_iPhoneX ? 44.f : 20.f)

//字体适配
#define autoScaleW(width) [(AppDelegate *)[UIApplication sharedApplication].delegate autoScaleW:width]
#define autoScaleH(height) [(AppDelegate *)[UIApplication sharedApplication].delegate autoScaleH:height]

#define IPHONEHIGHT(b) [UIScreen mainScreen].bounds.size.height*((b)/667.0)
#define IPHONEWIDTH(a) [UIScreen mainScreen].bounds.size.width*((a)/375.0)

/*
 *  系统版本I
 */
#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? 1 : 0)
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? 1 : 0)
#define ISIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? 1 : 0)
#define ISIOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 ? 1 : 0)


/*
 *  调试
 */
// NSLog
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行]\n %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#define debugMethod() printf("\n[%s] [第%d行] %s\n",__TIME__,__LINE__,__FUNCTION__);
#define MITLog(format, ...) printf("\n[%s] %s [第%d行]\n %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#define debugMethod()
#define MITLog(format, ...)
#endif



//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}


//占位图片
#define photoImage [UIImage imageNamed:@"register_empty_avatar"]
#define defaltImage [UIImage imageNamed:@"pic_default_avatar"]

//NSUserDefaults
#define DEFAULTS [NSUserDefaults standardUserDefaults]

//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];


/**
 *  获取Bundle Id
 **/

#define  Bundle_Id   [[NSBundle mainBundle]bundleIdentifier]


#pragma mark - 字符串区
//1.字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//2.数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//3.字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//4.是否是空对象
#define kObjectIsEmpty(_object)  (_object == nil \ || [_object isKindOfClass:[NSNull class]] \ || ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \ || ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

+ (CGSize)sizeWithFont:(UIFont *_Nullable)font maxW:(CGFloat)maxW text:(NSString *_Nullable)text;
#pragma mark 【 处理字符串为空 】
+ (NSString *_Nullable)judgeStringIsNull:(NSString *_Nullable)text;

@end
