//
//  UserModel.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, copy) NSString *merchant_id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *islogin;

//保存用户信息
-(void)saveUserData;
//清理用户信息(退出账号)
+(instancetype)clearUserData;
//解档
+(instancetype)getUseData;
@end
