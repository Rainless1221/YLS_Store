//
//  MD5Sign.h
//  PeanutLK
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 jufan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Sign : NSObject


/**
 MD5签名 对应sign的参数

 @param dic 需要请求的所有参数的字典key-value
 @return sign参数
 */
+(NSString*)signStr:(NSDictionary*)dic;

+(NSString *)MD5:(NSString *)mdStr;
@end
