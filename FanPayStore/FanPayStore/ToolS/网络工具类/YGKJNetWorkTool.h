//
//  YGKJNetWorkTool.h
//  新项目
//
//  Created by 刘耀宗 on 2016/10/21.
//  Copyright © 2016年 刘耀宗. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface YGKJNetWorkTool : NSObject
+(instancetype)shareNetWorkTool;

/**
 POst请求
 
 @param url 请求的API地址
 @param params 参数
 @param success 成功回调Block
 @param failure 失败回调Block
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *obj))success failure:(void (^)(NSError *error))failure;
@end
