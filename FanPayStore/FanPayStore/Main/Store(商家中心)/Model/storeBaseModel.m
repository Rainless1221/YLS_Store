//
//  storeBaseModel.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#define KUserDataFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"storeBaseData.plist"]

#import "storeBaseModel.h"

@implementation storeBaseModel
#pragma mark - 保存用户信息
-(void)saveUserData{
    //归档路径
    [NSKeyedArchiver archiveRootObject:self toFile:KUserDataFilePath];
    
}
#pragma mark - 清理用户信息(退出账号)
+(instancetype)clearUserData{
    //runtime设置所有值为空
    storeBaseModel *userInfo =[[storeBaseModel alloc]init];
    [NSKeyedArchiver archiveRootObject:userInfo toFile:KUserDataFilePath];
    return userInfo;
    
}
#pragma mark - 解档
+(instancetype)getUseData{
    
    @try {
        storeBaseModel *userInfo =[NSKeyedUnarchiver unarchiveObjectWithFile:KUserDataFilePath];
        return userInfo;
    } @catch (NSException *exception) {
        return nil;
    } @finally {
        
    }
    
}








//解档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count = 0;
        //获取类中所有成员变量名
        Ivar *ivar = class_copyIvarList([storeBaseModel class], &count);
        for (int i = 0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            //进行解档取值
            id value = [aDecoder decodeObjectForKey:strName];
            //利用KVC对属性赋值
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}

//归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([storeBaseModel class], &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        //利用KVC取值
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
}
@end
