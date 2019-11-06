 //
//  YBHttp.m
//  Wanyingjinrong
//
//  Created by Jason on 15/11/17.
//  Copyright © 2015年 www.jizhan.com. All rights reserved.
//

#import "YBHttpTool.h"
#import "YBMD5.h"
#import <objc/runtime.h>
#import "YBCacheConstant.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation YBCache

@end

static char *NSErrorStatusCodeKey = "NSErrorStatusCodeKey";

@implementation NSError (YBHttp)

- (void)setStatusCode:(NSInteger)statusCode
{
    objc_setAssociatedObject(self, NSErrorStatusCodeKey, @(statusCode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)statusCode
{
    return [objc_getAssociatedObject(self, NSErrorStatusCodeKey) integerValue];
}

@end


@implementation YBHttpTool

//错误处理
+ (void)errorHandle:(NSURLSessionDataTask * _Nullable)task error:(NSError * _Nonnull)error failure:(void (^)(NSError *))failure
{
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    
    error.statusCode = statusCode;
    
    if (statusCode == 401) {//密码错误
        
    } else if (statusCode == 0) {//没有网络
        
    } else if (statusCode == 500) {//参数错误
        
    } else if (statusCode == 404) {
        
    } else if (statusCode == 400) {
        
    }
    
    if (failure) {
        failure(error);
    }
}

+ (NSString *)fileName:(NSString *)url params:(NSDictionary *)params
{
    NSMutableString *mStr = [NSMutableString stringWithString:url];
    if (params != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [mStr appendString:str];
    }
    return mStr;
}

+ (AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    //设置接受的类型
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
   
    //设置请求超时
    sessionManager.requestSerializer.timeoutInterval = 30;

    return sessionManager;
}

+ (YBCache *)getCache:(YBCacheType)cacheType url:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success
{
    //缓存数据的文件名
    NSString *fileName = [self fileName:url params:params];
    NSData *data = [YBCacheTool getCacheFileName:fileName];
    
    YBCache *cache = [[YBCache alloc] init];
    cache.fileName = fileName;
    
    if (data.length) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (cacheType == YBCacheTypeReloadIgnoringLocalCacheData) {//忽略缓存，重新请求
            
        } else if (cacheType == YBCacheTypeReturnCacheDataDontLoad) {//有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
            
        } else if (cacheType == YBCacheTypeReturnCacheDataElseLoad) {//有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
            if (success) {
                success(dict);
            }
            cache.result = YES;
            
        } else if (cacheType == YBCacheTypeReturnCacheDataThenLoad) {///有缓存就先返回缓存，同步请求数据
            if (success) {
                success(dict);
            }
        } else if (cacheType == YBCacheTypeReturnCacheDataExpireThenLoad) {//有缓存 判断是否过期了没有 没有就返回缓存
            //判断是否过期
            if (![YBCacheTool isExpire:fileName]) {
                if (success) {
                    success(dict);
                }
                cache.result = YES;
            }
        }
    }
    return cache;
}

+ (void)get:(NSString *)url params:(NSDictionary *)params cacheType:(YBCacheType)cacheType success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    
//    NSString *httpStr = [[ kAPI_URL stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *httpStr = [[ url stringByAppendingString:@""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    //缓存数据的文件名 data
    YBCache *cache = [self getCache:cacheType url:url params:params success:success];
    NSString *fileName = cache.fileName;
    if (cache.result)
        return;
    YBWeakSelf
    [sessionManager GET:httpStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        YBLog(@"%lld", downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            if ([responseObject isKindOfClass:[NSNull class]] || responseObject==nil) {
                return ;
            }
            
            //缓存数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            [YBCacheTool cacheForData:data fileName:fileName];
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf errorHandle:task error:error failure:failure];
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"网络请求失败！"];
    }];
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [self get:url params:params cacheType:YBCacheTypeReloadIgnoringLocalCacheData success:success failure:failure];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params cacheType:(YBCacheType)cacheType success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    
    NSString * URLpublic = [PublicMethods readFromUserD:@"URL_addin"];
    NSString *KAPURL = [NSString new];
    if ([URLpublic  isEqualToString:@"1"]) {
        KAPURL = [NSString stringWithFormat:@"%@",kAPI_URL];
    }else{
        KAPURL = [NSString stringWithFormat:@"%@",kAPI_URL1];

    }
    NSString *httpStr = [[ KAPURL stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    httpStr = [httpStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    //缓存数据的文件名 data
    YBCache *cache = [self getCache:cacheType url:url params:params success:success];
    NSString *fileName = cache.fileName;
    if (cache.result) return;
    YBWeakSelf
    [sessionManager POST:httpStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            if ([responseObject isKindOfClass:[NSNull class]] || responseObject==nil) {
                return ;
            }
             NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
            if ([message isEqualToString:@"请重新登录"] || [message isEqualToString:@"您的账号已在其他设备上登录"]) {
                FBHLogInController *tabBarCtr = [[FBHLogInController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtr;
                [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
                [UserModel clearUserData];
                [insert_storeM clearUserData];
                [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    if (iResCode == 0) {
                        NSLog(@"删除别名成功");
                    }
                } seq:1];
                
            }
           
            //缓存数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            [YBCacheTool cacheForData:data fileName:fileName];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf errorHandle:task error:error failure:failure];
        NSLog(@"请求错误 : %@",error);
        
#pragma mark - 错误原因提示
        if (error.statusCode == 400) {
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:@"网络请求失败！"];
        }else if (error.statusCode == 0){
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:@"网络请求失败！稍后再尝试"];
        }else if (error.statusCode == 500){
            
        }else{
            
        }
        
        
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    
    NSMutableDictionary *Mdic = [NSMutableDictionary dictionaryWithDictionary:params];
//    NSString *timestamp = [YBHttpTool currentTimeStr];

/*
 [Mdic setValue:timestamp forKey:@"timestamp"];//时间
 NSString *versionNo=    [MOBFApplication shortVersion];
 [Mdic setValue:versionNo forKey:@"versionNo"];//版本号
 NSString *deviceID=   [MOBFDevice duid];
 [Mdic setValue:[NSString stringWithFormat:@"%@%@",deviceID,@"ios"] forKey:@"deviceId"];//设备ID
 NSString *signStr=  [MD5Sign signStr:Mdic];
 */
    
    /*
     NSString *signStr=  [[NSString alloc]init];
     NSString *phone = [params objectForKey:@"mobile"];
     if (phone==nil) {
     
     }else{
     NSString *process = [NSString stringWithFormat:@"%@%@",phone,timestamp];
     signStr = [MD5Sign MD5:process];
     }
     [Mdic setValue:signStr forKey:@"process"];
     */

    
    [self post:url params:Mdic cacheType:YBCacheTypeReloadIgnoringLocalCacheData success:success failure:failure];

}




//字典转NSData:
 +(NSData *)returnDataWithDictionary:(NSDictionary*)dict
 {
     NSMutableData *data = [[NSMutableData alloc]init];
     NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
     [archiver encodeObject:dict forKey:@"talkData"];
     [archiver finishEncoding];
     return data;
 }
//获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}



+ (void)uploadImageWithImage:(NSData *)image success:(void (^)(NSDictionary *obj))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *sessionManager = [self sessionManager];

    [sessionManager.requestSerializer setValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",                                                                               @"text/plain",                                                                               @"application/json",nil];
    
    NSString * URLpublic = [PublicMethods readFromUserD:@"URL_addin"];
    NSString *KAPURL = [NSString new];
    if ([URLpublic  isEqualToString:@"1"]) {
        KAPURL = [NSString stringWithFormat:@"%@",kAPI_URL];
    }else{
        KAPURL = [NSString stringWithFormat:@"%@",kAPI_URL1];
        
    }
    NSString *httpStr = [[KAPURL stringByAppendingString:@"api/Base/SysBase/UploadFile"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

//    [sessionManager.requestSerializer setValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
//    NSString *httpStr = [[kAPI_URL stringByAppendingString:@"api/Base/SysBase/UploadFile"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//     NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"bbb.png" withExtension:nil];

    YBWeakSelf
    [sessionManager POST:@"http://app.carcai.cn/api/Base/SysBase/UploadFile" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //upfile 是参数名 根据项目修改
        NSLog(@"image=%@",image);
//        [formData appendPartWithFileData:image name:@"upfile" fileName:[NSString stringWithFormat:@"%.0f.jpg", [[NSDate date] timeIntervalSince1970]] mimeType:@"image/jpg"];
//    imageData =     UIImageJPEGRepresentation([images objectAtIndex: i], 0.8);
//         [formData appendPartWithFileData:image name:@"file" fileName:[NSString stringWithFormat:@"%.0f.jpg", [[NSDate date] timeIntervalSince1970]] mimeType:@"image/jpeg"];
        // 上传filename
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        [formData appendPartWithFileData:image name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        
        
        
        
        NSLog(@"forData=%@",formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf errorHandle:task error:error failure:failure];
    }];
}

+ (void)uploadImageArrayWithImages:(NSArray<NSData *> *)images success:(void (^)(NSDictionary *obj))success failure:(void (^)(NSError *))failure
{
//    AFHTTPSessionManager *sessionManager = [self sessionManager];
//    [sessionManager.requestSerializer setValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
//    NSString *httpStr = [[kAPI_URL stringByAppendingString:@"pic/fileuploadArr"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    
    [sessionManager.requestSerializer setValue:@"image/jpg" forHTTPHeaderField:@"Content-Type"];
//    NSString *httpStr = [[kAPI_URL stringByAppendingString:@"api/Base/SysBase/UploadFile"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    YBWeakSelf
    [sessionManager POST:@"http://app.carcai.cn/api/Base/SysBase/UploadFile" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [images enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //upfiles 是参数名 根据项目修改
            [formData appendPartWithFileData:obj name:@"upfiles" fileName:[NSString stringWithFormat:@"%.0f.jpg", [[NSDate date] timeIntervalSince1970]] mimeType:@"image/jpg"];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            [weakSelf errorHandle:task error:error failure:failure];
        }
    }];
}

// Get IP Address
+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

+(void)uploadImage:(UIImage *)image
{
AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//接收类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableStatusCodes
 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                     @"text/html",
                                                     @"image/jpeg",
                                                     @"image/png",
                                                     @"application/octet-stream",
                                                     @"text/json",
                                                     nil];

    NSURLSessionDataTask *task = [manager POST:@"http://218.200.237.11:7060/appservice/rest/app/resourceImgUpload/imgUpload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
    
    NSData *imageData =UIImageJPEGRepresentation(image,0.1);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    
    //上传的参数(上传图片，以文件流的格式)
    [formData appendPartWithFileData:imageData
                                name:@"file"
                            fileName:fileName
                            mimeType:@"image/jpeg"];
    
} progress:^(NSProgress *_Nonnull uploadProgress) {
    //打印下上传进度
} success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    //上传成功
    NSLog(@"res=%@",responseObject);
} failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
    //上传失败
    NSLog(@"error=%@",error);
}];
}

@end
