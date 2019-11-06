//
//  MD5Sign.m
//  PeanutLK
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 jufan. All rights reserved.
//

#import "MD5Sign.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5Sign

#define APPSECRET @"d2168349de78e87dbe501843adgetweg"   //APPSECRET:加密密钥
#pragma mark ===>>> sign签名加密
+(NSString*)signStr:(NSDictionary*)dic{
    NSArray * arraykey = [dic allKeys];
    NSMutableArray * allAry = [NSMutableArray arrayWithArray:arraykey];
    NSArray *result = [allAry sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序: A~Z
    }];
    
    NSString * md5 = @"";
    for (NSString * canshu in result) {
        md5 = [NSString stringWithFormat:@"%@%@",md5,dic[canshu]];
    }
    md5 = [NSString stringWithFormat:@"%@%@",md5,APPSECRET];
    NSString * md5canshu = [self MD5:md5];
    return md5canshu ;
}

//MD5加密
+(NSString *)MD5:(NSString *)mdStr{
    const char *original_str = [mdStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_LONG cclong = (CC_LONG)strlen(original_str);
    CC_MD5(original_str, cclong , result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


@end
