//
//  YGKJNetWorkTool.m
//  新项目
//
//  Created by 刘耀宗 on 2016/10/21.
//  Copyright © 2016年 刘耀宗. All rights reserved.
//

#import "YGKJNetWorkTool.h"

@implementation YGKJNetWorkTool


+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *obj))success failure:(void (^)(NSError *error))failure
{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@",url] parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"text/html" forHTTPHeaderField:@"Accept"];



    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
                success(responseObject);
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            failure(error);
        }
    }] resume];
}
@end
