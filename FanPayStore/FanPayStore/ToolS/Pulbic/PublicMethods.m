//
//  PublicMethods.m
//  框架------------公共的一些方法
//

#import "PublicMethods.h"
//#import "FrameWork_Prefix.pch"
#define DEFAULTS [NSUserDefaults standardUserDefaults]
//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"
//用户model缓存
#define KUserModelCache @"KUserModelCache"

@implementation PublicMethods
#pragma mark --- 缓存
/**
 *  缓存
 *
 *  @param obj 传入要缓存的值
 *  @param key 值对应的 key
 */
+(void)writeToUserD:(id)obj andKey:(NSString *)key
{
    NSUserDefaults *userD = DEFAULTS;
    [userD setObject:obj forKey:key];
    [userD synchronize];
}
#pragma mark --- 读取缓存
/**
 *  读取缓存
 *
 *  @param key 传入要读取指定的 key
 *
 *  @return 返回 id 类型的所有值
 */
+(id)readFromUserD:(NSString *)key
{
    NSUserDefaults *userD = DEFAULTS;
    return [userD objectForKey:key];
}
#pragma mark --- 归档
+ (NSData *)archiveObj:(id)obj withKey:(NSString *)key
{
    NSMutableData *data = [NSMutableData new];
    NSKeyedArchiver *keyedA = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [keyedA encodeObject:obj forKey:key];
    [keyedA finishEncoding];
    return data;
    
}
#pragma mark --- 读档
+ (id)unArchiveObj:(NSData *)data withKey:(NSString *)key
{
    NSKeyedUnarchiver *keyedUnA = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    id obj = [keyedUnA decodeObjectForKey:key];
    [keyedUnA finishDecoding];
    return obj;
}

#pragma mark --- 判断密码是否包含特殊字符
+ (BOOL)checkPassword:(NSString *)password
{
    // 特殊字符包含`、-、=、\、[、]、;、'、,、.、/、~、!、@、#、$、%、^、&、*、(、)、_、+、|、?、>、<、"、:、{、}
    // 必须包含数字和字母，可以包含上述特殊字符。
    // 依次为（如果包含特殊字符）
    // 数字 字母 特殊
    // 字母 数字 特殊
    // 数字 特殊 字母
    // 字母 特殊 数字
    // 特殊 数字 字母
    // 特殊 字母 数字
    NSString *passWordRegex = @"(\\d+[a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*)|([a-zA-Z]+\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*)|(\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*[a-zA-Z]+)|([a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*\\d+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*\\d+[a-zA-Z]+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*[a-zA-Z]+\\d+)";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}
#pragma mark --- 首次加载判断
+(BOOL)Version
{
    /**
     *  通过修改 plist 中的版本号来加载引导页
     *
     *  修改 plist 中 Bundle version 的字符串版本数字
     *
     */
    //拿到关键key的字符串
    NSString *key = (NSString *) kCFBundleVersionKey;
    //1.拿到版本号的字典
    NSString *Version =  [NSBundle mainBundle].infoDictionary[key];
    //2.从沙盒中取出上次使用的版本号
    NSString *saveVersion = [DEFAULTS objectForKey:key];
    //把版本号存入沙盒
    [DEFAULTS setObject:Version forKey:key];
    NSLog(@"之前使用的版本%@",saveVersion);
    NSLog(@"现在使用的版本%@",Version);
//    int *a 
    //判断版本是否一致，再通过返回，看要不要进入引导页
    if ([saveVersion isEqualToString:Version])
    {
        //不进入引导页
        return NO;
    }
    return YES;
}
#pragma mark --
//传入文件名获取缓存地址
+(NSString *)getDocPath:(NSString *)str
{
    NSArray  *paths=NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=paths[0];
    NSString *pathFile=[path  stringByAppendingString:str];
    NSLog(@"%@",pathFile);
    return pathFile;
}

//判断手机号
+ (BOOL)checkTelNumber:(NSString*) telNumber
{
    NSString*pattern =@"^1+[3578]+\\d{9}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    return [pred evaluateWithObject:telNumber];
}

//判断邮箱是否合法
+ (BOOL) checkEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark - 生成当前时间字符串
+ (NSString*)GetCurrentTimeString
{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy年-MM月-dd号-HH-mm-ss"];
    return [dateformat stringFromDate:[NSDate date]];
}

#pragma mark - 生成文件路径
+ (NSString*)GetPathByFileName:(NSString *)_fileName ofType:(NSString *)_type
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];;
    NSString *fileDirectory = [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",_fileName,_type]];
    
    return fileDirectory;
}
#pragma mark -- 价格字符串的截取
+(NSString*)getTheCorrectNum:(NSString*)tempString
{
    //计算截取的长度
    NSUInteger endLength = tempString.length;
    //判断字符串是否包含 .
    if ([tempString containsString:@"."]) {
        //取得 . 的位置
        NSRange pointRange = [tempString rangeOfString:@"."];
//        NSLog(@"取得 . 的位置 = %lu",pointRange.location);
        //判断 . 后面有几位
        NSUInteger f = tempString.length - 1 - pointRange.location  ;
        //如果大于2位就截取字符串保留两位,如果小于两位,直接截取
        if (f > 2) {
            endLength = pointRange.location + 2;
        }
    }
    //先将tempString转换成char型数组
    NSUInteger start = 0;
    const char *tempChar = [tempString UTF8String];
    //遍历,去除取得第一位不是0的位置
    for (int i = 0; i < tempString.length; i++) {
        if (tempChar[i] == '0') {
//            start++;
        }else {
            break;
        }
    }
    //根据最终的开始位置,计算长度,并截取
    NSRange range = {start,endLength-start};
    tempString = [tempString substringWithRange:range];
    return tempString;
}

#pragma mark ————— 加载缓存的用户 —————
+(NSString*)UserInfoToKey:(NSString *)userKey{
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        NSString *User = [NSString stringWithFormat:@"%@",userDic[userKey]];
        return User;
    }else{
        return @"";
    }
}


#pragma mark - 判断字符串是否为URL
+ (BOOL)isUrl:(NSString *) string{
    
    if(self == nil) {
        return NO;
    }
    
    NSString *url;
    if (string.length>4 && [[string substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",string];
    }else{
        url = string;
    }
    NSString *urlRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}



@end
