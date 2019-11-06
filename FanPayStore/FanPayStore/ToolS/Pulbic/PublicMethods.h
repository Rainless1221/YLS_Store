//
//  PublicMethods.h
//  框架------------公共的一些方法
//

#import <Foundation/Foundation.h>

@interface PublicMethods : NSObject

#pragma mark --- 缓存
+(void)writeToUserD:(id)obj andKey:(NSString *)key;
#pragma mark --- 读取缓存
+(id)readFromUserD:(NSString *)key;
#pragma mark --- 归档
+ (NSData *)archiveObj:(id)obj withKey:(NSString *)key;
#pragma mark --- 读档
+ (id)unArchiveObj:(NSData *)data withKey:(NSString *)key;
#pragma mark --- 判断密码是否包含特殊字符
+ (BOOL)checkPassword:(NSString *)password;
#pragma mark --- 首次加载判断
+(BOOL)Version;

//传入文件名获取缓存地址
+(NSString *)getDocPath:(NSString *)str;
//判断手机号
+ (BOOL)checkTelNumber:(NSString*) telNumber;
//判断邮箱是否合法
+ (BOOL)checkEmail:(NSString *)email;

#pragma mark - 生成当前时间字符串
+(NSString*)GetCurrentTimeString;
#pragma mark - 生成文件路径
+(NSString*)GetPathByFileName:(NSString *)_fileName ofType:(NSString *)_type;
#pragma mark -- 价格字符串的截取
+(NSString*)getTheCorrectNum:(NSString*)tempString;
#pragma mark ————— 加载缓存的用户 —————
+(NSString*)UserInfoToKey:(NSString *)userKey;
//[resourcesFile.name hasPrefix:@"AAA"];//判断是否是“AAA”开头

//[resourcesFile.name hasSuffix:@".prss"];//判断是否是“.prss”结尾

#pragma mark - 判断字符串是否为URL
+ (BOOL)isUrl:(NSString *) string;



@end
